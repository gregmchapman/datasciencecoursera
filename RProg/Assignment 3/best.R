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
    
    by_state <- group_by(outcomeData, stateID)
    minSet <- switch(outcome, 
                     "heart attack" = filter(by_state, heartAttack == min(heartAttack, na.rm=T)),
                     "heart failure" = filter(by_state, outcomeCol == min(heartFailure, na.rm=T)), 
                     "pneumonia" = filter(by_state, outcomeCol == min(pneumonia, na.rm=T)))
    winners <- minSet[minSet$stateID == state, "hospitalName"]
    
    
    ## Return hospital name in that state with lowest 30-day death rate
    if (length(winners) == 1) { return(winners) }
}
