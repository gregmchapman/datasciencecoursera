# How have emissions from motor vehicle sources changed from 1999–2008 in 
# Baltimore City (fips == "maryland,baltimore city")?

source("set_up.R")  # reads in the two data files and replaces 
                    # numeric SCC w/ 'short name' and fips w/ state,county name
                    # (from maps package)

make_plot5 <- function(df = NULL) {
    
    if (is.null(df)) {df <- set_up()}
    
    # it's not entirely clear what is meant by "motor vehicle sources"
    # grep'ing "Motor Vehicle" returns mostly solvent sources 
    # (and "Motor Vehicle Fires"), which I don't believe is what was
    # intended; I could have just gone with type == "ON-ROAD", which
    # seems to be very close to what may have been intended, but why not
    # phrase the question that way if that was what was intended?
    # So what I went with was Highway and Off-highway Vehicles of all types
    
    motorVehicle <- grep("[Hh]ighway.*Vehicle", NEI$SCC, value = T)
    
    working_set <- df %>% group_by(year) %>%
                          filter(SCC %in% motorVehicle & 
                                 fips == "maryland,baltimore city") %>%
                          tally(Emissions)
    
    png("plot5.png")
    invisible(dev.off())
}