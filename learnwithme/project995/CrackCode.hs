-- Reference: http://puzzling.stackexchange.com/questions/46871/crack-the-lock-code
import Data.List
import Data.Maybe

padding :: Int -> String
padding x = (take padN $ repeat '0') ++ (show x)
    where padN = 3 - (length.show $ x)

oneWellPlace :: String -> String -> Maybe String
oneWellPlace cs x = if (x!!0 == cs!!0) || (x!!1 == cs!!1) || (x!!2 == cs!!2) then
                        Just x
                   else
                       Nothing

oneCorrect :: String -> String -> Maybe String
oneCorrect cs x = if (e1 || e2 || e3) then
                    Just x
                  else
                    Nothing
    where e1 = (cs!!0 `elem` [x!!1,x!!2])
          e2 = (cs!!1 `elem` [x!!0,x!!2])
          e3 = (cs!!2 `elem` [x!!0,x!!1])

nCorrect :: Int -> String -> String -> Maybe String
nCorrect n cs x = case oneWellPlace cs x of
                    Just _ -> Nothing
                    Nothing -> case oneCorrect cs x of
                                Just _ -> if (length (cs `intersect` x) == n) then
                                            Just x
                                          else
                                             Nothing
                                Nothing -> Nothing

twoCorrect :: String -> String -> Maybe String
twoCorrect = nCorrect 2

threeCorrect :: String -> String -> Maybe String
threeCorrect = nCorrect 3 -- Not used, for curry example

nothingCorrect :: String -> String -> Maybe String
nothingCorrect cs x  = if (not.or $ map (\a-> a `elem` x) cs) then
                        Just x
                    else
                        Nothing

checkNum :: Int -> Maybe String
checkNum x = oneWellPlace "682" sx >>=  -- One number is correct & well placed
             oneCorrect "614" >>=       -- One number is correct but wrong palced
             twoCorrect "206" >>=       -- Two numbers are correct but wrong placed
             nothingCorrect "738" >>=   -- Nothing is correct
             oneCorrect "780"           -- One number is correct but wrong palced
    where sx = padding x

main :: IO ()
main = do
    let result = catMaybes $ map checkNum [0..999] -- Loop from "000" to "999"
    print $ result -- Print valid matching result(s)
