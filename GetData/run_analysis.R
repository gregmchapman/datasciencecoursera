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
    
    require(reshape2) # we want to melt() and dcast()
    
    # I'm not going to assume you have the data yet
    fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    message("Downloading data...")
    download.file(url=fileUrl, destfile="Dataset.zip")
    message("Extracting data...")
    unzip("Dataset.zip", exdir=".")
    message("Ready to tidy.\n")
    
    
    # first, let's read in all the relevant files
    message("Loading data...")
    dir = "./UCI HAR Dataset"
    testSubjects  <- read.table(paste0(dir, "/test/subject_test.txt"), 
                                colClasses="factor", nrows=2950)
    trainSubjects <- read.table(paste0(dir, "/train/subject_train.txt"),
                                colClasses="factor", nrows=7400)
    testActivities  <- read.table(paste0(dir, "/test/y_test.txt"),
                                  colClasses="factor", nrows=2950)
    trainActivities <- read.table(paste0(dir, "/train/y_train.txt"),
                                  colClasses="factor", nrows=7400)
    testData  <- read.table(paste0(dir, "/test/X_test.txt"),
                            colClasses="numeric", nrows=2950)
    trainData <- read.table(paste0(dir, "/train/X_train.txt"),
                            colClasses="numeric", nrows=7400)
    features <- read.table(paste0(dir, "/features.txt"), nrows=600)
    activityNames <- read.table(paste0(dir, "/activity_labels.txt"))
    
    # phew, that's done, now let's mess with the feature names a bit
    message("Massaging data... (How's that coffee?)")
    featureNames <- features[, 2]
    featureNames <- gsub("()", "_", featureNames, fixed=T) # get rid of empty parens
                                                           # the replacement with underscores
                                                           # is a kludge to get grepl() to work below
    featureNames <- gsub("[(),-]", "", featureNames)       # remove other problem chars
    
    # next we'll duct-tape the whole mess together
    subjects <- rbind(testSubjects, trainSubjects)
    activities <- rbind(testActivities, trainActivities)
    data <- rbind(testData, trainData)
    enchilada <- cbind(subjects, activities, data) # enchilada, as in "the whole enchilada"
    
    # how 'bout naming those columns?
    colnames(enchilada) <- c("subject", "activity", featureNames)
    
    # let's get those activities named
    levels(enchilada$activity) <- activityNames$V2
    
    # alright, let's get the subsetting over with
    # I'm taking a fairly narrow view of "Extract only the measurements on the mean and standard deviation"
    # I'm only taking means and standard deviations on variables for which both were calculated
    #   so that means I'm ignoring 'meanFreq' and all of the angle() sub-variables
    enchilada <- cbind(subject=enchilada$subject,
                       activity=enchilada$activity,
                       enchilada[, grepl("(mean|std)_", colnames(enchilada))])
    
    
    message("Reshaping data...")
    # first make sure subjects are ordered as expected
    enchilada$subject <- ordered(enchilada$subject, c("1", "2", "3", "4", "5",
                                 "6", "7", "8", "9", "10", "11", "12", "13",
                                 "14", "15", "16", "17", "18", "19", "20", 
                                 "21", "22", "23", "24", "25", "26", "27",
                                 "28", "29", "30")) # there's prob. a better way to have done that...
    
    enchiladaMelt <- melt(enchilada, id = c("subject", "activity"), 
                                     measure.vars = colnames(enchilada)[3:68])
    meanCast <- dcast(enchiladaMelt, subject + activity ~ variable, mean)
    meanCast <- meanCast[order(meanCast$subject), ]
    
    message("Writing data...")
    write.table(meanCast, file="tidied_UCI_HAR_data.txt", row.names=F, quote=F)
    message("Finished!")
    meanCast
}
