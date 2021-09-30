dataPath = '/Users/nimo/Desktop/31010/7/nonlinear_models_07_data/'
library(MASS)
library(nnet)
install.packages('MLmetrics')
library(MLmetrics)

train_dat <- read.table(paste(dataPath,'Week7_Test_Sample_Train.csv',sep = '/'), header=TRUE)
test_dat <- read.table(paste(dataPath,'Week7_Test_Sample_Test.csv',sep = '/'), header=TRUE)

train_dat$Y <- as.factor(train_dat$Y)


polr.fit <- polr(Y~ X1 + X2, data = train_dat, method = "logistic")
summary(polr.fit)
predicted.prob.polr.train <- polr.fit$fitted.values

multinom.fit <- multinom(Y~ X1 + X2, data = train_dat)
summary(multinom.fit)
predicted.prob.multinom.train <- multinom.fit$fitted.values


y_true <- as.integer(train_dat$Y)
log.loss.polr.train = MultiLogLoss(y_pred =  predicted.prob.polr.train,y_true = y_true)
log.loss.multinom.train = MultiLogLoss(y_pred =  predicted.prob.multinom.train,y_true = y_true)


predicted.prob <-predict(multinom.fit,test_dat, type="prob")
sum(predicted.prob[1,])

res <- list(predicted.prob=predicted.prob,
            log.loss.polr.train=log.loss.polr.train,
            log.loss.multinom.train=log.loss.multinom.train)

saveRDS(res, file = paste(dataPath,'result.rds',sep = '/'))
