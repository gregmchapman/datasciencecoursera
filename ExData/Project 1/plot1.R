message("This file contains the function make_plot1() which can also be
invoked by sourcing make_plots.R and calling make_plots(1)")

make_plot1 <- function(df = NULL, dir = ".") {
    
    suppressMessages(source("load_data.R"))
    
    if (is.null(df)) { df <- load_data(dir) }
    
    png(filename = "plot1.png", bg = "transparent")
    hist(df[, 2], col = "red", 
         main = "Global Active Power", 
         xlab = "Global Active Power (kilowatts)")
    invisible(dev.off())
}
