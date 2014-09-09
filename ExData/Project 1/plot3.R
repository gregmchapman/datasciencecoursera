message("This file contains the function make_plot3() which can also be
invoked by sourcing make_plots.R and calling make_plots(3)")

make_plot3 <- function(df = NULL, dir = "./") {

    suppressMessages(source("load_data.R"))

    if (is.null(df)) { df <- load_data(dir) }
    
    png(filename = "plot3.png", bg = "transparent")
    plot(df[, 1], df[, 5], type="n", 
         ylab = "Energy sub metering", 
         xlab= "")
    lines(df[, 1], df[, 5])
    lines(df[, 1], df[, 6], col = "red")
    lines(df[, 1], df[, 7], col = "blue")
    legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
           lwd = 1, col = c("black", "red", "blue"))
    invisible(dev.off())
}
