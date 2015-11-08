## Coursera Course: Exploratory Data Analysis: Course Project 1
## plot4.R


##checking rough estimate of how much memory is required
top.size <- object.size(read.table("./data/household_power_consumption.txt", nrow=1000))
lines <- as.numeric(gsub("[^0-9]", "", system("wc -l ./data/household_power_consumption.txt", intern=T)))
size.estimate <- lines / 1000 * top.size
size.estimate

## loading data
dataFile <- "./data/household_power_consumption.txt"
powerData <- read.table(dataFile, header=TRUE, sep=";", stringsAsFactors=FALSE, na.strings = "?")
powerData$Date <- as.Date(powerData$Date, format="%d/%m/%Y")
powerData <- powerData[(powerData$Date == "2007-02-01" | powerData$Date == "2007-02-02"),]
powerData <- transform(powerData, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")


##plots the 4 charts to a png file
plot4 <- function() {
        ##sets 2 rows and 2 columns for showing the 4 charts
        par(mfrow=c(2,2))
        
        ##plots chart 1
        plot(powerData$timestamp, powerData$Global_active_power, type="l", xlab="", 
             ylab="Global Active Power", cex.axis=0.8, cex.lab=0.75)
        
        ##plots chart 2
        plot(powerData$timestamp, powerData$Voltage, type="l", xlab="datetime", 
             ylab="Voltage", cex.axis=0.8, cex.lab=0.75)
        
        ##plots chart 3
        plot(powerData$timestamp, powerData$Sub_metering_1, type="l", xlab="", 
             ylab="Energy sub metering", cex.axis=0.8, cex.lab=0.75)
        lines(powerData$timestamp, powerData$Sub_metering_2,col="red")
        lines(powerData$timestamp, powerData$Sub_metering_3,col="blue")
        legend("topright", col=c("black","red","blue"), 
               c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), 
               lty=1, lwd=1, cex=0.4, bty="n")
        
        ##plots chart 4
        plot(powerData$timestamp, powerData$Global_reactive_power, type="l", xlab="datetime", 
             ylab="Global_reactive_power", cex.axis=0.8, cex.lab=0.75)
        
        dev.copy(png, file = "plot4.png", width=480, height=480)
        dev.off()
}

plot4()