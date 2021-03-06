## Coursera Course: Exploratory Data Analysis: Course Project 1
## plot3.R


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

##plots the chart to a png file
plot3 <- function() {
        par(mfrow=c(1,1))
        plot(powerData$timestamp,powerData$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
        lines(powerData$timestamp,powerData$Sub_metering_2,col="red")
        lines(powerData$timestamp,powerData$Sub_metering_3,col="blue")
        legend("topright", col=c("black","red","blue"), 
               c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), 
               lty=1, lwd=1, cex=0.8)
        
        dev.copy(png, file = "plot3.png", width=480, height=480)
        dev.off()
}

plot3()