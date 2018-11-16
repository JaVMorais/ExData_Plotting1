# Load 'data.table' package. The function library() already checks whether the package is already 
# loaded
library(data.table)

# Load data from file
total_data <- fread("household_power_consumption.txt", colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"), na.strings = "?")

# Open 'png' graphics device and set background to 'transparent'
png("plot3.png")

par(bg = "transparent")

# Restrict data to the desired time interval and add extra column with complete time & date in 
# POSIXct format
plot_data <- total_data[as.Date(total_data$Date, format = "%d/%m/%Y") >= as.Date("2007-02-01") 
                        & as.Date(total_data$Date, format = "%d/%m/%Y") <= as.Date("2007-02-02"),]

plot_data[,Total_Time:=as.POSIXct(paste(Time,Date), format = "%H:%M:%S %d/%m/%Y")]

# Plot scatterplot with lines
with(plot_data, 
     plot(Total_Time,Sub_metering_1,
          col = "black",
          type = "l",
          xlab = "",
          ylab = "Energy sub metering"
          
     )
)
# Add decond line
with(plot_data,
     lines(Total_Time,Sub_metering_2,
           col = "red"
     )
)
# Add third line
with(plot_data,
     lines(Total_Time,Sub_metering_3,
           col = "blue"
     )
)

# Add legend to plot on the topright corner
legend("topright", 
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
       col = c("black","red","blue"), 
       lty = rep(1,3)
)

# Close graphics device
dev.off()