plot2 <- function() {
       
        ## loading the data
        file <- "household_power_consumption.txt" 
        ## using fread() function as it is 10 times faster than read.table()
        ## in this case
        data <- fread(file, sep = ";", na.strings = "?", 
                      colClasses = c("character", "character", rep("numeric",7)))
        data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
        dates <- as.Date(c("2007-02-01", "2007-02-02"), format = "%Y-%m-%d")
        data <- subset(data, data$Date %in% dates)
        ## saving time in POSIXct format, because data.table doesn't support POSIXlt 
        data$Time <- strftime(paste(data$Date, data$Time), 
                              format = "%Y-%m-%d %H:%M:%S")
        
        ## building the plot
        png("plot2.png", width = 480, height = 480)
        
        plot(as.POSIXlt(data$Time), data$Global_active_power,
             type = "l",
             xlab = "",
             ylab = "Global Active Power (kilowatts)")
        
        dev.off()
}