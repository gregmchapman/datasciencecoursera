# not so much an analysis, as a *tidying up* of the UCI HAR dataset

clean_that_data <- function(dir = "./UCI HAR Dataset") {
    # run_analysis.R does (will do, whatever) the following:
    #    (though not neccesarily in the order given here)
    #    1. Merge the training and the test sets to create one data set.
    ###     DONE, HOORAY!!!
    #    2. Extract only the measurements on the mean and standard deviation
    #       for each measurement. 
    ###     DONE, HOORAY!!!
    #    3. Use descriptive activity names to name the activities in the data set.
    ###     DONE, HOORAY!!!
    #    4. Appropriately label the data set with descriptive variable names.
    ###     DONE, HOORAY!!!
    #    5. Create a second, independent tidy data set with the average of
    #       each variable for each activity and each subject. 
    #       - 6 activites, 30 subjects = 180 rows X 78? columns **expected** dimensions
    
    message("This could take a while, why don't you grab some coffee?")
    
    # first, let's read in all the relevant files
    testSubjects  <- read.table(paste0(dir, "/test/subject_test.txt"))
    trainSubjects <- read.table(paste0(dir, "/train/subject_train.txt"))
    testActivities  <- read.table(paste0(dir, "/test/y_test.txt"))
    trainActivities <- read.table(paste0(dir, "/train/y_train.txt"))
    testData  <- read.table(paste0(dir, "/test/X_test.txt"))
    trainData <- read.table(paste0(dir, "/train/X_train.txt"))
    features <- read.table(paste0(dir, "/features.txt"))
    activityNames <- read.table(paste0(dir, "/activity_labels.txt"))
    
    # phew, that's done, now let's mess with the feature names a bit
    featureNames <- features[, 2]
    featureNames <- gsub("()", "", featureNames, fixed=T) # get rid of empty parens
    # featureNames <- gsub("[(),-]", "\\.", featureNames)     # replace other problem chars with dots
                                                          # this one doesn't seem to be working...
                                                          # but it also doesn't seem to matter...
    
    # next we'll duct-tape the whole mess together
    subjects <- rbind(testSubjects, trainSubjects)
    activities <- rbind(testActivities, trainActivities)
    data <- rbind(testData, trainData)
    enchilada <- cbind(subjects, activities, data) # enchilada, as in "the whole enchilada"
    
    # how 'bout naming those columns?
    colnames(enchilada) <- c("subject", "activity", featureNames)
    
    # let's get those activities named
    enchilada$activity <- factor(enchilada$activity)
    levels(enchilada$activity) <- activityNames$V2
    
    # now let's order by subject/activity (can you tell I'm putting off subsetting?)
    enchilada$subject <- factor(enchilada$subject)
    enchilada <- enchilada[order(c(enchilada$subject, enchilada$activity)),]
    
    # alright, let's get the subsetting over with
    # I'm taking a fairly narrow view of "Extract only the measurements on the mean and standard deviation"
    # I'm only taking means and standard deviations on variables for which both were calculated
    #   so that means I'm ignoring 'meanFreq' and all of the angle() sub-variables
    enchilada <- cbind(subject=enchilada$subject,
                       activity=enchilada$activity,
                       enchilada[, grepl("(mean|std)[^F]", colnames(enchilada), perl=T)])
    
    ### If we've gotten this far w/o errors, let's output the reduced dataset to play with interactively
    enchilada
    
    ### Issues: I have 10000 NA's that I should probably deal with?
    ### That damned grepl() (As it stands, does *not* include end-of-string mean|std)
}
