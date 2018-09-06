-- currying
isUpper = (`elem` ['A'..'Z'])
isLower = (`elem` ['a'..'z'])

-- higher order functions
zipWith' _ [] _ = []
zipWith' _ _ [] = []
zipWith' f (a:as) (b:bs) = (f a b) : (zipWith' f as bs)

flip' f = g
          where g x y = f y x

map' _ [] = []
map' f (a:as) = (f a) : (map' f as)

filter' _ [] = []
filter' f (a:as)
  | f a = a : filter' f as
  | otherwise = filter' f as

-- fold
somaL l = foldl (+) 0 l
somaR l = foldr (+) 0 l
somaL1 l = foldl1 (+) l
somaR1 l = foldr1 (+) l

-- foldr combina valor-inicial-res lista
-- foldr _ z []     = z 
-- foldr f z (x:xs) = f x (foldr f z xs) 

-- foldr combina valor-inicial-acc lista
-- foldl _ z []     = z                  
-- foldl f z (x:xs) = foldl f (f z x) xs
