message("This file contains the function make_plot4() which can also be
invoked by sourcing make_plots.R and calling make_plots(4)")

make_plot4 <- function(df = NULL, dir = ".") {
    
    suppressMessages(source("load_data.R"))
    
    if (is.null(df)) { df <- load_data(dir) }
    
    png(filename = "plot4.png", bg = "transparent")
    par(mfrow = c(2, 2))
    
    # top left
    plot(df[, 1], df[, 2], type="l", 
         ylab = "Global Active Power", 
         xlab= "")
    
    # top right
    plot(df[, 1], df[, 4], type="l", 
         ylab = "Voltage", 
         xlab= "datetime")
         
    # bottom left
    plot(df[, 1], df[, 5], type="n", 
         ylab = "Energy sub metering", 
         xlab= "")
    lines(df[, 1], df[, 5])
    lines(df[, 1], df[, 6], col = "red")
    lines(df[, 1], df[, 7], col = "blue")
    legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
           lwd = 1, col = c("black", "red", "blue"), bty = "n")
    
    # bottom right
    plot(df[, 1], df[, 3], type="l", 
         ylab = "Global_reactive_power", 
         xlab= "datetime")
    invisible(dev.off())
}