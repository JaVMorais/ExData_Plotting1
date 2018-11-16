# Load 'data.table' package. The function library() already checks whether the package is already 
# loaded
library(data.table)

# Load data from file
total_data <- fread("household_power_consumption.txt", 
                    colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"), 
                    na.strings = "?"
                )

# Open 'png' graphics device and set background to 'transparent'
png("plot1.png")

par(bg = "transparent")

# Restrict data to the desired time interval
plot_data <- total_data[as.Date(total_data$Date, format = "%d/%m/%Y") >= as.Date("2007-02-01") 
                        & as.Date(total_data$Date, format = "%d/%m/%Y") <= as.Date("2007-02-02"),]

# Plot histogram
with(plot_data, 
     hist(Global_active_power, 
          col="red", 
          xlab = "Global Active Power (kilowatts)", 
          main = "Global Active Power"
    )
)

# Close graphics device
dev.off()