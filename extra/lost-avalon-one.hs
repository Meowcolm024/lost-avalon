{- lost-avalon-one v0.3.0-}

import Text.ParserCombinators.Parsec
import System.IO
import System.Environment

main :: IO()
main = someFunc

-- source
someFunc :: IO ()
someFunc = do
    (name:args) <- getArgs
    handle      <- openFile name ReadMode  
    contents    <- hGetContents handle 
    let codes   = getVal $ parseTo $ contents ++ "\n" 
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
transVar []             = []
transVar (x:xs) = let l = length xs in (x, "var" ++ show l) : transVar xs

findFC :: String -> [[String]] -> [String]
findFC _ []         = []
findFC _ [x]        = []
findFC key (x:xs)
    | null y = findFC key xs
    | head y == key = y !! 1 : findFC key xs
    | otherwise            = findFC key xs
    where y = dropWhile (== "") x

transFC :: String -> [String] -> [(String,String)]
transFC _ []        = []
transFC k (x:xs)
    | k == funkey   = (x, "fun" ++ show l) : transFC funkey xs
    | k == classkey = (x, "cla" ++ show l) : transFC classkey xs
    where l = length xs

-- data
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
        -- operators
        ("加", "+"),
        ("减", "-"),
        ("乘", "*"),
        ("除", "/"),
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
        (varkey,"###")
    ]

varkey :: String
varkey = "有参者"

classkey :: String
classkey = "有族名"

funkey :: String
funkey = "有略名"