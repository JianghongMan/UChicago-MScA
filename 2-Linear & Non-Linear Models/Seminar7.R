library(pscl)
library(VGAM)
library(countreg)
library(MASS)
data(crashp)
crashp
dta<-data.frame(Count=c(as.matrix(crashp)),
                Day=rep(colnames(crashp),each=dim(crashp)[1]),
                Hour=as.factor(rep(0:23,7)))
head(dta,25)
plot(table(dta$Count))
mPoi<-glm(Count~.,family=poisson,data=dta)
countreg::rootogram(mPoi)
DF=mPoi$df.residual
LogLk=logLik(mPoi)[1]
fit_mPoi=c(LogLk,DF)
out<-dpois(0,predict(mPoi,type="response"))
midnightWeekendCrashes_mPoi<-out[145]*out[121]
out<-dpois(0,predict(mPoi,type="response"))
mondayNightCrashes_mPoi<-out[1]*out[2]*out[3]

mNbin<-glm.nb(Count~.,data=dta)
DF=mNbin$df.residual
LogLk=logLik(mNbin)[1]
fit_mNbin=c(LogLk,DF)
mu<-unique(predict(mNbin,type="response"))
(theta<-mNbin$theta)
p<-theta/(mu+theta)
out<-dnbinom(0,p=p,size=theta)
midnightWeekendCrashes_mNbin<-out[145]*out[121]
mondayNightCrashes_mNbin<-out[1]*out[2]*out[3]

mHurd<-hurdle(Count~.,data=dta, dist = "negbin")
DF=mHurd$df.residual
LogLk=logLik(mHurd)[1]
fit_mHurd=c(LogLk,DF)
fit_mHurd
x<-(cbind(c('Sat','Sun'),c(0,0)))
colnames(x)<-c('Day','Hour')
midnightWeekendCrashes_mHurdle<-predict(mHurd,as.data.frame(x),type='prob')
midnightWeekendCrashes_mHurdle<-midnightWeekendCrashes_mHurdle[1,1]*midnightWeekendCrashes_mHurdle[2,1]
x<-dta[1:3,2:3]
x
mondayNightCrashes_mHurdle<-predict(mHurd,as.data.frame(x),type='prob')
mondayNightCrashes_mHurdle<-mondayNightCrashes_mHurdle[1,1]*mondayNightCrashes_mHurdle[2,1]*mondayNightCrashes_mHurdle[3,1]

mZINbin <- zeroinfl(Count~Day,data=dta,dist = "negbin")
DF=mZINbin$df.residual
LogLk=logLik(mZINbin)[1]
fit_mZINbin=c(LogLk,DF)
fit_mZINbin
x<-(cbind(c('Sat','Sun'),c(0,0)))
colnames(x)<-c('Day','Hour')
midnightWeekendCrashes_mZINbin<-predict(mZINbin,as.data.frame(x),type='prob')
midnightWeekendCrashes_mZINbin<-midnightWeekendCrashes_mZINbin[1,1]*midnightWeekendCrashes_mZINbin[2,1]
x<-dta[1:3,2:3]
x
mondayNightCrashes_mZINbin<-predict(mZINbin,as.data.frame(x),type='prob')
mondayNightCrashes_mZINbin<-mondayNightCrashes_mZINbin[1,1]*mondayNightCrashes_mZINbin[2,1]*mondayNightCrashes_mZINbin[3,1]

fits<-rbind(fit_mPoi=fit_mPoi,
            fit_mNbin=fit_mNbin,
            fit_mHurd=fit_mHurd,
            fit_mZINbin=fit_mZINbin)

mondayNightCrashes<-c(mondayNightCrashes_mPoi=mondayNightCrashes_mPoi,
                      mondayNightCrashes_mNbin=mondayNightCrashes_mNbin,
                      mondayNightCrashes_mHurdle=mondayNightCrashes_mHurdle,
                      mondayNightCrashes_mZINbin=mondayNightCrashes_mZINbin)

midnightWeekendCrashes<-
  c(midnightWeekendCrashes_mPoi=midnightWeekendCrashes_mPoi,
    midnightWeekendCrashes_mNbin=midnightWeekendCrashes_mNbin,
    midnightWeekendCrashes_mHurdle=midnightWeekendCrashes_mHurdle,
    midnightWeekendCrashes_mZINbin=midnightWeekendCrashes_mZINbin)

numbers0<-round(c(Obs = sum(dta$Count < 1),
                  mPoi = sum(dpois(0, fitted(mPoi))),
                  mNbin = sum(dnbinom(0, mu = fitted(mNbin), 
                                      size = mNbin$theta)),
                  mHurdle = sum(predict(mHurd, type = "prob")[,1]),
                  mZINBin = sum(predict(mZINbin, type = "prob")[,1])))

modelCoefficients<-cbind(mPoi$coefficients,
                         mNbin$coefficients,
                         mHurd$coefficients$count,
                         c(mZINbin$coefficients$count,rep(NA,23)))
res <- list(fits=fits,
            mondayNightCrashes = mondayNightCrashes,
            midnightWeekendCrashes= midnightWeekendCrashes,
            modelCoefficients = modelCoefficients,
            numbers0=numbers0)



res
saveRDS(res,'result.rds')
