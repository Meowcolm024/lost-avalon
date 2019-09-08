module Words 
    ( keywords, varkey
    ) where

-- translate Wenyanwen to python syntax
keywords :: [(String, String)]
keywords = 
    [
        -- define variant
        ("者", "="),
        ("今乃", "="),
        ("换作", "="),
        ("也", " "),
        -- define function
        ("有略名", "def"),
        ("文曰", ": "),
        ("上疏曰", "return"),
        -- print function
        ("曰", "print("),
        ("。", ")"),
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
        (varkey,"###")
    ]

varkey :: String
varkey = "有参者"
