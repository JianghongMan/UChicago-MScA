getwd()
dataPath <- "C:/Users/nimo/Desktop/Winter2021_Stat/"
dta<-read.csv(paste0(dataPath,"trustStudy2012.csv"),header = TRUE)
dim(dta)

table(dta$TRUST)
# 1 Most people can be trusted
# 2 You can’t be too careful in life
# 3 Depends

#To post the problem as binary regression the type 3 answers will be removed below, 
# the first 2 types of the answer will be transformed into binary format with 
# 1 representing “Most people can be trusted” and 0 representing “You can’t be too careful in life”.

# remove rows with NA
dta_clean<-dta[complete.cases(dta), ]
# remove rows with TRUST answer #3
dta_clean<-subset(dta_clean,TRUST!=3)
dta_clean<-dta_clean[,-1]

# make TRUST binary, male=1
dta_clean$TRUST<-(dta_clean$TRUST==1)*1

head(dta_clean)

dim(dta_clean)
table(dta_clean$TRUST)
table(dta_clean$DEGREE)
head(dta_clean)

dta_clean_F<-as.data.frame(apply(dta_clean[,4:8],2,as.factor))
dta_clean_F$TRUST<-dta_clean$TRUST
head(dta_clean_F)

#wh_happy_m: white happy male for levels of education 0 to 4
#wh_notHappy_m: white not too happy male for levels of education 0 to 4
#wh_veryHappy_fm: white very happy female for levels of education 0 to 4
#wh_happy_fm: white happy female for levels of education 0 to 4

# white male with very happy 
glmProbit <- glm(TRUST~DEGREE+HAPPY+SEX+RACE,family=binomial(link="probit")
                 ,data=dta_clean_F)
dta1 <- data.frame(DEGREE = c(0,1,2,3,4), SEX = c(1,1,1,1,1), RACE = c(1,1,1,1,1),
                   HAPPY = c(1,1,1,1,1))
w_very_happy <- as.data.frame(apply(dta1[,1:4],2,as.factor))
head(w_very_happy)
predProbit <- predict(glmProbit, newdata = w_very_happy, type="response")
wh_veryHappy_m <- predProbit

# white male with  happy

glmProbit1 <- glm(TRUST~DEGREE+HAPPY+SEX+RACE,family=binomial(link="probit"),data=dta_clean_F)
dta2 <- data.frame(DEGREE = c(0,1,2,3,4), SEX = c(1,1,1,1,1), RACE = c(1,1,1,1,1),
                   HAPPY = c(2,2,2,2,2))
wh_happy <- as.data.frame(apply(dta2[,1:4],2,as.factor))
predProbit1 <- predict(glmProbit1, newdata = wh_happy,type="response")
wh_happy_m <- predProbit1


# white male with not happy
glmProbit2 <- glm(TRUST~DEGREE+HAPPY+SEX+RACE,family=binomial(link="probit"),data=dta_clean_F)
dta3 <- data.frame(DEGREE = c(0,1,2,3,4), SEX = c(1,1,1,1,1), RACE = c(1,1,1,1,1),
                   HAPPY = c(3,3,3,3,3))
wh_notHappy <- as.data.frame(apply(dta3[,1:4],2,as.factor))
predProbit2 <- predict(glmProbit2, newdata = wh_notHappy, type="response")
wh_notHappy_m <- predProbit2

# white very happy female for levels of education 0 to 4
glmProbit3 <- glm(TRUST~DEGREE+HAPPY+SEX+RACE,family=binomial(link="probit"),data=dta_clean_F)
dta4 <- data.frame(DEGREE = c(0,1,2,3,4), SEX = c(2,2,2,2,2), RACE = c(1,1,1,1,1),
                   HAPPY = c(1,1,1,1,1))
wh_veryHappy_f <- as.data.frame(apply(dta4[,1:4],2,as.factor))
predProbit3 <- predict(glmProbit3,newdata = wh_veryHappy_f, type="response")
wh_veryHappy_fm <- predProbit3

