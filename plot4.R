# Source of data for this project: 
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip

# This R script does the following:
# 1. read the full data
data <- read.table("household_power_consumption.txt", 
                   header=T, sep=";", na.strings="?",
                   colClasses=c(rep("character",2), rep("numeric",7)))
#2. subset the data by match the date equals to 2007/02/01 or 2007/02/02
data_subset <- data[data$Date=="1/2/2007"|data$Date=="2/2/2007",]

#3. create a new variable "DateTime" which is combine the Date and Time variables
#   and then convert to "date" class
data_subset$DateTime <- strptime(paste(data_subset[,1],data_subset[,2])
                                 ,"%d/%m/%Y %H:%M:%S",tz = "EST5EDT")

#4. construct the plot4 and saved as png file
png(filename="plot4.png",width=480,height=480)
par(mfrow=c(2,2))
#topleft
with(data_subset, plot(DateTime, Global_active_power,type="l",xlab=""
                       ,ylab="Global Active Power"))
#topright
with(data_subset, plot(DateTime,Voltage,type="l",xlab="datetime"
                       ,ylab="Voltage"))
#bottomleft
with(data_subset, plot(DateTime, Sub_metering_1,type="l",xlab=""
                       ,ylab="Energy sub metering"))
with(data_subset, lines(DateTime, Sub_metering_2, type="l", col="red"))
with(data_subset, lines(DateTime, Sub_metering_3, type="l", col="blue"))
legend("topright", lty=c(1,1,1), col=c("black","red","blue"),bty="n",
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
#bottomright
with(data_subset, plot(DateTime,Global_reactive_power,type="l",xlab="datetime"
                       ,ylab="Global_reactive_power"))
dev.off()