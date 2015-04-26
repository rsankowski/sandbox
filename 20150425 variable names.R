listOnames <- c("catiphone", "dogandroid", "dogiphone")
description <- listOnames
description <- gsub("cat", "sound of a cat ", description)
description <- gsub("dog", "sound of a dog ", description)
description <- gsub("iphone", "recorded by an iphone", description)
description <- gsub("android", "recorded by an android phone", description)
outputStrings <- paste("* ", listOnames, "\n\n", description,"\n", sep="")
write.table(outputStrings, "outline.txt", quote=FALSE, row.names = FALSE, col.names=FALSE)
outputStrings
features2 <- features [,2]
features2 <- gsub("Body", " Body ", features2, ignore.case = TRUE)
features2 <- gsub("gravity", " Gravity ", features2, ignore.case = TRUE)
features2 <- gsub("Acc", " linear acceleration ", features2, ignore.case = TRUE)
features2 <- gsub("Gyro", " angular velocity ", features2, ignore.case = TRUE)
features2 <- gsub("Mag", " magnitude ", features2, ignore.case = TRUE)
features2 <- gsub("Mean", " Mean ", features2, ignore.case = TRUE)
features2 <- gsub("std", " STD ", features2, ignore.case = TRUE)
features3 <- paste(features2, sep=""); head(features3)
features3[470]
features[555,2]
features3 = NULL
head(features)
