
##Downloads the dataset, uzips file
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, "./household_power_consumption.zip")
unzip("./household_power_consumption.zip")

##reads data from .txt file
path<-"./household_power_consumption.txt"
data<-read.table(path,header= TRUE, sep = ";")

##converts date and time columns to date-time classes: Date and POSIXct  
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
data$Time <- paste(as.character(data$Date), data$Time)
data$Time <- strptime(data$Time,format= "%Y-%m-%d %H:%M:%S")

##Subsets 2 day's worth of data
y<-(data$Date == as.Date("01/02/2007",format = "%d/%m/%Y")
    |data$Date == as.Date("02/02/2007",format = "%d/%m/%Y"))
data<- data[y,]

##converts column to numerics for plotting
suppressWarnings(data$Global_active_power <- 
                   as.numeric(as.vector(data$Global_active_power )))
suppressWarnings(data$Sub_metering_1 <- 
                   as.numeric(as.vector(data$Sub_metering_1 )))
suppressWarnings(data$Sub_metering_2 <- 
                   as.numeric(as.vector(data$Sub_metering_2 )))
suppressWarnings(data$Sub_metering_3 <- 
                   as.numeric(as.vector(data$Sub_metering_3 )))
suppressWarnings(data$Global_reactive_power <- 
                   as.numeric(as.vector(data$Global_reactive_power )))
suppressWarnings(data$Voltage <- 
                   as.numeric(as.vector(data$Voltage )))

##opens PNG graphics device
png(file="plot4.png")

##sets up room for 4 plots
par(mfrow=c(2,2))

##adds 4 plots
plot(data$Time, data$Global_active_power, type = "l", 
     xlab = "", ylab = "Global Active Power (kilowatts)")

plot(data$Time, data$Voltage, type = "l", xlab = "datetime",ylab = "Voltage")

plot(data$Time, data$Sub_metering_1, type = "l", xlab = "",ylab = "Energy sub metering")
lines(data$Time, data$Sub_metering_2, col="Red")
lines(data$Time, data$Sub_metering_3, col="Blue")
legend("topright", legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), 
       col = c(par("col"),"Red", "Blue"), lty = 1, bty = "n")

plot(data$Time, data$Global_reactive_power, type = "l", 
     xlab = "datetime",ylab = "Global_reactive_power")

##closes graphics device
dev.off()