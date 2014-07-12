# read in the complete household_power_consumption.txt file

inputTable <- read.table("household_power_consumption.txt",comment.char="", sep = ";", header=TRUE, stringsAsFactors=FALSE, na.string = "?")

# create a new column that combines Date and Time columns

inputTable$DateTime <- paste(inputTable$Date, inputTable$Time, sep= " ")



inputTable$DateTime <- strptime(inputTable$DateTime, format = "%d/%m/%Y %H:%M:%S")

# create a new data table of data that is on 2007-02-01 and 2007-02-02
# this is used to create the data plots
subsetFrame <- subset(inputTable, as.Date(inputTable$Date, format = "%d/%m/%Y") >= "2007-02-01" & as.Date(inputTable$Date, format = "%d/%m/%Y") <= "2007-02-02")


# The first plot is of Global_active_power vs date (histogram)

png(filename = "plot1.png",
    width = 480, height = 480, units = "px")
hist(subsetFrame$Global_active_power, col="red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()

