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

懒得看的话，也可以参考这个[实例](examples/wenyan.txt)，转换后代码是[这个](examples/wenyan.py)

### 中文变量声明

* 在使用中文变量名前需要提前声明
* 使用语句： `有参者 <变量1> <变量2> <...>`
* 注意由于lost-avalon程式的原理，该语句仅可声明一次，否则会导致变量名混乱

### 主要的语句

**注意：函数名需要为如fib( x )的形式**

**注意：语句块中的代码要有缩进**

* defining a variant 定义变量： `<变量名> 者 <变量> 也` 或 `<变量名> 换作 <变量> 也` 或 `<变量名> 今乃 <变量> 也`
* defining a function 定义函数： `有略名 <函数> 文曰 <<代码>>`
* defining a function with return value 定义又返回值的函数： `<<前面和定义函数一样，用这个语句返回变量>> 上疏曰 <变量>`
* a *for loop* for 循环： `凡 <变量名> 之于 <一个list或者其他东西> 为 <<代码>>`
* a *while loop* while 循环： `复为之，方 <条件> 乃止`
* a *if-elif-else* structure 逻辑分支： `若 <条件> 则为 <<代码>> 又或 <条件> 则为 <<代码>> 不者 则为 <<代码>>`
* *print* function print函数： `曰 <内容> 。`
* comments 注释 `批： <注释内容>` 或 `旁注言 <注释内容> 注终`

### 运算符及其他

| 文言文         | 运算符 |
| -------------- | :----: |
| 加             |   +    |
| 减             |   -    |
| 乘             |   *    |
| 除             |   \    |
| 大于           |   >    |
| 小于           |   <    |
| 非小于         |   >=   |
| 非大于         |  <=   |
| 等于/同于/实为 |   ==   |
| 非             |  not   |
| 与             |  and   |
| 或             |   or   |

| 文言文 | 变量名 |
| ------ | :----: |
| 真     |  True  |
| 伪     | False  |
