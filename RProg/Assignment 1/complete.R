complete <- function(directory, id = 1:332) {
        ## 'directory' is a character vector of length 1 indicating
        ## the location of the CSV files

        ## 'id' is an integer vector indicating the monitor ID numbers
        ## to be used
        
        ## Return a data frame of the form:
        ## id nobs
        ## 1  117
        ## 2  1041
        ## ...
        ## where 'id' is the monitor ID number and 'nobs' is the
        ## number of complete cases
        
        files <- list.files(directory, full.names=T)
        
        completeCases <- data.frame(id=numeric(), nobs=numeric())
        for (monitor in id) {
            monitorData <- read.csv(files[monitor])
            nDump <- is.na(monitorData$nitrate)
            sDump <- is.na(monitorData$sulfate)
            completeCases <- rbind(completeCases, data.frame(id=monitor, nobs=length(monitorData[!nDump & !sDump, 1])))
        }
        completeCases
}