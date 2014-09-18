# Of the four types of sources indicated by the type (point, nonpoint, 
# onroad, nonroad) variable, which of these four sources have seen decreases 
# in emissions from 1999–2008 for Baltimore City (fips == "maryland,baltimore city")? Which 
# have seen increases in emissions from 1999–2008? Use the **ggplot2 plotting 
# system to make a plot answer this question.

source("set_up.R")  # reads in the two data files and replaces 
                    # numeric SCC w/ 'short name' and fips w/ state,county name
                    # (from maps package)

make_plot3 <- function(df = NULL) {
    
    if (is.null(df)) {df <- set_up()}
    
    working_set <- df %>% group_by(year, type) %>%
                      filter(fips == "maryland,baltimore city") %>% 
                      tally(Emissions)
    rm(df)
    png("plot3.png")
    
    plot3 <- ggplot(working_set, aes(year, n)) + 
                geom_line(aes(col = type)) +
                scale_x_continuous(breaks = c(1999, 2002, 2005, 2008)) +
                labs(x = "Year", y = "PM2.5 emissions (tons)") +
                scale_color_discrete(name = "Type") +
                ggtitle("Baltimore City PM2.5 Emissions")
    print(plot3)
    invisible(dev.off())
}