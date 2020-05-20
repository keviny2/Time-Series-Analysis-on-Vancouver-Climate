library(dplyr)
data <- BC_Climate_Data
data <- data[1:5568,]
colnames(data)[15] <- "mean.temp"
colnames(data)[7] <- "year"
colnames(data)[8] <- "month"

data$mean.temp <- as.numeric(as.character(data$mean.temp))
data$year <- as.numeric(as.character(data$year))
data$month <- as.numeric(as.character(data$month))
mean <- mean(mean.temp, na.rm=TRUE)

month.data <- data %>% group_by(year,month) %>% summarize(mean.temp = mean(mean.temp, na.rm=TRUE)) %>% as.data.frame
month.mean <- month.data$mean.temp
mean <- mean(month.mean, na.rm=TRUE)
for (i in 1:184) {
  if (is.na(month.mean[i])) {
    month.mean[i] <- mean
  }
}


date=c(2003,1)
climate.ts <- ts(month.mean,start=date,frequency=12)