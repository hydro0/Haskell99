module NextPalindrome
    ( solve
    ) where

import Data.List ( reverse, find, concat )
import Data.Char ( intToDigit )
solve :: String -> String
solve = show . nextPalindrome . read

nextPalindrome :: Int -> String
nextPalindrome n = map intToDigit . nextPalindromeList . digits $ (n + 1)

nextPalindromeList :: [Int] -> [Int]
nextPalindromeList digs = findNextPalindrome digs (reverse digs)

findNextPalindrome :: [Int] -> [Int] -> [Int]
findNextPalindrome []   = []
findNextPalindrome [x]  = [x]
findNextPalindrome []

digits :: Int -> [Int]
digits n
    | n < 10    = [n]
    | otherwise = (n `mod` 10) : digits (n `div` 10)