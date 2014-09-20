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
    
    df <- df %>% group_by(year) %>%
                 filter(SCC %in% motorVehicle & 
                        fips == "maryland,baltimore city") %>%
                 tally(Emissions)
    
    png("plot5.png")
    
    with(df, plot(year, n, 
                  xlim = c(1998, 2009),
                  xlab = "Year", 
                  ylab = "Emissions (tons)", 
                  main = "Baltimore City PM2.5 emissions from motor vehicle sources",
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