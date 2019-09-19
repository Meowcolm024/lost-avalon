{- The place to write the code? -}
module Lib
    ( someFunc
    ) where

import Text.ParserCombinators.Parsec
import System.IO
import System.Environment
import Words
import Detector

someFunc :: IO ()
someFunc = do
    (name:args) <- getArgs
    handle      <- openFile name ReadMode
    contents    <- hGetContents handle
    let codes   = getVal $ parseTo $ contents ++ "\n" 
    let vfcs    = detectFC codes ++ detectVar codes
    let tmp     = map (`replaceList` (keywords ++ vfcs)) codes
    writeFile (takeWhile (/= '.') name ++ ".py") $ parseBack tmp
    hClose handle  

wyFile = endBy line eol
line   = sepBy cell (char ' ')
cell   = many (noneOf " \n")
eol    = char '\n'

-- convert to single word
parseTo :: String -> Either ParseError [[String]]
parseTo = parse wyFile "(unknown)"

-- convert back to normal format
parseBack :: [[String]] -> String
parseBack x = unlines $ map unwords x

getVal :: Either a b -> b
getVal (Right x) = x
getVal (Left x)  = error "Probably syntax error"

-- replace Wenyan sytax with Python syntax
replace :: (Eq a) => a -> [(a, a)] -> a
replace x ((a, b):ys)
    | x == a             = b
    | x /= a && ys /= [] = replace x ys
    | otherwise          = x

replaceList :: (Eq a) => [a] -> [(a, a)] -> [a]
replaceList [] _  = []
replaceList xs ys = map (`replace` ys) xs
