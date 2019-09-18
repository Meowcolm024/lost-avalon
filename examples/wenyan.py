#!/usr/local/bin/python
# -*- coding: utf-8 -*-

# 参名书于此
### var5 var7 var6 var8 var1

""" 
此乃
多行注释也
"""

# 此乃批注也

import calendar 

class cla0 ():
    def __init__ ( self ): 
        self . var8 = 100  

    def fun2 ( self ): 
        print( self . var8 )

var7 = 1  
var6 = 2  
var5 = True  

def fun1 ( var3 , var4 ): 
    return var3 + var4

print(  fun1 ( var7 , var6 ) )

for var2 in [1,2,3] : 
    print( var2 )

while var7 < 3 :
    var7 = var7 + 1  
    print( " 善哉 " )

if var6 == 3 :
    print( " 行路难 " )
elif var6 < 0 :
    print( " 多歧路 " )
else :
    print( " 今安在 " )

if var5 == True :
    var5 = False  

print( var5 )

var1 = cla0 ()  

var1 . fun2 ()

def fun0 ( ): 
    print( "哈哈" )

(  fun0 () )

print( calendar . isleap ( 2019 ) )
