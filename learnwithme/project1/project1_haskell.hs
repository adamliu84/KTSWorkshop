{-|
Haskell quick prototyping on
Python Beginner Project #1! for </Learn With Me>
-}

import Data.Char (toUpper)

bottleRange :: [Int]
bottleRange = [99,98..0]
    
bottleBeerCount :: Int -> String
bottleBeerCount x 
    | 0 == x = ofBeer $ "no more bottles"
    | 1 == x = ofBeer $ bottlePS 1
    | otherwise = ofBeer $ bottlePS x
    where bottlePS x
            | x > 1 = show x ++ " bottles"
            | otherwise = show x ++ " bottle"
          ofBeer x = x ++ " of beer"

onTheWall :: Int -> String
onTheWall x = concat [bottleBeerCount x, " on the wall"] 

takeDown :: Int -> String
takeDown 0 = concat["Go to the store and buy some more, ", onTheWall $ maximum bottleRange, "."]
takeDown x = concat["Take one down and pass it around, ", onTheWall (x-1), "."]

verse :: Int -> String
verse x = firstPart x ++ "\n" ++ secondPart x ++ "\n\n"
    where firstPart x = concat [verseUpper (onTheWall x), ", ", bottleBeerCount x, "."]
          secondPart = takeDown
          verseUpper x = toUpper (head x) : tail x

main :: IO ()
main = let song = foldl (\b a-> b ++ verse a) "" bottleRange
       in putStr song
