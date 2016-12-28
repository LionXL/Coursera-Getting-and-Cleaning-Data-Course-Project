# Getting and cleaning data course project
## developed by lloyd Prendergast

## Introduction

The script run_analysis.Rperforms the 5 steps described in the course project's definition.
Those 5 steps are performed as follows:

deplyr package was used to combine and manipulate data tables being used.
library(dplyr)

define url for source filename
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

destination filename, will automatically save to current directory 

	filename <- "getdata_dataset.zip"

Download and unzip the dataset:
 first check if file existed already and delete it then retrieve it
 
 	if (!file.exists(filename)){
		download.file(fileURL, filename
		unzip(filename, overwrite = TRUE)
		}
	else { 
		file.remove(filename)
		download.file(fileURL, filename)
		nzip(filename, overwrite = TRUE) 
		}

load and merge x dataset use features,txt to build filter used to 
extract mean and standard deviation

	features <- read.table("UCI HAR Dataset/features.txt") 
	features[,2] <- as.character(features[,2]) 
	filter <- grep(".mean.|.std.", features[,2]) 
	filter.names <- features[filter,2] 
	filter.names = gsub('-mean', 'Mean', filter.names) 	filter.names = gsub('-std', 'Std', filter.names) 
	filter.names <- gsub('[-()]', '', filter.names)

	x_train <- read.table("UCI HAR Dataset/train/X_train.txt")[filter] 
	x_test <- read.table("UCI HAR Dataset/test/X_test.txt")[filter] 
	x_data <- rbind(x_train, x_test)

load and merge y dataset use activity_labels.txt to get descriptive names and apply to columns

	y_train <- read.table("UCI HAR Dataset/train/y_train.txt") 
	y_test <- read.table("UCI HAR Dataset/test/y_test.txt") 
	y_data <- rbind(y_train, y_test)

	activities <- read.table("UCI HAR Dataset/activity_labels.txt") 
	y_data[, 1] <- activities[y_data[, 1], 2] 
	names(y_data) <- "activity

load and merge subject dataset

	subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt") 
	subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt") 
	subject_data <- rbind(subject_train, subject_test)

	names(subject_data) <- "subject"

bind all the data in a single data set

	combined_data <- cbind(x_data, y_data, subject_data) 
	colnames(combined_data) <- c("subject", "activity", filter.names)

Create a second, independent tidy data set with the average of each variable 

	tidy_data <- ddply(combined_data, .(subject, activity), function(x) colMeans(x[, 1:66]))

save datatable as text file 

	write.table(tidy_data, "tidy_data.txt", row.name=FALSE)

## Variables
	x_train, y_train, x_test, y_test, subject_train and subject_test contain the data from the downloaded files.
	x_data, y_data and subject_data merge the previous datasets to further analysis.
	filter contains the correct names for the x_data dataset, which are applied to the column names stored in mean_and_std_features, 	 a numeric vector used to extract the desired data.
	A similar approach is taken with activity names through the activities variable.
	combined_datamergesx_data,y_dataandsubject_data` in a big dataset.
	Finally, tidy_data contains the relevant averages which will be later stored in a .txt file. ddply() from the plyr package is 		used to apply colMeans() and ease the development.


## Identifiers
	subject - The ID of the test subject
	activity - The type of activity performed when the corresponding measurements were taken


## Measurements
	tBodyAccMeanX
	tBodyAccMeanY
	tBodyAccMeanZ
	tBodyAccStdX
	tBodyAccStdY
	tBodyAccStdZ
	tGravityAccMeanX
	tGravityAccMeanY
	tGravityAccMeanZ
	tGravityAccStdX
	tGravityAccStdY
	tGravityAccStdZ
	tBodyAccJerkMeanX
	tBodyAccJerkMeanY
	tBodyAccJerkMeanZ
	tBodyAccJerkStdX
	tBodyAccJerkStdY
	tBodyAccJerkStdZ
	tBodyGyroMeanX
	tBodyGyroMeanY
	tBodyGyroMeanZ
	tBodyGyroStdX
	tBodyGyroStdY
	tBodyGyroStdZ
	tBodyGyroJerkMeanX
	tBodyGyroJerkMeanY
	tBodyGyroJerkMeanZ
	tBodyGyroJerkStdX
	tBodyGyroJerkStdY
	tBodyGyroJerkStdZ
	tBodyAccMagMean
	tBodyAccMagStd
	tGravityAccMagMean
	tGravityAccMagStd
	tBodyAccJerkMagMean
	tBodyAccJerkMagStd
	tBodyGyroMagMean
	tBodyGyroMagStd
	tBodyGyroJerkMagMean
	tBodyGyroJerkMagStd
	fBodyAccMeanX
	fBodyAccMeanY
	fBodyAccMeanZ
	fBodyAccStdX
	fBodyAccStdY
	fBodyAccStdZ
	fBodyAccMeanFreqX
	fBodyAccMeanFreqY
	fBodyAccMeanFreqZ
	fBodyAccJerkMeanX
	fBodyAccJerkMeanY
	fBodyAccJerkMeanZ
	fBodyAccJerkStdX
	fBodyAccJerkStdY
	fBodyAccJerkStdZ
	fBodyAccJerkMeanFreqX
	fBodyAccJerkMeanFreqY
	fBodyAccJerkMeanFreqZ
	fBodyGyroMeanX
	fBodyGyroMeanY
	fBodyGyroMeanZ
	fBodyGyroStdX
	fBodyGyroStdY
	fBodyGyroStdZ
	fBodyGyroMeanFreqX
	fBodyGyroMeanFreqY
	fBodyGyroMeanFreqZ
	fBodyAccMagMean
	fBodyAccMagStd
	fBodyAccMagMeanFreq
	fBodyBodyAccJerkMagMean
	fBodyBodyAccJerkMagStd
	fBodyBodyAccJerkMagMeanFreq
	fBodyBodyGyroMagMean
	fBodyBodyGyroMagStd
	fBodyBodyGyroMagMeanFreq
	fBodyBodyGyroJerkMagMean
	fBodyBodyGyroJerkMagStd
	fBodyBodyGyroJerkMagMeanFreq


## Activity Labels
	WALKING (value 1): subject was walking during the test
	WALKING_UPSTAIRS (value 2): subject was walking up a staircase during the test
	WALKING_DOWNSTAIRS (value 3): subject was walking down a staircase during the test
	SITTING (value 4): subject was sitting during the test
	STANDING (value 5): subject was standing during the test
	LAYING (value 6): subject was laying down during the test
