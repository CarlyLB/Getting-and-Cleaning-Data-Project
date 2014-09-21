## Codebook


#### Data 

Source data can be found at the following link:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

* After running the program "run_analysis.R" a tidy data set called tidy_FINAL is created and contains the mean of all of the mean and std measurements for each subject by each activity. 
* 'tidy_FINAL' contains 11,880 observations and 4 variables.
* A file, 'tidy_samsung.txt' is also written after running the "run_analysis.R" program.



#### Variables

* Subject, is a value in the range from 1 to 30 and identifies the subject who performed the activity for each window sample. 

* Activity,  denotes the six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) performed during the study. 

* variables, are a measurement collected from the accelerometer (Acc-XYZ) and gyroscope (Gyro-XYZ) 3-axial raw signal. 
    * There are 66 variables in total 
    * Each variable will have a prefix of either 't' or 'f' 
        * prefix 't' to denote time, they were time domain signals captured at a constant rate of 50 Hz.
        * prefix 'f' to indicate frequency domain signals, they were applied by a Fast Fourier Transform (FFT) of the original signal.
    * The variable names contains either a "mean" or "std" to denote whether it is the mean value or standard deviation of the measurement
    * The suffix 'X' , 'Y' or 'Z' is used to denote 3-axial signals in the X, Y or Z directions.
    
* mean, is the mean of the variable measurement
  


#### Data Transformations
   
This data was processed into a tidy data set using the following transformations:

* Assume the data is already downloaded to the working firectory
* Unzip the zip file, which in turn creates a directory called "UCI HAR Dataset" containing all of the required datasets
* Merge the y_test (activities) and subject_test (subjects) into a single test data set of 2,947 obs and 2 vars.
* Merge the y_train (activities) and subject_train (subjects) into a single train data set of 7,353 obs and 2 vars.
* Append the 'y' test data set to 'y' train data set to get a full 'y' data set of 10,299 observations and 2 vars.
* Append the 'x' test data set to 'x' train data set to get a full 'x' data set of 10,299 observations and 561 vars and use                   features.txt as the column names of the merged x data.
* Keep only columns which contains mean() or std() in column names since they are the measurements we need.
* Merge the 'x' and 'y' data sets to get a complete dataset and join this with the activity labels to get the activity name
* Drop the label id which is no longer used.
* Melt the data using the reshape2 library and then dcast using the dplyr library to create a dataset of 11,880 obs and 4 vars with the mean of each variable grouped by each subject and activity. 
* Write the result to the 'tidy_samsung.txt' file in the working directory. 



#### References

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012