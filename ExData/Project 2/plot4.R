# Across the United States, how have emissions from coal combustion-related 
# sources changed from 1999–2008?
# Too many NA's (and east coast counties too crowded) for choropleth
# Next idea?

source("set_up.R")  # reads in the two data files and replaces 
                    # numeric SCC w/ 'short name' and fips w/ state,county name
                    # (from maps package)

make_plot4 <- function(df = NULL) {
    
    require(tidyr)
    
    if (is.null(df)) {df <- set_up()}
    
    coalComb <- grep("Comb|Coal-fired", 
                     grep("Coal", NEI$SCC, value = T), 
                     value = T)
                     # Just grep'ing "Coal" gets emissions related to mining,
                     # transporting and storing coal, this gets *most* of the
                     # combustion
                     
    df <- df %>% group_by(year) %>%
                 filter(SCC %in% coalComb) %>%
                 tally(Emissions)

    png("plot4.png")
    
    with(df, plot(year, n, 
                  xlim = c(1998, 2009),
                  xlab = "Year", 
                  ylab = "Emissions (tons)", 
                  main = "United States PM2.5 emissions from coal-combustion sources",
                  axes = FALSE,
                  type = "n"))
                  
    lim <- par("usr")
    rect(lim[1], lim[3], lim[2], lim[4], 
         border = "lightskyblue1", 
         col = "lightskyblue1")
    with(df, lines(year, n, lwd = 2))
    axis(1, at = c(1999, 2002, 2005, 2008))
    axis(2)
    
    invisible(dev.off())
}