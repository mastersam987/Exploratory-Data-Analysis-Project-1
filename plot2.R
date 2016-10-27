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

#Plot 2 Creation
png("plot2.png", width=480, height=480)
plot(actual_hpc_data$Global_active_power~actual_hpc_data$Datetime, type="l",ylab="Global Active Power (kilowatts)", xlab="")
dev.off()