module RPN
    ( solve
    ) where

import Data.List ( groupBy, intercalate, elemIndex, splitAt, elem )

type Operator = Char
data Expression = Variable Char | Operation Operator Expression Expression

solve :: String -> String
solve = evalExpression . parseExpression

evalExpression :: Expression -> String
evalExpression (Variable c)        = [c]
evalExpression (Operation o e1 e2) = evalExpression e1 ++ evalExpression e2 ++ [o]

parseExpression :: String -> Expression
parseExpression [c] = Variable c
parseExpression e   =
    let (o, e1, e2) = splitExpression e
    in Operation o (parseExpression e1) (parseExpression e2)

splitExpression :: String -> (Char, String, String)
splitExpression = splitPureExpression . init . tail
    where splitPureExpression e =
              let index       = findOperatorIndex 0 0 e
                  (e1, o:e2)  = splitAt index e
              in (o, e1, e2)

findOperatorIndex :: Int -> Int -> String -> Int
findOperatorIndex n p ('(':xs) = findOperatorIndex (n + 1) (p + 1) xs
findOperatorIndex n p (')':xs) = findOperatorIndex (n - 1) (p + 1) xs
findOperatorIndex n p (x:xs)
    | x `elem` "*/-+^"  && n == 0   = p
    | otherwise                     = findOperatorIndex n (p + 1) xs