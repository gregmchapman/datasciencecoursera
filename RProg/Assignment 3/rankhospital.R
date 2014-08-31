rankhospital <- function(state, outcome, num = "best") {

    require(dplyr)
    source("load_data.R")
    
    outcomeData <- load_data(outcome)
    colnames(outcomeData) <- c("hospital", "stateID", "outcome")
    
    ## Check that state and outcome are valid (outcome already checked, but data
    #  needed to be loaded in for state check)
    if (!(state %in% outcomeData$stateID))   { stop("invalid state") }
    
    outcomeData <- outcomeData %>% filter(stateID == state) %>%
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