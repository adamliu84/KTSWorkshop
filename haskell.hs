import Data.List as L

main = do
	main0
	main1
	main2
	main3
	main4
	main5
	main6
	main7
    
-- Example 0: Introduction
data Noob = NoobLevel {getLevel :: String}
             | NoobSpeaker {getName :: String, getTitle :: String}
             | NoobAudiences {getNames :: [String]}

example0 :: Noob -> Noob -> Noob -> IO ()
example0 level speaker audiences = do
        let szAudiences = unwords $ L.intersperse "," $ getNames audiences
        print $ getLevel level ++ " Haskell kickstart guide " ++
                "by " ++ getName speaker ++ " (" ++ getTitle speaker ++ ") " ++
                "for " ++ szAudiences
                
main0 :: IO ()
main0 = do
    let level = NoobLevel "Noob"
        speaker = NoobSpeaker "Adam" "Noob minion"
        audiences = NoobAudiences ["Liu Bei", "Cao Cao", "Sun Quan"]
    example0 level speaker audiences
   
-- Example 1: Pattern matching
main1 :: IO ()
main1 = do
    let lNum = countup 1 2
    putStrLn . show $ lNum    
    where countup _  100 = []
          countup inc cur = cur : countup inc (cur+inc)  

-- Example 2: Curry
main2 :: IO ()
main2 = do
    let countupByInc5 = countup 5
        countupByInc10 = countup 10
        lNum = countupByInc5 10
    putStrLn . show $ lNum    
    where countup _  100 = []
          countup inc cur = cur : countup inc (cur+inc) 

-- Example 3 : Guards   
main3 :: IO ()
main3 = do
    let lNum = countup 10 11
    putStrLn . show $ lNum    
    where countup inc cur
           | cur > terminalValue = []
           | otherwise = cur : countup inc (cur+inc)
           where terminalValue = 100                   
          
-- Example 4: Functor & Map
example4Func :: Int -> Int -> Int -> [Int]
example4Func term inc cur
         | cur > terminalValue = []         
         | otherwise = cur : example4Func term inc (cur+inc)
         where terminalValue = term

main4 :: IO ()
main4 = do
    let lTemp = example4Func 20 2 1
        lNum = map (*10) lTemp
    putStrLn . show $ lNum              
    
-- Example 5: Folding, reduce
example5 :: [Int]
example5 = [2,3,4,5,6]
      
main5 :: IO ()
main5 = do
    let lTemp = example5         
        lNumL = foldl (+) 0 lTemp    
        lNumR = foldr (+) 0 lTemp
    putStrLn . show $ lTemp    
    putStrLn $ "By left folding: " ++ (show $ lNumL :: String)
    putStrLn $ "By right folding: " ++ (show $ lNumR :: String)
       
-- Example 6: Folding right & left
main6 :: IO ()
main6 = do
    let lTemp = example5         
        lNumL = foldl (-) 0 lTemp    
        lNumR = foldr (-) 0 lTemp
    putStrLn . show $ lTemp    
    putStrLn $ "By left folding: " ++ (show $ lNumL :: String)
    putStrLn $ "By right folding: " ++ (show $ lNumR :: String)

-- Example 7: Filter, lambda (aka anonymous functions), mapM_
example7 = [93,22,53,344,25,5,234,43,363,456,1434,12,52,8756,3423,654,2341,7654,1321,435,33]

main7 :: IO ()
main7 = do
    let lNum = filter (\x -> x `mod` divValue == 0 && x < terminalValue ) example7        
    putStrLn . show $ lNum
    let iam100 = terminalValue `div` 5    
        lNum = map (\x -> (show x) ++ " is less than " ++ (show iam100) ) $ 
                filter (\x -> x `mod` divValue == 0 && x < iam100) example7
    mapM_ (print) lNum  
    where   divValue = 3
            terminalValue = 500
