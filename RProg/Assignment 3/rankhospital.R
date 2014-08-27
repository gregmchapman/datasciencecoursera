rankhospital <- function(state, outcome, num = "best") {

    ## Read (and structure) outcome data
    columnClasses <- replicate(46, NULL)
    columnClasses[c(2, 7, 11, 17, 23)] <- "character"
    outcomeData <- read.csv("outcome-of-care-measures.csv", colClasses=columnClasses,
                             na.strings="Not Available")
    colnames(outcomeData) <- c("hospitalName", "stateID", "heartAttack", 
                               "heartFailure", "pneumonia")
    outcomeData$heartAttack <- as.numeric(outcomeData$heartAttack)
    outcomeData$heartFailure <- as.numeric(outcomeData$heartFailure)
    outcomeData$pneumonia <- as.numeric(outcomeData$pneumonia)
        
    ## Check that state and outcome are valid
    validOutcome <- outcome %in% c("heart attack", "heart failure", "pneumonia")
    validState   <- state %in% outcomeData$stateID
    if (!validOutcome) { stop("invalid outcome") }
    if (!validState)   { stop("invalid state") }
    
    outcomeData <- outcomeData[outcomeData$stateID == state, ]
    outcomeData <- switch(outcome, 
                          "heart attack" = outcomeData[with(outcomeData, order(outcomeData$heartAttack, outcomeData$hospitalName, na.last=NA)), ],
                          "heart failure" = outcomeData[with(outcomeData, order(outcomeData$heartFailure, outcomeData$hospitalName, na.last=NA)), ],
                          "pneumonia" = outcomeData[with(outcomeData, order(outcomeData$pneumonia, outcomeData$hospitalName, na.last=NA)), ])
    outcomeData$rank <- seq_along(outcomeData$hospitalName)
    
    if (num == "best") { num <- 1 }
    if (num == "worst") { num <- length(outcomeData$rank) }
    # if num is some string other than "best" | "worst" we don't know what to do with it
    if (class(num) == "character") { stop("invalid rank requested") }
    if (num > length(outcomeData$rank)) { return(NA) }
    
    ## Return hospital name in that state with the given rank
    outcomeData[outcomeData$rank == num , "hospitalName"]
    
}