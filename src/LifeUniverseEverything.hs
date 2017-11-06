module LifeUniverseEverything
    ( solve
    ) where

import Control.Monad ( unless )

solve :: IO ()
solve = getLinesBefore42

getLinesBefore42 :: IO ()
getLinesBefore42 = do
    l <- getLine
    let i = read l
    unless (i == 42) (print i >> getLinesBefore42)