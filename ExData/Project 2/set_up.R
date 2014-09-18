require(plyr)
require(dplyr)
require(ggplot2)
require(maps)
    
set_up <- function() {
    
    message("Loading data: NEI")
    NEI <- readRDS("summarySCC_PM25.rds")
    message("Loading data: SCC")
    scc <- readRDS("Source_Classification_Code.rds")
    message("Loading data: County FIPS")
    data("county.fips", package = "maps", envir = environment())
    
    scc <- scc %>% select(SCC, Short.Name)
    NEI <- within(NEI, {
                  fips <- as.numeric(fips)
                  message("Translating SCC")
                  SCC <- mapvalues(SCC, 
                                   from = as.character(scc$SCC), 
                                   to = as.character(scc$Short.Name),
                                   warn_missing = F)
                  message("Translating FIPS")
                  fips <- mapvalues(fips, 
                                    from = county.fips$fips, 
                                    to = as.character(county.fips$polyname),
                                    warn_missing = F)
                  })
    
    NEI
}