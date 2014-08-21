# Getting and Cleaning Data Course Project

## Running the script
`run_analysis.R` will produce a tidy data set from the [UCI HAR Dataset](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)\[1\]
if you import it using `source("/path/to/run_analysis.R")` and then run `clean_that_data()`.
The script will download and unzip the data into your working directory and writes the tidy data set to the working directory as well. The script returns the data frame with the complete set of observations for the 66 mean/std variables in case you want to capture that for other analyses 
    
    semiTidy <- clean_that_data()

if you want to use the reduced 'tidy' data frame, just read it in: 

    tidyData <- read.table("tidied_UCI_HAR_data.txt", header=TRUE)

## Notes to the reviewer
There is some discussion on the forums about the ambiguity in the meaning of the instruction "Extracts only the measurements on the mean and standard deviation for each measurement."  I interpreted this to include only those measures which had values for both mean and standard deviation, and for each of those measures I extracted both the mean and standard deviation. There are several other measures which include the word 'mean' which I opted to exclude. I think without a better understanding of the subject domain or a sense of what the data might be used for downstream of this 'tidying' that my interpretation of the instruction is valid.

There is also quite a bit of discussion over the interpretation of "Appropriately labels the data set with descriptive variable names."  I opted to deviate as little as possible from the feature names given in features.txt, as the code book gives descriptions of what those names mean, and for someone familiar with the dataset the names will be close to their expectations.

## Reference
\[1\] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. 
Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass 
Hardware-Friendly Support Vector Machine. International Workshop of Ambient 
Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
