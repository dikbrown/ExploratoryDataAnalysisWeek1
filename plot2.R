library(tidyverse)
library(lubridate)

# Read in electric power consumption dataset and do some exploratory data analysis

dat <- read.table("household_power_consumption.txt", sep = ";", header = TRUE)

data <- dat[dat$Date %in% c("1/2/2007","2/2/2007"),]

rm(dat)
data$DateTime <- dmy_hms(paste(data$Date, data$Time))

# data$Date <- as.Date(data$Date, "%d/%m/%Y")
# data$Time <- strptime(data$Time, "%H:%M:%S")
data$Date <- dmy(data$Date)
data$Time <- hms(data$Time)


# data <- data[data$Date == as.Date("2007-02-01") || data$Date == as.Date("2007-02-02"),]
# data <- data[data$Date %in% c(as.Date("2007-02-01"), as.Date("2007-02-02")),]
data[,3:8] <- sapply(data[,3:8], as.numeric)

################
###  Plot 2  ###
################
png(filename = "plot2.png", width = 480, height = 480)  # set output to file in png format
plot(x = data$DateTime, 
     y = data$Global_active_power, 
     type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)")
dev.off() # close png device
dev.set(2) # set back to screen output

