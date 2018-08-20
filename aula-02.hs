-- tamanho de uma lista
tamanho [] = 0
tamanho (_:xs) = 1 + tamanho xs

-- soma dos elementos de uma lista
soma x = soma' x 0
  where soma' [] acc = acc
        soma' (x:xs) acc = soma' xs (x+acc)

-- soma dos números pares de uma lista
somaPares [] = 0
somaPares (x:xs)
  | mod x 2 == 0 = x + somaPares xs
  | otherwise = somaPares xs

-- soma dos elementos nas posições pares da lista (o primeiro elemento esta na posicao 1)
somaPosPares [] = 0
somaPosPares [_] = 0
somaPosPares (_:xs) = head xs + somaPosPares (tail xs)

-- existe item na lista (True ou False)
existe _ [] = False
existe e (x:xs)
  | x == e = True
  | otherwise = existe e xs

-- posição do item na lista (0 se nao esta la, 1 se é o primeiro)
posicao _ [] = 0
posicao e (x:xs)
  | x == e = 1
  | posicao e xs /= 0 = 1 + posicao e xs
  | otherwise = 0

-- conta quantas vezes o item aparece na lista (0 se nenhuma)
conta _ [] = 0
conta e (x:xs)
  | x == e = 1 + conta e xs
  | otherwise = conta e xs

-- maior elemento de uma lista - FAZER p/ proxima aula - variáveis locais
maior [x] = x
maior (x:xs)
  | x >= y = x
  | otherwise = y
  where y = maior xs

-- reverte uma lista - FAZER p/ próxima aula - recursão com acumulados
reverte x = reverte' x []
  where reverte' [] acc = acc
        reverte' (x:xs) acc = reverte' xs (x:acc)

-- intercala 2 listas
-- intercala1 [1,2,3] [4,5,6,7,8]
-- ==> [1,4,2,5,3,6]
intercala1 _ [] = []
intercala1 [] _ = []
intercala1 (x:xs) (y:ys) = x : y : (intercala1 xs ys)

-- intercala 2 listas
-- intercala2 [1,2,3] [4,5,6,7,8]
-- ==>  [1,4,2,5,3,6,7,8]
intercala2 x [] = x
intercala2 [] y = y
intercala2 (x:xs) (y:ys) = x : y : (intercala2 xs ys)

-- a lista ja esta ordenada?
ordenada [] = True
ordenada [_] = True
ordenada (x:xs)
  | x <= head xs = ordenada xs
  | otherwise = False

-- dado n gera a lista de 1 a n
gera n
  | n < 1 = []
  | n == 1 = [1]
  | otherwise = gera (n-1) ++ [n]

-- retorna o ultimo elemento de uma lista
ultimo [x] = x
ultimo (_:xs) = ultimo xs

-- retorna a lista sem o utlimo elemento
comeco [_] = []
comeco (x:xs) = x : comeco xs

-- shift right
-- shiftr [1,2,3,4]
-- ==> [4,1,2,3]
shiftr [] = []
shiftr [x] = [x]
shiftr (x:xs) = let xs' = shiftr xs in 
                head xs' : x : tail xs'

-- shiftr n lista (shift right n vezes)
shiftrN [] _ = []
shiftrN [x] _ = [x]
shiftrN (x:xs) 0 = (x:xs)
shiftrN (x:xs) n = let xs' = shiftrN xs 1 in 
                   shiftrN (head xs' : x : tail xs') (n-1)

-- shift left
-- shiftl [1,2,3,4]
-- ==> [2,3,4,1]
shiftl [] = []
shiftl (x:xs) = xs ++ [x]

-- shift left n vezes
shiftlN [] _ = []
shiftlN [x] _ = [x]
shiftlN (x:xs) 0 = (x:xs)
shiftlN (x:xs) n = shiftlN (xs ++ [x]) (n-1)

-- remove item da lista (1 vez so)
removePrim _ [] = []
removePrim e (x:xs)
  | x == e = xs
  | otherwise = x : removePrim e xs

-- remove item da lista (todas as vezes)
remove _ [] = []
remove e (x:xs)
  | x == e = remove e xs
  | otherwise = x : remove e xs

-- remove item da lista n (as primeiras n vezes)
removeN _ [] _ = []
removeN e (x:xs) n
  | n <= 0 = (x:xs)
  | x == e = removeN e xs (n-1)
  | otherwise = x : removeN e xs n

-- remove item da lista (a ultima vez que ele aparece) **
removeUlt _ [] = []
removeUlt e (x:xs)
  | x /= e = x : xs'
  | xs /= xs' = x : xs'
  | otherwise = xs
  where xs' = removeUlt e xs

-- troca velho por novo na lista (1 so vez)
trocaPrim _ _ [] = []
trocaPrim a b (x:xs)
  | x == a = b : xs
  | otherwise = x : trocaPrim a b xs

-- troca velho por novo na lista (todas vezes)
troca _ _ [] = []
troca a b (x:xs)
  | x == a = b : troca a b xs
  | otherwise = x : troca a b xs

-- troca velho por novo na lista n (as primeiras n vezes)
trocaN _ _ [] _ = []
trocaN a b (x:xs) n
  | n <= 0 = (x:xs)
  | x == a = b : trocaN a b xs (n-1)
  | otherwise = x : trocaN a b xs n

-- troca velho por novo na lista (a ultima vez que ele aparece)
trocaUlt a b x = trocaUlt' a b x
  where trocaUlt' _ _ [] = ([], False)
        trocaUlt' a b (x:xs)
          | x /= a || trocou = (x:xs', trocou)
          | otherwise = (b:xs', True)
          where (xs', trocou) = trocaUlt' a b xs
