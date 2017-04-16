-- http://forums.hardwarezone.com.sg/eat-drink-man-woman-16/programming-guys-there-better-way-improve-my-current-solution-5597987.html
-- Trying out benchmarking technique in Haskell: http://chrisdone.com/posts/measuring-duration-in-haskell
-- Bug: To investigate 2nd benchmark time seem to be invalid.

{-# LANGUAGE OverloadedStrings #-}
import Control.Exception (evaluate)
import Formatting ((%), fprint)
import Formatting.Clock (timeSpecs)
import System.Clock (getTime, Clock(Monotonic))
import Data.List

-- Data array
input :: [String]
input = ["aab","aaa","aabb","abcdefa","abfdefa","zzzzzzzz","a","aaab","aaabb"]

-- Method 1 : Brute force via Data.List.permutations build-in lirary
permAlone :: String -> Int
permAlone str = length $ filter (checkRepeat) (upl)
    where upl = permutations $ str
          checkRepeat [x] = True
          checkRepeat (x:y:zz) = if (x == y) then
                                    False
                                 else
                                    checkRepeat (y:zz)

-- Method 2 : Trie
permAlone' :: String -> Int
permAlone' x = genTrie [] x

checkgen :: String -> String -> Int
checkgen x [] = 1
checkgen x y = genTrie x y

genTrie :: String -> String -> Int
genTrie cur bank = sum $ map (\x-> checkgen (cur++[x]) (delete x bank)) newbank
    where newbank = if (length cur == 0) then
                       map (\x -> x) bank
                    else
                       filter (\x -> (last cur) /= x) bank

main :: IO ()
main = do
    start <- getTime Monotonic
    temp <- evaluate (map permAlone input)
    end <- getTime Monotonic
    fprint (timeSpecs % "\n") start end

    start' <- getTime Monotonic
    temp' <- evaluate (map permAlone' input)
    end' <- getTime Monotonic
    fprint (timeSpecs % "\n") start' end'

    let result = zip3 input temp temp'
    mapM_ print result
