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

activityLabel <- fread("UCI HAR Dataset/activity_labels.txt")
features <- fread("UCI HAR Dataset/features.txt")


testActivityType <- join(fread("UCI HAR Dataset/test/y_test.txt"), activityLabel)
setnames(testActivityType, "V2", "Activity")

testSubject <- fread("UCI HAR Dataset/test/subject_test.txt")
setnames(testSubject, "V1", "Subject")

testData <- read.table("UCI HAR Dataset/test/x_test.txt", na.string = "N/A")
names(testData) <- features[["V2"]]

testData <- cbind(testSubject, testActivityType, testData)


trainActivityType <- join(fread("UCI HAR Dataset/train/y_train.txt"), activityLabel)
setnames(trainActivityType, "V2", "Activity")

trainSubject <- fread("UCI HAR Dataset/train/subject_train.txt")
setnames(trainSubject, "V1", "Subject")


trainData <- read.table("UCI HAR Dataset/train/x_train.txt", na.string = "N/A")
names(trainData) <- features[["V2"]]

trainData <- cbind(trainSubject, trainActivityType, trainData)


allData <- rbind(testData, trainData)

keepCols <- sort(c(1, 3, grep("std()", names(allData), fixed=TRUE), grep("mean()", names(allData), fixed=TRUE)))

keepData <- allData[, keepCols, with=FALSE]

meltedData <- melt(keepData, id=c("Subject", "Activity"))

output <- ddply(meltedData, .(Subject, Activity, variable), summarize, Mean=mean(value))
names(output) <- c("Subject", "Activity", "Variable", "Average")

write.table(output, file="tidyDataAverage.txt", row.names=FALSE)




