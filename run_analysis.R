# run_analysis.R

# DESCRIBE WHAT THE PROGRAM DOES


# order-preserving merge.  Parameters should be data frames with the
# same structure - ie, columns should have the same names.
# www.r-statistics.com/2012/01/merging-two-data-frame-ojects-while-preserving-the-rows-order
# elmerehbi.com/2014/10/08/r-merging-two-data-frames-without-messing-with-the-row-order

mergePreservingOrder <- function(df1, df2) {

    ordered <- NULL
    n1 <- nrow(df1)
    n2 <- nrow(df2)

    # DEBUG
    print(n1)
    print(n2)
    # END

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

readInertialSignals <- function(name, isTest) {
    df <- NULL
    if(isTest) {    
        path <- paste('UCI HAR Dataset/Inertial Signals/test', name, sep='/')
    } else {
        path <- paste('UCI HAR Dataset/Inertial Signals/train', name, sep='/')
    } 

    # DEBUG
    print('reading ', path)
    # END

    widths <- rep(16,times=128)
    df     <- read.fwf(path,widths) 
    return(df)
}

run_analysis <- function() {

    library("dplyr")

    activities        <- NULL
    
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

    # LOAD ACTIVITY NAMES #############################################
    activities <- read.table('UCI HAR Dataset/activity_labels.txt', 
	stringsAsFactors = FALSE)
    activities <- activities$V2			# chr [1:6]

    # LOAD TEST DATA SETS #############################################

    # INERTIAL SIGNALS ###
    testBodyAccX      <- readInertialSignals('BodyAccX', TRUE)
    testBodyAccY      <- NULL
    testBodyAccZ      <- NULL
    testTotalAccX     <- NULL
    testTotalAccY     <- NULL
    testBodyGyroZ     <- NULL
    testBodyGyroX     <- NULL
    testBodyGyroY     <- NULL
    testBodyGyroZ     <- NULL


    # OTHER DATA #########

    # each line is one or two digits followed by a newline; this
    # becomes a data.frame of 2947 obs of 1 var
    testSubjects <- read.table('UCI HAR Dataset/test/subject_test.txt' )

    # each line consists of 128 16-character fields
    widths <- rep(16,times=128)
    # this is 2.6 MB which becomes 2.9 MB in R's memory
    testDataX <- read.fwf('UCI HAR Dataset/test/X_test.txt',widths) 
   
    # indexes into the list of activity labels; data.frame, 2947 obs of 1 var
    testDataY <- read.table('UCI HAR Dataset/test/y_test.txt')
 
    # LOAD TRAIN DATA SETS ############################################

    trainSubjects <- read.table('UCI HAR Dataset/train/subject_train.txt')

    trainDataX <- read.fwf('UCI HAR Dataset/train/X_train.txt',widths) 
   
    # each line is one or two digits followed by a newline; this
    # becomes a data.frame of 2947 obs of 1 var
    trainDataY <- read.table('UCI HAR Dataset/train/y_train.txt')

    # CALCULATE MERGED DATA SETS #####################################

    mergedSubjects <- mergePreservingOrder(testSubjects, trainSubjects)
    mergedDataX    <- mergePreservingOrder(testDataX,    trainDataX)
    mergedDataY    <- mergePreservingOrder(testDataY,    trainDataY)



    # WHAT WE RETURN ##################################################

    output <- list(activities, 
                  testSubjects,   testDataX,   testDataY, 
                  trainSubjects,  trainDataX,  trainDataY, 
                  mergedSubjects, mergedDataX, mergedDataY)
    return(output)
}
