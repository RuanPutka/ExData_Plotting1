library(dplyr)
library(sqldf)

## Reading the dataset
## File must be in the working directory
file <- "household_power_consumption.txt"
df <- read.csv.sql(
        file=file,
        header = TRUE,
        sep=";",
        stringsAsFactors = FALSE,
        sql="SELECT * FROM file WHERE Date='1/2/2007' OR Date='2/2/2007'")

df$DateTime <- strptime(paste(df$Date, df$Time), "%d/%m/%Y %H:%M:%S")
df$Date <- as.Date(df$Date, "%d/%m/%Y")

## Plot 4
par(mfcol=c(2,2))

# plot top right
plot(df$DateTime, df$Global_active_power, type="l", ylab="Global Active Power (kilowatts)",xlab=NA)

# plot bottom right
plot(df$DateTime, df$Sub_metering_1,type="l",ylab="Energy sub metering",xlab=NA,col="black")
lines(df$DateTime, df$Sub_metering_2, col="red")
lines(df$DateTime, df$Sub_metering_3, col="blue")
legend("topright", lty=1, bty="n", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# plot top left
plot(df$DateTime, df$Voltage, type="l", xlab="datetime", ylab="Voltage")

# plot bottom left
plot (df$DateTime, df$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()

