import System.IO
import Data.List
import Text.Regex.Posix

pattern = "roaH"
type Pattern = String

mFunctionListing :: IO [String]
mFunctionListing = return.sort.lines =<< readFile "functionlisting.txt"

charCompare :: String -> Pattern -> Bool
charCompare _ [] = True
charCompare [] _ = False
charCompare (x:xs) (y:ys)
    | x == y = charCompare xs ys
    | otherwise = charCompare (xs) (y:ys)

regaxCompare :: String -> Pattern -> Bool
regaxCompare x y = x =~ (createPattern y)
    where createPattern :: String -> String
          createPattern z = "(.*)" ++ foldl (\acc a -> acc++[a]++"(.*)") [] z

main :: IO ()
main = do
    funclist <- mFunctionListing
    let byChar = filter (flip charCompare pattern) funclist
        byRegx = filter (flip regaxCompare pattern) funclist
    print byChar
    print byRegx
    print $ byChar == byRegx
