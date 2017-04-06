# GettingandCleaningData

For an explanation of what the script does, see comments in the script. 

Quick summmary:

#Imports and merges the training and test data to create one data frame.

#Change column names

#Arrange columns

#2. Extracts only the measurements on the mean and standard deviation for each measurement.
#find index of all column names with "mean" and "std

#3. Uses descriptive activity names to name the activities in the data set
#Order according to activity and subject.

#Exchange code for activity names.

#4. Appropriately labels the data set with descriptive variable names.
#Done - Used variables from the "features.txt" file. 

#5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
#Subset every subject

#Summarise using dplyr package

#Output is the data frame NewData.

#Export for submission

#Bind into one df

