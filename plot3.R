setwd('~/R/ExData_Plotting1')
library(data.table)
library(dplyr)

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, destfile="./data/har.zip", method="curl")
unzip("data/har.zip", exdir="data/")

data <- data.table(read.csv('data/household_power_consumption.txt', sep=";",na.strings="?",stringsAsFactors=FALSE))
data$D <- as.Date(data$Date, "%d/%m/%Y")

filtered_data <- filter(data, data$D == '2007-02-01' | data$D == '2007-02-02')


filtered_data <- within(filtered_data, { timestamp=format(as.POSIXct(paste(D, Time)), "%m/%d/%Y %H:%M:%S") })

filtered_data$timestamp <- as.POSIXct(filtered_data$timestamp, format="%m/%d/%Y %H:%M:%S")



png(filename = "plot3.png", width = 480, height = 480)
plot(filtered_data$timestamp, filtered_data$Sub_metering_1, col='black', type='l',ylab = "Global Active Power (kilowatts)", xlab = "")
lines(filtered_data$timestamp, filtered_data$Sub_metering_2, col='red')
lines(filtered_data$timestamp, filtered_data$Sub_metering_3, col='blue')
legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2, 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))     
dev.off()
