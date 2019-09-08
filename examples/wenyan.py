#!/usr/local/bin/python
# -*- coding: utf-8 -*-

### var2 var1 var0

""" 
此乃
多行注释也
"""

# 此乃批注也

var1 = 1  
var0 = 2  
var2 = True  

def add(x,y) : 
    return x + y

print( add( var1 , var0 ) )

for i in [1,2,3] : 
    print( i )

while var1 < 3 :
    var1 = var1 + 1  
    print( " 善哉 " )

if var0 == 3 :
    print( " 行路难 " )
elif var0 < 0 :
    print( " 多歧路 " )
else :
    print( " 今安在 " )

if var2 == True :
    var2 = False  

print( var2 )

