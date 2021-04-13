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
###  Plot 1  ###
################
png(filename = "plot1.png", width = 480, height = 480) # set output to file in png format
hist(data$Global_active_power, 
     xlab = "Global Active Power (kilowatts)",
     ylab = "Frequency",
     main = "Global Active Power",
     col = "red")
dev.off() # close png device
dev.set(2) # set back to screen output
