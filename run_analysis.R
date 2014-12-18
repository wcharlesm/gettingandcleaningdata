if (!require("data.table")) {
  install.packages("data.table")
  library("data.table")
}

if (!require("plyr")) {
  install.packages("plyr")
  library("plyr")
}

if (!require("reshape")) {
  install.packages("reshape")
  library("reshape")
}

# Import human readable Activity Labels with their associated id numbers
activityLabel <- fread("UCI HAR Dataset/activity_labels.txt")

# Import human readable Feature Labels with their associated id numbers
features <- fread("UCI HAR Dataset/features.txt")


# Import record of Activity Types from the test data.  Join that data with the human readable description / label for each Activity
testActivityType <- join(fread("UCI HAR Dataset/test/y_test.txt"), activityLabel)
setnames(testActivityType, "V2", "Activity")

# Import Subject ids from the test data.
testSubject <- fread("UCI HAR Dataset/test/subject_test.txt")
setnames(testSubject, "V1", "Subject")

# Import measurements from the test data, set the appropriate features as column labels / names
testData <- read.table("UCI HAR Dataset/test/x_test.txt", na.string = "N/A")
names(testData) <- features[["V2"]]

# combine the Subject id and Activity type with the measurements
testData <- cbind(testSubject, testActivityType, testData)


# Import record of Activity Types from the test data.  Join that data with the human readable description / label for each Activity
trainActivityType <- join(fread("UCI HAR Dataset/train/y_train.txt"), activityLabel)
setnames(trainActivityType, "V2", "Activity")

# Import Subject ids from the test data.
trainSubject <- fread("UCI HAR Dataset/train/subject_train.txt")
setnames(trainSubject, "V1", "Subject")

# Import measurements from the test data, set the appropriate features as column labels / names
trainData <- read.table("UCI HAR Dataset/train/x_train.txt", na.string = "N/A")
names(trainData) <- features[["V2"]]

# combine the Subject id and Activity type with the measurements
trainData <- cbind(trainSubject, trainActivityType, trainData)

# combine test and training data
allData <- rbind(testData, trainData)

# subset data to include only columns whose names are associated with Standard Deviation and Mean calculations
keepCols <- sort(c(1, 3, grep("std()", names(allData), fixed=TRUE), grep("mean()", names(allData), fixed=TRUE)))
keepData <- allData[, keepCols, with=FALSE]

# melt data so that each row has only one measured variable
meltedData <- melt(keepData, id=c("Subject", "Activity"))

# aggregate all measurements that represent the same Subject, Activity and Feature being measured then take the mean of that aggregate data
output <- ddply(meltedData, .(Subject, Activity, variable), summarize, Mean=mean(value))
names(output) <- c("Subject", "Activity", "Feature", "Average")

write.table(output, file="tidyDataAverage.txt", row.names=FALSE)




