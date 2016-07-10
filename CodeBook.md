##Getting Tidy Data Project

###UCI HAR Dataset
The dataset includes the following files:

- 'README.txt'
- 'features_info.txt': Shows information about the variables used on the feature vector.
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 
- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 
- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 
 
For each record it is provided:

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

###Analysis

The first step, read the files activity_labels.txt and feature.txt. I use the function `read.table` to read all files in the script. I use this code to read and assign a name to each column:

```
feature<-read.table("UCI HAR Dataset/features.txt", col.names = c("id","feature"))
activity<-read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("id","activity"))
```

The training's dataset are split in three files, those are:

1. X_train.txt, contains 561 columns and each one contains a value for each feature. this file no contains columns titles, the titles are in the file features.txt
2. y_train.txt, contains one columns and each row contains the id activity.
3. subject_train.txt, contains one columns and each row contains the id subject.

The three files have the same quantity of rows, to get one dataset from these file, there have to join the files by columns. But, first there are to read these files and assign a name for each columns.I use this code to read and assign a name to each column:

```
fmTrain<-read.table("UCI HAR Dataset/train/X_train.txt", col.names = feature$feature)
aTrain<-read.table("UCI HAR Dataset/train/y_train.txt",col.names="activityId")
sTrain<-read.table("UCI HAR Dataset/train/subject_train.txt",col.names="subject")
```

Note: I use the column *feature* from the data.frame *feature* to assign a name for each column in the X_train.txt file.

Now, I can join this files by column ussing the function `cbind`. Here is the code:

```
trainData<-cbind(sTrain, aTrain, fmTrain)
```

I do the same actions to process the test dataset. Here is the code:

```
fmTest<-read.table("UCI HAR Dataset/test/X_test.txt", col.names = feature$feature)
aTest<-read.table("UCI HAR Dataset/test/y_test.txt",col.names="activityId")
sTest<-read.table("UCI HAR Dataset/test/subject_test.txt",col.names="subject")
testData<-cbind(sTest, aTest, fmTest)
```

Now I can merge the training dataset and the test dataset, I use the function `rbind` to perform this action. Here is the code:

```
mergeData<-rbind(testData, trainData)
```
First objective, done!

Now I have to filter the columns on the dataset that contains the standard deviation or mean for each feature. I use the function `select` from the library *dplyr*, but previously I get the id from each column that match with condition. To perform that action I use the function `grep` in the vector `feature$feature` with a regular expression and added 2 to the result vector becasuse the new dataset has two columns before the columns of features. Here is the code:

```
p<-grep("(mean|std)\\(", feature$feature)
p<-p+2
filterData<-select(mergeData, subject, activityId, p)
```
Second objective, done!

Now I have to replace the activity id by the activity description. To perform this action I have to merge the *filterData* data.frame with the *activity* data.frame. I use the function `merge` to do this. Here is the code:

```
data<-merge(activity, filterData, by.x = "id", by.y = "activityId", all = FALSE)
```

Now I remove those columns that I don't needed. I use the function `select` from the library *dplyr*. Here is the code:

```
data<-select(data, 3, 2, 4:69)
```
Third objective, done!
