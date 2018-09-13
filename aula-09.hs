data Expr = Val Int | Div Expr Expr deriving (Show)

-- unsafe
unsafeeval :: Expr -> Int
unsafeeval (Val n) = n
unsafeeval (Div x y) = (unsafeeval x) `div` (unsafeeval y)

-- safe
safediv :: Int -> Int -> Maybe Int
safediv m n = if n == 0 then Nothing else Just (m `div` n)

safeeval :: Expr -> Maybe Int
safeeval (Val n) = Just n
safeeval (Div x y) = safeeval x >>= (\m ->
                     safeeval y >>= (\n ->
                     safediv m n))

-- m >>= f = case m of 
--             Nothing -> Nothing
--             Just x -> f x

-- "do notation"
eval :: Expr -> Maybe Int
eval (Val n) = return n
eval (Div x y) = do
                  m <- eval x
                  n <- eval y
                  safediv m n

-- Maybe monad
-- return :: a -> Maybe a
-- >>= :: Maybe a -> (a -> Maybe b) -> Maybe b
