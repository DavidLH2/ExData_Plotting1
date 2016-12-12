# Peer-graded Assignment: Course Project 1
# 12-12-2016
# David Lennox-Hvenekilde
# plot 1, Histogram

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
png("plot1.png", width = 480, height = 480)
hist(HHPC2$Global_active_power, breaks = 12, col = "red", main = "Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()

