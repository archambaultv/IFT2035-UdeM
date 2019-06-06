-- Première version
-- On peut pour démarrer utiliser le datatype Maybe comme
-- valeur de retour. Ainsi, notre table est fabriquée à
-- l'aide des fermetures.
type T a b = (a -> Maybe b)

empty :: T a b
empty = \x -> Nothing

add ::  (Eq a) => a -> b -> T a b  -> T a b
add key value oldtable  = \k -> if k == key
                                then Just value
                                else oldtable k

lookup :: (Eq a) => a -> T a b -> b -> b
lookup key table def = case table key of
                         Nothing -> def
                         Just x -> x



-- Deuxième version
-- Sans le type Maybe
-- Le type T2 comporte un b extra par rapport à T pour
-- la valeur de défaut
type T2 a b = a -> b -> b

empty2 :: T2 a b
empty2 x y = y -- On retourne la valeur de défaut

add2 :: (Eq a) => a -> b -> T2 a b  -> T2 a b
add2 key value oldtable = \k def -> if k == key
                                    then value
                                    else oldtable k def

lookup2 :: (Eq a) => a -> T2 a b -> b -> b
lookup2 key table def = table key def
