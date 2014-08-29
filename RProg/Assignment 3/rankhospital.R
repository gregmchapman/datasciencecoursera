rankhospital <- function(state, outcome, num = "best") {

    require(dplyr)
    
    validOutcome <- outcome %in% c("heart attack", "heart failure", "pneumonia")
    if (!validOutcome) { stop("invalid outcome") }
    
    ## Read (and structure) outcome data
    columnClasses <- replicate(46, NULL)
    outCol <- switch(outcome, "heart attack" = 11, "heart failure" = 17, 
                              "pneumonia" = 23)
    columnClasses[c(2, 7, outCol)] <- "character"
    outcomeData <- read.csv("outcome-of-care-measures.csv", colClasses=columnClasses,
                             na.strings="Not Available")
    colnames(outcomeData) <- c("hospital", "state", "outcome")
    outcomeData$outcome <- as.numeric(outcomeData$outcome)
    outcomeData <- outcomeData[!is.na(outcomeData$outcome), ]
        
    ## Check that state and outcome are valid
    validState   <- state %in% outcomeData$state
    if (!validState)   { stop("invalid state") }
    
    outcomeData <- outcomeData[outcomeData$state == state, ] # this can probably be dplyr'd too
    outcomeData <- outcomeData %>% arrange(outcome, hospital) %>%
                                   mutate(rank = row_number(outcome))
    
    if (num == "best") { num <- 1 }
    if (num == "worst") { num <- length(outcomeData$rank) }
    # if num is some string other than "best" | "worst" we don't know what to do with it
    if (class(num) == "character") { stop("invalid rank requested") }
    if (num > length(outcomeData$rank)) { return(NA) }
    
    ## Return hospital name in that state with the given rank
    outcomeData[outcomeData$rank == num , "hospital"]
    
}