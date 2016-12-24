-- Create this algorithm as my friend can't find the target "DOG" in the matrix
-- Direction only move along North, East, South, West, NorthEast, SouthEast, SouthWest, NorthWest in a single direction

import System.IO.Unsafe
import Data.List

type Coord = (Int,Int)

target :: String
target = "DOG"

fileMatrix :: [String]
fileMatrix = lines $ unsafePerformIO $ readFile "input.txt"
(minrow,mincol,maxrow,maxcol) = (0,0,length fileMatrix-1, length (fileMatrix!!0)-1)

validRange :: [Coord]
validRange = [(row,col) | row <- [minrow..maxrow], col <- [mincol..maxcol]]
             where targetLength = length target - 1

getMatrixChar :: Coord -> Char
getMatrixChar (row,col)
    | row < minrow || row > maxrow || col < mincol || col > maxcol = ' '
    | otherwise = fileMatrix!!row!!col

getNewCoord :: Coord -> Coord -> Coord
getNewCoord coord@(orow,ocol) direction@(nrow,ncol) = (orow+nrow, ocol+ncol)

initTraverse :: Coord -> [[Coord]]
initTraverse coord@(row,col)
    | currentChar == head target = filter (not.null) $
            targetTraverse [coord] (-1,0) : -- North
            targetTraverse [coord] (0,1) : -- East
            targetTraverse [coord] (1,0) : -- South
            targetTraverse [coord] (0,-1) : -- West
            targetTraverse [coord] (-1,1) : -- NorthEast
            targetTraverse [coord] (1,1) : -- SouthEast
            targetTraverse [coord] (1,-1) : -- SouthWest
            targetTraverse [coord] (-1,-1) :[] -- NorthWest with tail
    | otherwise = []
    where currentChar = getMatrixChar coord

targetTraverse :: [Coord] -> Coord -> [Coord]
targetTraverse prevCoord curDirection
    | latestrow < minrow || latestrow > maxrow || latestcol < mincol || latestcol > maxcol = []
    | length prevCoord > length target = []
    | length prevCoord == length target && curString == target = prevCoord
    | getMatrixChar curCoord == target!!(length prevCoord) = targetTraverse (prevCoord++[curCoord]) curDirection
    | otherwise = []
    where lastestCoord@(latestrow, latestcol) = last prevCoord
          curCoord = getNewCoord lastestCoord curDirection
          curString = map (getMatrixChar) prevCoord

getNonProgrammerCoord :: [Coord] -> [Coord]
getNonProgrammerCoord [] = []
getNonProgrammerCoord ((curRow,curCol):xs) = (curRow+1,curCol+1) : getNonProgrammerCoord xs

main :: IO ()
main = do
    let result = concat $ map initTraverse validRange
    case (length result) of
        0 -> print $ intercalate " " ["No",target, "is found"]
        _ -> do print $ intercalate " " [target, "found at the following position (Row,Column):"]
                mapM_ (print.getNonProgrammerCoord) result
