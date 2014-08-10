pollutantmean <- function(directory, pollutant, id = 1:332) {
        ## 'directory' is a character vector of length 1 indicating
        ## the location of the CSV files

        ## 'pollutant' is a character vector of length 1 indicating
        ## the name of the pollutant for which we will calculate the
        ## mean; either "sulfate" or "nitrate".

        ## 'id' is an integer vector indicating the monitor ID numbers
        ## to be used

        ## Return the mean of the pollutant across all monitors list
        ## in the 'id' vector (ignoring NA values)
        
        # Thanks to CTA Derek Franks for his tutorial 
        # (https://github.com/derekfranks/practice_assignment) from which I 
        # learned this method of making the files easily indexable
        files <- list.files(directory, full.names=T)
        
        pollutantLevel <- numeric()
        for (monitor in id) {
            monitorData <- read.csv(files[monitor])
            pollutantLevel <- c(pollutantLevel, monitorData[, pollutant])
            rm(monitorData) # don't hold everything in memory, I assume this is done anyways when monitorData is bound to a new file, but better safe than sorry I figure
        }
        polMean <- mean(pollutantLevel, na.rm=T)
        round(polMean, 3) # Match sample output with 3 digit precision
}