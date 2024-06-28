#第三章
#四个板块：管道操作、函数、向量、迭代（for）

library(magrittr)
library(tidyverse)
library(pryr)

#object_size()查看数据框的大小/内存####
diamonds2 <- diamonds %>% mutate(price_per_carat = price / carat)
object_size(diamonds)
object_size(diamonds2)
object_size(diamonds, diamonds2)#说明运行过的东西不会重复运行

#environment()查看当前运行的环境####
#包是函数的父环境，当前运行环境中搜索不到的变量会去父环境搜索，负环境搜索不到再去父父环境搜索，巡此反复只到空环境
#空环境是唯一一个没有父环境的环境
#基环境的父环境是空环境
environment()#一般是在全局环境中运行
search() #查看当前运行的所有环境


#assign函数不适用于管道操作####
assign("x", 10)#assign 函数结果是储存在一个临时环境中，不是全局环境
x
"x" %>% assign(100)
x #发现没有运行成功，x还是10

#惰性求值的函数?不适用于管道操作####
#不设置也会运行的函数如na.rm = T 默认也会运行这个函数，默认是F，很多参数都是惰性求值的
#你不调用它根本不会出来

# %T>% 返回值是左向####
#既想画图又想看后面数据的结构时可以用这个。锁定
# %>% 返回值是右向
rnorm(100) %>% 
  matrix(ncol = 2) %T>% #返回值是左侧矩阵
  plot() %>% 
  str()
rnorm(100) %>% 
  matrix(ncol = 2) %>% #返回值是右侧plot
  plot() %>% 
  str()#其实这一步无法运行，因为无法对plot进行str

# %$% 告诉你我里面要用到的是独立的向量而不是一整个数据框#### 
mtcars %$% cor(disp, mpg) #cor求相关系数
mtcars %>% cor(disp, mpg)

# %<>% 赋值符号等同于 <- ####