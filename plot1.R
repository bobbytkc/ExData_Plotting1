
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

##opens PNG graphics device
png(file = "plot1.png")

##Plots histogram
par(mar=c(4.1,5.1,1.1,1.1))
hist(data$Global_active_power, main = "Gobal Active Power", 
     col = "Red", xlab = "Global Active Power (kilowatts)")

##Closes graphics device
dev.off()