
###############################################################################
# Getting and cleaning data course project
# developed by lloyd Prendergast
###############################################################################

## load dplyr package to cobine data tables
library(dplyr)

## define url for source filename
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

## destination filename, will automatically save to current directory
filename <- "getdata_dataset.zip"

## Download and unzip the dataset:
## first check if file existed already and delete it then retrieve it
if (!file.exists(filename)){
  
  download.file(fileURL, filename)
  unzip(filename, overwrite = TRUE) 
  
}else {
  
  file.remove(filename)
  download.file(fileURL, filename)
  unzip(filename, overwrite = TRUE)
  
}
  
# Step 1 - load and merge x dataset
# use features,txt to build filter used to extract mean and standard deviation
###############################################################################
features <- read.table("UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])
filter <- grep(".*mean.*|.*std.*", features[,2])
filter.names <- features[filter,2]
filter.names = gsub('-mean', 'Mean', filter.names)
filter.names = gsub('-std', 'Std', filter.names)
filter.names <- gsub('[-()]', '', filter.names)

x_train <- read.table("UCI HAR Dataset/train/X_train.txt")[filter]
x_test <- read.table("UCI HAR Dataset/test/X_test.txt")[filter]
x_data <- rbind(x_train, x_test)


# Step 2 - load and merge y dataset
# use activity_labels.txt to get descriptive names and apply to columns
###############################################################################
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
y_data <- rbind(y_train, y_test)

activities <- read.table("UCI HAR Dataset/activity_labels.txt")
y_data[, 1] <- activities[y_data[, 1], 2]
names(y_data) <- "activity"


# Step 3 - load and merge subject dataset
###############################################################################
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
subject_data <- rbind(subject_train, subject_test)

names(subject_data) <- "subject"


# Step 4 - bind all the data in a single data set
###############################################################################
combined_data <- cbind(x_data, y_data, subject_data)


# Step 5 - Create a second, independent tidy data set with the average of each variable
#          for each activity and each subject
#          66 <- 68 columns but last two (activity & subject)
###############################################################################
tidy_data <- ddply(combined_data, .(subject, activity), function(x) colMeans(x[, 1:66]))

write.table(tidy_data, "tidy_data.txt", row.name=FALSE)
