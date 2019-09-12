#!/usr/local/bin/python
# -*- coding: utf-8 -*-

# 参名书于此
### var4 var3 var2 var1 var0

""" 
此乃
多行注释也
"""

# 此乃批注也

import calendar 

class cla0 ():
    def __init__ ( self ): 
        self . var1 = 100  

    def fun2 ( self ): 
        print( self . var1 )

var3 = 1  
var2 = 2  
var4 = True  

def fun1 ( x , y ): 
    return x + y

print(  fun1 ( var3 , var2 ) )

for i in [1,2,3] : 
    print( i )

while var3 < 3 :
    var3 = var3 + 1  
    print( " 善哉 " )

if var2 == 3 :
    print( " 行路难 " )
elif var2 < 0 :
    print( " 多歧路 " )
else :
    print( " 今安在 " )

if var4 == True :
    var4 = False  

print( var4 )

var0 = cla0 ()  

var0 . fun2 ()

def fun0 ( ): 
    print( "哈哈" )

(  fun0 () )

print( calendar . isleap ( 2019 ) )
