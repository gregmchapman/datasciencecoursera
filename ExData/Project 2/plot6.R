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
    
    df <- df %>% filter(fips == "maryland,baltimore city" |
                                 fips == "california,los angeles") %>%
                          group_by(year, fips) %>%
                          filter(SCC %in% motorVehicle) %>%
                          tally(Emissions)
    
    png("plot6.png")
    
    with(df, plot(year, n, 
                  xlim = c(1998, 2009),
                  xlab = "Year", 
                  ylab = "Emissions (tons)", 
                  main = "PM2.5 emissions from motor vehicle sources",
                  axes = FALSE,
                  type = "n"))
                  
    lim <- par("usr")
    rect(lim[1], lim[3], lim[2], lim[4], 
         border = "lightskyblue1", 
         col = "lightskyblue1")
    par(new = T)
    with(df[df$fips == "maryland,baltimore city", ], 
         lines(year, n, lwd = 2, col = "red"))
    with(df[df$fips == "california,los angeles", ], 
         lines(year, n, lwd = 2, col = "green"))
    legend("topright", 
           legend = c("Baltimore City, MD", "Los Angeles, CA"),
           col = c("red", "green"),
           lwd = 1,
           bty = "n")
    axis(1, at = c(1999, 2002, 2005, 2008))
    axis(2)
    
    invisible(dev.off())
}