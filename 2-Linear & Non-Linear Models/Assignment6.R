dataPath = '/Users/nimo/Desktop/31010/6/'
test_dat <- read.table(paste(dataPath,'Week6_Test_Sample.csv',sep = '/'), header=TRUE)

library('pscl')

zeroinfl.nb.fit = zeroinfl(Output~ Predictor.Count | Predictor.Zero, data = test_dat, 
                           dist = "negbin",
                           link = 'logit')

theta = zeroinfl.nb.fit$theta

predicted.prob = predict(zeroinfl.nb.fit, type="prob")

predicted.prob = predicted.prob[,1]

predZero<-predict(zeroinfl.nb.fit,type="zero")

predicted.prob.zero.component<-predict(zeroinfl.nb.fit,type="zero")

predicted.prob.count.component = (predicted.prob-predZero)/(1-predZero)

newdata = data.frame(test_dat$Predictor.Zero,test_dat$Predictor.Count)

colnames(newdata)[1] <- "Predictor.Zero"
colnames(newdata)[2] <- "Predictor.Count"

Probability.Zero = predict(zeroinfl.nb.fit,newdata = newdata, type="prob")
Probability.Zero = Probability.Zero[,1]

Predictor.Count = test_dat$Predictor.Count
Predictor.Zero = test_dat$Predictor.Zero
predicted.prob.total = cbind(Probability.Zero,Predictor.Count,Predictor.Zero)


res <- list(predicted.prob.zero.component=predicted.prob.zero.component,
            predicted.prob.count.component = predicted.prob.count.component,
            predicted.prob.total = predicted.prob.total,
            theta = theta)

saveRDS(res, file = paste(dataPath,'result.rds',sep = '/'))