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
    {-
    let tmp     = map (`replaceList` keywords) codes
    let vfcs    = detectFC tmp ++ detectVar tmp
    let fin     = map (`replaceList` vfcs) tmp
    -}
    let vars    = transVar $ findVar codes
    let fcs     = transFC funkey (findFC funkey codes) ++ transFC classkey (findFC classkey codes)
    writeFile (takeWhile (/= '.') name ++ ".py") $ parseBack (map (`replaceList` (keywords ++ vars ++ fcs)) codes)
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
transVar []     = []
transVar (x:xs) = let l = length xs in (x, "var" ++ show l) : transVar xs

findFC :: String -> [[String]] -> [String]
findFC _ []         = []
findFC _ [x]        = []
findFC key (x:xs)
    | null y        = findFC key xs
    | head y == key = y !! 1 : findFC key xs
    | otherwise     = findFC key xs
    where y = dropWhile (== "") x

transFC :: String -> [String] -> [(String,String)]
transFC _ []        = []
transFC k (x:xs)
    | k == funkey   = (x, "fun" ++ show l) : transFC funkey xs
    | k == classkey = (x, "cla" ++ show l) : transFC classkey xs
    where l = length xs
