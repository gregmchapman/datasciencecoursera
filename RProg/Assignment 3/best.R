## based on an outdated dataset, will tell you which hospital in a state has
## the lowest 30 day mortality for one of the outcomes ["heart attack" | "heart failure" |
## "pneumonia"]
## lexicographic ordering is used to break ties, rather than say upper bound
## or something informative; just living down to the spec... 

## frankly, now that I've been playing with these scripts a bit, I see that
## best() is equivalent to rankhospital() w/ default value of num

best <- function(state, outcome) {

    require(dplyr)
    source("load_data.R")
    
    outcomeData <- load_data(outcome)
    colnames(outcomeData) <- c("hospital", "stateID", "outcome")
        
    ## Check that state is valid
    if (!(state %in% outcomeData$stateID)) { stop("invalid state") }
    
    ## Actually solve the problem
    winners <- outcomeData %>% filter(stateID == state) %>%
                               arrange(outcome, hospital) %>%
                               select(hospital)
    
    ## Return hospital name in that state with lowest 30-day death rate
    winners[1, 1]
    }
