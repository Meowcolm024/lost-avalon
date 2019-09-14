{-
FLAWED:
when encountering lists, function parameters
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
    | k == "def"   = (x, "fun" ++ show l) : transFC "def" xs
    | k == "class" = (x, "cla" ++ show l) : transFC "class" xs
    where l = length xs

-- find variants
findVar :: [[String]] -> [String]
findVar []         = []
findVar (x:xs)
    | null vs      = findVar xs
    | head vs == 0 = error "Could not find variant: nothing before = !"
    | otherwise    = [x !! (v - 1) | v <- vs] ++ findVar xs
    where vs = ["=", "-=", "+=", "==", ">", "<", ">=", "<=", "in"] `allIndices` x

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
detectFC xs = transFC "def" (findFC "def" xs) ++ transFC "class" (findFC "class" xs)

detectVar :: [[String]] -> [(String,String)]
detectVar = transVar . nub . findVar
