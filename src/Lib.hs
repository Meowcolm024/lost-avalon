{- The place to write the code? -}
module Lib
    ( someFunc
    ) where

import Text.ParserCombinators.Parsec
import System.IO

someFunc :: IO ()
someFunc = do
    handle <- openFile "t1.txt" ReadMode  
    contents <- hGetContents handle  
    print $ getVal $ parseCSV contents  
    hClose handle  
  
csvFile = endBy line eol
line = sepBy cell (char ' ')
cell = many (noneOf " \n")
eol = char '\n'

parseCSV :: String -> Either ParseError [[String]]
parseCSV = parse csvFile "(unknown)"

getVal :: Either a b -> b
getVal (Right x) = x
getVal (Left x) = error "Error"
