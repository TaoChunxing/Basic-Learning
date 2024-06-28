####第二章####
####1.因子 2.时间####
library(tidyverse)
library(forcats)
#forcats包虽然包含在tidyverse包中，但不是tidyverse包的核心包，有些东西在tidyverse里还是没有的，所以还是要单独运行forcats包
#因子？名义变量或有序变量
#字符串不能进行排序
library(lubridate)
library(nycflights13)

####1.factor####
x1 <- c("Dec", "Apr", "Jan", "Mar")
month_levels <- c("Jan", "Feb", "Mar", "Apr", "May", "Jun",
                  "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")
#1.1
y1 <- factor(x1, levels = month_levels)
y1 #此时已排好序但是不显示
sort(y1) #显示排序

#1.2什么都没有做输入英文字符串factor之后就是按英文字母排序
y1 <- factor(x1) #不设置levels时系统默认以首字母按字母顺序排序，单单变成因子
y1
sort(y1)

#1.2不想按照系统排，就只想按照自己输入的排序:unique()
y1 <- factor(x1, levels = unique(x1))
y1



str(gss_cat)
head(gss_cat)
gss_cat %>% count(partyid)
####fct_recode()重命名####
gss_cat %>% mutate(partyid = fct_recode(partyid, 
                                        "Republican strong" = "Strong republican")) %>% 
  count(partyid)

####fct_collapse()重新归类####
#Collapse factor levels into manually defined groups
partyid2 <- fct_collapse(gss_cat$partyid, 
                         missing = c("No answer", "Don't know"),
                         other = "Other party",
                         rep = c("Strong republican", "Not str republican"),
                         ind = c("Ind,near rep", "Independent", "Ind,near dem"),
                         dem = c("Not str democrat", "Strong democrat"))
count(partyid2)#错误，因为partyis2是一个因子类对象，count用于对数据框中的变量进行计数
fct_count(partyid2)
gss_cat %>% 
  mutate(partyid2 = fct_collapse(partyid, 
                                 missing = c("No answer", "Don't know"),
                                 other = "Other party",
                                 rep = c("Strong republican", "Not str republican"),
                                 ind = c("Ind,near rep", "Independent", "Ind,near dem"),
                                 dem = c("Not str democrat", "Strong democrat"))) %>% 
  count(partyid2)




####2.时间####
today()
now()
ymd("2024-02-28")
ymd("20240228")
mdy("02-28-2024")
mdy("Feb-28-2024")
ymd_hms("2024022821:13:30")
ymd_hms("20240228 21:13:30")

#简化数据框
####make_datetime()####
flights %>% select(year, month, day, hour, minute) %>% 
  mutate(departure = make_datetime(year, month, day, hour, minute))

make_datetime_100 <- function(year, month, day, time){
  make_datetime(year, month, day, time %/% 100, time %% 100)
}
#在这个函数内部，time被分成两个部分，
#time %/% 100表示获取time整除以100的商，即小时部分，
#time %% 100b表示获取time除以100的余数，即分钟部分。

flights_dt <- flights %>% 
  filter(!is.na(dep_time), !is.na(arr_time)) %>% 
  mutate(
    dep_time = make_datetime_100(year, month, day, dep_time),
    arr_time = make_datetime_100(year, month, day, arr_time),
    sched_dep_time = make_datetime_100(
      year, month, day, sched_dep_time
    ),
    sched_arr_time = make_datetime_100(
      year, month, day, sched_arr_time
    )
  ) %>% 
  select(origin, dest, ends_with("delay"), ends_with("time"))#选取以delay和time结尾的列
flights_dt
print(flights_dt, width = Inf)

flights_dt %>% ggplot(aes(dep_time))+
  geom_freqpoly(binwidth = 86400)
