library(reshape2)
library(plyr)


#####  Merges the training and the test sets to create one data set

## Unzip files

unzip('UCI HAR Dataset.zip')

## Read the files into dataframes

X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
features <- read.table("./UCI HAR Dataset/features.txt")
activity_labels <-read.table("./UCI HAR Dataset/activity_labels.txt")


## Combine Dataframes y_test (activities) and subject_test (subjects) and rename columns to be Activity and Subject

y_test_ActBySubject <- cbind(y_test, subject_test)
newnames = c("Activity", "Subject") 
colnames(y_test_ActBySubject) <- newnames

## Combine Dataframes y_train (activities) and subject_train (subjects) and rename columns to be Activity and Subject

y_train_ActBySubject <- cbind(y_train, subject_train)
newnames = c("Activity", "Subject") 
colnames(y_train_ActBySubject) <- newnames

## Merge the Test and Train datasets into one dataset containing the Activity by Subject data

y_ActBySubject <- rbind(y_test_ActBySubject,y_train_ActBySubject)

## Merge X_train and X_test data

X_data <- rbind(X_test, X_train)

## Rename the column names from X_data to those in the features dataset 

colnames(X_data) <- features[,2]


#####  Extracts only the measurements on the mean and standard deviation for each measurement

## Remove columns from X_data which do not contain "mean()" or "std()" in the column names.

X_data <- X_data[, grepl("mean()" , names(X_data), fixed = TRUE) | grepl("std()" , names(X_data), fixed = TRUE) ] 

## Combine the y_ActBySubject dataframe with the X_data dataframe

yX_data <- cbind(y_ActBySubject,X_data)


#####  Uses descriptive activity names to name the activities in the data set
## Merge the activity labels and yX_data dataframes
merged_data <- merge(activity_labels, yX_data, by.x = "V1", by.y = "Activity", all = TRUE)

## Drop the V1 column that was introduced as part of the merge

merged_data <- merged_data[,-1]

## Rename the first column to Activity

colnames(merged_data)[1] <- "Activity"


##### Create a second, independent tidy data set with the average of each variable for each activity and each subject.
## Create a vector to hold the variable names
features <- colnames(merged_data)
## Remove Subject and activity from the features vector
features <- features[-c(1,2)]

## Melt the data frame
tidy_data <- melt(merged_data, id=c("Subject","Activity"),measure.vars=features)

## Calculate the mean of observations grouped by the Subject, Activity and Variable

tidy_FINAL <- ddply(tidy_data, c("Subject", "Activity", "variable"), summarise, mean = mean(value))


## Write the final tidy dataset to the "tidy_samsung.txt" file

write.table(tidy_FINAL, file = "tidy_samsung.txt", row.name=FALSE)

