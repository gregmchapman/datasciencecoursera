# As all the figures use the same data (give or take some columns) I've 
#   pulled the data loading code out to a separate function. This script 
#   probably will never be run directly, but 'dir', the path to the data,
#   trickles down from calling functions.

message("This file contains the function load_data(), which is invoked
automatically by the plotting scripts. There is no need to source this file directly.")

load_data <- function(dir = ".") {

    require(lubridate) # for parse_date_time2(), a faster, simpler, less 
                       # misbehaving alternative to strptime()

    cols <- rep("character", 9)
    cols[6] <- "NULL" # we never chart this column, so trim it now
    # read in header as data since we'll be skipping it later
    data_names <- read.table(paste0(dir, "household_power_consumption.txt"),
                             nrows=1, sep=";", colClasses="character")
    # skip down to Feb. 1, read in 2 days
    consumption_data <- read.csv2(paste0(dir, "household_power_consumption.txt"), 
                                  colClasses = cols, na.strings = "?", 
                                  nrows=2880, skip=66637, header=F, 
                                  col.names=data_names[1,])
    consumption_data <- within(consumption_data, {
                               Date <- parse_date_time2(
                                        mapply(paste, Date, Time),
                                        "dmYHMS")
                               rm(Time)})
    consumption_data[, 2:7] <- sapply(consumption_data[, 2:7], as.numeric)
    consumption_data
}
