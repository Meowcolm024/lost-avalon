#!/usr/local/bin/python
# -*- coding: utf-8 -*-

### var1 var0 var2 巡

def fun0 ( var2 ): 
    var1 = 0  
    var0 = 1  
    while var2 > 0 :
        var1 = var0  
        var0 = var1 + var0   
        var2 -= 1  
        yield var1
        # 无同yield之函数也

for 巡 in fun0 ( 10 ) : 
    print( 巡 )
