library(tidyverse)
#原子向量（逻辑、数值【整数和双精度都是num】、字符、复合、因子、日期时间型）和列表都属于向量
#原子向量和列表共有的特征：类型(typeof)、长度(length)、属性(attributes)
#length()####
1:10
length(1:10)

x <- list("a", "b", "1:10", "c")
x
length(x) #4个表

#typeof()####
typeof(2) #查看变量类型为双精度型，系统默认数值为双精度型
typeof(2L) #一定要把双精度型转化为整数型，加L

#double与integer的区别####
test <- sqrt(2) ^ 2 #测试2开根号再平方是否等于2？
test == 2 #返回F，因为双精度型变量开根号时除不尽只是保留约数,近似浮点算法

#整数型向量的缺失值只有NA
#双精度型向量缺失值有NA、NAN、Inf、-Inf
x <- 1:10
is.logical(x) #识别逻辑型向量
is.infinite(x) #识别无限值
is.atomic() || is.list() #识别原子向量、列表
is.vector() #识别向量，但是要除了名字之外没有其他属性的情况

#“#（即3）”键＋上键或下键，快捷输入上一步或下一步运行过的命令

#两个向量相加，长度需要一样或者是整数倍关系####
x <- c(1:10)
y <- c(1:3)
x+y #error
x <- c(1:9)
x+y # 1:3+1:3, 4:6+1:3, 7:9+1:3

tibble(1:4, rep(1:2, 2)) #1212
tibble(1:4, rep((1:2), each = 2)) #1122

#set_names()设置名称####
set_names(1:3, c("a", "b", "c"))
c( a = 1, b = 2, c = 3)

#[]取子集####
number <- c("one", "two", "three", "four", "five")
number[2]
number[c(2, 4)] #取2、4位
number[c(-2, -4)] #不要2、4位
#number[c(-2, 4)] #error, 正负不能混用

#列表可以有多重向量类型
#表中可以再放表
x <- list("a", 1L, 5, T, list(1,2))
str(x)

# 在多个表的表中[]提取一张表，[[]]提取表中的内容
y <- list(a = 1:3, b = 4:5, c = 7:9)
str(y[1]) #提取第一个表
y[[1]] #提取第一个表里面具体的东西




#attribute()属性####
attr(x, "greeting") <- "hi"
attr(x, "farewell") <- "bye"
attributes(x)

#泛型函数####
print
#出现UseMethod意味着是泛型函数
methods("print")
#运行之后会出现很多print.函数，有很多后缀
#如果仅仅运行了print, 但其实是要运行具体的print.什么
#但是你不输入后缀没关系，它会根据你输入的内容自己去搜索需要用哪个函数拿来用
#泛型函数是机智聪明的小天才
getS3method("print", "default")
#四个大类：S3, S4，参考类，基础类型，这些中都可以有泛型函数
#print是在S3下的泛型函数


#print是在S3下的泛型函数####
x <- factor(c("ab", "cd", "ef")) 
typeof(x) #factor后都是整数型向量
attributes(x) #出现level（排序，默认按照字母排序）和class（类别）

#unclass() 去掉类别特征####
y <- as.Date("2024-03-01")
attributes(y)
unclass(y)
typeof(y)

tb <- tibble::tibble(x = 1:3, y = 3:1)
tb
attributes(tb)
#当查看一个 tibble 对象的属性时
#class 属性通常会显示多个值: "tbl_df"、"tbl" 和 "data.frame"
#这些值表示该对象是一个 tibble 对象，并且也可以被视为一个普通的数据框（data frame）。
