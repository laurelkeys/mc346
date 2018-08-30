-- define uma árvore binária
data Tree a = Vazia | No a (Tree a) (Tree a) deriving (Eq, Show, Read)

menor (No a Vazia _) = a
menor (No _ esq _) = menor esq

maior (No a _ Vazia) = a
maior (No _ _ dir) = maior dir

-- acha um item numa arvore de busca binaria (abb)
existe :: (Ord a) => a -> Tree a -> Bool
existe _ Vazia = False
existe it (No a esq dir)
  | it == a = True
  | it < a = existe it esq
  | otherwise = existe it dir

-- verifica se uma arvore é uma abb
abb :: (Ord a) => Tree a -> Bool
abb Vazia = True
abb (No a Vazia Vazia) = True
abb (No a esq dir)
  | esq == Vazia = a <= menorDir && abb dir
  | dir == Vazia = a >= maiorEsq && abb esq
  | a < maiorEsq = False
  | a > menorDir = False
  | otherwise = abb esq && abb dir && maiorEsq <= menorDir
  where menorDir = menor dir
        maiorEsq = maior esq
     
-- insere um item numa abb
insere :: (Ord a) => a -> Tree a -> Tree a
insere it Vazia = No it Vazia Vazia
insere it (No a esq dir)
  | it < a = No a (insere it esq) dir
  | it > a = No a esq (insere it dir)
  | otherwise = No a esq dir

-- remove um item de uma abb
remove :: (Ord a) => a -> Tree a -> Tree a
remove _ Vazia = Vazia
remove it (No a esq dir)
  | it < a = No a (remove it esq) dir
  | it > a = No a esq (remove it dir)
  | otherwise = removeRaiz (No a esq dir)

removeRaiz Vazia = Vazia
removeRaiz (No _ Vazia Vazia) = Vazia
removeRaiz (No _ esq Vazia) = esq
removeRaiz (No _ Vazia dir) = dir
removeRaiz (No _ esq dir) = let maiorEsq = maior esq in
                            (No maiorEsq (remove maiorEsq esq) dir)

-- calcula a profundidade maxima de uma abb
profundidade :: (Eq a, Num b, Ord b) => Tree a -> b
profundidade t = profundidade' t 0
  where profundidade' Vazia acc = acc
        profundidade' (No _ Vazia Vazia) acc = acc + 1
        profundidade' (No _ esq dir) acc 
          | esq == Vazia = profundidadeDir
          | dir == Vazia = profundidadeEsq
          | profundidadeDir >= profundidadeEsq = profundidadeDir
          | otherwise = profundidadeEsq
          where profundidadeDir = profundidade' dir (acc + 1)
                profundidadeEsq = profundidade' esq (acc + 1)

-- coverte uma abb numa lista em ordem infixa (arvore-esquerda, no, arvore-direita)
infixa :: Tree a -> [a]
infixa Vazia = []
infixa (No a esq dir) = (infixa esq) ++ [a] ++ (infixa dir)

-- converte uma abb numa lista em ordem prefixa (no, ae, ad)
prefixa :: Tree a -> [a]
prefixa Vazia = []
prefixa (No a esq dir) = [a] ++ (infixa esq) ++ (infixa dir)

-- converte uma lista em uma abb
converte :: (Ord a) => [a] -> Tree a
converte l = converte' l Vazia
             where converte' [] abb = abb
                   converte' (a:as) abb = converte' as (insere a abb)
