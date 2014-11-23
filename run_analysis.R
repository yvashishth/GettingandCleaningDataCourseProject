#####################################################################
##                Reading the FeatureSet and the Labels            ##
#####################################################################

features <- read.table("./data./UCI HAR Dataset./features.txt",sep="")
labels <- read.table("./data./UCI HAR Dataset./activity_labels.txt",sep="")

#####################################################################
##              Finding the Desired indeces from feature Set       ##
#####################################################################

wanted_feature_indices <- grep("mean\\(|std\\(", features[,2])

#####################################################################
##                        Reading the Test Data                    ##
#####################################################################

xtest <- read.table("./data./UCI HAR Dataset./test/X_test.txt",sep="")
xtest <- xtest[,wanted_feature_indices]
ytest <- read.table("./data./UCI HAR Dataset./test/Y_test.txt",sep="",col.names="label")
subjecttest <- read.table("./data./UCI HAR Dataset./test/subject_test.txt",sep="",col.names="subject")

#####################################################################
##                        Merging the Test Data                    ##
#####################################################################

testMerge <- cbind(subjecttest,ytest,xtest)


#####################################################################
##                    Reading the Training Data                    ##
#####################################################################


xtrain <- read.table("./data./UCI HAR Dataset./train/X_train.txt",sep="")
xtrain <- xtrain[,wanted_feature_indices]
ytrain <- read.table("./data./UCI HAR Dataset./train/Y_train.txt",sep="",col.names="label")
subjecttrain <- read.table("./data./UCI HAR Dataset./train/subject_train.txt",sep="",col.names="subject")


#####################################################################
##                    Merging the Training Data                    ##
#####################################################################


trainMerge <- cbind(subjecttrain,ytrain,xtrain)

#####################################################################
##       Merging the Testingn and Training Data                    ##
#####################################################################

testtrainMerge <- rbind(testMerge,trainMerge)           


#####################################################################
##                        Reshaping the  Data                      ##
#####################################################################


library(reshape2)
molten <- melt(testtrainMerge, id = c("label", "subject"))
####################################################################
## 		produce the tidy dataset with mean of each variable 	  ##
## 		for each activyt and each subject						  ##
####################################################################
tidyFinalData <- dcast(molten, label + subject ~ variable, mean)

#####################################################################
##                        Writing Data to Disk                     ##
#####################################################################
write.table(tidyFinalData, file="means.txt", quote=FALSE, row.names=FALSE, sep="\t")

