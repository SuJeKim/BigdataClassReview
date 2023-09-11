install.packages("ggplot2")
library(ggplot2)
?mpg

class(mpg)
 mpg = as.data.frame(ggplot2::mpg)
head(mpg) 
tail(mpg)
View(mpg)
dim(mpg)
str(mpg)

# 열별 기초 통계량
summary(mpg)


# 데이터 프레임 생성
df = data.frame(var1 = c(4,3,8), var2 = c(2,6,1))
df

# 파생 변수 만들기
df$var_mean = (df$var1 + df$var2) / 2
df

# mpg 데이터 평균 연비 구하기
mpg$total 

mpg$cty[1:5] 
mpg$hwy[1:5]

mpg$total = (mpg$cty + mpg$hwy) / 2
mpg$total

View(mpg)

# test변수 생성
mpg$test = ifelse(mpg$total >= 20, "pass", "fail")
View(mpg)

# 빈도표 생성 및 막대그래프
table(mpg$test)
qplot(mpg$test)

View(midwest)

# dplyr 패키지 설치
install.packages("dplyr")
library(dplyr)

# 현 디렉토리 문서로 옮겨서 확인하기
# 현 작업디렉토리 확인
getwd() 

exam = read.csv("csv_exam.csv")
exam

# x1 <- read.csv(choose.files())
# read.csv("파일 경로/파일 이름") => 백슬레쉬 슬래쉬로 변경하여 사용해야 함.
# "C:/Users/CBA2303_26/Documents/My pro/csv_exam.csv"

# class가 1인 행 추출
View(exam)
?filter

filter(exam, class==1)
exam %>% filter(class == 1)

# class가 2인 데이터 추출
# 열 벡터와의 비교.
exam %>% filter(class == 2)
exam %>% filter(class != 3)

# ------------------------
exam %>% filter(math > 50)


# 벡터끼리 연산이기에 &만 사용.
exam %>% filter(class == 1 & math >= 50)

# 수학 >= 90 | 영어 >= 90
exam %>% 
  filter((math >= 90) | (english >= 90))
         

#--------------------
# 연습문제
mpg_lt4 = mpg %>% 
  filter(displ <= 4)

mpg_gt5 = mpg %>% 
  filter(displ >= 5)

dim(mpg_lt4)
#  163  13
dim(mpg_gt5)
# 38 13

# 평군 계산
mean(mpg_lt4$hwy)
#  25.96319
mean(mpg_gt5$hwy)
#  18.07895

#------------------
# 연숩문제 2
mpg_audi = mpg %>% filter(mpg$manufacturer == "audi")
mpg_to = mpg %>% filter(mpg$manufacturer == "toyota")

mean(mpg_audi$cty)
#  17.61111
mean(mpg_to$cty)
# [1]  18.52941
