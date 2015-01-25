##GETTING AND CLEANING DATA COURSE PROJECT

##SET WORKING DIRECTORY AND FILES
getwd()
setwd("C:/Users/me/Desktop/AS")
dir()
## Load required libaries
library(plyr);

##Reading datafile and loading it in R-studio, then uzip it
fileUrl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "     
download.file(fileUrl,destfile="C:/Users/me/Desktop/AS/Dataset.zip", mode="wb")
unzip(zipfile="C:/Users/me/Desktop/AS/Dataset.zip",exdir="C:/Users/me/Desktop/AS")
setwd("C:/Users/me/Desktop/AS/UCI HAR Dataset") #unziped data is within this folder

#Verify all required files are in working diectory
path <- file.path("C:/Users/me/Desktop/AS/" , "UCI HAR Dataset")
files<-list.files(path, recursive=TRUE)
files; #28 txt files

# 1. MERGES THE TRAINING AND THE TEST SETS TO CREATE ONE DATA SET.
#Read Activity files
dataActTrain<- read.table("train/y_train.txt")
dataActTest <- read.table("test/y_test.txt")
 
#Read Subject Files
dataSubTrain <- read.table("train/subject_train.txt")
dataSubTest <- read.table("test/subject_test.txt")
 
#Read Features files
dataFeatTrain <- read.table("train/X_train.txt")
dataFeatTest <- read.table("test/X_test.txt")
 
# Concatenating data tables by rows
datActivity<- rbind(dataActTrain, dataActTest)
datSubject <- rbind(dataSubTrain, dataSubTest)
datFeatures<- rbind(dataFeatTrain, dataFeatTest) 

#Verifying results
dim(datActivity)      #[1] 10299     1
dim(datSubject)       #[1] 10299     1
dim(datFeatures)      #[1] 10299   561

#Simplify names as string variables
names(datSubject)<-"subject" 
names(datActivity)<- "activity"
datFeatNames <- read.table(file.path(path, "features.txt"),head=FALSE)
names(datFeatures)<- datFeatNames$V2
names(datFeatures);
                  head(datSubject);
                  head(datActivity);
                          
#Merging columns to obtain a total frame for all data
datCombine <- cbind(datSubject, datActivity)
      str(datCombine);
Data <- cbind(datFeatures, datCombine)

str(Data);
head(Data,100);

# 2.EXTRACTS ONLY THE MEASUREMENTS ON THE MEAN AND STANDARD DEVIATION FOR EACH MEASUREMENT.
subdataFeaturesNames<-datFeatNames$V2[grep("mean\\(\\)|std\\(\\)", datFeatNames$V2)]

#Subset the data frame Data by seleted names of Features
MeanSTD<-c(as.character(subdataFeaturesNames), "subject", "activity")
Data<-subset(Data,select=MeanSTD)

# Verifying THE MEASUREMENTS ON THE MEAN AND STANDARD DEVIATION FOR EACH MEASUREMENT are included
str(Data)
#---end Q2

#3	USES DESCRIPTIVE ACTIVITY NAMES TO NAME THE ACTIVITIES IN THE DATA SET 
activityLabel <- read.table("activity_labels.txt")
activityLabel[, 2] = gsub("_", "", tolower(as.character(activityLabel[, 2])))
datActivity[,1] = activityLabel[datActivity[,1], 2]
names(datActivity) <- "activity"

#Verifying with a sample of 100
head(datActivity$activity, 100)

#---end Q3

# 4 APPROPRIATELY LABELS THE DATA SET WITH DESCRIPTIVE VARIABLE NAMES
#prefix t is replaced by tempo
#Acc is replaced by Meter
#Gyro is replaced by Gyro
#prefix f is replaced by freq
#Mag is replaced by Magnitude
#BodyBody is replaced by Body
names(Data)<-gsub("^t", "tempo", names(Data))
names(Data)<-gsub("^f", "freq", names(Data))
names(Data)<-gsub("Acc", "Meter", names(Data))
names(Data)<-gsub("Gyro", "Gyro", names(Data))
names(Data)<-gsub("Mag", "Magnitude", names(Data))
names(Data)<-gsub("BodyBody", "Body", names(Data))
#Verify
 names(Data)
 write.table(Data, "merged_clean_data.txt") # write out dataset
#---end Q4
 
# Q5  FROM THE DATA SET IN STEP 4, CREATES A SECOND, INDEPENDENT TIDY DATA SET WITH THE AVERAGE OF EACH VARIABLE FOR EACH ACTIVITY AND EACH SUBJECT.
require(plyr); #if not loaded previoulsy

Data2<-aggregate(. ~subject + activity, Data, mean)
Data2<-Data2[order(Data2$subject,Data2$activity),]
write.table(Data2, file = "my_tidyData.txt",row.name=FALSE)    # write out datset

##---end Q5

 
