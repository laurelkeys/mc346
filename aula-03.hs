-- soma dos elementos de uma lista
soma x = soma' x 0
  where soma' [] acc = acc
        soma' (x:xs) acc = soma' xs (x+acc)

-- soma dos números pares de uma lista
somaPares [] = 0
somaPares (x:xs)
  | mod x 2 == 0 = x + somaPares xs
  | otherwise = somaPares xs

-- tamanho de uma lista
tamanho [] = 0
tamanho (_:xs) = 1 + tamanho xs

-- conta quantas vezes o item aparece na lista (0 se nenhuma)
conta _ [] = 0
conta e (x:xs)
  | x == e = 1 + conta e xs
  | otherwise = conta e xs

-- dado n gera a lista de 1 a n
gera n
  | n < 1 = []
  | n == 1 = [1]
  | otherwise = gera (n-1) ++ [n]

-- remove item da lista (todas as vezes)
remove _ [] = []
remove e (x:xs)
  | x == e = remove e xs
  | otherwise = x : remove e xs

-- troca velho por novo na lista (todas vezes)
troca _ _ [] = []
troca a b (x:xs)
  | x == a = b : troca a b xs
  | otherwise = x : troca a b xs
