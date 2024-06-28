#for循环####
#example1
for(i in 1:5) print(1:i) #迭代1：5中的每个值并将每个值储存在i中
#example2
for(n in c(2,5,10,20,50)) {
  x <- stats::rnorm(n) #生成一个长度为n的随机正态分布的向量，储存在x当中
  cat(n, ": ", sum(x^2), "\n", sep = "") #对x内的每个值进行平方和
}
#example3
f <- factor(sample(letters[1:5], 10, replace = TRUE))
for(i in unique(f)) print(i)