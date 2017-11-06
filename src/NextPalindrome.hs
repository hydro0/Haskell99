module NextPalindrome
    ( solve
    ) where

import Data.List ( reverse, find )

solve :: String -> String
solve = show . nextPalindrome . read

nextPalindrome :: Int -> Int
nextPalindrome n =
    let (Just next) = find isPalindrome [(n+1)..]
    in next

isPalindrome :: Int -> Bool
isPalindrome n = reversal n == n

reversal :: Int -> Int
reversal = go 0
  where go a 0 = a
        go a b = let (q,r) = b `quotRem` 10 in go (a*10 + r) q