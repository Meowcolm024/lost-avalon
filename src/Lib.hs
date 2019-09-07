{- The place to write the code? -}
module Lib
    ( someFunc
    ) where

import Text.ParserCombinators.Parsec
import System.IO
import Words

someFunc :: IO ()
someFunc = do
    handle <- openFile "t1.txt" ReadMode  
    contents <- hGetContents handle  
    writeFile "t1.py" $ parseBack $ getVal $ parseTo contents  
    hClose handle  
  
wyFile = endBy line eol
line = sepBy cell (char ' ')
cell = many (noneOf " \n")
eol = char '\n'

-- convert to single word
parseTo :: String -> Either ParseError [[String]]
parseTo = parse wyFile "(unknown)"

-- convert back to normal format
parseBack :: [[String]] -> String
parseBack x = unlines $ map unwords x

getVal :: Either a b -> b
getVal (Right x) = x
getVal (Left x) = error "Error"

replace :: (Eq a) => a -> [(a, a)] -> a
replace x ((a, b):ys)
    | x == a = b
    | x /= a && ys /= [] = replace x ys
    | otherwise = x

replaceList :: (Eq a) => [a] -> [(a, a)] -> [a]
replaceList [] _ = []
replaceList xs ys = map (`replace` ys) xs