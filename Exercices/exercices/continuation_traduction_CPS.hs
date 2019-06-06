import Prelude hiding (length)

length :: [a] -> Int
length [] = 0
length (_ : xs) = 1 + length xs

lengthCPS :: [a] -> (Int -> b) -> b
lengthCPS [] k = k 0
lengthCPS (_ : xs) k = lengthCPS xs (\r -> k (r + 1))
  
applatir :: [[a]] -> [a]
applatir [] = []
applatir (xs : xss) = xs ++ applatir xss

applatirCPS :: [[a]] -> ([a] -> b) -> b
applatirCPS [] k = k []
applatirCPS (xs : xss) k =  applatirCPS xss (\r -> k (xs ++ r))

fact :: Int -> Int
fact 0 = 1
fact n = n * fact (n - 1)

factCPS :: Int -> (Int -> a) -> a
factCPS 0 k = k 1
factCPS x k = factCPS (x - 1) (\r -> k (x * r))

fib :: Int -> Int
fib 0 = 0
fib 1 = 1
fib n = fib (n - 1) + fib (n - 2)

fibCPS :: Int -> (Int -> b) -> b
fibCPS 0 k = k 0
fibCPS 1 k = k 1
fibCPS n k = fibCPS (n - 1) (\r -> fibCPS (n - 2) (\r2 -> k (r + r2)))
