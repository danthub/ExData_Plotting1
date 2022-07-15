library(readr)
library(dplyr)

household_power_consumption <- read_delim("household_power_consumption.txt", delim = ";", escape_double = FALSE, na = "?", trim_ws = TRUE)
household_power_consumption$Date <- as.Date(household_power_consumption$Date, format = "%d/%m/%Y")
household_power_sub <- household_power_consumption %>% filter(between(Date, as.Date('2007-02-01'), as.Date('2007-02-02'))) 
household_power_sub$date_time <- with(household_power_sub, as.POSIXct(paste(Date, Time)))

png(filename = "plot2.png", width = 480, height = 480) 
with(household_power_sub,plot(date_time, Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = ""))
dev.off()
