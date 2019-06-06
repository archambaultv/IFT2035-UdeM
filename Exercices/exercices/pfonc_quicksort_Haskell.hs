-- Version spécialisée pour les liste d'entiers
quicksortInt :: [Int] -> [Int]
quicksortInt [] = []
quicksortInt (x:xs) =
  let (smaller, bigger) = partition (\y -> y <= x) xs
  in quicksortInt smaller ++ [x] ++ quicksortInt bigger

  where partition :: (Int -> Bool) -> [Int] -> ([Int],[Int])
        partition _ [] = ([],[])
        partition test (z:zs) =
          let (a, b) = partition test zs
          in if (test z)
             then (z : a, b)
             else (a, z : b)


-- Version générale. Pour une liste arbitraire et un
-- opérateur de comparaison arbitraire.
quicksort :: (a -> a -> Bool) -> [a] -> [a]
quicksort _ [] = []
quicksort compare (x:xs) =
  let (smaller, bigger) = partition (\y -> compare y x) xs
  in quicksort compare smaller ++ [x] ++ quicksort compare bigger

  where partition :: (a -> Bool) -> [a] -> ([a],[a])
        partition _ [] = ([],[])
        partition test (z:zs) =
          let (a, b) = partition test zs
          in if (test z)
             then (z : a, b)
             else (a, z : b)
