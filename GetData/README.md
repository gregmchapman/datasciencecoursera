# Getting and Cleaning Data Course Project

## Running the script
`run_analysis.R` will produce a tidy data set from the UCI HAR Dataset\[1\]
if you import it using `source("/path/to/run_analysis.R")` and then run `clean_that_data()`.
The script will download and unzip the data into your working directory and writes the tidy data set to the working directory as well. The script returns the data frame with the complete set of observations for the 66 mean/std variables in case you want to capture that for other analyses 
    
    semiTidy <- clean_that_data()

if you want to use the reduced 'tidy' data frame, just read it in: 

    tidyData <- read.table("tidied_UCI_HAR_data.txt", header=TRUE)

## Notes to the reviewer
There is some discussion on the forums about the ambiguity in the meaning of the instruction "Extracts only the measurements on the mean and standard deviation for each measurement."  I interpreted this to include only those measures which had values for both mean and standard deviation, and for each of those measures I extracted both the mean and standard deviation. There are several other measures which include the word 'mean' which I opted to exclude. I think without a better understanding of the subject domain or a sense of what the data might be used for downstream of this 'tidying' that my interpretation of the instruction is valid.

There is also quite a bit of discussion over the interpretation of "Appropriately labels the data set with descriptive variable names."  I opted to deviate as little as possible from the feature names given in features.txt, as the code book gives descriptions of what those names mean, and for someone familiar with the dataset the names will be close to their expectations.

The code book is a bit sparse, I acknowledge. I was unable to determine what the units of the values in the data set were meant to be (I was also a bit unclear how they obtained negative standard deviation values). I was also unsure of the purpose of the column width information in the code book; I could understand if it were a fixed width format file and that information were necessary to read the file, I opted to leave it out as uninformative in this case.

## Reference
\[1\] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. 
Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass 
Hardware-Friendly Support Vector Machine. International Workshop of Ambient 
Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
