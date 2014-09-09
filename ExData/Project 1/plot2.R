message("This file contains the function make_plot2() which can also be
invoked by sourcing make_plots.R and calling make_plots(2)")

make_plot2 <- function(df = NULL, dir = "./") {
    
    suppressMessages(source("load_data.R"))
    
    if (is.null(df)) { df <- load_data(dir) }
    
    png(filename = "plot2.png", bg = "transparent")
    plot(df[, 1], df[, 2], type="l", 
         ylab = "Global Active Power (kilowatts)", 
         xlab= "")
    invisible(dev.off())
}
