library(MASS)
library(AER)
library(pscl)

dataPath = '/Users/nimo/Desktop/31010/5/Assignment'
test_dat <- read.table(paste(dataPath,'Week5_Test_Sample.csv',sep = '/'), header=TRUE)
head(test_dat)

#glm.poisson.fit = glm(Output~Predictor, family = 'poisson', data = test_dat)
glm.nb.fit = glm.nb(Output~Predictor,  data = test_dat)

dispersion.test = dispersiontest(glm.poisson.fit,alternative="two.sided")
dispersion.test.p.value = dispersion.test$p.value

theta = glm.nb.fit$theta

predict(glm.nb.fit,type="response")

odTest(glm.nb.fit)

predicted.values = glm.nb.fit$fitted.values



res <- list(predicted.values=predicted.values,  
            dispersion.test.p.value=dispersion.test.p.value,
            theta = theta)

saveRDS(res, file = paste(dataPath,'result.rds',sep = '/'))

