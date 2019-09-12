#!/usr/local/bin/python
# -*- coding: utf-8 -*-

### var4 var3 var2 var1 var0

def fun0 ( var4 ): 
    for var3 in range( 1 , len( var4 )  ) : 
        var2 = var4 [ var3 ]  
        var1 = var3 - 1  
        while var1 >= 0 and var2 < var4 [ var1 ] :
            var4 [ var1 + 1  ] = var4 [ var1 ]
            var1 -= 1  
        var4 [ var1 + 1 ] = var2  

var0 = [12, 11, 13, 5, 6] 
(  fun0 ( var0 ) )
print( var0 )  
