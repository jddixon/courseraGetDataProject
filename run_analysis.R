# run_analysis.R

# This program cleans up the data from the University of Genoa 
# "Human Activity Recognition Using Smartphones" project, selects
# features of interest, and creates two tidy data sets.  The first
# includes all of the features from the original project representing
# means and standard deviations; the second summarizes the first, 
# organizing the data by activity (STANDING, WALKING, etc) and 
# subject ID, and then taking averages of the mean and standard
# deviation ('std') features.

# ===================================================================
# UTILITY FUNCTIONS
# ===================================================================

# The features vector has at least three sets of duplicated names.
# This function modifies the list of names to suffix the three sets of
# names with 'A', 'B', and 'C' respectively.  A kludge, but necessary.
# It also removes or replaces character sequences such as '()' that 
# might lead to confusion in variable names.

fixFeatures <- function(f) {
    f2 <- f

    # get rid of confusing characters and character sequences
    f2 <- gsub('\\(\\)', '', f2)
    f2 <- gsub('\\(', '', f2)
    f2 <- gsub('\\)', '', f2)
    f2 <- gsub(',', '_', f2)
    f2 <- gsub('-', '_', f2)

    # there are 9 bands of 14 duplicated names each
    abc <- c('A','B','C')
    ndx <- 1
    for (i in c(303, 317, 331)) {
        suffix <- abc[ndx] 
        for (j in 0:13) {
            f2[i+j] <- paste(f2[i + j], suffix, sep='') 
        }           
        ndx <- ndx + 1
     }
    ndx <- 1
    for (i in c(382, 396, 410)) {
        suffix <- abc[ndx] 
        for (j in 0:13) {
            f2[i+j] <- paste(f2[i + j], suffix, sep='') 
        }           
        ndx <- ndx + 1
    }
    ndx <- 1
    for (i in c(461, 475, 489)) {
        suffix <- abc[ndx] 
        for (j in 0:13) {
            f2[i+j] <- paste(f2[i + j], suffix, sep='') 
        }           
        ndx <- ndx + 1
    }
    return(f2)
}
# order-preserving merge.  Parameters should be data frames with the
# same structure - ie, columns should have the same names.
# www.r-statistics.com/2012/01/merging-two-data-frame-ojects-while-preserving-the-rows-order
# elmerehbi.com/2014/10/08/r-merging-two-data-frames-without-messing-with-the-row-order

mergePreservingOrder <- function(df1, df2) {

    ordered <- NULL
    n1 <- nrow(df1)
    n2 <- nrow(df2)

    # Add a column of row numbers to the first data frame.
    df1$rowID <- 1:n1
    # Add a column with the same name to the second data frame.
    df2$rowID <- (n1+1):(n1+n2)
    
    # compine the two data frames
    merged  <- merge(df1, df2, sort='FALSE', all=TRUE)
    ordered <- merged[order(merged$rowID),]

    ordered$rowID <- NULL		# remove the column we added
    return(ordered)
}

# takes about 8 sec oer 6 MB test file, each consistng of 2947 obs of 128 var
readInertialSignals <- function(name, isTest) {
    df <- NULL
    path <- 'UCI HAR Dataset'
    if(isTest) {    
        path <- paste(path, 'test', sep='/')
    } else {
        path <- paste(path, 'train', sep='/')
    } 
    path <- paste(path, 'Inertial Signals', sep='/')
    path <- paste(path, name, sep='/')
    if(isTest) {    
        path <- paste(path, 'test', sep='_')
    } else {
        path <- paste(path, 'train', sep='_')
    } 
    path <- paste(path, 'txt', sep='.')

    # DEBUG
    sprintf('reading %s', path)
    # END

    widths <- rep(16,times=128)
    df     <- read.fwf(path,widths) 
    return(df)
}

