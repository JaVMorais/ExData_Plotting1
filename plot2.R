# Load 'data.table' package. The function library() already checks whether the package is already 
# loaded
library(data.table)

# Load data from file
total_data <- fread("household_power_consumption.txt", colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"), na.strings = "?")

# Open 'png' graphics device and set background to 'transparent'
png("plot2.png")

par(bg = "transparent")

# Restrict data to the desired time interval and add extra column with complete time & date in 
# POSIXct format
plot_data <- total_data[as.Date(total_data$Date, format = "%d/%m/%Y") >= as.Date("2007-02-01") 
                        & as.Date(total_data$Date, format = "%d/%m/%Y") <= as.Date("2007-02-02"),]

plot_data[,Total_Time:=as.POSIXct(paste(Time,Date), format = "%H:%M:%S %d/%m/%Y")]

# Plot scatterplot with lines
with(plot_data, 
     plot(Total_Time,Global_active_power,
          xlab = "",
          ylab = "Global Active Power (kilowatts)",
          type = "l"
    )
)

# Close graphics device
dev.off()