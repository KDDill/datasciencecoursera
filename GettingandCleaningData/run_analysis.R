# load libraries
library(plyr)
library(reshape)

# Read features and activity_labels
features <- read.table("UCI HAR Dataset/features.txt", head=F)
colnames(features) <- c("FeatureNum","FeatureName")
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt", head=F)
colnames(activityLabels) <- c("ActivityNum", "Activity")
activityLabels$ActivityNum <- as.character(activityLabels$ActivityNum)

# Read UCI HAR test data 
subjectTest <- read.table("UCI HAR Dataset/test/subject_test.txt", head=F)
colnames(subjectTest) <- "Subject"
ActivityTest <- read.table("UCI HAR Dataset/test/y_test.txt",head=F)
colnames(ActivityTest) <- "ActivityNum"
ActivityTest$ActivityNum <- as.character(ActivityTest$ActivityNum)
FeatTest <- read.table("UCI HAR Dataset/test/X_test.txt",head=F)
colnames(FeatTest) <- features$FeatureName

## Merge (cbind) X, Y and subject data
test <- cbind(subjectTest,ActivityTest,FeatTest)

# Read UCI HAR training data 
subjectTrain <- read.table("UCI HAR Dataset/train/subject_train.txt", head=F)
colnames(subjectTrain) <- "Subject"
ActivityTrain <- read.table("UCI HAR Dataset/train/y_train.txt",head=F)
colnames(ActivityTrain) <- "ActivityNum"
ActivityTrain$ActivityNum <- as.character(ActivityTrain$ActivityNum)
FeatTrain <- read.table("UCI HAR Dataset/train/X_train.txt",head=F)
colnames(FeatTrain) <- features$FeatureName

## Merge (cbind) X, Y and subject data
train <- cbind(subjectTrain,ActivityTrain,FeatTrain)

# Merge (rbind) test and training data 
HARDat <- rbind(test,train)

# Extract only the mean and std features using grep and colnames n=66
KeyFeatures <- grep("mean|std",colnames(HARDat), value=T) # includes mean Freq variables
KeyFeatures <- grep("Freq",KeyFeatures, invert=T, value=T) #removes mean Freq variables
HARDatMeanStds <- data.frame(HARDat[,1:2],HARDat[,colnames(HARDat) %in% KeyFeatures])

# Use descriptive activity names to name the activities
HARDatMeanStds <- merge(HARDatMeanStds, activityLabels, by.x="ActivityNum",by.y="ActivityNum")

# Appropriately labels the data set with descriptive activity names using gsub 
# prefix t is for time
# prefix f is for frequency 
NewColnames <- gsub("tBody", "TimeBody", colnames(HARDatMeanStds))
NewColnames <- gsub("tGrav", "TimeGrav", NewColnames)
NewColnames <- gsub("fBody", "FreqBody", NewColnames)
NewColnames <- gsub("[.]", "", NewColnames)
NewColnames <- gsub("BodyBody", "Body", NewColnames)
colnames(HARDatMeanStds) <- NewColnames

# Creates a tidy data set with the average of each variable for each activity and each subject
tidymelt <-melt(HARDatMeanStds, c("Subject", "Activity", "ActivityNum"))
tidycast <-cast(tidymelt, Subject + Activity + ActivityNum ~ variable, mean)
tidycast <- tidycast[order(tidycast$Subject,tidycast$ActivityNum),]
tidycast <- tidycast[,-3] # remove ActivityNum

# Write out Tidy Data Set
write.table(tidycast,"Tidy_HAR_data.txt", row.names=F)