# white happy female for levels of education 0 to 4
glmProbit4 <- glm(TRUST~DEGREE+HAPPY+SEX+RACE,family=binomial(link="probit"),data=dta_clean_F)
dta5 <- data.frame(DEGREE = c(0,1,2,3,4), SEX = c(2,2,2,2,2), RACE = c(1,1,1,1,1),
                   HAPPY = c(2,2,2,2,2))
wh_vHappy_f <- as.data.frame(apply(dta5[,1:4],2,as.factor))
predProbit4 <- predict(glmProbit4, newdata = wh_vHappy_f, type="response")
wh_happy_fm <- predProbit4

# white not too happy female for levels of education 0 to 4
glmProbit5 <- glm(TRUST~DEGREE+HAPPY+SEX+RACE,family=binomial(link="probit"),data=dta_clean_F)
dta6 <- data.frame(DEGREE = c(0,1,2,3,4), SEX = c(2,2,2,2,2), RACE = c(1,1,1,1,1),
                   HAPPY = c(3,3,3,3,3))
wh_notHappy_f <- as.data.frame(apply(dta6[,1:4],2,as.factor))
predProbit5 <- predict(glmProbit5, newdata = wh_notHappy_f, type="response")
wh_notHappy_fm <- predProbit5 

# black very happy male for levels of education 0 to 4
glmProbit6 <- glm(TRUST~DEGREE+HAPPY+SEX+RACE,family=binomial(link="probit"),data=dta_clean_F)
dta7 <- data.frame(DEGREE = c(0,1,2,3,4), SEX = c(1,1,1,1,1), RACE = c(2,2,2,2,2),
                   HAPPY = c(1,1,1,1,1))
bl_veryHappy <- as.data.frame(apply(dta7[,1:4],2,as.factor))
predProbit6 <- predict(glmProbit6, newdata = bl_veryHappy, type="response")
bl_veryHappy_m <- predProbit6

# black happy male for levels of education 0 to 4
glmProbit7 <- glm(TRUST~DEGREE+HAPPY+SEX+RACE,family=binomial(link="probit"),data=dta_clean_F)
dta8 <- data.frame(DEGREE = c(0,1,2,3,4), SEX = c(1,1,1,1,1), RACE = c(2,2,2,2,2),
                   HAPPY = c(2,2,2,2,2))
bl_Happy <- as.data.frame(apply(dta8[,1:4],2,as.factor))
predProbit7 <- predict(glmProbit7, newdata = bl_Happy, type="response")
bl_happy_m <- predProbit7


# black not too happy male for levels of education 0 to 4

glmProbit8 <- glm(TRUST~DEGREE+HAPPY+SEX+RACE,family=binomial(link="probit"),data=dta_clean_F)
dta8 <- data.frame(DEGREE = c(0,1,2,3,4), SEX = c(1,1,1,1,1), RACE = c(2,2,2,2,2),
                   HAPPY = c(3,3,3,3,3))
bl_notHappy <- as.data.frame(apply(dta8[,1:4],2,as.factor))
predProbit8 <- predict(glmProbit8, newdata = bl_notHappy, type="response")
bl_notHappy_m <- predProbit8

# black very happy female for levels of education 0 to 4
glmProbit9 <- glm(TRUST~DEGREE+HAPPY+SEX+RACE,family=binomial(link="probit"),data=dta_clean_F)
dta9 <- data.frame(DEGREE = c(0,1,2,3,4), SEX = c(2,2,2,2,2), RACE = c(2,2,2,2,2),
                   HAPPY = c(1,1,1,1,1))
bl_veryHappy_f <- as.data.frame(apply(dta9[,1:4],2,as.factor))
predProbit9 <- predict(glmProbit9, newdata = bl_veryHappy_f, type="response")
bl_veryHappy_fm <- predProbit9

# black happy female for levels of education 0 to 4

