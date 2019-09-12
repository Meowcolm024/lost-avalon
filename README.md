# lost-avalon

![GitHub release (latest by date including pre-releases)](https://img.shields.io/github/v/release/Meowcolm024/lost-avalon?include_prereleases)
![GitHub](https://img.shields.io/github/license/Meowcolm024/lost-avalon)
![Hackage-Deps](https://img.shields.io/hackage-deps/v/parsec)

## Introduction 介绍

A simple program allowing you to write *Python* in **Wenyanwen（文言文）**

这是一个可以让你用**文言文**来写*Python*的小程序

## Usage 使用

Makesure you have installed *Haskell* and *Stack*

1. Enter the directory then use command ```stack build``` to build the project
2. Execute the program using: ```stack exec lost-avalon-exe <name of your source file>```

## Syntax 语法

Check out here [在这里](wenyan-syntax.md)

## Examples 例子

| 内容         |               文言                |              译文               |
| ------------ | :-------------------------------: | :-----------------------------: |
| 示例         | [wenyan.txt](examples/wenyan.txt) | [wenyan.py](examples/wenyan.py) |
| 斐波那契数列 |    [fib.txt](examples/fib.txt)    |    [fib.py](examples/fib.py)    |
| 插入排序 |    [sort.txt](examples/sort.txt)    |    [sort.py](examples/sort.py)    |

## Others 其他

* Input file should be encoded in **UTF-8**
* If you have trouble using *Stack* check out the `extra` folder
