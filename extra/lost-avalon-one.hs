{- lost-avalon-one v0.4.2 -}
import Data.List
import Text.ParserCombinators.Parsec
import System.IO
import System.IO.Error
import Control.Exception
import System.Environment

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
    | k == "有略名" = (x, "fun" ++ show l) : transFC "有略名" xs
    | k == "有族名" = (x, "cla" ++ show l) : transFC "有族名" xs
    where l = length xs

-- find variants
findVar :: [[String]] -> [String]
findVar []         = []
findVar (x:xs)
    | null vs      = findVar xs
    | head vs == 0 = error "Could not find variant: nothing before = !"
    | otherwise    = [x !! (v - 1) | v <- vs] ++ findVar xs
    where vs = ["者", "其文曰", "之于", "、"] `allIndices` x -- here 

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
detectVar xs = transVar $ nub (findVar xs) \\ ["吾身", "无参也"]

-- translate Wenyanwen to python syntax
keywords :: [(String, String)]
keywords = 
    [
        -- define variant
        ("者", "="),
        ("今乃", "="),
        ("换作", "="),
        ("也", " "),
        -- import
        ("自", "from"),
        ("遗", "import"),
        ("之策", ""),
        -- define function
        (funkey, "def"),
        ("其参名", "("),
        ("其文曰", "): "),
        ("无参也", "("),
        ("、", ","),
        ("上疏曰", "return"),
        -- use function
        ("用略", ""),
        ("其参乃", "("),
        ("是也", ")"),
        ("无参", "()"),
        -- print function
        ("曰", "print("),
        ("。", ")"),
        -- class
        (classkey, "class"),
        ("因袭", "("),
        ("之族", "):"),
        ("新立", "():"),
        ("一式", "__init__"),
        ("吾身", "self"),
        ("用族", ""),
        -- for loop
        ("凡", "for"),
        ("之于", "in"),
        ("为", ": "),
        -- while loop
        ("复为之，方", "while"),
        ("乃止", ":"),
        -- if-else
        ("若", "if"),
        ("则为", ":"),
        ("又或", "elif"),
        ("不者", "else"),
        -- functions
        ("数数", "range("),
        ("数数自", "range("),
        ("至", ","),
        -- lists 
        ("诸", "["), -- tmp !
        ("位之数", "]"),
        ("求长于", "len("),
        ("之中", ")"),
        -- operators
        ("加", "+"),
        ("减", "-"),
        ("乘", "*"),
        ("除", "/"),
        ("迁", "+="),
        ("谪", "-="),
        ("大于", ">"),
        ("小于", "<"),
        ("非小于", ">="),
        ("非大于", "<="),
        ("等于", "=="),
        ("同于", "=="),
        ("实为", "=="),
        ("非", "not"),
        ("与", "and"),
        ("或", "or"),
        -- boolean
        ("真", "True"),
        ("伪", "False"),
        -- comment
        ("批：", "#"),
        ("旁注言", "\"\"\""),
        ("注终", "\"\"\""),
        -- misc
        ("“","\""),
        ("”","\""),
        ("，", ","),
        ("（", "("),
        ("）", ")"),
        ("之", "."),
        ("【", "]"),
        ("】", "["),
        ("所得之数", ""),
        (varkey,"###")
    ]

varkey :: String
varkey = "有参者"

classkey :: String
classkey = "有族名"

funkey :: String
funkey = "有略名"