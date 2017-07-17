library(data.table)

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

download.file(url,"destfile.zip") #Downloading the file
unzip("destfile.zip") #unzipping the file

#load all the data frames
testSubject <- read.table("./UCI HAR Dataset/test/subject_test.txt", header = FALSE)
testLabels <- read.table("./UCI HAR Dataset/test/y_test.txt", header = FALSE)
test <- read.table("./UCI HAR Dataset/test/X_test.txt", header = FALSE)

trainSubject <- read.table("./UCI HAR Dataset/train/subject_train.txt", header = FALSE)
trainLabels <- read.table("./UCI HAR Dataset/train/y_train.txt", header = FALSE)
train <- read.table("./UCI HAR Dataset/train/X_train.txt", header = FALSE)

activities <- read.table("./UCI HAR Dataset/activity_labels.txt",header = FALSE, colClasses = "character")
features <- read.table("./UCI HAR Dataset/features.txt",header = FALSE, colClasses = "character")

#transform to a factor the test and train lablels
testLabels$V1 <- factor(testLabels$V1,levels = activities$V1,labels = activities$V2)
trainLabels$V1 <- factor(trainLabels$V1,levels = activities$V1,labels = activities$V2)

#get only the measurements on the mean and standard deviation
featuresMeanSD <- grep(".*mean.*|.*std.*",features$V2)
features.names <- features[featuresMeanSD,2]
features.names <-gsub('-mean', 'Mean', features.names)
features.names <-gsub('-std', 'Std', features.names)
features.names <-gsub('[-()]', '', features.names)

#filter by results above
test<-test[,featuresMeanSD]
train<-train[,featuresMeanSD]

#combine the datasets
test <- cbind(test,testLabels)
test <- cbind(test,testSubject)

train <- cbind(train,trainLabels)
train <- cbind(train,trainSubject)

totalData <- rbind(train,test)

#rename colnames
colnames(totalData) <- c(features.names,"activity","subject")

#transform to factor the subject
totalData$subject <- as.factor(totalData$subject)

#new tidy dataset
totalData.tidy <- melt(totalData, id = c("activity", "subject"))
tidy <- dcast(totalData.tidy, activity+subject  ~ variable, mean)

write.table(tidy, "tidy.txt", row.names = FALSE, quote = FALSE)
