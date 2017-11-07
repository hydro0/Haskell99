module NextPalindrome
    ( solve
    ) where

import Data.List ( reverse, find, concat )
import Data.Char ( intToDigit, digitToInt )
solve :: String -> String
solve = nextPalindrome

nextPalindrome :: String -> String
nextPalindrome = map intToDigit . nextPalindromeList . increment . map digitToInt

nextPalindromeList :: [Int] -> [Int]
nextPalindromeList digits = findNextPalindrome (reverse h2) h1
    where (h1, h2) = splitAt (half digits) digits

half :: [a] -> Int
half xs = length xs `div` 2

findNextPalindrome :: [Int] -> [Int] -> [Int]
findNextPalindrome [] _         = []
findNextPalindrome xs []        = xs
findNextPalindrome digs rDigs   =
    let first   = head digs
        last    = head rDigs
        recur   = if first <= last then last : findNextPalindrome (tail digs) (tail rDigs) ++ [last]
        else nextPalindromeList . increment $ rDigs ++ reverse digs
    in recur

increment :: [Int] -> [Int]
increment []        = [1]
increment (x:xs)    =
    let inc = x + 1
    in if inc < 10 then inc:xs else 0:increment xs

digits :: Int -> [Int]
digits n
    | n < 10    = [n]
    | otherwise = (n `mod` 10) : digits (n `div` 10)