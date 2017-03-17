module Lib
    ( someFunc
    ) where

import System.Random

someFunc :: IO ()
someFunc = print str where str = range 5 12

myLast :: [a] -> a

myLast [] = error "No end for empty lists!"
myLast [x] = x
myLast (_:xs) = myLast xs

myButLast :: [a] -> a
myButLast [] = error "No end for empty lists!"
myButLast [x] = error ""
myButLast [x, _] = x
myButLast (_:xs) = myButLast xs

elementAt :: [a] -> Int -> a
elementAt [] _ = error ""
elementAt (x:_) 1 = x
elementAt (_:xs) i = elementAt xs (i-1)

myLength :: [a] -> Int
myLength [] = 0
myLength (_:xs) = 1 + myLength xs

myReverse :: [a] -> [a]
myReverse [] = []
myReverse [x] = [x]
myReverse (x:xs) = myReverse xs ++ [x]

isPalindrome :: (Eq a) => [a] -> Bool
isPalindrome xs = xs == (myReverse xs)

data NestedList a = Elem a | List [NestedList a]
myFlatten :: NestedList a -> [a]
myFlatten (Elem x) = [x]
myFlatten (List []) = []
myFlatten (List (x:xs)) = myFlatten x ++ myFlatten (List xs)

compress :: (Eq a) => [a] -> [a]
compress (x:ys@(y:_))
    | x == y    = compress ys
    | otherwise = x : compress ys
compress ys = ys

pack :: (Eq a) => [a] -> [[a]]
pack (x:xs) = let (first,rest) = span (==x) xs
                in (x:first) : pack rest
pack [] = []

encode :: (Eq a) => [a] -> [(Int, a)]
encode xs = map compose $ pack xs
    where compose xs = (length xs, head xs)

data Ext a = Multiple (Int, a) | Single a deriving (Show)

encode_mod :: (Eq a) => [a] -> [Ext a]
encode_mod xs = let ext (1, x) = Single x
                    ext (y, x) = Multiple (y, x)
                in map ext $ encode xs


decode_mod :: [Ext a] -> [a]
decode_mod xs = let dec (Single a) = [a]
                    dec (Multiple (c, a)) = replicate c a
                in concat $ map dec xs

dupl :: [a] -> [a]
dupl [] = []
dupl [x] = [x, x]
dupl (x:xs) = x:x:(dupl xs)

repli :: Int -> [a] -> [a]
repli c xs = concat $ map (replicate c) xs

dropEvery :: [a] -> Int -> [a]
dropEvery xs n = dropEvery' xs n
    where dropEvery' [] _ = []
          dropEvery' (x:xs) 1 = dropEvery' xs n
          dropEvery' (x:xs) k = x : dropEvery' xs (k-1)

split :: [a] -> Int -> ([a], [a])
split xs n = helper xs n
    where helper (x:xs) k | k > 0 = let (y, ys) = helper xs (k-1) in (x:y, ys)
          helper xs _ = ([], xs)

rotate :: [a] -> Int -> [a]
rotate [] _ = []
rotate xs 0 = xs
rotate (x:xs) n | n > 0 = rotate (xs ++ [x]) (n-1)
rotate xs n | n < 0 = rotate xs (length xs + n)

remove :: [a] -> Int -> (Maybe a, [a])
remove [] _ = (Nothing, [])
remove (x:xs) 1 = (Just x, xs)
remove (x:xs) n = let (y,ys) = remove xs (n-1) in (y, x : ys)

insertAt :: a -> [a] -> Int -> [a]
insertAt x xs 1 = x:xs
insertAt x (y:ys) n = y : insertAt x ys (n-1)

range :: Int -> Int -> [Int]
range i k | i == k = [k]
range i k | i < k = i : range (i+1) k
range i k | i > k = i : range (i-1) k