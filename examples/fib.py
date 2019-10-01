#!/usr/local/bin/python3
# -*- coding: utf-8 -*-

def fun0 ( var3 ): 
    var2 = 0  
    var1 = 1  
    while var3 > 0 :
        var2 = var1  
        var1 = var2 + var1   
        var3 -= 1  
        yield var2
        # 无同yield之函数也

for var0 in fun0 ( 10 ) : 
    print( var0 )
