#!/usr/local/bin/python
# -*- coding: utf-8 -*-

### var3 var2 var1 var0

def fib( var1 ) : 
    var3 = 0  
    var2 = 1  
    while var1 > 0 :
        var3 = var2  
        var2 = var3 + var2  
        var1 = var1 - 1  
        yield var3
        # 无同yield之函数也

for var0 in fib(10) : 
    print( var0 )
