
#QQ <- read.delim("clipboard") #I copied the table in Excel and
#used this command to import the data

#you can also simply load the RData file I saved
load(file="Vakas_data.RData") 
class(QQ) #good if data.frame
class(QQ$State) #good if factor
class(QQ$Year) #good if integer
class(QQ$Eviction) #this one and the rest should be numeric. They all are. Good
class(QQ$Crime)
class(QQ$Unempl)
class(QQ$Ch_Evict)
class(QQ$Ch_Crime)
class(QQ$Ch_Unempl)

summary(QQ) #format the results in a pretty way and present them in the paper,
# also dicuss what unemployment rate, eviction rate and crime rate means and where the date is from.

#create a new variable - lagged eviction and unemployment
#one would think maybe crime rate this year depends on last year's eviction and unemployment rates

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
#check if the new variable lags the values correctly.
#I think it does.

#Also, we can adjust the year variable. Let's create a time variable
QQ$Time=QQ$Year-1999 #it is better to use this to control for time

save(QQ,file="Vakas_data.RData") #Save data so don't need to go back to Excel anymore

#possible regressions you can include in your discussion

reg1=lm(Crime~Eviction+Unempl+State+Time,data=QQ)
summary(reg1)
library(lmtest)
library(sandwich)
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
summary(reg4)
reg4b=coeftest(reg4, vcov = vcovHC(reg4)) #use heteroskedasticity robust SE
reg4b

#graph 
reg1 <- lm(Crime~Eviction,Unempl,data=QQ)

summary(reg1)
with(QQ,plot(Eviction, Crime))
abline(reg1)
