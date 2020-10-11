setwd("C:/Users/cafil/Desktop")

dt <- read.csv("AustraliaIntAirPassengers.csv")

y <- ts(dt$Passengers, start = c(1985, 1), frequency = 12)
plot(y)

ly <- log(y)
plot(ly) #-- stagionalità
library(forecast)
ggseasonplot(ly)

sdly <- diff(ly, 12) #-- differenza rispetto a 12 oss precedenti
autoplot(sdly)

library(urca)
adf <- ur.df(sdly, "drift", lags = 12, "AIC")
summary(adf) #-- regressione della differenza su una costante sotto
             #-- ipotesi di radice unitaria

ggAcf(sdly, lag.max = 48)
ggPacf(sdly, lag.max = 48)

y_train <- window(y, c(1985, 1), c(2011,12))
y_test <- window(y, c(2012, 1))

mod1 <- Arima(y_train, c(2,0,0), c(0,1,0), include.constant = T,
              lambda = 0) #-- box cox (log)

ggAcf(mod1$residuals, lag.max = 48)
ggPacf(mod1$residuals, lag.max = 48)

mod1 <- Arima(y_train, c(2,0,0), c(0,1,1), include.constant = T,
              lambda = 0) #-- box cox (log)

ggAcf(mod1$residuals, lag.max = 48)
ggPacf(mod1$residuals, lag.max = 48)

mod1 <- Arima(y_train, c(3,0,0), c(0,1,1), include.constant = T,
              lambda = 0) #-- box cox (log)

checkresiduals(mod1)

ggAcf(mod1$residuals, lag.max = 48)
ggPacf(mod1$residuals, lag.max = 48)



mod1 <- Arima(y_train, c(4,0,0), c(0,1,1), include.constant = T,
              lambda = 0) #-- box cox (log)

checkresiduals(mod1)

ggAcf(mod1$residuals, lag.max = 48)
ggPacf(mod1$residuals, lag.max = 48)

#-- prediction
pre1 <- forecast(mod1, h = 24) #-- orizzonte previsione
plot(y_test)
lines(pre1$mean, col = "red") #-- leggera sovra previsione

mod2 <- Arima(y_train, c(0,1,1), c(0,1,1),
              lambda = 0)
checkresiduals(mod2)

pre2 <- forecast(mod2, h = 24)

plot(y_test)
lines(pre1$mean, col = "red") #-- leggera sovra previsione
lines(pre2$mean, col = "green") #-- meglio il secondo

#-- energia es2
dt <- read.csv("LoadByHour0514.csv")
dum <- readxl::read_xlsx("elettrodummies.xlsx")

library(xts)
y<-xts(dt$h10, as.Date(as.character(dt$X), format = "%Y%m%d"))
ggAcf(y, lag.max = 366)
ggPacf(y, lag.max = 366)

ggAcf(diff(y,7), lag.max = 30)
ggPacf(diff(y,7), lag.max = 30)

mod0 <- Arima(y, c(3,0,0),
              list(order = c(0, 1, 1),
              period = 7), include.constant = T)

ggAcf(mod1$residuals, lag.max = 366)
ggPacf(mod1$residuals, lag.max = 366)


#--costruzione frequenze sinusoidi stagionali
tempo <- 1:nrow(y)
vj <- 1:16

freq <- outer(tempo,vj)*2*pi/365
x <- cbind(cos(freq), sin(freq))
colnames(x) <- c(paste0("cos", vj), paste0("sin", vj))

mod1 <- Arima(y, c(3,0,0),
              list(order = c(0, 1, 1),
                   period = 7), include.constant = T,
              xreg = x)

mod1

freq1 <- outer(3653:4018, 1:16)*2*pi/365
X1 <- cbind(cos(freq1), sin(freq1))
colnames(x1) <- colnames(x)

plot(forecast(mod0, h =365), include = 365)
plot(forecast(mod1, h =365), x = X1, include = 365)

#-- già messo
#-- local linear trend
set.seed(20201006)
n <- 200 #-- oss
beta <- numeric(n) #-- parametri
mu <- numeric(n)   #-- trend

sd_eta <- 1
sd_xi  <- 0.1

#-- costruzione local linear trend
for (t in 2:n){
  beta[t] <- beta[t-1] + rnorm(1,sd = sd_xi) #-- coeff. angolare
  mu[t] <- mu[t-1] + beta[t-1] + rnorm(1, sd = sd_eta) #-- intercetta
}

plot(ts(beta))
plot(ts(mu))