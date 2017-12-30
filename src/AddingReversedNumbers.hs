module AddingReversedNumbers
    ( solve
    ) where

solve :: String -> String
solve l = let xs      = words l
              (a:b:_) = read . reverse <$> xs
	      in show . reversal $ (a + b)

reversal :: Int -> Int
reversal = go 0
  where go a 0 = a
        go a b = let (q,r) = b `quotRem` 10 in go (a*10 + r) q