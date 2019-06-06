-- Une mini calculatrice avec type


-- Les 5 opérateurs de notre calculuatrice
-- +, -,  ==, <, if, not
data Operateur = OPlus
               | OMinus
               | OEqual
               | OLessThan
               | OIf
               | ONot
               deriving (Show)

-- Le langage est composé d'application préfixe d'opérateurs
-- ou de constante Int ou Bool
-- Il n'y a pas d'application partielle possible
data Exp = EInt Int
         | EBool Bool
         | EOp Operateur
         | EApp [Exp]
         deriving (Show)
         
-- ex : EApp [EOp OPlus, EInt 1, EInt 2] -> (+ 1 2)
-- ex : EApp [EOp OIf, (EApp [EOp OLessThan, EInt 1, EInt 2]),
--            EBool True, EBool False]
--      -> (if (< 1 2) True False)

data Value = VInt Int
           | VBool Bool
           deriving (Show)

data Type = TInt
          | TBool
          deriving (Eq, Show)

typeCheck :: Exp -> Either String Type
typeCheck (EInt _) = Right $ TInt
typeCheck (EBool _) = Right $ TBool
typeCheck (EOp _) = Left $ "Opérateur sans arguments"
typeCheck (EApp (EOp op : args)) =
   case op of
    OPlus -> do
      binaryInt args
      return TInt -- Pour Either, return Int <-> Right Int
    OMinus -> do
      binaryInt args
      return TInt 
    OEqual -> do
      binaryInt args
      return TBool 
    OLessThan -> do
      binaryInt args
      return TBool
    OIf -> do
      if length args /= 3 then Left "Expecting 3 arguments" else Right ()
      unaryBool [head args]
      t1 <- typeCheck (args !! 1)
      t2 <- typeCheck (args !! 2)
      if t1 == t2
       then Right t2
       else Left "Oparator If must have the same type in both branches"
    ONot -> do
      unaryBool args
      return TBool

   where binaryInt (e1 : e2 : []) = do
           t <- typeCheck e1
           t2 <- typeCheck e2
           if t == TInt && t2 == TInt
             then return ()
             else Left "Expecting integers"  
         binaryInt _ = Left "Expecting 2 arguments"

         unaryBool (e1 : []) = do
           t <- typeCheck e1
           if t == TBool
             then return ()
             else Left "Expecting integers"  
         unaryBool _ = Left "Expecting 1 argument1"
    

-- Fonction eval comme si le code était bien écrit
eval :: Exp -> Value
eval (EInt x) = VInt x
eval (EBool x) = (VBool x)
eval (EApp (EOp op : args)) =
  case op of
    OPlus -> binaryInt (+) args
    OMinus -> binaryInt(-) args
    OEqual -> binaryBool (==) args
    OLessThan -> binaryBool (<=) args
    OIf -> case args of
             [e1, e2, e3] ->
               let (VBool r1) = eval e1
               in if r1 then eval e2 else eval e3
    ONot -> let (VBool r1) =  oneArg args
            in (VBool $ not r1)

  where
        oneArg :: [Exp] -> Value
        oneArg (e1 : []) = eval e1

        twoArgs :: [Exp] -> (Value, Value)
        twoArgs (e1 : e2 : []) =
          let v1 = eval e1
              v2 = eval e2
          in (v1 , v2)

        binaryInt :: (Int -> Int -> Int) -> [Exp] -> Value
        binaryInt op args =
          let (VInt r1, VInt r2) = twoArgs args
          in VInt (r1 `op` r2)

        binaryBool :: (Int -> Int -> Bool) -> [Exp] -> Value
        binaryBool op args =
          let (VInt r1, VInt r2) = twoArgs args
          in VBool (r1 `op` r2)
