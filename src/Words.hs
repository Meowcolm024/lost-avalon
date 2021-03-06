module Words 
    ( keywords
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
        -- import
        ("自", "from"),
        ("遗", "import"),
        ("之策", ""),
        -- define function
        ("有略名", "def"),
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
        ("有族名", "class"),
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
        ("有参者","###")
    ]
