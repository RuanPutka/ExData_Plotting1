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

## Plot 1
hist(df$Global_active_power, main="Global Active Power",
     xlab="Global Active Power [kW]", col='seagreen3')
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()

