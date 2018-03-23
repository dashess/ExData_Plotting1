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

# Plot 3
par(mfrow = c(1,1))
plot(energy$DateTime, energy$Sub_metering_1, type = "n", xlab = "", ylab = "Energy Sub metering")
lines(energy$DateTime, energy$Sub_metering_1, type = "l", col = "black")
lines(energy$DateTime, energy$Sub_metering_2, type = "l", col = "red")
lines(energy$DateTime, energy$Sub_metering_3, type = "l", col = "blue")
legend("topright", lty = c(1,1,1),col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.copy(png, file = "plot3.png", width=480, height=480) ## Copy my plot to a PNG file
dev.off() ## Don't forget to close the PNG device!