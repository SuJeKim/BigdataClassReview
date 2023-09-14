library("dplyr")
# file.choose() or 경로명 직접 입력 or 하단과 같이
exam = read.csv("csv_exam.csv")

View(exam)

###################select__24p##################

# data %>% select(변수명1, 변수명2,....)
# %>%: 파이프 연산자

View(exam %>% select(math))
View(exam %>% select(math, english))


# 변수 제외
View(exam %>% select(-math))

# filter + select

## class가 1이고, english열 선택
exam %>% filter(class == 1) %>% select(english)

## id, math열 선택
exam %>% select(id,math) %>% head()


#### 연습 2 ####
# data(mpg, package = ggplot2)
library(ggplot2)
?mpg
View(mpg)

# 1.
mpg_cc = mpg %>% select(class, cty)
mpg_cc %>% head()
head(mpg_cc)

# 2. suv vs compact: cty 비교
mpg_cc %>% filter(class == "suv") %>% select(cty) %>% colMeans()
mpg_cc %>% filter(class == "compact") %>% select(cty) %>% colMeans()

############# arrange() ###################

# 행 정렬(기본: 오름차순)
exam %>% arrange(math)

# 내림차순
## 상위: head(), 하위: tail()
exam %>% arrange(desc(math)) %>% head()

# class, math 오름차순 정렬
exam %>% arrange(class, math)


#### 연습 3 ####
mpg %>% filter(manufacturer == "audi") %>% arrange(desc(hwy)) %>% head(5) %>% View()     


############# mutate() ###################
# 변수 = 벡터연산
# 벡터연산이 아닌 것으로 할 경우(예 mean()) error

exam %>% mutate(total = math + english + science) %>% head()
# exam$total = exam$math + exam$english + exam$science) 

exam %>% 
  mutate(total = math + english + science, mean = (math + english + science)/3) %>%
  head()


#### 연습 4 ####

# 1.
mpg_su = mpg %>%
  mutate(total = hwy + cty)

# 2.
mpg_av = mpg_su %>%
  mutate(me = total / 2)

head(as.data.frame(mpg_av))

# 3.
mpg_av %>%
  arrange(desc(me)) %>%
  head(3)

# 4.
mpg %>%
  mutate(total = hwy + cty) %>%
  mutate(me = total / 2) %>%
  arrange(desc(me)) %>%
  head(3)



############# summarise() ###################
# 데이터에 변수를 추가하는 것이 아닌 새로운 변수가 생성

exam %>% summarise(mean_math = mean(math))

exam %>% summarise(
  mean_math = mean(math),
  mean_eng = mean(english), 
  mean_sci = mean(science))

############# group_by()  ###################

# class 별로 수학 평균
exam %>%
  group_by(class) %>%
  summarise(mean_math = mean(math))

# class 별로 평균, 합계, 중앙값, 수
exam %>%
  group_by(class) %>%
  summarise(mean_math = mean(math),
            sd_math = sd(math),
            sum_math = sum(math),
            median_math = median(math),
            n = n())

#### 연습 5 ####

# 1.class별 cty 평균
## mutate() 사용할 수 잇지만, 벡터 연산으로만 계싼해야 함.
mpg %>%
  group_by(class) %>%
  summarise(mean_cty = mean(cty))

# 2.
mpg %>%
  group_by(class) %>%
  summarise(mean_cty = mean(cty)) %>%
  arrange(desc(mean_cty))

# 3.
mpg %>%
  group_by(manufacturer) %>%
  summarise(mean_hwy = mean(hwy)) %>%
  arrange(desc(mean_hwy)) %>%
  head(3)

# 4.
mpg %>%
  group_by(manufacturer) %>%
  summarise(count_compact = sum(class == "compact")) %>%
  arrange(desc(count_compact))


############# join() ###################
?join

x = exam %>% select(id, class, math)
y = exam %>% select(id, class, english)
head(x)
head(y)

# left_join: 원 데이터의 정보가 없어지지 않음
x %>% inner_join(y, by= "id")
