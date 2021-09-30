library(HoRM)
data(Auto)
Auto
Auto$logCost<-log(Auto$Cost)
Auto$InsuredZ<-(Auto$Insured-mean(Auto$Insured))/sd(Auto$Insured)
Auto$PremiumZ<-(Auto$Premium-mean(Auto$Premium))/sd(Auto$Premium)
Auto$ClaimsZ<-(Auto$Claims-mean(Auto$Claims))/sd(Auto$Claims)
head(Auto)

pca = princomp(Auto[,c('InsuredZ', 'PremiumZ', 'ClaimsZ')])
Auto[,'Factor1'] = pca$scores[,1]
Auto[,'Factor2'] = pca$scores[,2]
Auto[,'Factor3'] = pca$scores[,3]

gammaRegr <- glm(formula = Cost ~ Merit + Class + Factor1 + Factor2 + Factor3, 
                 family = Gamma(link = "log"), data = Auto)
stepgamma <- step(gammaRegr)
logNormRegr <- glm(formula = log(Cost) ~ Merit + Class + Factor1 + Factor2 + Factor3,
                   family = gaussian, data = Auto)
steplog <- step(logNormRegr)
modelCoeffs <- cbind(Gamma=stepgamma$coefficients, lognormal=steplog$coefficients)
modelCoeffs
predictedValues <- cbind(prdictedByGamma=stepgamma$fitted.values, 
                         predictedByLognormal=exp(steplog$fitted.values))
predictedValues
compareResiduals <- cbind(gammaResid=gammaRegr$residuals,
                          LogNormResid=logNormRegr$residuals)
compareResiduals
dispersions <- c(dispersion_gamma=summary(stepgamma)$dispersion, 
                 dispersion_lnorm=summary(steplog)$dispersion)
shapeGamma <- 1/summary(stepgamma)$dispersion
scaleGamma <- summary(stepgamma)$dispersion
gammaParameters <- c(shapeGamma,scaleGamma)
gammaParameters
shapeLNorm <- sqrt(summary(steplog)$dispersion)
meanLNorm <- (-0.5*summary(steplog)$dispersion)
lognormalParameters <- c(shapeLNorm,meanLNorm)
x <- data.frame(Merit='0', Class='1', Factor1 = -0.05, Factor2 = 0.05, Factor3 = 0.05)
policyGamma <- predict(stepgamma, newdata = x, type = 'response')
policyGamma
policyLNorm <- predict(steplog, newdata = x, type = 'response')
policyLNorm
policyPredictions <- c(policyGamma=policyGamma, policyLNorm=exp(policyLNorm))
policyPredictions

res<-list(modelCoeffs=modelCoeffs,
          predictedValues=predictedValues,
          compareResiduals=compareResiduals,
          dispersions=dispersions,
          gammaParameters=gammaParameters,
          lognormalParameters=lognormalParameters,
          policyPredictions=policyPredictions)
saveRDS(res,'result.rds')

