# This is just a handy way of making all the plots at once, only 
#    performing the relatively expensive data loading once, saving
#    some typing at the console, etc.

make_plots <- function(nums = 1:4, dir = ".") {

    suppressMessages({
        source("load_data.R")
        source("plot1.R")
        source("plot2.R")
        source("plot3.R")
        source("plot4.R")})
    
    makeFuncs <- c(make_plot1, make_plot2, make_plot3, make_plot4, 
                   function(...) message("Not producing any figures.")) 
                   # this last function is for testing purposes
    toMake <- makeFuncs[nums]
    
    consumption_data <- load_data(dir)
    
    invisible(sapply(toMake, do.call, consumption_data))
    # do.call() wants to spit out a list of return values, which in this case
    #   is all NULLs, so it just spams the console (I could have captured
    #   the list of NULLs, but why?)
}
