rankhospital <- function(state, outcome, num = "best") {

    require(dplyr)
    
    if (!(outcome %in% c("heart attack", "heart failure", "pneumonia"))) { 
        stop("invalid outcome") }
    
    ## Read (and structure) outcome data
    # we only want 3 columns, so we'll choose which outcome column to keep and chuck the rest
    columnClasses <- replicate(46, NULL)
    outCol <- switch(outcome, "heart attack" = 11, "heart failure" = 17, 
                              "pneumonia" = 23)
    columnClasses[c(2, 7, outCol)] <- "character"   # outcome won't read in as numeric, we'll convert later
    outcomeData <- read.csv("outcome-of-care-measures.csv", colClasses=columnClasses,
                             na.strings="Not Available")
    colnames(outcomeData) <- c("hospital", "stateID", "outcome")
    outcomeData$outcome <- as.numeric(outcomeData$outcome)
    
    ## Check that state and outcome are valid (outcome already checked, but data
    #  needed to be loaded in for state check)
    if (!(state %in% outcomeData$stateID))   { stop("invalid state") }
    
    outcomeData <- outcomeData %>% filter(!is.na(outcome), stateID == state) %>%
                                   arrange(outcome, hospital) %>%
                                   mutate(rank = row_number(outcome))
    
    # I feel like this could be done more elegantly
    if (num == "best") { num <- 1 }
    if (num == "worst") { num <- length(outcomeData$rank) }
    # if num is some string other than "best" | "worst" we don't know what to do with it
    if (class(num) == "character") { stop("invalid rank requested") }
    if (num > length(outcomeData$rank)) { return(NA) }
    
    ## Return hospital name in that state with the given rank
    outcomeData[outcomeData$rank == num, "hospital"]
    
}