library(data.table)

total_data <- fread("household_power_consumption.txt", colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"), na.strings = "?")

png("plot2.png")

par(bg = "transparent")

plot_data <- total_data[as.Date(total_data$Date, format = "%d/%m/%Y") >= as.Date("2007-02-01") 
                        & as.Date(total_data$Date, format = "%d/%m/%Y") <= as.Date("2007-02-02"),]

plot_data[,time2:=as.POSIXct(paste(Time,Date), format = "%H:%M:%S %d/%m/%Y")]

with(plot_data, 
     plot(time2,Global_active_power,
          xlab = "",
          ylab = "Global Active Power (kilowatts)",
          type = "l"
    )
)

dev.off()