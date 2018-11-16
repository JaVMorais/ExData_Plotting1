library(data.table)

total_data <- fread("household_power_consumption.txt", colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"), na.strings = "?")

png("plot1.png")

par(bg = "transparent")

with(total_data[as.Date(total_data$Date, format = "%d/%m/%Y") >= as.Date("2007-02-01") & as.Date(total_data$Date, format = "%d/%m/%Y") <= as.Date("2007-02-02"),], hist(Global_active_power, col="red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power"))

dev.off()