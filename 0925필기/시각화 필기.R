# ggplot2는 3층 레이어 구조를 가짐
library(ggplot2)

# 산점도 geom_point() #

# 1. 배경 생성
ggplot(data = mpg, aes(x = displ, y = hwy))

# 2. 배경에 산점도(그래프) 추가
# aes(): 축 변수 지정
# ?geom_ => 그래프 종류 지정하기기
ggplot(data = mpg, aes(x = displ, y = hwy)) + geom_point()

# 3. 설정 추가 - 축 범위, 색, 표식, 제목, margin 등등
ggplot(data = mpg, aes(x = displ, y = hwy)) + geom_point() + 
  xlim(3, 6) + ylim(10, 30)


# 막대그래프 geom_col() #

library(dplyr)
df_mpg = mpg %>% group_by(drv) %>% summarise(mean_hwy = mean(hwy))
df_mpg

# 요약된 통계값을 바탕으로 막대그래프를 그려야 함.
ggplot(data= df_mpg, aes(x = drv, y=mean_hwy)) + geom_col()

# 크기 순 정렬 reorder()
?reorder()
ggplot(data= df_mpg, aes(x = reorder(drv, -mean_hwy), y=mean_hwy)) + geom_col()


# 빈도 막대 그래프(히스토그램, 도수 막대그래프,....) geom_bar() #

ggplot(data = mpg, aes(x=drv)) + geom_bar()

# 수치형 변수일 경우 도수히스토그램
ggplot(data = mpg, aes(x=hwy)) + geom_bar()

# Question

toupper("suv")
tolower("SUV")
sum(tolower(mpg$class) == "suv")

mpg_suv = mpg %>% filter(class == "suv")
dim(mpg_suv)

# 결측값 확인하기 위해 size, length를 확인
View(mpg_suv)
df <- mpg %>%
  filter(class == "suv") %>%
  group_by(manufacturer) %>%
  summarise(mean_cty = mean(cty, na.rm = TRUE)) %>%
  arrange(desc(mean_cty)) %>%
  head(5)

ggplot(data = df, aes(x =reorder(manufacturer, -mean_cty), y = mean_cty)) + geom_col()

ggplot(data = mpg, aes(x = class)) + geom_bar()
