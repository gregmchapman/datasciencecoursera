# not so much an analysis, as a *tidying up* of the UCI HAR dataset

clean_that_data <- function(dir = "./UCI HAR Dataset") {
    # run_analysis.R does (will do, whatever) the following:
    #    1. Merge the training and the test sets to create one data set.
    #       a. colnames from features.txt -> for X_*, columns for subject and activity name manually
    #       b. merge all relavent files (subject_test, y_test, X_test) of test (cbind)
    #       c. merge all relevant files of train (cbind)
    #       d. merge test and train (rbind)
    #    2. Extract only the measurements on the mean and standard deviation
    #       for each measurement. 
    #       - subset, probably using grepl()
    #    3. Use descriptive activity names to name the activities in the data set.
    #       - I interpret this as turning activities (y_{test|train}) into factors
    #         and naming them per activity_labels.txt
    #    4. Appropriately label the data set with descriptive variable names.
    #       - I feel like this is just the colnames that I assumed were part of step 1?
    #    5. Create a second, independent tidy data set with the average of
    #       each variable for each activity and each subject. 
    #       - 6 activites, 30 subjects = 180 rows X 78? columns **expected** dimensions
}