# ===================================================================
# MAIN PROGRAM
# ===================================================================
run_analysis <- function() {

    library("dplyr")

    activityLabels    <- NULL
    
    testBodyAccX      <- NULL
    testBodyAccY      <- NULL
    testBodyAccZ      <- NULL
    testTotalAccX     <- NULL
    testTotalAccY     <- NULL
    testBodyGyroZ     <- NULL
    testBodyGyroX     <- NULL
    testBodyGyroY     <- NULL
    testBodyGyroZ     <- NULL

    trainBodyAccX     <- NULL
    trainBodyAccY     <- NULL
    trainBodyAccZ     <- NULL
    trainTotalAccX    <- NULL
    trainTotalAccY    <- NULL
    trainBodyGyroZ    <- NULL
    trainBodyGyroX    <- NULL
    trainBodyGyroY    <- NULL
    trainBodyGyroZ    <- NULL

    mergedBodyAccX    <- NULL
    mergedBodyAccY    <- NULL
    mergedBodyAccZ    <- NULL
    mergedTotalAccX   <- NULL
    mergedTotalAccY   <- NULL
    mergedBodyGyroZ   <- NULL
    mergedBodyGyroX   <- NULL
    mergedBodyGyroY   <- NULL
    mergedBodyGyroZ   <- NULL

    testSubjects      <- NULL
    testDataX         <- NULL 
    testDataY         <- NULL 
    trainSubjects     <- NULL 
    trainDataX        <- NULL
    trainDataY        <- NULL
    mergedSubjects    <- NULL
    mergedDataX       <- NULL
    mergedDataY       <- NULL
    tidierData        <- NULL   # for debugging

    #################################################################
    # LOAD ACTIVITY AND FEATURE NAMES 
    #################################################################

    activityLabels <- read.table('UCI HAR Dataset/activity_labels.txt', 
	    stringsAsFactors = FALSE)
    activityLabels <- activityLabels$V2			# chr [1:6]

    features <- read.table('UCI HAR Dataset/features.txt', 
	    stringsAsFactors = FALSE)
    features <- features$V2			    # chr [1:561]

    #################################################################
    # STEP 1: LOAD AND MERGE DATA SETS
    #################################################################

    # LOAD TEST DATA SETS -------------------------------------------

    # INERTIAL SIGNALS ------------------------------------
    testBodyAccX      <- readInertialSignals('body_acc_x', TRUE)
    testBodyAccY      <- readInertialSignals('body_acc_y', TRUE)
    testBodyAccZ      <- readInertialSignals('body_acc_z', TRUE)
    
    testTotalAccX     <- readInertialSignals('total_acc_x', TRUE)
    testTotalAccY     <- readInertialSignals('total_acc_y', TRUE)
    testTotalAccZ     <- readInertialSignals('total_acc_z', TRUE)
    
    testBodyGyroX      <- readInertialSignals('body_gyro_x', TRUE)
    testBodyGyroY      <- readInertialSignals('body_gyro_y', TRUE)
    testBodyGyroZ      <- readInertialSignals('body_gyro_z', TRUE)

    trainBodyAccX      <- readInertialSignals('body_acc_x', FALSE)
    trainBodyAccY      <- readInertialSignals('body_acc_y', FALSE)
    trainBodyAccZ      <- readInertialSignals('body_acc_z', FALSE)
    
    trainTotalAccX     <- readInertialSignals('total_acc_x', FALSE)
    trainTotalAccY     <- readInertialSignals('total_acc_y', FALSE)
    trainTotalAccZ     <- readInertialSignals('total_acc_z', FALSE)
    
    trainBodyGyroX     <- readInertialSignals('body_gyro_x', FALSE)
    trainBodyGyroY     <- readInertialSignals('body_gyro_y', FALSE)
    trainBodyGyroZ     <- readInertialSignals('body_gyro_z', FALSE)

    # LOAD OTHER DATA -------------------------------------

    # each line is one or two digits followed by a newline; this
    # becomes a data.frame of 2947 obs of 1 var
    testSubjects <- read.table('UCI HAR Dataset/test/subject_test.txt' )

    # each line consists of 561 16-character fields
    widths <- rep(16,times=561)
    # this is 2.6 MB which becomes 2.9 MB in R's memory
    testDataX <- read.fwf('UCI HAR Dataset/test/X_test.txt',widths) 
   
    # indexes into the list of activity labels; data.frame, 2947 obs of 1 var
    testDataY <- read.table('UCI HAR Dataset/test/y_test.txt')
 
    # LOAD TRAIN DATA SETS ------------------------------------------

    trainSubjects <- read.table('UCI HAR Dataset/train/subject_train.txt')

    trainDataX <- read.fwf('UCI HAR Dataset/train/X_train.txt',widths) 
   
    # each line is one or two digits followed by a newline; this
    # becomes a data.frame of 2947 obs of 1 var
    trainDataY <- read.table('UCI HAR Dataset/train/y_train.txt')

    # CALCULATE MERGED DATA SETS ------------------------------------

    mergedSubjects  <- mergePreservingOrder(testSubjects,  trainSubjects)
    mergedDataX     <- mergePreservingOrder(testDataX,     trainDataX)
    mergedDataY     <- mergePreservingOrder(testDataY,     trainDataY)

    mergedBodyAccX  <- mergePreservingOrder(testBodyAccX,  trainBodyAccX)
    mergedBodyAccY  <- mergePreservingOrder(testBodyAccY,  trainBodyAccY)
    mergedBodyAccZ  <- mergePreservingOrder(testBodyAccZ,  trainBodyAccZ)
    mergedTotalAccX <- mergePreservingOrder(testTotalAccX, trainTotalAccX)
    mergedTotalAccY <- mergePreservingOrder(testTotalAccY, trainTotalAccY)
    mergedBodyGyroZ <- mergePreservingOrder(testBodyGyroZ, trainBodyGyroZ)
    mergedBodyGyroX <- mergePreservingOrder(testBodyGyroX, trainBodyGyroX)
    mergedBodyGyroY <- mergePreservingOrder(testBodyGyroY, trainBodyGyroY)
    mergedBodyGyroZ <- mergePreservingOrder(testBodyGyroZ, trainBodyGyroZ)

    #################################################################
    # STEP 2: EXTRACT MEAN AND STANDARD DEVIATION MEASUREMENTS
    #################################################################

    # In the merged data set, only mergedDataX has such attributes.
    # First we clean up the features vector.
    features <- fixFeatures(features)

    # Then we assign the names in the features vector to the table of interest.
    colnames(mergedDataX) <- features
    # Select columns containing either 'mean' and 'std'.  There is 
    # some ambiguity about the requirements here; we are choosing
    # to ignore features whose names contain 'Mean'.
    simplerData <- select(mergedDataX, 
                          contains('mean', ignore.case=FALSE), 
                          contains('std',  ignore.case=FALSE))

    #################################################################
    # STEP 3: MAKE THE DATA SET TIDIER: ADD ACTIVITY AND SUBJECT COLUMNS
    #################################################################

    # mergedDataY contains indexes for labels; we want to turn this
    # into a column of labels ('STANDING', 'WALKING', etc)
    simplerData$activity <- plyr::mapvalues(mergedDataY$V1, 
                                         from=1:6, to=activityLabels)
    simplerData$subject <- mergedSubjects$V1

    #################################################################
    # STEP 4: DESCRIPTIVE COLUMN NAMES
    #################################################################
   
    # this has been done in step 2

    #################################################################
    # STEP 5: INDEPENDENT DATA SET WITH AVERAGE OF EACH VARIABLE FOR
    #    EACH ACTIVITY AND EACH SUBJECT 
    #    6 * 30 = 180 rows of 88 features = 14,220 values
    #################################################################
    grouped     <- simplerData %>% group_by(activity, subject)
    tidyData5   <- summarize_each(grouped, funs(mean))

    #################################################################
    # RETURNED FOR DEBUGGING 
    #################################################################

    # deference these using [[, not [
    output <- list(activityLabels,  features,
                  testSubjects,     testDataX,       testDataY, 
                  trainSubjects,    trainDataX,      trainDataY, 
                  mergedSubjects,   mergedDataX,     mergedDataY,
                  mergedBodyAccX,   mergedBodyAccY,  mergedBodyAccZ,
                  mergedTotalAccX,  mergedTotalAccY, mergedBodyGyroZ,
                  mergedBodyGyroX,  mergedBodyGyroY, mergedBodyGyroZ,
                  simplerData,      tidyData5
                  )
    return(output)
}
