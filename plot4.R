
# Setup Download & Local Paths
downloadURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
downloadFile <- file.path(getwd(), 'household_power_consumption.zip')
localFile <- file.path(getwd(), 'household_power_consumption.txt')

# Check if file needs to be downloaded & unzipped
if (!file.exists(localFile)) {
  download.file(downloadURL, downloadFile, method = "curl")
  unzip(downloadFile)
}

# Read the file, removing missing values
plotData <- read.table(localFile, header=TRUE, sep=";", na.strings="?")

# Extract the subset data by date range
finalData <- plotData[plotData$Date %in% c("1/2/2007","2/2/2007"),]
setTime <- strptime(paste(finalData$Date, finalData$Time, sep=" "),"%d/%m/%Y %H:%M:%S")
finalData <- cbind(setTime, finalData)

# Generate Plot 4
png("plot4.png", width=480, height=480)

labels <- c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
columnlines <- c("black","red","blue")
par(mfrow=c(2,2))
plot(finalData$setTime, finalData$Global_active_power, type="l", col="black", xlab="", ylab="Global Active Power")
plot(finalData$setTime, finalData$Voltage, type="l", col="black", xlab="datetime", ylab="Voltage")
plot(finalData$setTime, finalData$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
  lines(finalData$setTime, finalData$Sub_metering_2, type="l", col="red")
  lines(finalData$setTime, finalData$Sub_metering_3, type="l", col="blue")
  legend("topright", bty="n", legend=labels, lty=1, col=columnlines)
plot(finalData$setTime, finalData$Global_reactive_power, type="l", col="black", xlab="datetime", ylab="Global_reactive_power")

dev.off()