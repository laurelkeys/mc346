-- tamanho de uma lista
tamanho [] = 0
tamanho (x:xs) = 1 + tamanho xs

-- soma dos elementos de uma lista
soma [] = 0
soma (x:xs) = x + soma xs

-- soma dos números pares de uma lista
somaPares [] = 0
somaPares (x:xs)
  | mod x 2 == 0 = x + somaPares xs
  | otherwise = somaPares xs

-- soma dos elementos nas posições pares da lista (o primeiro elemento esta na posicao 1)
somaPosPares [] = 0
somaPosPares [x] = 0
somaPosPares (x:xs) = head xs + somaPosPares (tail xs)

-- existe item na lista (True ou False)
existe e [] = False
existe e (x:xs)
  | x == e = True
  | otherwise = existe e xs

-- posição do item na lista (0 se nao esta la, 1 se é o primeiro)
posicao e [] = 0
posicao e (x:xs)
  | x == e = 1
  | posicao e xs /= 0 = 1 + posicao e xs
  | otherwise = 0

-- conta quantas vezes o item aparece na lista (0 se nenhuma)
conta e [] = 0
conta e (x:xs)
  | x == e = 1 + conta e xs
  | otherwise = conta e xs

-- maior elemento de uma lista - FAZER p/ proxima aula - variáveis locais
maior [x] = x
maior (x:xs)
  | x >= maior xs = x
  | otherwise = maior xs

-- reverte uma lista - FAZER p/ próxima aula - recursão com acumulados
reverte [] = []
reverte (x:xs) = reverte xs ++ [x]

-- intercala 2 listas
-- intercala1 [1,2,3] [4,5,6,7,8]
-- ==> [1,4,2,5,3,6]
intercala1 x [] = []
intercala1 [] y = []
intercala1 (x:xs) (y:ys) = x : y : (intercala1 xs ys)

-- intercala 2 listas
-- intercala2 [1,2,3] [4,5,6,7,8]
-- ==>  [1,4,2,5,3,6,7,8]
intercala2 x [] = x
intercala2 [] y = y
intercala2 (x:xs) (y:ys) = x : y : (intercala2 xs ys)

-- a lista ja esta ordenada?
ordenada [] = True
ordenada [x] = True
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
ultimo (x:xs) = ultimo xs

-- retorna a lista sem o utlimo elemento
comeco [x] = []
comeco (x:xs) = x : comeco xs

-- shift right
-- shiftr [1,2,3,4]
-- ==> [4,1,2,3]
shiftr [] = []
shiftr [x] = [x]
shiftr (x:xs) = head (shiftr xs) : x : tail (shiftr xs)

-- shiftr n lista (shift right n vezes)
shiftrN [] n = []
shiftrN [x] n = [x]
shiftrN (x:xs) 0 = (x:xs)
shiftrN (x:xs) n = shiftrN (head (shiftrN xs 1) : x : tail (shiftrN xs 1)) (n-1)

-- shift left
-- shiftl [1,2,3,4]
-- ==> [2,3,4,1]
shiftl [] = []
shiftl (x:xs) = xs ++ [x]

-- shift left n vezes
shiftlN [] n = []
shiftlN [x] n = [x]
shiftlN (x:xs) 0 = (x:xs)
shiftlN (x:xs) n = shiftlN (xs ++ [x]) (n-1)

-- remove item da lista (1 vez so)
removePrim e [] = []
removePrim e (x:xs)
  | x == e = xs
  | otherwise = x : removePrim e xs

-- remove item da lista (todas as vezes)
remove e [] = []
remove e (x:xs)
  | x == e = remove e xs
  | otherwise = x : remove e xs

-- remove item da lista n (as primeiras n vezes)
removeN e [] n = []
removeN e (x:xs) n
  | n <= 0 = (x:xs)
  | x == e = removeN e xs (n-1)
  | otherwise = x : removeN e xs n

-- remove item da lista (a ultima vez que ele aparece) **
removeUlt e [] = []
removeUlt e (x:xs)
  | x /= e = x : removeUlt e xs
  | otherwise = if xs == removeUlt e xs then xs
                                        else x : removeUlt e xs

-- troca velho por novo na lista (1 so vez)
trocaPrim a b [] = []
trocaPrim a b (x:xs)
  | x == a = b : xs
  | otherwise = x : trocaPrim a b xs

-- troca velho por novo na lista (todas vezes)
troca a b [] = []
troca a b (x:xs)
  | x == a = b : troca a b xs
  | otherwise = x : troca a b xs

-- troca velho por novo na lista n (as primeiras n vezes)
trocaN a b [] n = []
trocaN a b (x:xs) n
  | n <= 0 = (x:xs)
  | x == a = b : trocaN a b xs (n-1)
  | otherwise = x : trocaN a b xs (n-1)
