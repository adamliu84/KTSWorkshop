-- Facebook friend who post the following & <Mr. Robot Season 2, Episode 11>, ROT13 cipher   
-- trigger me to create a Haskell script to comb list of english words that fulfil the requirement
-- https://www.reddit.com/r/todayilearned/comments/2x3gea/til_that_if_you_take_all_the_letters_from_the/

import Data.Char
import Network.HTTP.Conduit
import Network.HTTP
import qualified Data.ByteString.Lazy as LB (unpack)
import Data.Maybe (catMaybes)

revrot :: Char -> Char
revrot x     
    | charint >= 97 && charint <= 110 = chr $ 122 - (charint - 97)
    | charint > 111 && charint <= 122 = chr $ 97 + (122 - charint)
    | otherwise = x
    where charint = Data.Char.ord $ toLower x

revword :: String -> String
revword x = reverse $ map revrot x

checkrevword :: String -> Maybe (String, String, String)
checkrevword x
    | x == y = Just (x,z,y)
    | otherwise = Nothing
    where y = revword x
          z = map revrot x

-- Ref https://www.quora.com/Where-can-I-find-a-dictionary-in-a-CSV-or-Excel-format
url :: String
url = "https://raw.githubusercontent.com/eneko/data-repository/master/data/words.txt"

dlDictionaryCsv ::  IO [String]
dlDictionaryCsv = do 
                  return.lines.bsToStr =<< simpleHttp url
    where bsToStr = map (chr . fromEnum).LB.unpack

main :: IO ()
main = do    
    -- lWords <- (return.lines) =<< readFile "words.csv" -- Temp for local reading
    lWords <- dlDictionaryCsv
    let lValidReqWords = catMaybes $ map checkrevword lWords
    mapM_ print lValidReqWords
    