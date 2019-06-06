data Tree = Leaf Int
          | Node Tree Int Tree


nbrLeaf (Leaf _) = 1
nbrLeaf (Node tg _ td) = nbrLeaf tg + nbrLeaf td

nbrNodes (Leaf _) = 0
nbrNodes (Node tg _ td) = 1 + nbrLeaf tg + nbrLeaf td

applyFunction :: (Int ->  Int) -> Tree -> Tree
applyFunction f (Leaf n) = Leaf (f n)
applyFunction f (Node tg n td) =
  let tg' = applyFunction f tg
      td' = applyFunction f td
  in Node tg' (f n) td'
