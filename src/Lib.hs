{- The place to write the code? -}
module Lib
    ( someFunc
    ) where

import Text.ParserCombinators.Parsec
import System.IO
import System.IO.Error
import Control.Exception
import System.Environment
import Words
import Detector

someFunc :: IO ()
someFunc = toTry `catch` handler

toTry :: IO ()
toTry = do  (name:_) <- getArgs
            handle   <- openFile name ReadMode
            hSetEncoding handle utf8
            contents <- hGetContents handle
            writeFile (takeWhile (/= '.') name ++ ".py") $ convert contents
            hClose handle

handler :: IOError -> IO ()
handler e
    | isDoesNotExistError e =
        case ioeGetFileName e of Just path -> putStrLn $ "Whoops! File does not exist at: " ++ path
                                 Nothing   -> putStrLn "Whoops! File does not exist at unknown location!"
    | otherwise = ioError e

-- convert wenyan to python
convert :: String -> String
convert content = let codes = getVal $ parseTo $ content ++ "\n"
                      vfcs  = detectFC codes ++ detectVar codes
                      tmp   = map (`replaceList` (keywords ++ vfcs)) codes
                  in parseBack tmp

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
