# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
# (fips == "24510") from 1999 to 2008? Use the base plotting system to make 
# a plot answering this question.

make_plot2 <- function(df = NULL) {
    require(dplyr)
    
    if (is.null(df)) {df <- readRDS("summarySCC_PM25.rds")}
    
    # %>% is the chaining operator from dplyr; since each dplyr
    #     function returns a data frame, we can pass a data frame
    #     to one function and the subsequent return values from 
    #     one function to the next
    by_year <- df %>% group_by(year) %>%
                      filter(fips == "24510") %>%
                      tally(Emissions)
    png("plot2.png")
    with(by_year, plot(year, n, 
                       xlim = c(1998, 2008),
                       xlab = "Year", 
                       ylab = "Emissions (tons)", 
                       main = "Baltimore City PM2.5 emissions from all sources",
                       axes = FALSE,
                       type = "n"))
    lim <- par("usr")
    rect(lim[1], lim[3]-1, lim[2], lim[4]+1, 
         border = "lightskyblue", 
         col = "lightskyblue")
    axis(1, at = c(1999, 2002, 2005, 2008))
    axis(2)
    with(by_year, lines(year, n, lwd = 3))
    invisible(dev.off())
}