set_up <- function() {
    
    require(dplyr)
    require(ggplot2)
    
    NEI <- readRDS("summarySCC_PM25.rds")
    SCC <- readRDS("Source_Classification_Code.rds")
    
    list(nei = NEI, scc = SCC)
}