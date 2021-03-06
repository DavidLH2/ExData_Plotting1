# Peer-graded Assignment: Course Project 1
# 12-12-2016
# David Lennox-Hvenekilde
# plot 2

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

#Plotting to png file
png("plot2.png", width = 480, height = 480)
par(mar = c(3,4,3,2))

plot(HHPC2$Global_active_power,
     type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowatt)",
     xaxt="n")

axis(1, at=c(0,length(HHPC2$Global_active_power)/2, length(HHPC2$Global_active_power)), 
     labels=c("Thu", "Fri", "Sat"))

dev.off()

