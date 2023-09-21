# missing value
# deletion
#   행 / 열 제거
# imputation
#   mean: 평균값으로 대체
#     문제 > 관측자료의 평균값이 늘어나 원래 분포와 다른 분포가 되어짐.
#             (표준편차/분산가 작게 추정이됨)
#   회귀: 다른 관측값을 바탕으로 회귀모델 추정.

df = data.frame(sex = c("M", "F", NA, "M", "F"), score = c(5,4,3,4,NA))
df

library(dplyr)
df %>% filter(is.na(score))
df %>% filter(!is.na(score))
df_nomiss = df %>% filter(!is.na(score))
mean(df_nomiss$score)

# 성별 평균, 표준편차
# na.rm: 결측 빼고 계산해줌
df %>% group_by(sex) %>% summarise(mean = mean(score, na.rm = TRUE), my_sd = sd(score, na.rm = TRUE))

## 여러 변수 중에 결측이 있는 경우
df %>% filter(!is.na(score) & !is.na(sex))

# 결측이 없는 데이터를 얻을 수 있음.
na.omit(df)

################

# 평균 대치법
mn_score = mean(df$score, na.rm = TRUE) # 결측 제외하고 평균 구함.
mn_score
df$score[is.na(df$score)] = mn_score
df

df$score = ifelse(is.na(df$score), mn_score, df$score)
df

###
table(df$sex)
table(is.na(df$sex))

### 이상치 처리

# 이상치 삽입
mpg =as.data.frame(ggplot2::mpg)
mpg[c(10, 14, 58, 93), "drv"] = "k"
mpg[c(29, 43, 129,203), "cty"] = c(3,4,39,42)

View(mpg)

# 결측치 확인
sum(is.na(mpg))

summary(mpg)

# 범주형으로 변환함. -> 빈도 계산
mpg$drv = as.factor(mpg$drv)
summary(mpg)


##### Q1
table(mpg$drv)
# mpg$drv = ifelse(mpg$drv %in% c("4", "f", "r"), mpg$drv, NA )
mpg$drv[!(mpg$drv %in% c("4", "f", "r"))] = NA
table(mpg$drv)

#### Q2

boxplot(mpg$cty)
boxplot(mpg$cty)$stats
s = boxplot(mpg$cty)$stats
summary(mpg$cty)

mpg$cty = ifelse((mpg$cty < s[1]) | (mpg$cty > s[5]), NA, mpg$cty)

boxplot(mpg$cty)

#####Q3

mpg %>% group_by(mpg$drv) %>% summarise(mean = mean(mpg$cty))
