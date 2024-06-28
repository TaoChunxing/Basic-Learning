####处理关系数据####
#用到的包
library(nycflights13)
library(tidyverse) #需要里面的dplyr包
#用到的数据框
planes
flights
airlines
airports
weather

####主键与外键：主键具有唯一性，比如ID，不具有缺失值####
planes %>% count(tailnum) %>% filter(n>1) #检查tailnum是不是主键即具不具有唯一性
#如何创建主键？即新增新的一列从1开始排列
flights2 <- mutate(flights, number = row_number())
flights2
print(flights2, n=10, width = Inf) #显示前10行、全部列
select(flights2, number, everything()) #将主键（number)显示在第一列

#简化数据框
flights2 <- flights %>% select(year:day, hour, origin, dest, tailnum,carrier)
flights2

####合并与连接:left_join()####
flights2 %>% left_join(airlines, by = "carrier") #方法1
left_join(flights2, airlines, by = "carrier") #方法2
flights2 %>% mutate(name = airlines$name[match(carrier, airlines$carrier)])#方法3
#假设flights2中的”dest"与airports中的"faa"是不同列名相同数据
flights2 %>% left_join(airports, c("dest" = "faa")) #R语言认为faa是个重复的东西，cut了不显示

#举个例子
#tribble是tidyverse包中的函数，可以通过行的方式输入数据来创建数据框，意为“tibbble with row-wise data entry"
#tibble也是tidyverse包中的函数，是逐列赋值输入，与data.frame不同，tibble 不会自动转化为factors
x<- tribble(~key, ~val_x,
            1, "x1",
            2, "x2",
            3, "x3")
y <- tribble(~key, ~val_y,
             1, "y1",
             2, "y2",
             4, "y4")
####内连接：inner_join()####
x %>% inner_join(y, by = "key") #只连接主键相同的，把不同的舍弃
####外连接：左连接、右连接、全连接####
x %>% left_join(y, by = "key")
x %>% right_join(y, by = "key")
x %>% full_join(y, by = "key")

?merge

top_dest <- flights %>% count(dest, sort = T) %>% head(10)#筛选10个最火的旅游景点
top_dest #航班n总和为14万多
####semi_join()与anti_join()：筛选出我需要的与不需要的####
flights %>% semi_join(top_dest) #显示14万多条航班
flights %>% anti_join(top_dest) #显示总航班33万-14万=19万多条航班

####再举个例子理解intersect(),union(),setdiff()####
x1 <- tribble(~key, ~val_x,
              1, "1",
              2, "2",
              3, "3")
x2 <- tribble(~key, ~val_x,
              1, "1",
              2, "2",
              4, "4")
intersect(x1, x2) #返回x1与x2的交集
union(x1, x2) #返回x1与x2的并集
setdiff(x1, x2) #set_different：返回x1中有的x2没有的
setdiff(x2, x1) #返回x2中有的x1没有的
