-- split - dado um item e uma lista retorna uma lista de listas, todos os elementos da lista antes do item (a primeira vez que ele aparece) e todos depois
-- split 't' "qwertyuiopoiuyt" ==> ["qwer", "yuiopoiuyt"]
split e x = split' e x []
  where split' _ [] acc = [acc]
        split' e (x:xs) acc
          | x == e = [acc, xs]
          | otherwise = split' e xs (acc ++ [x])

-- splitall - mesma coisa que o split mas retorna todas as sublistas
-- splitall 't' "qwertyuiopoiuytxxt" ==> ["qwer", "yuiopoiuy", "xx", ""]  ou  ["qwer", "yuiopoiuy", "xx"]
splitall e x = splitall' e x []
  where splitall' _ [] acc = [acc]
        splitall' e (x:xs) acc
          | x == e = acc : (splitall' e xs [])
          | otherwise = splitall' e xs (acc ++ [x])

-- dado uma subsequencia pequena (o separador) e uma sequencia (grande), usa o separador para quebrar a sequencia grande em techos.
-- splitseq "abc" "123abc456abc890" ==> ["123","456","890"]
splitseq s x = splitseq' s x []
  where splitseq' _ [] acc = [acc]
        splitseq' s x acc
          | isPrefix s x = acc : (splitseq' s x' [])
          | otherwise = splitseq' s (tail x) (acc ++ [head x])
          where x' = takeSize s x

isPrefix [] _ = True
isPrefix _ [] = False
isPrefix (s:ss) (x:xs)
  | s == x = isPrefix ss xs
  | otherwise = False

takeSize [] x = x
takeSize _ [] = []
takeSize (s:ss) (x:xs) = takeSize ss xs
