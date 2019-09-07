#!/usr/local/bin/python
# -*- coding: utf-8 -*-

def fib(n) : 
    a = 0  
    b = 1  
    while n > 0 :
        a = b  
        b = a + b  
        n = n - 1  
        yield a 
        #  无同yield之函数也

for i in fib(10) : 
    print( i )
