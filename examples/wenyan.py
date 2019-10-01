#!/usr/local/bin/python3
# -*- coding: utf-8 -*-

""" 
此乃
多行注释也
"""

# 此乃批注也

import calendar 

class cla0 ():
    def __init__ ( self ): 
        self . var7 = 100  

    def fun2 ( self ): 
        print( self . var7 )

var6 = 1  
var5 = 2  
var4 = True  

def fun1 ( var2 , var3 ): 
    return var2 + var3

print(  fun1 ( var6 , var5 ) )

for var1 in [1,2,3] : 
    print( var1 )

while var6 < 3 :
    var6 = var6 + 1  
    print( " 善哉 " )

if var5 == 3 :
    print( " 行路难 " )
elif var5 < 0 :
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
