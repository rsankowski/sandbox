library(plyr)
library(dplyr)
## downloading the raw data
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "./data.zip", method = "curl")
list.files("./")
data <- unzip ("data.zip", exdir = "./")
##loading train dataset
train_subject <- read.table("./UCI HAR Dataset/train/subject_train.txt")
str(train_subject)
train_set <- read.table("./UCI HAR Dataset/train/X_train.txt")
str(train_set)
head(train_set)
train_label <- read.table("./UCI HAR Dataset/train/y_train.txt")
str(train_label)
summary(train_label)
features <- read.table("./UCI HAR Dataset/features.txt")
tail(features)
##here I'm making the features more readable
features2 <- features [,2]
features2 <- gsub("Body", " Body", features2, ignore.case = TRUE)
features2 <- gsub("gravity", " Gravity", features2, ignore.case = TRUE)
features2 <- gsub("Acc", " linear acceleration ", features2, ignore.case = TRUE)
features2 <- gsub("Gyro", " angular velocity", features2, ignore.case = TRUE)
features2 <- gsub("Mag", " magnitude", features2, ignore.case = TRUE)
features2 <- gsub("Mean", " Mean ", features2, ignore.case = TRUE)
features2 <- gsub("std", " STD ", features2, ignore.case = TRUE)
features3 <- paste(features2, sep=""); head(features3)
colnames(train_set) <- features3 ##assigning the formatted feature names to the dataset
colnames(train_label)<- "Activity" ##assigning a column name to the activity
colnames(train_subject)<- "Subject" ##..and the subject table
train_columns <- cbind(train_subject, train_label, train_set)
str(train_columns)
##loading test dataset
test_subject <- read.table("./UCI HAR Dataset/test/subject_test.txt")
str(test_subject)
test_label <- read.table("./UCI HAR Dataset/test/y_test.txt")
str(test_label)
test_set <- read.table("./UCI HAR Dataset/test/X_test.txt")
str(test_set)
colnames(test_set) <- features3
colnames(test_label)<- "Activity"
colnames(test_subject)<- "Subject"
test_columns <- cbind(test_subject, test_label, test_set)
str(test_columns)
## merging train and test datasets
dataset <- rbind(train_columns, test_columns)  ##merging datasets
##subsetting columns
valid_column_names <- make.names(names=names(dataset), unique=TRUE, allow_ = TRUE) ## to generate valid column names
names(dataset) <- valid_column_names
dataset2 <- select(dataset, matches("Activity|Subject|mean|std", ignore.case = TRUE)) ## only mean and std values
str(dataset2)
##arrange new dataset according to Subject
dataset2 <- arrange(dataset2, Subject)
## adjusting the activity labels
activ <- c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING", "STANDING","LAYING") ##creating lables vector
act_labels = factor(activ,levels=c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING", "STANDING","LAYING"))
summary(act_labels)
act<-dataset2$Activity
head(act)
Activity<- act_labels[act]
tail(Activity)
dataset2$Activity <- Activity
##creating a tidy dataset
names(dataset2)
tidy_dat <- ddply(dataset2, c("Subject","Activity"), numcolwise(mean))
write.table(tidy_dat, "./tidy data.txt", sep=" ", row.name=FALSE)


