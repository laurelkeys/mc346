-- soma dos elementos de uma lista
soma x = soma' x 0
  where soma' [] acc = acc
        soma' (x:xs) acc = soma' xs (x+acc)

-- soma dos números pares de uma lista
somaPares xs = soma [x | x <- xs, mod x 2 == 0]

-- tamanho de uma lista
tamanho xs = soma [1 | _ <- xs]

-- conta quantas vezes o item aparece na lista (0 se nenhuma)
conta e xs = tamanho [x | x <- xs, x == e]

-- dado n gera a lista de 1 a n
gera n = [1..n]

-- remove item da lista (todas as vezes)
remove e xs = [x | x <- xs, x /= e]

-- troca velho por novo na lista (todas vezes)
troca a b xs = [if x == a then b else x | x <- xs]

-- quicksort
qs [] = []
qs (x:xs) = menor ++ [x]  ++ maior
  where  menor = qs [y | y <- xs, y <= x]
         maior = qs [y | y <- xs, y > x]
