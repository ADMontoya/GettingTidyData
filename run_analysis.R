#Libraries needed
library(dplyr)
library(tidyr)
# Read features
feature<-read.table("UCI HAR Dataset/features.txt", col.names = c("id","feature"))
# Read activities
activity<-read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("id","activity"))
# Read training data
fmTrain<-read.table("UCI HAR Dataset/train/X_train.txt", col.names = feature$feature)
aTrain<-read.table("UCI HAR Dataset/train/y_train.txt",col.names="activityId")
sTrain<-read.table("UCI HAR Dataset/train/subject_train.txt",col.names="subject")
trainData<-cbind(sTrain, aTrain, fmTrain)
rm(fmTrain, aTrain, sTrain)
# Read test data
fmTest<-read.table("UCI HAR Dataset/test/X_test.txt", col.names = feature$feature)
aTest<-read.table("UCI HAR Dataset/test/y_test.txt",col.names="activityId")
sTest<-read.table("UCI HAR Dataset/test/subject_test.txt",col.names="subject")
testData<-cbind(sTest, aTest, fmTest)
rm(fmTest, aTest, sTest)
# Merge test and training data
mergeData<-rbind(testData, trainData)
rm(testData, trainData)
# Looking for id columns that are mean or standard deviation
p<-grep("(mean|std)\\(", feature$feature)
p<-p+2
# Selecting columns: subject, activity and that are standard deviation or mean
filterData<-select(mergeData, subject, activityId, p)
rm(mergeData,p)
# Merge filterData with activity
data<-merge(activity, filterData, by.x = "id", by.y = "activityId", all = FALSE)
rm(filterData, activity, feature)
# Add column for id row
data$row<-1:nrow(data)
# Select required columns
data<-select(data, 3, 2, 4:69)
## Tidying data with rules from Hadley Wickham
#xData<-gather(data, feature, value, -row, -subject, -activity)
#xData<-separate(xData, col = "feature", into = c("feature","direction"), sep = "\\.\\.\\.")
#xData<-separate(xData, col = "feature", into = c("feature","var"), sep = "\\.")
#xData<-spread(xData, var, value)
# Ajust columns names
names(data)<-sub("\\.\\.", "", names(data))
names(data)<-sub("^t", "time.", names(data))
names(data)<-sub("^f", "frequency.", names(data))
# New tidy dataset
tidyData<-data %>% group_by(subject, activity) %>% summarise_each(funs(mean))
# Write file with the tidy dataset
write.table(tidyData, "UCI HAR Dataset/tidyData.txt", row.names = FALSE)
