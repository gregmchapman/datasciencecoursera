# Across the United States, how have emissions from coal combustion-related 
# sources changed from 1999–2008?
# Heh, heh... choropleth time (prob using maps package, 
#                              just have to figure out coloring)

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
                     
    df <- df %>% group_by(fips, year) %>%
                 filter(SCC %in% coalComb) %>%
                 tally(Emissions) %>%
                 spread(year, n)

    names(df) <- c("fips", "ninetynine", "ohtwo", "ohfive", "oheight")
    df <- df %>% mutate(delta = oheight - ninetynine)
    
    png("plot4.png")
    invisible(dev.off())
}