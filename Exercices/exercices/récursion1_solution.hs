mylength :: [Int] -> Int
mylength [] = 0
mylength (_:xs) = 1 + mylength xs
 
myconcat :: [Int] -> [Int] -> [Int]
myconcat [] xs = xs
myconcat (x : xs) ys = x : (myconcat xs ys)

mymember :: Int -> [Int] -> Bool
mymember _ [] = False
mymember x (y : ys) = x == y || mymember x ys

myreverse :: [Int] -> [Int]
myreverse xs =
  let helper [] acc = acc
      helper (x : xs) acc = helper xs (x : acc)
  in helper xs []

mysubList :: [Int] -> [Int] -> Bool
mysubList [] _ = True
mysubList _ [] = False
mysubList xList yList@(_ : ys) =
  let matchInFront [] _ = True
      matchInFront (x : xs) (y : ys) =
        if x == y
        then matchInFront xs ys
        else False
      matchInFront _ _ = False
  in
    matchInFront xList yList ||  mysubList xList ys
