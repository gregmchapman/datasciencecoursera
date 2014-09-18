# Have total emissions from PM2.5 decreased in the United States from 1999 
# to 2008? Using the base plotting system, make a plot showing the total 
# PM2.5 emission from all sources for each of the years 1999, 2002, 2005, 
# and 2008.

source("set_up.R")  # reads in the two data files and replaces 
                    # numeric SCC w/ 'short name' and fips w/ state,county name
                    # (from maps package)

make_plot1 <- function(df = NULL) {
    require(dplyr)
    
    if (is.null(df)) {df <- set_up()}
    
    # %>% is the chaining operator from dplyr; since each dplyr
    #     function returns a data frame, we can pass a data frame
    #     to one function and the subsequent return values from 
    #     one function to the next
    total_emissions <- df %>% group_by(year) %>%
                          tally(Emissions)
    png("plot1.png")
    par(mar = c(5, 4, 4, 5))
    
    with(total_emissions, plot(year, n, 
                               xlim = c(1998, 2009),
                               xlab = "Year", 
                               ylab = "", 
                               main = "United States PM2.5 emissions from all sources",
                               axes = FALSE,
                               type = "n"))
    # credit to SO user Gavin Simpson for this method of coloring plot area
    # (http://stackoverflow.com/q/8741013/3958453)
    lim <- par("usr")
    rect(lim[1], lim[3], lim[2], lim[4], 
         border = "lightskyblue1", 
         col = "lightskyblue1")
    with(total_emissions, lines(year, n, lwd = 2, col = "peru"))
    axis(1, at = c(1999, 2002, 2005, 2008))
    axis(4, col = "peru", col.axis = "peru")
    mtext("Total emissions (tons)", side = 4, col = "peru", line = 2)
    
    par(new = T)
    with(df, boxplot(log10(Emissions) ~ year,
                     boxwex = 0.5,
                     notch = TRUE,
                     varwidth = TRUE,
                     at = c(1999, 2002, 2005, 2008),
                     axes = FALSE,
                     xlab = "",
                     ylab = "log10(Emissions)",
                     main = ""))
    axis(2)
    
    invisible(dev.off())
}