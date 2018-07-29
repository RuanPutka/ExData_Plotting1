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

## Plot 3
with(df, plot(DateTime, Sub_metering_1, type='l', col='black',
              xlab="", ylab="Energy sub metering") + 
             lines(DateTime, Sub_metering_2, col='red') + 
             lines(DateTime, Sub_metering_3, col='blue'))
legend("topright", lty=1, col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()
