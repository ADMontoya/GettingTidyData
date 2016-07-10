## Getting Tidy Data Project

###Description

This project read a dataset downloaded from [UCI HAR Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip), making some transformations to tidy the dataset and write the result in a text file.

This project are compound by three files:
  * README.md, the file that you are reading now.
  * CodeBook.md, describes the variables, the data, and any transformations or work performed to clean up the data.
  * run_analysis.R, this file is a R script to perform actions to tidy the [UCI HAR Dataset](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).

### Objectives

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

###Prerequisites

* Download [UCI HAR Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) and extract its content to your working directory in "R"
* Install these R packages dplyr and tidyr

### Running the script

* Download run_analysis.R from this project to your working directory in "R"
* Start RStudio and execute this instruction: *source("run_analysis.R")*
  
