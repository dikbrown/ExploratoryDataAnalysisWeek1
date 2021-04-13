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
###  Plot 4  ###
################

par(mfrow = c(2,2))
# top left
png(filename = "plot4.png", width = 480, height = 480) # set output to file in png format
par(mfrow = c(2,2))

par(mar = c(2,2,2,1))
par(mgp = c(1,.25,0))
par(tck = -.01)
plot(x = data$DateTime, 
     y = data$Global_active_power, 
     type = "l",
     cex.lab = 0.75,
     cex.axis = 0.75,
     xlab = "",
     ylab = "Global Active Power")

# top right
plot(x = data$DateTime, 
     y = data$Voltage, 
     type = "l",
     cex.lab = 0.75,
     cex.axis = 0.75,
     xlab = "datetime",
     ylab = "Voltage",
     ylim = c(233,247))

# bottom left
plot(x = data$DateTime, 
     y = data$Sub_metering_1, 
     type = "l",
     cex.lab = .75,
     cex.axis = 0.75,
     xlab = "",
     ylab = "Energy sub metering")
lines(x = data$DateTime,
      y = data$Sub_metering_2,
      col = "red")
lines(x = data$DateTime,
      y = data$Sub_metering_3,
      col = "blue")
legend("topright", 
       lwd = 1, 
       col = c("black", "red", "blue"), 
       cex = .6,
       bty = "n",
       text.width = 60*60*13, # changing the last number allows changing the x-offset by number of hours
       legend = c("Sub_metering_1\n", "Sub_metering_2\n", "Sub_metering_3\n"))

plot(x = data$DateTime, 
     y = data$Global_reactive_power, 
     cex.lab = 0.75,
     cex.axis = 0.7,
     type = "l",
     xlab = "datetime",
     ylab = "Global_reactive_power")

par(mfrow = c(1,1))
dev.off() # close png device
dev.set(2) # set back to screen output


