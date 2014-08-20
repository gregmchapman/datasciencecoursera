# Getting and Cleaning Data Course Project

## Running the script
`run_analysis.R` will produce a tidy data set from the [UCI HAR Dataset](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)\[1\]
if you import it using `source("/path/to/run_analysis.R")` and then run `clean_that_data()`.
The script will download and unzip the data into your working directory and writes the tidy data set to the working directory as well. The script returns the data frame with the complete set of observations for the 66 mean/std variables in case you want to capture that for other analyses; if you want to use the reduced 'tidy' data frame, use `read.table()`.

## Notes to the reviewer

## Codebook

## Reference
\[1\] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. 
Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass 
Hardware-Friendly Support Vector Machine. International Workshop of Ambient 
Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
