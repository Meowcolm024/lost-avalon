{-
FLAWED:
when encountering lists, function parameters
IDEA:
"=" -> "者"
-}

module Detector
    ( detectFC, detectVar
    ) where

import Data.List

-- find function and class
findFC :: String -> [[String]] -> [String]
findFC _ []         = []
findFC _ [x]        = []
findFC key (x:xs)
    | null y        = findFC key xs
    | head y == key = y !! 1 : findFC key xs
    | otherwise     = findFC key xs
    where y = dropWhile (== "") x

transFC :: String -> [String] -> [(String,String)]
transFC _ []       = []
transFC k (x:xs)
    | k == "有略名"   = (x, "fun" ++ show l) : transFC "有略名" xs
    | k == "有族名" = (x, "cla" ++ show l) : transFC "有族名" xs
    where l = length xs

-- find variants
findVar :: [[String]] -> [String]
findVar []         = []
findVar (x:xs)
    | null vs      = findVar xs
    | head vs == 0 = error "Could not find variant: nothing before = !"
    | otherwise    = [x !! (v - 1) | v <- vs] ++ findVar xs
    where vs = ["者", "其文曰"] `allIndices` x -- here 

transVar :: [String] -> [(String,String)]
transVar []     = []
transVar (x:xs) = let l = length xs in (x, "var" ++  show l) : transVar xs

-- helper
allIndices :: (Eq a) => [a] -> [a] -> [Int]
allIndices _ []      = []
allIndices [] _      = []
allIndices (v:vs) xs = (v `elemIndices` xs) ++ allIndices vs xs

-- detectors
detectFC :: [[String]] -> [(String,String)]
detectFC xs = transFC "有略名" (findFC "有略名" xs) ++ transFC "有族名" (findFC "有族名" xs)

detectVar :: [[String]] -> [(String,String)]
detectVar = transVar . nub . findVar
