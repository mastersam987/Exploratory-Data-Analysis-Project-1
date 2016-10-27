#load the libraries
library(dplyr)

#Loading the dataset
hpcf <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", nrows = 2075259, na.strings = "?",
                   comment.char = "", stringsAsFactors = FALSE)

#Converting the date column to Date Type class
hpcf$Date <- as.Date(hpcf$Date, format = "%d/%m/%Y")

#Subsettign data to save memory space and use the required data to perform plotting
actual_hpc_data <- subset(hpcf, subset = (Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(hpcf)        #removing the actual data to free up memory space

#Creating new Datetime column as Date and POSIXct class
datetime <- paste(as.Date(actual_hpc_data$Date), actual_hpc_data$Time)
actual_hpc_data$Datetime <- as.POSIXct(datetime)

#Plot 4 Creation
png("plot4.png", width=480, height=480)
par(mfrow = c(2,2), mar = c(4,4,2,1))
plot(actual_hpc_data$Global_active_power~actual_hpc_data$Datetime, type="l",ylab="Global Active Power", xlab="")
plot(actual_hpc_data$Voltage~actual_hpc_data$Datetime, type="l",ylab="Voltage", xlab="datetime")
with(actual_hpc_data, {plot(Sub_metering_1~Datetime, type = "l", ylab = "Energy Sub Metering",xlab="")
  lines(Sub_metering_2~Datetime, col = "red")
  lines(Sub_metering_3~Datetime, col = "blue")})
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), lty = 1,bty = "n")
plot(actual_hpc_data$Global_reactive_power~actual_hpc_data$Datetime, type="l",ylab="Global_reactive_power", xlab="datetime")
dev.off()