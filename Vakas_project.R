
#QQ <- read.delim("clipboard") #I copied the table in Excel and
#used this command to import the data
library(stargazer) #to create charts for regression and summary data 
#you can also simply load the RData file I saved
load(file="Vakas_data.RData") 
class(QQ) #good if data.frame
class(QQ$State) #good if factor
class(QQ$Year) #good if integer
class(QQ$Eviction) #lines 10-15 should be numeric
class(QQ$Crime)
class(QQ$Unempl)
class(QQ$Ch_Evict)
class(QQ$Ch_Crime)
class(QQ$Ch_Unempl)

summary(QQ) 

#lagged eviction and unemployment
#one would assume that crime rates this year depends on last year's eviction and unemployment rates

QQ$lag_Crime=NA
QQ$lag_Unempl=NA
QQ$lag_Evict=NA

for (i in seq(2,nrow(QQ))) {
  if (QQ$State[i]==QQ$State[i-1]){
    QQ$lag_Crime[i]=QQ$Crime[i-1]
    QQ$lag_Unempl[i]=QQ$Unempl[i-1]
    QQ$lag_Evict[i]=QQ$Evict[i-1]
  }
}
#test if the new variable lags the values correctly.


#Also, we can adjust the year variable. Let's create a time variable
QQ$Time=QQ$Year-1999 #control for time

save(QQ,file="Vakas_data.RData") #Save data so don't need to go back to Excel anymore

#regressions

reg1=lm(Crime~Eviction+Unempl+State+Time,data=QQ)
summary(reg1)
library(lmtest)
library(sandwich)
bptest(reg1)
reg1b=coeftest(reg1, vcov = vcovHC(reg1)) #use heteroskedasticity robust SE
reg1b

reg2=lm(Crime~lag_Evict+lag_Unempl+State+Time,data=QQ)
summary(reg2)
reg2b=coeftest(reg2, vcov = vcovHC(reg2)) #use heteroskedasticity robust SE
reg2b

reg3=lm(Crime~Eviction+lag_Evict+lag_Unempl+State+Time,data=QQ)
summary(reg3)
library(car)
linearHypothesis(reg3,c("Eviction=0","lag_Evict=0"))
reg3b=coeftest(reg3, vcov = vcovHC(reg3)) #use heteroskedasticity robust SE
reg3b

reg4=lm(Ch_Crime~Ch_Evict+Ch_Unempl,data=QQ)
stargazer(reg4, type='html', out = "Eviction and Crime Rates/reg4.html")
summary(reg4)
reg4b=coeftest(reg4, vcov = vcovHC(reg4)) #use heteroskedasticity robust SE
reg4b

#graph 
reg1 <- lm(Crime~Eviction,Unempl,data=QQ)

summary(reg1)
with(QQ,plot(Eviction, Crime))
abline(reg1)
