best <- function(state, outcome) {
    ## Read outcome data
    outcomeData <- read.csv("outcome-of-care-measures.csv", colClasses="character")
    # trim out most of the gristle (the comparisons and bounds could go to, but I'm curious about them)
    outcomeData <- outcomeData[, c(2, 7, 11:14, 17:20, 23:26)]
    colnames(outcomeData) <- c("hospitalName", "state", "heartAttack30DayMortality", 
                               "heartAttackComparison", "heartAttackLower", "heartAttackUpper", 
                               "heartFailure30DayMortality", "heartFailureComparison", 
                               "heartFailureLower", "heartFailureUpper", "pneumonia30DayMortality", 
                               "pneumoniaComparison", 'pneumoniaLower', "pneumoniaUpper")
    ## Check that state and outcome are valid
    validOutcome <- outcome %in% c("heart attack", "heart failure", "pneumonia")
    validState   <- state %in% outcomeData$state
    if (!validOutcome) { stop("invalid outcome") }
    if (!validState)   { stop("invalid state") }
    
    ## Return hospital name in that state with lowest 30-day death rate
}
