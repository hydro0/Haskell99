module Main where
import System.Random
import Data.List (permutations, subsequences)
import PrimeGenerator as PG
import LifeUniverseEverything as LUE
import RPN
import NextPalindrome as NP
import AddingReversedNumbers as ARN
import BTSFactorial as BTS

main :: IO ()
main = solveWithCounter BTS.solve

solveWithCounter :: (String -> String) -> IO ()
solveWithCounter f = do
    c <- getLine
    printResults f $ read c

printResults :: (String -> String) -> Int -> IO ()
printResults _ 0 = return ()
printResults f n = do
    line <- getLine
    let rpn = f line
    putStrLn rpn
    printResults f (n - 1)

--main = someFunc

--someFunc :: IO ()
--someFunc = str >>= print where str = return $ group [2, 2, 5] [1..9]

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

rnd_select :: [a] -> Int -> IO [a]
rnd_select xs n = do
    gen <- getStdGen
    return $ take n [ xs !! i | i <- randomRs(0, length xs - 1) gen ]

rnd_select_i :: Int -> Int -> IO [Int]
rnd_select_i n m = rnd_select [1..m] n

rndElem :: [a] -> IO a
rndElem xs = do
  index <- randomRIO (0, length xs - 1)
  return $ xs !! index

rndPermutation :: [a] -> IO [a]
rndPermutation xs = rndElem . permutations $ xs

combinations :: Int -> [a] -> [[a]]
--combinations 1 xs = map (\x -> [x]) xs
--combinations _ [] = []
--combinations n (x:xs) = (++ combinations n xs) . map (x:) . combinations (n - 1) $ xs
combinations n xs = filter ((==n) . length) . subsequences $ xs

--group :: [Int] -> [a] -> [[[a]]]