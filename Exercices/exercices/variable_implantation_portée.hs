
data Exp = EInt Int
         | Var String
         | Lambda String Exp
         | App Exp Exp
         deriving (Show)

type Env a = [(String, a)]

data ValueD = VDVar String
            | VDInt Int
            | VDLambda String Exp
            deriving (Show)
                  
evalD :: Env ValueD -> Exp -> Either String ValueD
evalD _ (EInt x) = Right $ VDInt x
evalD env (App e1 e2) = do
  e1' <- evalD env e1
  e2' <- evalD env e2
  case e1' of
    VDLambda var body -> evalD ((var, e2') : env) body
    _ -> Left "Operand must be a lambda"
evalD env (Lambda x body) = Right $ VDLambda x body
evalD env (Var x) =
  case lookup x env of
    Nothing -> Left  "Variable not found"
    Just x -> Right x


-- Remarquer que les fonctions portent un environnement pour retenir
-- la valeur de leur variable libre et que c'est dans cet
-- environnement que le corps de la fonction est exécuté.
data Value = VVar String
           | VInt Int
           | VLambda String Exp (Env Value)
           deriving (Show)

evalL :: Env Value -> Exp -> Either String Value
evalL _ (EInt x) = Right $  VInt x
evalL env (App e1 e2) = do
  e1' <- evalL env e1
  e2' <- evalL env e2
  case e1' of
    VLambda var body closure -> evalL ((var, e2') : closure) body
    _ -> Left "Operand must be a lambda"
-- Normalement il faudrait retenir seulement les variables libres de
-- la fonction, mais pour la démo il est suffisant
-- de retenir tout l'environnement et tant pis pour la fuite mémoire
evalL env (Lambda x body) = Right $ VLambda x body env
evalL env (Var x) =
    case lookup x env of
    Nothing -> Left  "Variable not found"
    Just x -> Right x

-- Le code suivant démontre la différence entre les deux évaluateurs
-- Il est l'équivalent de :
-- let x = 4
--     f = \y -> x        Ici x doit être 4 en portée lexicale
--     x = 3
-- in f 3

e1 = App (Var "f") (EInt 3)
e2 = App (Lambda "x" e1) (EInt 3)
e3 = App (Lambda "f" e2) (Lambda "y" (Var "x"))
e4 = App (Lambda "x" e3) (EInt 4)

eDynamique = evalD [] e4 -- Vaut VDInt 3
eLexicale = evalL [] e4 -- Vaut VInt 4
