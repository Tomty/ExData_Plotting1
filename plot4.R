### library

library(dplyr)
library(lubridate)

### Read Data

temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)

df <- read.table(unz(temp,"household_power_consumption.txt"), sep = ";", header = TRUE)

unlink(temp)

df <- subset(df, Date == "2/2/2007" | Date == "1/2/2007")
df <- mutate(df, DateTime = strptime(paste(Date,Time,sep = " "), "%d/%m/%Y %H:%M:%S"))

### Making plot

par(mfrow=c(2,2))

plot(df$DateTime, df$Global_active_power, type = "l", xlab = "",ylab = "Global Active Power (kilowatts)")
plot(df$DateTime, df$Voltage, type = "l", ylab = "Voltage", xlab = "datetime")
plot(df$DateTime, df$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "")  # Plot with Base R
lines(df$DateTime, df$Sub_metering_2, type = "l", col = "blue")
lines(df$DateTime, df$Sub_metering_3, type = "l", col = "red")
legend("topright", col = c("black","blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"), lty = 1)
plot(df$DateTime, df$Global_reactive_power, type = "l", ylab = "Global_reactive_power", xlab = "datetime")

### Export as png

dev.copy(png,'plot4.png')
dev.off()