## based on an outdated dataset, will tell you which hospital in a state has
## the lowest 30 day mortality for one of the outcomes ["heart attack" | "heart failure" |
## "pneumonia"]
## lexicographic ordering is used to break ties, rather than say upper bound
## or something informative; just living down to the spec... 

best <- function(state, outcome) {

    require(dplyr) # because _fuck_ it makes things easier
    
    ## Read outcome data
    columnClasses <- replicate(46, NULL)
    columnClasses[c(2, 7, 11, 17, 23)] <- "character"
    outcomeData <- read.csv("outcome-of-care-measures.csv", colClasses=columnClasses,
                             na.strings="Not Available")
    colnames(outcomeData) <- c("hospitalName", "state", "heartAttack", 
                               "heartFailure", "pneumonia")
    outcomeData[3:5] <- as.numeric(outcomeData[3:5])
    
    ## Check that state and outcome are valid
    validOutcome <- outcome %in% c("heart attack", "heart failure", "pneumonia")
    validState   <- state %in% outcomeData$state
    if (!validOutcome) { stop("invalid outcome") }
    if (!validState)   { stop("invalid state") }
    
    outcomeCol <- switch(outcome, "heart attack" = "heartAttack",
                                  "heart failure" = "heartFailure", 
                                  "pneumonia" = "pneumonia")
                                  
    
    by_state <- group_by(outcomeData, state)
    minSet <- as.data.frame(filter(by_state, outcomeCol == min(outcomeCol, na.rm=T)))
    winners <- minSet[minSet$state == state, "hospitalName"]
    if (length(winners) == 1) { return(winners) }
    
    
    ## Return hospital name in that state with lowest 30-day death rate
}
