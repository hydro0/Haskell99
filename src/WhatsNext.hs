module WhatsNext (
    main
) where

main = do
    l <- getLine
    let xs = words l
        (a:b:c:_) = read <$> xs
    solve a b c

data Progression = GP Int | AP Int

solve :: Int -> Int -> Int -> IO ()
solve 0 0 0 = return ()
solve a b c = let p  = findProgression a b c
                  n  = next p c
                  r  = show p ++ " " ++ show n
              in do
                 putStrLn r
                 main

findProgression :: Int -> Int -> Int -> Progression
findProgression a b c = let d1 = b - a
                            d2 = c - b
                        in if d1 == d2 then AP d1
                        else GP (quot b a)

next :: Progression -> Int -> Int
next (AP d) = (+) d
next (GP m) = (*) m

instance Show Progression where
    show (GP _) = "GP"
    show (AP _) = "AP"