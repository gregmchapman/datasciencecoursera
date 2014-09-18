# Compare emissions from motor vehicle sources in Baltimore City 
# (fips == "maryland,baltimore city") with emissions from motor vehicle sources in Los Angeles 
# County, California (fips == "california,los angeles"). Which city has seen greater changes 
# over time in motor vehicle emissions?

source("set_up.R")  # reads in the two data files and replaces 
                    # numeric SCC w/ 'short name' and fips w/ state,county name
                    # (from maps package)

make_plot6 <- function(df = NULL) {
    
    if (is.null(df)) {df <- set_up()}
    
    # it's not entirely clear what is meant by "motor vehicle sources"
    # grep'ing "Motor Vehicle" returns mostly solvent sources 
    # (and "Motor Vehicle Fires"), which I don't believe is what was
    # intended; I could have just gone with type == "ON-ROAD", which
    # seems to be very close to what may have been intended, but why not
    # phrase the question that way if that was what was intended?
    # So what I went with was Highway and Off-highway Vehicles of all types
    
    motorVehicle <- grep("[Hh]ighway.*Vehicle", NEI$SCC, value = T)
    
    working_set <- df %>% filter(fips == "maryland,baltimore city" |
                                 fips == "california,los angeles") %>%
                          group_by(year, fips) %>%
                          filter(SCC %in% motorVehicle) %>%
                          tally(Emissions)
    
    png("plot6.png")
    invisible(dev.off())
}