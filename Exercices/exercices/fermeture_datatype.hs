import Prelude hiding (Bool, succ, fst, snd, head, tail)

-- Booléen et If
type Bool a = a -> a -> a

false :: Bool a
false a b = b

true :: Bool a
true a b = a

if2 :: Bool a -> a -> a -> a 
if2 test a b = test a b

testIfTrue = if2 true 1 2
testIfFalse = if2 false 1 2

-- Nombre entier
type Number t = (t -> t) -> t -> t

zero :: Number t
zero = \f z -> z

succ :: Number t -> Number t
succ n = \f z -> f (n f z)

one :: Number t
one = succ zero

plus :: Number t -> Number t -> Number t
plus n m = \f z -> n f (m f z)

-- Pair
type Pair a b t = (a ->  b ->  t) ->  t

mkPair :: a -> b -> Pair a b t
mkPair a b = \f -> f a b

fst :: Pair a b a -> a
fst p = p (\a b -> a)

snd :: Pair a b b -> b
snd p = p (\a b -> b)

-- Liste
type List a t = (a->t->t)->t->t

cons :: a -> List a t -> List a t
cons x l = \f z -> f x (l f z)

nil :: List a t
nil = \f z -> z

isNil :: List a (Bool t2) -> Bool t2
isNil l = l (\_ _ -> false) true

head :: List a a -> a -> a
head l ifEmpty = l (\x _ -> x) ifEmpty
