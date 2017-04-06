#Import and merge the training and test data to create one data frame.
filelisttest <- list.files("UCI HAR Dataset/test", pattern = ".txt")
TEST <- lapply(filelisttest, function(x){read.table(paste("UCI HAR Dataset/test/", x, sep = ""))})
varlist <- read.table("UCI HAR Dataset/features.txt") #load feature variables
varlist <- subset(varlist[2]) #subset
varlist <- unlist(varlist)
colnames(TEST[[2]]) <- varlist

filelisttrain <- list.files("UCI HAR Dataset/train", pattern = ".txt")
TRAIN <- lapply(filelisttrain, function(x){read.table(paste("UCI HAR Dataset/train/", x, sep = ""))})
colnames(TRAIN[[2]]) <- varlist

#Create TRAIN and TEST df
TEST <- do.call("cbind", TEST)
TRAIN <- do.call("cbind", TRAIN)
TESTTRAIN <- rbind(TEST, TRAIN)

#Change column names
colnames(TESTTRAIN)[c(1, 563)] <- c("Subject", "Activity")

#Arrange columns
TESTTRAIN <- TESTTRAIN[c(1, 563, 2:562)]

#2. Extracts only the measurements on the mean and standard deviation for each measurement.
#find index of all column names with "mean" and "std
means <- grep("mean", colnames(TESTTRAIN))
stds <- grep("std", colnames(TESTTRAIN))

means_stds <- c(1, 2, means, stds)

ONLYdf <- TESTTRAIN[means_stds]

#3. Uses descriptive activity names to name the activities in the data set
#Order according to activity and subject.
ONLYdf <- ONLYdf[order(ONLYdf$Activity, ONLYdf$Subject),]

#Exchange code for activity names.
ONLYdf$Activity[ONLYdf$Activity == 1] <- c("WALKING")
ONLYdf$Activity[ONLYdf$Activity == 2] <- c("WALKING_UPSTAIRS")
ONLYdf$Activity[ONLYdf$Activity == 3] <- c("WALKING_DOWNSTAIRS")
ONLYdf$Activity[ONLYdf$Activity == 4] <- c("SITTING")
ONLYdf$Activity[ONLYdf$Activity == 5] <- c("STANDING")
ONLYdf$Activity[ONLYdf$Activity == 6] <- c("LAYING")

#4. Appropriately labels the data set with descriptive variable names.
#Done - Used variables from the "features.txt" file. 

#5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
#Subset every subject
library(dplyr)
subjects <- unique(ONLYdf$Subject)
Sublist <- lapply(subjects, function(x){subset(ONLYdf, ONLYdf$Subject == x)})


#Summarise
NewData <- lapply(subjects, function(x){Sublist[[x]] %>% group_by(Activity) %>% summarise_each(funs(mean))})
#Bind into one df
NewData <- bind_rows(NewData)

#Export for submission
write.table(NewData, "submission.txt", row.name = F)

rm(NewData, ONLYdf, TEST, TRAIN, TESTTRAIN, filelisttest, filelisttrain, means, means_stds, stds, subjects, Sublist, varlist)