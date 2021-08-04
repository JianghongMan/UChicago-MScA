comment/uncomment: command+shift+c
fuction 要加括号，比如install.package(), sqrt()
不要写0.5，要写5e-1
special value: pi, Inf: 1 / 0, NaN: 0 / 0
%%: reminder(modulus)
rnorm(100):随机生成100个数
log(): Base e
?Reserved: 代表有些词汇在r里面有特殊的意义
data type hierarchy: logical, integer, double, character: 2 == '2' # TRUE: '2' == '2'
compound data: 
  vector: sequence of data in the same type : c(number, character), numeric(有几个0)
    rep(1,5):repeat 1 5 times
    x <- 2:7 表示 2,3,4,5,6,7 / y <- 7:5 表示 7,6,5
    c(x,y) 表示 2,3,4,5,6,7,7,6,5
    seq(1,10,by=3) 表示1 4 7 10 / seq(1,10,length.out = 20)
  index: 1-base 第一个就是第一个，(3:5) include 第3和第5
    x[c(3,1,5)] 表示只要x当中第3第1第5个 / x[c(-3,-1,-5)] 表示除了第3，1，5都要
    x[x>6] 可以在index加condition
    if out of bound: NA 而不是 NULL
    x[1:5] <- c(-1,-2) 表示 把这个list改成第一个到第五个数-1，-2，-1循环，其他不变
  vectorization: function applied to vectors 
    & / | 是对比两个vector的时候用的，而 && / ｜ 是对比两个variable用的
  
  matrix
    matrix(0,3,2) / matrix(1:6,3,2) 第一个是实际的数，第二个是r，第三个是c 
    matrix(1:6) 是 column-major ordering 是竖着第一行先填满再第二行 / byrow=TRUE 横行
    diag(3): 斜着3*3都是1 / diag(3,5,2): 斜着3*3是3，5，2
    cbind() / rbind(v1，v2) : combine two matrix
  index: 
    m[2, ]表示我要第二行全部的 / m[2, ,drop=FALSE] 可以把行数列数表示出来
    m[c(2,3),c(-1,-4)]要2，3行的不要1，4列
    m[,m[1,]>=6] 要所有列which这个数>=6
  dim(): dimension / m*m: element-wise multiplication / t(m) %*% m: matrix multiplication 
  
  list:
    list() / list 是可以store不同的variable type：list(TRUE, 2, "three")
    str(一个list)可以表示这个list的性质
    c(2,3,4)是一个vector 但是 list(2,3,4)是一个list 两个不同的概念
    create list with names: movie <- list(title="Monsters Inc", year=2001, production=c("Walt Disney", "Pixar"))
      或者 movie <- list("Monst", 2001, c("Walt","Px"))
           names(movie) <- c("ti","yr","prod")
           并可以改东西：names(movie)[1]
    []和[[]]的区别：11:28分
    when assigning something to a variable, thats a copy
    x <- append(x,4) 表示加了一个list
    y[length(y)+1] <- 7 表示在list最后一个东西后面加了7
    y[length(y)]: list的最后一个东西是什么
    x$seven <- 7 # By name
    x[4:5] <- NULL # Remove by assigning NULL to the sub-list
      x[[4]]         # All of the following items move forward
    combine：
      c(x, y)    # A list of all the elements from the two lists
      list(x, y) # A list of the two lists
  
import data
  getwd()
  setwd("...")
  car <- read.csv("car.csv", header = TRUE) # data frame 
  # data frame = a list of columns, each column = vector
  car[4] # list notation, data frame 
  car[[4]] == car$Horsepower == car[,4]
  whichi is fast which is slow 12:13 分钟
  look the type of variables in each column: 看有没有什么奇怪的数据
  is.na(vecterize)
    colSums(is.na(car)): 看哪一个vector有na
  another_df <- car[car$Horsepower<100, ]
  car[order(car$Horsepower), ] # reorder data frame
  car[sample(nrow(car), 10),] # Sample 10 rows randomly
  
export data
  write.csv(car.brand.hp, file="car_brand_hp.csv", row.names=FALSE)

plot
  mfrow # 1*1
  par(mfrow = c(2,2)): 把初始设定改了（把canvas改成2*2的格式）
  
  install.packages("ggplot2")
  library(ggplot2)
  
Exporting PDF

dyplyer:
  v %>% abs %>% mean == mean(abs(v))
random:
  set.seed(17)
  s3 <- rnorm(7, mean=3, sd=2)
  set.seed(17) # Can do this at anytime
  s4 <- rnorm(7, mean=3, sd=2)

    
    
    
    