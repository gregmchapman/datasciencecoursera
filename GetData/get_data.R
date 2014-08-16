# This script downloads and unzips the data for the Getting and Cleaning Data
# course project, setting the stage for run_analysis.R to tidy things up.
# In other words, this script is Getting Data, the other is Cleaning Data.

# extracts data to directory dir, defaults to the working directory because
# the data are already in a folder called "UCI HAR Dataset"
get_that_data <- function(dir=".") {
    fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    message("Downloading...")
    download.file(url=fileUrl, destfile="Dataset.zip")
    message("Extracting...")
    unzip("Dataset.zip", exdir=dir)
    message("Ready to analyze.")
}