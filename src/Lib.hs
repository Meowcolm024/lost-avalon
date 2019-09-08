{- The place to write the code? -}
module Lib
    ( someFunc
    ) where

import Text.ParserCombinators.Parsec
import System.IO
import System.Environment
import Words

someFunc :: IO ()
someFunc = do
    (name:args) <- getArgs
    handle      <- openFile name ReadMode  
    contents    <- hGetContents handle 
    let codes   = getVal $ parseTo $ contents ++ "\n" 
    let vars    = transVar $ findVar codes
    writeFile (takeWhile (/= '.') name ++ ".py") $ parseBack (map (`replaceList` (keywords ++ vars)) codes)
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

-- find Chinese variants and convert them to English
findVar :: [[String]] -> [String]
findVar (x:xs)
    | null x           = findVar xs
    | head x == varkey = tail x
    | otherwise        = findVar xs

transVar :: [String] -> [(String,String)]
transVar []             = []
transVar (x:xs) = let l = length xs in (x, "var" ++ show l) : transVar xs
