module Words 
    ( keywords
    ) where

-- translate Wenyanwen to python syntax
keywords :: [(String, String)]
keywords = 
    [
        -- define variant
        ("者", "="),
        ("也", " "),
        -- define function
        ("有略名", "def"),
        ("文曰", ": "),
        ("上疏曰", "return"),
        -- print function
        ("曰", "print("),
        ("。", ")")
    ]