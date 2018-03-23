filename <- "getdata_dataset.zip"

## Download and unzip the dataset:
if (!file.exists(filename)){
        fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(fileURL, filename)
}  
if (!file.exists("household_power_consumption.txt")) { 
        unzip(filename) 
}        

energy <- read.table("household_power_consumption.txt", header = TRUE, na.strings = "?", sep = ";", stringsAsFactors = FALSE)
energy <- subset(energy, Date %in% c("1/2/2007", "2/2/2007"))
energy$Date <- as.Date(energy$Date, "%d/%m/%Y")
energy$DateTime <- as.POSIXct(paste(energy$Date, energy$Time), format="%Y-%m-%d %H:%M:%S")
energy <- energy[, c(10,3,4,5,6,7,8,9)]
rownames(energy) <- NULL

# Plot 4
par(mfrow = c(2,2))
#1
with(energy, plot(DateTime, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power"))
#2
with(energy, plot(DateTime, Voltage, type = "l"))
#3
plot(energy$DateTime, energy$Sub_metering_1, type = "n", xlab = "", ylab = "Energy Sub metering")
points(energy$DateTime, energy$Sub_metering_1, type = "l", col = "black")
points(energy$DateTime, energy$Sub_metering_2, type = "l", col = "red")
points(energy$DateTime, energy$Sub_metering_3, type = "l", col = "blue")
legend("topright", bty = "n", cex = 0.9, lty = c(1,1,1), col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
#4
with(energy, plot(DateTime, Global_reactive_power, type = "l"))
dev.copy(png, file = "plot4.png", width=480, height=480) ## Copy my plot to a PNG file
dev.off() ## Don't forget to close the PNG device!
