# Getting and Cleaning Data Course Project

`run_analysis.R` will produce a tidy data set from the [UCI HAR Dataset](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)\[1\] (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
if you import it using `source()` and then run `clean_that_data()`.
The script assumes the data live in "./UCI HAR Dataset", but `clean_that_data()` takes an
optional argument `dir` giving the directory to the dataset on your machine.  If
the dataset does not live on your machine, you can import `get_data.R` using `source()`
and run `get_that_data()`, again with an optional `dir` argument, but the default will
set you up nicely to run the analysis without having to retype the directory.


\[1\] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. 
Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass 
Hardware-Friendly Support Vector Machine. International Workshop of Ambient 
Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
