library(dplyr)

filename <- "dataset.zip"

## Download the dataset if it doesn't exist
if (!file.exists(filename)){
        download.file(
                "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
                filename,
                method="curl"
        )
}  

## Extract the content, if it hasn't been extracted yet.
if (!file.exists("UCI HAR Dataset")) { 
        unzip(filename) 
}

## Load the features
features <- read.table("UCI HAR Dataset/features.txt", stringsAsFactors=F)

## Select only the measurements on the mean and standard deviation 
features_wanted <- grep(".*mean.*|.*std.*", features[,2])

## Label the features with descriptive names
features_wanted.names <- features[features_wanted,2]
features_wanted.names <- gsub('-','.', features_wanted.names)
features_wanted.names <- gsub('[()]','', features_wanted.names)

## Load the datasets with only the selected measurements and bind them
train <- read.table("UCI HAR Dataset/train/X_train.txt")[features_wanted]
train_subjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
train_activities <- read.table("UCI HAR Dataset/train/y_train.txt")
train <- cbind(train_subjects, train_activities, train)

test <- read.table("UCI HAR Dataset/test/X_test.txt")[features_wanted]
test_subjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
test_activities <- read.table("UCI HAR Dataset/test/y_test.txt")
test <- cbind(test_subjects, test_activities, test)

## Merge datasets
data <- rbind(train, test)

## Add labels
colnames(data) <- c("subject", "activity", features_wanted.names)

## Load the activities
activities <- read.table(
                "UCI HAR Dataset/activity_labels.txt", 
                stringsAsFactors = F, 
                col.names = c("id", "label")
        )

## Turn activities and subjects into factors
data$activity <- factor(
                data$activity, 
                levels = activities$id, 
                labels=activities$label
        )
data$subject <- factor(data$subject)

## Get the average of each variable for each activity and subject
tidy <- summarize_each(
                group_by(data, subject, activity), 
                funs(mean)
        )

## Persist the tidy data set
write.table(tidy, "tidy.txt", row.name=FALSE)
