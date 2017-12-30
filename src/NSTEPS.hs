module NSTEPS (
    solve
) where

solve :: String -> String
solve l = let xs      = words l
              (a:b:_) = read <$> xs
              r       = inPoint a b
          in if r == -1 then "No Number" else show r

inPoint :: Int -> Int -> Int
inPoint x y = if (valid x y)
                then x + y  - (y `mod` 2)
              else -1

valid :: Int -> Int -> Bool
valid x y
    | x == y    = True
    | otherwise = (x - y) == 2