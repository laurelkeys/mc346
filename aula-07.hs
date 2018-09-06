-- piping
-- f (g (h x y))
-- f $ g $ h x y

-- function composition
-- f (g x)
-- (f . g) x
aplica2 f = f . f
aplica3 f = f . f . f

-- conta o numero de vezes um item aparece numa lista
contaL it l = foldl (\acc x -> if x == it then acc+1 else acc) 0 l
contaR it l = foldr (\x res -> if x == it then res+1 else res) 0 l

-- conta quantos elementos satisfazem uma funcao
contaf f l = foldl (\acc x -> if f x then acc+1 else acc) 0 l

-- troca elemento velho por novo
trocaL velho novo l = foldl (\acc x -> if x == velho then acc++[novo] else acc++[x]) [] l
trocaR velho novo l = foldr (\x res -> if x == velho then novo:res else x:res) [] l 

-- remove elemento de uma lista (primeiras n vezes)
removeN it n l = fst $
                 foldl (\(l', n') x -> 
                        if x == it && n' > 0
                          then (l', n'-1)
                          else (l'++[x], n'))
                 ([], n) l

-- cria uma arvore a partir de uma lista
data Tree a = Vazia | No a (Tree a) (Tree a) deriving (Eq, Show, Read)

-- insereArvore acc x
insereListaL l = foldl insereArvore Vazia l
-- insereArvore res x == (flip insereArvore) x res
insereListaR l = foldr (flip insereArvore) Vazia l

insereArvore Vazia x = No x Vazia Vazia
insereArvore (No n esq dir) x 
   | x == n = (No n esq dir)
   | x < n  = (No n (insereArvore esq x) dir)
   | x > n  = (No n esq (insereArvore dir x))

-- uma matrix é implementada como uma lista de linhas (que são listas)
-- 1  2  3
-- 4  5  6 
-- 7  8  9
-- 0  0 -1
-- [[1,2,3],[4,5,6],[7,8,9],[0,0,-1]]

-- implemente transposta que transpoe uma matrix
transposta ([]:_) = []
transposta m = col : transposta m'
               where col = map (head) m
                     m' = map (tail) m

-- implemente matmul que dado duas matrizes de formatos apropriados multiplica-as. (*)
-- obs.: mt é uma matriz transposta, assim é uma lista de colunas (não linhas)
-- matmul [[1,1,1]] [[3],[5],[7]]
-- [[15]]
-- matmul [[3],[5],[7]] [[1,1,1]]
-- [[3,3,3],[5,5,5],[7,7,7]]
matmul m1 m2 = matmul' m1 (transposta m2)
matmul' [] mt = []
matmul' (lin:linhas) mt = (map (\col -> dotprod lin col) mt) : matmul' linhas mt
                          where dotprod lin col = sum $ zipWith (*) lin col
