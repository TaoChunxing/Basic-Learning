#1.双冒号::用于访问一个包中的函数或数据集，而不需要加载整个包
#2.区别于library(tibble),tibble(),这种方法将整个包加载到当前会话中
#如果只需要调用tibble()函数一次或几次，而不需要加载整个包，那么1.是更好的选择
#如果经常需要使用tibble包中的函数和数据集，那么2.可能更为方便
#创建数据框####
df <- tibble::tibble( #即调用tibble包中的tibble函数
  a = rnorm(10), #10个随机生成的满足正态分布的数
  b = rnorm(10),
  c = rnorm(10),
  d = rnorm(10)
)

#不使用函数求值
df$a <- (df$a - min(df$a, na.rm = T))/
  (max(df$a, na.rm = T) - min(df$a, na.rm = T))
df$b <- (df$b - min(df$b, na.rm = T))/
  (max(df$b, na.rm = T) - min(df$b, na.rm = T))
df$c <- (df$c - min(df$c, na.rm = T))/
  (max(df$c, na.rm = T) - min(df$c, na.rm = T))
df$d <- (df$d - min(df$d, na.rm = T))/
  (max(df$d, na.rm = T) - min(df$d, na.rm = T))

#将上面的用function来实现
#创建方程####
rescale01 <- function(x){#只有abcd一个变量需要改变,所以方程设置一个x
  rng <- range(x, na.rm = T) #range对x进行排序
  (x - rng[1])/(rng[2] - rng[1])#排序好之后默认2是最大值，1是最小值
}
#代入方程
df$a <- rescale01(df$a)
df$b <- rescale01(df$b)
df$c <- rescale01(df$c)
df$d <- rescale01(df$d)

has_name <- function(x){
  nms <- names(x)
  if(is.null(nms)){
    rep(F, length(x))
  }else{!is.na(nms) & nms != ""
  }
}
# if(){
# }else{
# }
# if语句中||或，&&和

#function内不用逗号，直接换行
se_alpha <- function(x, conf = 0.95){
  se <- sd(x) / sqrt(length(x))
  alpha <- 1 - conf
  cat(se, alpha) #cat相当于显示函数，把变量显示出来
}
x <- c(1:10)
se_alpha(x)

?print
print
#function(x, ...)
#...表示可以去其他地方拿这个参数来引用
#...默认你爸那没有的你可以去叔叔那拿，如果没有...说明你只能去你爸那拿这个东西，他没有就是没有

#返回值return()