glmProbit10 <- glm(TRUST~DEGREE+HAPPY+SEX+RACE,family=binomial(link="probit"),data=dta_clean_F)
dta10 <- data.frame(DEGREE = c(0,1,2,3,4), SEX = c(2,2,2,2,2), RACE = c(2,2,2,2,2),
                    HAPPY = c(2,2,2,2,2))
bl_Happy_f <- as.data.frame(apply(dta10[,1:4],2,as.factor))

predProbit10 <- predict(glmProbit10, newdata = bl_Happy_f, type="response")
bl_happy_fm <- predProbit10

# black not too happy female for levels of education 0 to 4
glmProbit11 <- glm(TRUST~DEGREE+HAPPY+SEX+RACE,family=binomial(link="probit"),data=dta_clean_F)
dta11 <- data.frame(DEGREE = c(0,1,2,3,4), SEX = c(2,2,2,2,2), RACE = c(2,2,2,2,2),
                    HAPPY = c(3,3,3,3,3))
bl_notHappy_f <- as.data.frame(apply(dta11[,1:4],2,as.factor))

predProbit11 <- predict(glmProbit11, newdata = bl_notHappy_f, type="response")
bl_notHappy_fm <- predProbit11

# white very happy male for levels of education 0 to 4 by the logistic model
glmProbit12 <- glm(TRUST~DEGREE+HAPPY+SEX+RACE,family=binomial,data=dta_clean_F)
dta12 <- data.frame(DEGREE = c(0,1,2,3,4), SEX = c(1,1,1,1,1), RACE = c(1,1,1,1,1),
                    HAPPY = c(1,1,1,1,1))
wh_veryHappy_log <- as.data.frame(apply(dta12[,1:4],2,as.factor))
predProbit12 <- predict(glmProbit12, newdata = wh_veryHappy_log, type="response")
wh_veryHappy_m_log <- predProbit12

# white happy male for levels of education 0 to 4 by the logistic model

glmProbit13 <- glm(TRUST~DEGREE+HAPPY+SEX+RACE,family=binomial,data=dta_clean_F)
dta12 <- data.frame(DEGREE = c(0,1,2,3,4), SEX = c(1,1,1,1,1), RACE = c(1,1,1,1,1),
                    HAPPY = c(2,2,2,2,2))
wh_Happy_log <- as.data.frame(apply(dta12[,1:4],2,as.factor))

predProbit13 <- predict(glmProbit13,newdata = wh_Happy_log ,type="response")
wh_happy_m_log <- predProbit13

# white not too happy male for levels of education 0 to 4 by the logistic model

glmProbit14 <- glm(TRUST~DEGREE+HAPPY+SEX+RACE,family=binomial,data=dta_clean_F)
dta13 <- data.frame(DEGREE = c(0,1,2,3,4), SEX = c(1,1,1,1,1), RACE = c(1,1,1,1,1),
                    HAPPY = c(3,3,3,3,3))
wh_Happy_log <- as.data.frame(apply(dta13[,1:4],2,as.factor))
predProbit14 <- predict(glmProbit14,newdata = wh_Happy_log, type="response")
wh_notHappy_m_log <- predProbit14

trustPredictions<-rbind(wh_veryHappy_m=wh_veryHappy_m,
                        wh_happy_m=wh_happy_m,
                        wh_notHappy_m=wh_notHappy_m,
                        wh_veryHappy_fm=wh_veryHappy_fm,
                        wh_happy_fm=wh_happy_fm,
                        wh_notHappy_fm=wh_notHappy_fm,
                        bl_veryHappy_m=bl_veryHappy_m,
                        bl_happy_m=bl_happy_m,
                        bl_notHappy_m=bl_notHappy_m,
                        bl_veryHappy_fm=bl_veryHappy_fm,
                        bl_happy_fm=bl_happy_fm,
                        bl_notHappy_fm=bl_notHappy_fm,
                        wh_veryHappy_m_log=wh_veryHappy_m_log,
                        wh_happy_m_log=wh_happy_m_log,
                        wh_notHappy_m_log=wh_notHappy_m_log)
saveRDS(trustPredictions,paste0(dataPath,'result.rds'))
