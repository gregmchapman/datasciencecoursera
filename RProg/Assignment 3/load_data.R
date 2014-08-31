load_data <- function(outcome) {

    ## Check that outcome is valid
    if (!(outcome %in% c("heart attack", "heart failure", "pneumonia"))) { 
        stop("invalid outcome") }
    
    ## Read (and structure) outcome data
    columnClasses <- replicate(46, NULL)
    outCol <- switch(outcome, "heart attack" = 11, "heart failure" = 17, 
                              "pneumonia" = 23)
    columnClasses[c(2, 7, outCol)] <- "character"
    outcomeData <- read.csv("outcome-of-care-measures.csv", colClasses=columnClasses,
                             na.strings="Not Available")
    colnames(outcomeData) <- c("hospital", "state", "outcome")
    outcomeData$outcome <- as.numeric(outcomeData$outcome)
    
    outcomeData %>% filter(!is.na(outcome))
}