-- Implemente a função vogalmaiscomum que dado um string retorna a (uma das) vogais mais comum no string.
-- Considerar que vogais maiúsculas e minúsculas contam como a mesma vogal.

-- Assuma que um contador é implementado como uma lista de tuplas onde o primeiro elemento da tupla é a chave e o segundo a contagem relativa a chave.

-- Assuma a função soma1 que dado uma chave e um contador (a lista) soma 1 na contagem relativa a chave no contador, ou inclui a chave na lista com contagem 1 se ela não tiver lista.
-- soma1 "abc" [("efg",4),("abc",2),("qwe",1)] ==> [("efg",4),("abc",3),("qwe",1)]
-- soma1 'a' [('b',1),('d',3),('u',2)] ==>  [('a',1),('b',1),('d',3),('u',2)]
     
soma1 :: (Eq a) => a -> [(a,Int)] -> [(a,Int)]
soma1 ch [] = [(ch,1)]
soma1 ch ((x,n):xs)
     | x == ch = (x,n+1) : xs
     | otherwise = (x,n) : soma1 ch xs

vogalmaiscomum s = let swap (a,b) = (b,a) in 
                   snd $ maximum $ map swap $ foldl (\acc x -> soma1 x acc) [] $ filter (`elem` "aeiou") $ map toLower s
