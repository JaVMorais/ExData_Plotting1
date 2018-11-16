library(data.table)

total_data <- fread("household_power_consumption.txt", colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"), na.strings = "?")

png("plot3.png")

par(bg = "transparent")

plot_data <- total_data[as.Date(total_data$Date, format = "%d/%m/%Y") >= as.Date("2007-02-01") 
                        & as.Date(total_data$Date, format = "%d/%m/%Y") <= as.Date("2007-02-02"),]

plot_data[,time2:=as.POSIXct(paste(Time,Date), format = "%H:%M:%S %d/%m/%Y")]

with(plot_data, 
     plot(time2,Sub_metering_1,
          col = "black",
          type = "l",
          xlab = "",
          ylab = "Energy sub metering"
          
     )
)
with(plot_data,
     lines(time2,Sub_metering_2,
           col = "red"
     )
)
with(plot_data,
     lines(time2,Sub_metering_3,
           col = "blue"
     )
)

legend("topright", 
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
       col = c("black","red","blue"), 
       lty = rep(1,3)
)

dev.off()