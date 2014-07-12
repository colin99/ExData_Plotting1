# read in the complete household_power_consumption.txt file

inputTable <- read.table("household_power_consumption.txt",comment.char="", sep = ";", header=TRUE, stringsAsFactors=FALSE, na.string = "?")

# create a new column that combines Date and Time columns

inputTable$DateTime <- paste(inputTable$Date, inputTable$Time, sep= " ")



inputTable$DateTime <- strptime(inputTable$DateTime, format = "%d/%m/%Y %H:%M:%S")

# create a new data table of data that is on 2007-02-01 and 2007-02-02
# this is used to create the data plots
subsetFrame <- subset(inputTable, as.Date(inputTable$Date, format = "%d/%m/%Y") >= "2007-02-01" & as.Date(inputTable$Date, format = "%d/%m/%Y") <= "2007-02-02")

# The third plot is each of the three Sub_metering variables vs date (line chart)

png(filename = "plot3.png",
    width = 480, height = 480, units = "px")
plot(subsetFrame$DateTime, subsetFrame$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
points(subsetFrame$DateTime, subsetFrame$Sub_metering_2, type = "l", col = "red")
points(subsetFrame$DateTime, subsetFrame$Sub_metering_3, type = "l", col = "blue")

legend("topright", lty=c(1,1), col = c("black","red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()

