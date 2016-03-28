# Getting and Cleaning Data - Course Project
This is the Getting and Cleaning Data project. It contains a R script called `run_analysis.R` which produce the file `tidy.csv` containing the tidy data set described in the `CodeBook.md` file.

`run_analysis.R` executes the following steps: 

1. Check if the original dataset exists, if not, download it
1. Check if the original dataset has been extracted, if not, extract it.
1. Load the features
1. Find only the features on the mean and standard deviation to be extracted.
1. Label the features with descriptive names
1. Load the datasets with only the selected measurements and bind them
1. Merge the training and test datasets
1. Add labels to the merged data sets
1. Load the activities
1. Turn activities and subjects into factors
1. Get the average of each variable grouped by each activity and subject
1. Store the tidy data set in the file `tidy.csv`