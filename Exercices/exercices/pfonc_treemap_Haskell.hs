data TreeMap b = Empty | Node (TreeMap b) Int b (TreeMap b)
  deriving (Show, Eq)


tmLookup :: TreeMap b -> Int -> Maybe b
tmLookup Empty _ = Nothing
tmLookup (Node tl k v tr) k1 | k1 == k = Just v
tmLookup (Node tl k v tr) k1 | k1 < k = tmLookup tl k1
tmLookup (Node tl k v tr) k1 | k1 > k = tmLookup tr k1
                                

tmInsert :: TreeMap b -> Int -> b -> TreeMap b
tmInsert Empty k v = Node Empty k v Empty
tmInsert (Node tl k v tr) k1 v1 | k1 == k =
                                  (Node tl k v1 tr)
tmInsert (Node tl k v tr) k1 v1 | k1 < k =
                                  (Node (tmInsert tl k1 v1) k v tr)
tmInsert (Node tl k v tr) k1 v1 | k1 > k =
                                  (Node tl k v (tmInsert tr k1 v1))

tmRemove :: TreeMap b -> Int -> TreeMap b
tmRemove Empty _ = Empty
tmRemove (Node tl k1 v1 tr) k
  | k < k1 = (Node (tmRemove tl k) k1 v1 tr)
tmRemove (Node tl k1 v1 tr) k
  | k > k1 = (Node tl  k1 v1 (tmRemove tr k))
tmRemove (Node tl k1 v1 tr) k
  | k == k1 = (merge tl tr)
  where merge :: TreeMap b -> TreeMap b -> TreeMap b
        merge Empty y = y
        merge x Empty = x
        merge x (Node tl2 k2 v2 tr2) =
          (Node (merge x tl2) k2 v2 tr2)
