### library

library(dplyr)
library(lubridate)

### Read Data

temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)

df <- read.table(unz(temp,"exdata_data_household_power_consumption/household_power_consumption.txt"), sep = ";", header = TRUE)

unlink(temp)

df <- subset(df, Date == "2/2/2007" | Date == "1/2/2007")
df <- mutate(df, DateTime = strptime(paste(Date,Time,sep = " "), "%d/%m/%Y %H:%M:%S"))

### Exporting plot

par(mfrow=c(1,1))

png("plot2.png") 

plot(df$DateTime, df$Global_active_power, type = "l", xlab = "",ylab = "Global Active Power (kilowatts)")

dev.off()