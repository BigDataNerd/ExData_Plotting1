# Usage: run this script "as is" to create Plot 2
# The source data filename is hard-coded below and is assumed to be in the same
# directory as this script.  To run this on other data files that filename must be updated.
#

# Set source data filename here:
filename <- 'exdata_data_household_power_consumption.zip'

# read from zipped input file
alldata <- read.table( unz(filename, "household_power_consumption.txt"), header=T, sep=';',
					stringsAsFactors=F,colClasses=c("character","character",rep("numeric",7)),na.strings=c('?'))

# add new datetime column of type POSIXlt
alldata$datetime <- strptime(paste(alldata$Date,alldata$Time), format="%d/%m/%Y %H:%M:%S")

# select the desired days subset of data...
data <- alldata[alldata$datetime >= as.POSIXlt("2007-02-01") & alldata$datetime < as.POSIXlt("2007-02-03"),]

# make plot2 using png device
png("plot2.png", width=480, height=480, units="px", bg="transparent")
with(data=data[!is.na(data$Global_active_power),], plot(datetime,Global_active_power, main="",
					 ylab='Global Active Power (kilowatts)', type='l',xlab=""))
dev.off()
