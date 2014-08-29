## based on an outdated dataset, will tell you which hospital in a state has
## the lowest 30 day mortality for one of the outcomes ["heart attack" | "heart failure" |
## "pneumonia"]
## lexicographic ordering is used to break ties, rather than say upper bound
## or something informative; just living down to the spec... 

best <- function(state, outcome) {

    require(dplyr) # because _fuck_ it makes things easier
    
    if (!(outcome %in% c("heart attack", "heart failure", "pneumonia"))) { 
        stop("invalid outcome") }
    
    ## Read (and structure) outcome data
    columnClasses <- replicate(46, NULL)
    outCol <- switch(outcome, "heart attack" = 11, "heart failure" = 17, 
                              "pneumonia" = 23)
    columnClasses[c(2, 7, outCol)] <- "character"
    outcomeData <- read.csv("outcome-of-care-measures.csv", colClasses=columnClasses,
                             na.strings="Not Available")
    colnames(outcomeData) <- c("hospital", "stateID", "outcome")
    outcomeData$outcome <- as.numeric(outcomeData$outcome)
        
    ## Check that state and outcome are valid
    if (!(state %in% outcomeData$stateID)) { stop("invalid state") }
    
    ## Actually solve the problem
    winners <- outcomeData %>% filter(stateID == state) %>%
                               arrange(outcome, hospital) %>%
                               select(hospital)
    
    ## Return hospital name in that state with lowest 30-day death rate
    winners[1, 1]
    }
