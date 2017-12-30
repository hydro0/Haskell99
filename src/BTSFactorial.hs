module BTSFactorial
    ( solve
    ) where

solve :: String -> String
solve = show . calculateResult . read

calculateResult :: Int -> Int
calculateResult x = calculateResultInt x 0

calculateResultInt :: Int -> Int -> Int
calculateResultInt x n = if x < 5 then 0 else
					  let (c, f) = findForPow n
					  in
					  		if f < x then calculateResultInt x (n + 1)
					  		else if f == x then c
					  			 else let (c1, f1) = findForPow (n - 1)
					  			 	  in c1 + calculateResult (x - f1)

findForPow :: Int -> (Int, Int)
findForPow 0 = (0, 1)
findForPow n = let (c, f) = findForPow (n - 1)
			   in (1 + 5 * c, 5 * f)
