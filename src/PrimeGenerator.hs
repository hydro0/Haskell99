module PrimeGenerator
    ( solve
    ) where

import Data.List (intercalate)

solve :: String -> String
solve l = let xs      = words l
              (a:b:_) = read <$> xs
              primes  = getPrimes a b
          in (++"\n") $ intercalate "\n" $ show <$> primes

isPrime :: Int -> Bool
isPrime 1 = False
isPrime 2 = True
isPrime k = null [ x | x <- [2..isqrt k], k `mod`x  == 0]

getPrimes :: Int -> Int -> [Int]
getPrimes x y
    | x > y     = []
    | x == y    = [x | isPrime x]
    | otherwise = [ k | k <- [x..y], isPrime k]

isqrt :: Int -> Int
isqrt = floor . sqrt . fromIntegral