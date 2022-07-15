library(readr)
library(dplyr)

household_power_consumption <- read_delim("household_power_consumption.txt", delim = ";", escape_double = FALSE, na = "?", trim_ws = TRUE)
household_power_consumption$Date <- as.Date(household_power_consumption$Date, format = "%d/%m/%Y")
household_power_sub <- household_power_consumption %>% filter(between(Date, as.Date('2007-02-01'), as.Date('2007-02-02'))) 
household_power_sub$date_time <- with(household_power_sub, as.POSIXct(paste(Date, Time)))

png(filename = "plot4.png", width = 480, height = 480)
par(mfcol = c(2,2))
with(household_power_sub,plot(date_time, Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = ""))

with(household_power_sub,plot(date_time, Sub_metering_1, type = "l", col = 1, ylab = "Energy sub metering", xlab = ""))
with(household_power_sub,lines(date_time, Sub_metering_2, col = 2))
with(household_power_sub,lines(date_time, Sub_metering_3, col = 4))
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1,1,1), col = c(1, 2, 4))

with(household_power_sub,plot(date_time, Voltage, type = "l", ylab = "Voltage", xlab = "datetime"))

with(household_power_sub,plot(date_time, Global_reactive_power, type = "l", ylab = "Global_reactive_power", xlab = "datetime"))

dev.off()
