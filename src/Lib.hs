module Lib
    ( someFunc
    ) where

someFunc :: IO ()
someFunc = print str where str = repli 3 "abcde"

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
dropEvery xs n = dropEvery