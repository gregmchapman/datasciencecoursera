corr <- function(directory, threshold = 0) {
        ## 'directory' is a character vector of length 1 indicating
        ## the location of the CSV files

        ## 'threshold' is a numeric vector of length 1 indicating the
        ## number of completely observed observations (on all
        ## variables) required to compute the correlation between
        ## nitrate and sulfate; the default is 0

        ## Return a numeric vector of correlations
        
        # we're reusing some functionality, so why rewrite?
        source("complete.R")
        files <- list.files(directory, full.names=T)
        completeCases <- complete(directory)
        
        corrVector <- numeric()
        for (monitor in 1:332) {
          if (completeCases[monitor, "nobs"] < threshold) {next}
          monitorData <- read.csv(files[monitor])
          corrVector <- c(corrVector, 
              cor(monitorData$nitrate, monitorData$sulfate, use="pairwise", method="pearson"))
        }
        corrVector
}