# Peer-graded Assignment: Course Project 1
# 12-12-2016
# David Lennox-Hvenekilde
# plot 4, combination

library(dplyr)
library(lubridate)
#Create new dir for data, download the zip data, unzip, and read in the data table
if(!file.exists("./Data")){dir.create("./Data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl,destfile="./Data/EPC.zip")
unzip("./Data/EPC.zip")
HHPC <- read.table("household_power_consumption.txt", sep = ";", header = TRUE)

#COnvert date and time with lubridate package:
HHPC$Date <- dmy(HHPC$Date)
HHPC$Time <- hms(HHPC$Time)
s

#Subset data to include only observations with Date == 2007-02-01 OR 2007-02-02, using dplyr
HHPC2 <- filter(HHPC, Date == c(ymd(20070201),ymd(20070202)))

#Convert from factor to numeric so that it can be plotted
HHPC2 <- mutate(HHPC2, Global_active_power = as.numeric(levels(Global_active_power))[Global_active_power])
HHPC2 <- mutate(HHPC2, Sub_metering_1 = as.numeric(levels(Sub_metering_1))[Sub_metering_1])
HHPC2 <- mutate(HHPC2, Sub_metering_2 = as.numeric(levels(Sub_metering_2))[Sub_metering_2])
HHPC2 <- mutate(HHPC2, Sub_metering_3 = as.numeric(levels(Sub_metering_3))[Sub_metering_3])
HHPC2 <- mutate(HHPC2, Voltage = as.numeric(levels(Voltage))[Voltage])
HHPC2 <- mutate(HHPC2, Global_reactive_power = as.numeric(levels(Global_reactive_power))[Global_reactive_power])

#Plotting to png file
png("plot4.png", width = 480, height = 480)
par(mar = c(4,4,2,2))
par(mfrow=c(2,2))

#1
plot(HHPC2$Global_active_power,
     type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowatt)",
     xaxt="n")

axis(1, at=c(0,length(HHPC2$Global_active_power)/2, length(HHPC2$Global_active_power)), 
     labels=c("Thu", "Fri", "Sat"))
#2
plot(HHPC2$Voltage,
     type = "l",
     xlab = "datetime",
     ylab = "Voltage",
     xaxt="n")

axis(1, at=c(0,length(HHPC2$Global_active_power)/2, length(HHPC2$Global_active_power)), 
     labels=c("Thu", "Fri", "Sat"))

#3
plot(HHPC2$Sub_metering_1,
     type = "l",
     xlab = "",
     ylab = "Energy sub metering",
     xaxt="n")

lines(HHPC2$Sub_metering_2, col = "red")
lines(HHPC2$Sub_metering_3, col = "blue")

legend("topright", 
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty=c(1,1,1),
       lwd=c(2.5,2.5,2.5),
       col=c("black", "red", "blue"),
       bty = "n")

axis(1, at=c(0,length(HHPC2$Global_active_power)/2, length(HHPC2$Global_active_power)), 
     labels=c("Thu", "Fri", "Sat"))

#4
plot(HHPC2$Global_reactive_power,
     type = "l",
     xlab = "datetime",
     ylab = "Global_reactive_power",
     xaxt="n")

axis(1, at=c(0,length(HHPC2$Global_active_power)/2, length(HHPC2$Global_active_power)), 
     labels=c("Thu", "Fri", "Sat"))

dev.off()

