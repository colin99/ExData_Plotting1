# read in the complete household_power_consumption.txt file

inputTable <- read.table("household_power_consumption.txt",comment.char="", sep = ";", header=TRUE, stringsAsFactors=FALSE, na.string = "?")

# create a new column that combines Date and Time columns

inputTable$DateTime <- paste(inputTable$Date, inputTable$Time, sep= " ")



inputTable$DateTime <- strptime(inputTable$DateTime, format = "%d/%m/%Y %H:%M:%S")

# create a new data table of data that is on 2007-02-01 and 2007-02-02
# this is used to create the data plots
subsetFrame <- subset(inputTable, as.Date(inputTable$Date, format = "%d/%m/%Y") >= "2007-02-01" & as.Date(inputTable$Date, format = "%d/%m/%Y") <= "2007-02-02")


# The fourth plot is a combination of the first three plus a line chart of Global_reactive_power

png(filename = "plot4.png",
    width = 480, height = 480, units = "px")
par(mfrow = c(2,2))
par(cex.lab=0.75)
par(cex.axis = 0.75)

with(subsetFrame, {
  plot(DateTime, Global_active_power,  type = "l", ylab = "Global Active Power", xlab ="")
  
  plot(DateTime, Voltage, type = "l", ylab = "Voltage", xlab = "datetime")
  
  plot(DateTime, Sub_metering_1, type ="l",ylab = "Energy sub metering", xlab ="")
  points(DateTime, Sub_metering_2, type = "l", col = "red")
  points(DateTime,Sub_metering_3, type = "l", col = "blue")
  
  legend("topright", bty = "n",lty=c(1,1), cex = 0.75, col = c("black","red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  
  plot(DateTime, Global_reactive_power, type = "l", xlab ="datetime")
})
dev.off()