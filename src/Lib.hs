module Lib
    ( someFunc
    ) where

someFunc :: IO ()
someFunc = print str where str = isPalindrome [2,3,4,5,4,3,2]

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

compress :: (Eq a) => [a] -> []
compress [] = []
compress [x] = x
compress (x:xs) =