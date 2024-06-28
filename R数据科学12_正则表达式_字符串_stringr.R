####正则表达式:用一个符号提取信息####
library(tidyverse)
library(stringr) #主角,用于处理和操作字符串数据
string1 <- "I am a lovely girl" #一般用双引号
string2 <- 'I am a "lovely" girl' #单引号通常仅用于包含双引号的字符常量
string1
string2
?"'"
#转义,用前面的格式匹配后面，反斜杠\是转义字符
#‘\n’ newline,在上一个字符末尾写
#‘\r’ carriage return 回车
#‘\t' tab 制表符，能打出一段空格
#‘\b’ backspace退格，即删除前面的字符或空格
#‘\\’	backslash '\'，双反斜杠匹配单反斜杠
#'⁠\'⁠’	ASCII apostrophe ‘⁠'⁠’
#’\"’	ASCII quotation mark ‘"’

####cat()####
name <- "Taochunxing"
cat("Hello", name, ".")
cat("Hello", name, "\b.", "I\'d", "like", "to", "tell", "you")
cat("Hello", name, "\b.\n", "I\'d", "like\n", "to", "tell", "you")
cat("Hello", name, "\b.\n", "I\'d", "like\n", "to\t", "tell\b", "you")
str_length(name)#字符串有多少长度？

####str_c()组合字符串####
str_c("x", "y")
str_c("a-", "love-", c("b", "c"))

#提取子集
# .（匹配除换行符以外的任意字符），^（开头），$（结尾），\d（数字），\s（空白字符）
#[abc](a或b或c), [^abc]（除abc以外）
#？（0个或1个），+（1个或多个），*（0个或多个），{n,m}, {n,}, {,m}, ()代表字符

####str_sub() 提取出指定位置的字符串####
x <- c("apple", "banana", "pear")
str_sub(x, 1, 3) 

####str_subset()筛选出满足指定模式的字符串####
fruit <- c("apple", "banana", "pear", "pineapple")
str_subset(fruit, "a") #筛选出含有a的字符串
str_subset(fruit, "^a")#筛选出以a开头的字符串
str_subset(fruit, "a$")#筛选出以a结尾的字符串
str_subset(fruit, "[aeiou]")#筛选出含有aeiou的字符串

####str_detect()返回的是T/F####
str_detect(fruit, "e") #匹配含有e的字符串，有的返回T，没有的返回F

####str_count()计数####
str_count(fruit, "e")

####str_c()、str_subset()、str_extract()提取颜色####
head(sentences)
colors <- c("yellow", "green", "blue", "purple")
color_match <- str_c(colors, collapse = "|")
color_match
has_color <- str_subset(sentences, color_match) %>% head()
has_color
matched <- str_extract(has_color, color_match)
matched
matched <- sentences %>% 
  str_subset(color_match) %>% 
  str_extract(color_match) %>% 
  head(5)
matched

####str_view()####
str_view(c("abc", "def", "fghi"), "[aeiou]")
str_view(x,".a.")
d <- "mdzzbssssbbbbb"
str_view(d,"ss?")
str_view(d, "s{2,}")
str_view(d, "s{2,}?")
#双斜杠转义
dot <- "\\." #若要匹配.，则需转义告诉它我匹配的是.而不是除换行符以外的任意字符
writeLines(dot)
str_view(c("abc", "a.c"), "a\\.c")
str_view(c("abc", "a.c"), "a.c")
y <- "a\\b" #双反斜杠匹配单反斜杠，即该字符串包含一个单反斜杠
str_view(y, "\\\\") #双反斜杠匹配双反斜杠（即单反斜杠）


####stringr包中转换大小写####
str_to_upper(x)
str_to_upper(str_sub(x, 1, 10))
str_to_upper(str_sub(x, 1, 2))
str_to_lower(x)
#基础包中大小写
toupper(x)
tolower(x)

####str_extract(), ([^ ]+)表示一个单词####
sentences
noun <- "(a|the) ([^ ]+)" #[^ ]匹配一个非空格字符，+表示前面匹配模式的多次
has_noun <- sentences %>% str_subset(noun) %>% head(10)
has_noun
has_noun %>% str_extract(noun)
has_noun %>% str_match(noun)

####str_replace()####
str_replace(fruit, "[aeiou]", "-")
str_replace_all(fruit, "[aeiou]", "-")

sentences %>% str_replace("([^ ]+) ([^ ]+) ([^ ]+)", "\\1 \\3 \\2") %>% head(5)

####str_split()####
sentences %>% str_split(" ") %>% head(3) #按照空格进行分割
sentences %>% head(3) %>% str_split(" ", simplify = T) #simplify=T可以返回一个矩阵
