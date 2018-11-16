# Load 'data.table' package. The function library() already checks whether the package is already 
# loaded
library(data.table)

# Load data from file
total_data <- fread("household_power_consumption.txt", colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"), na.strings = "?")

# Open 'png' graphics device with a 2x2 scheme and set background to 'transparent' 
png("plot4.png")

par(mfrow = c(2,2), bg = "transparent")

# Restrict data to the desired time interval and add extra column with complete time & date in 
# POSIXct format
plot_data <- total_data[as.Date(total_data$Date, format = "%d/%m/%Y") >= as.Date("2007-02-01") 
                        & as.Date(total_data$Date, format = "%d/%m/%Y") <= as.Date("2007-02-02"),]

plot_data[,Total_Time:=as.POSIXct(paste(Time,Date), format = "%H:%M:%S %d/%m/%Y")]

# Plot 1 - histogran
with(plot_data, 
     plot(Total_Time,Global_active_power,
          xlab = "",
          ylab = "Global Active Power",
          type = "l"
     )
)

# Plot 2 - scatterplot with lines
with(plot_data, 
     plot(Total_Time, Voltage,
          xlab = "datetime",
          ylab = "Voltage",
          type = "l"
     )
)

# Plot 3 - scatterplot with lines
with(plot_data, 
     plot(Total_Time,Sub_metering_1,
          col = "black",
          type = "l",
          xlab = "",
          ylab = "Energy sub metering"
          
     )
)
with(plot_data,
     lines(Total_Time,Sub_metering_2,
           col = "red"
     )
)

with(plot_data,
     lines(Total_Time,Sub_metering_3,
           col = "blue"
     )
)

# Legends for Plot 3
legend("topright", 
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
       col = c("black","red","blue"), 
       lty = rep(1,3),
       bty = "n", # to eliminate the border of the legend box
       cex = .9  # to reduce the size of the font 
)

# Plot 4 - scatterplot with lines
with(plot_data, 
     plot(Total_Time,Global_reactive_power,
          xlab = "datetime",
          type = "l"
     )
)

# Close graphics device
dev.off()