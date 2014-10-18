# Week 2 Assignment

# Clear the objects
rm(list=ls())

# ###################################################################
# Assignement 1 Using R Data Preparation
# ###################################################################


#A.a. Set URL address to a variable
url <- "http://archive.ics.uci.edu/ml/machine-learning-databases/00225/Indian%20Liver%20Patient%20Dataset%20(ILPD).csv"

#A. b. Download dataset to ILPD object, withno headers
ILPD <- read.csv(url, header=FALSE, stringsAsFactors=FALSE)

#C Manually contstruct a vector of column names
headers<-c("Age", "Gender", "TB", "DB", "Alkhpos","Sgpt","Sgot","TP","ALB","AGRatio","Selector")

#D Associate names with Dataframes
names(ILPD)<-headers

# ###################################################################
# Assignement 2 Using R Data Exploration on ILPD
# ###################################################################

#A. View first 6 rows)
head(ILPD)

#B. Determine Mean Median and Standard Deviation for each column
# create subset with selecting variables/columns to which mean,sd,median applies
ILPDSubset=subset(ILPD,select=c(1,3,4,5,6,7,8,9,10))
sapply(ILPDSubset,mean)
sapply(ILPDSubset,median)
sapply(ILPDSubset,sd)

#C. na.rm=TRUE -- Ignores the missing value represented by NA in R. 
# Column AGRatio has NA vlaues hence sd returns NA unless na.rm is set to TRUE
#e.g.
sd(ILPD$AGRatio) # returns NA
sd(ILPD$AGRatio,na.rm=TRUE) # returns 0.3195921

#D. Create Histogram
hist(ILPD$Age)
hist(ILPD$TB)
hist(ILPD$DB)
hist(ILPD$Alkhpos)
hist(ILPD$Sgpt)
hist(ILPD$Sgot)
hist(ILPD$TP)
hist(ILPD$ALB)
hist(ILPD$AGRatio)
hist(ILPD$Selector)

# E. plot
#create ILPD Subset without Gender column as its non-numeric
ILPDSub=subset(ILPD,select=c(1,3,4,5,6,7,8,9,10,11))
plot(ILPDSub)

#E.a What can you say about data 
# From the Plot i can say in some cases there is strong correlation between the variables like between TB 
# and DB. While in some cases there is no correlation between variables like between Age and TP,ALB.

#E.b How can you say if a vector contains continous number of binary data
# Binary data in the plot would be represented ast 2 distinct lines in the graph. For e.g. All the plots 
# involving Selector field show 2 distinct parallel lines either horizontal or parallel.

#E.c How can you tell if two vectors are correlated.
# 2 Vectors can be said to be correlated if one can expressa vector say'Y' as function of 'X'. 
# On the graph plotted it would show up as straight line

# ###################################################################
# Assignement 3 Data Preparation concept
# ###################################################################

#3.A Remove outliers
x<-c(-1, 1, 5, 1, 1, 17, -3, 1, 1, 3)
#one way to identify outlier is to do a boxplot, which would data within SD and ones which are outliers
boxplot(x)
# clearly from plot we can see there is observation 17 which is extremes / outliers.
# removing outliers
upperbound <- mean(x) + 2*sd(x)
lowerbound <- mean(x) - 2*sd(x)
goodFlag <- (x < upperbound) & (x > lowerbound)
x <- x[goodFlag]
x

#3.B Relable
degree <- c('BS', 'MS', 'PhD', 'HS', 'Bachelors', 'Masters', 'High School', 'BS', 'MS', 'MS')
degree[degree == "High School"] <- "HS"
degree[degree == "Bachelors"] <- "BS"
degree[degree == "Masters"] <- "MS"
degree

#3. C Normalize
obj<-c(-1, 1, 5, 1, 1, 17, -3, 1, 1, 3)
#a. Min-Max normalize
# (the value - the minimum) / (the range of values). By this process data remains in the range 0 to 1.
objmin <- min(obj)
objrange <- max(obj) - min(obj)
normalized <- (x - objmin) / objrange
normalized

#b. Z Score normalization
objmean <- mean(obj)
objsd <- sd(obj)
normalized <- (obj - objmean) / objsd
normalized
mean(normalized) # with Z score normalization mean is always 0
sd(normalized)   # with Z score normalization SD is always 1


#3. D Binarize
objbin=c('Red', 'Green', 'Blue', 'Blue', 'Blue', 'Blue', 'Blue', 'Red', 'Green', 'Blue')
isRed <- objbin == 'Red'
isGreen <- objbin == 'Green'
isBlue <- objbin == 'Blue'
objbin

#3. E Descretize
x <- c(3, 4, 4, 5, 5, 5, 5, 5, 5, 5, 5, 6, 6, 6, 6, 6, 7, 7, 7, 7,8, 8, 9, 12, 23, 23, 25, 81)
#a. 3 bins of equal range
range <- max(x) - min(x)
binWidth <- range / 3
bin1Min <- -Inf
bin1Max <- min(x) + binWidth
bin2Max <- min(x) + 2*binWidth
bin3Max <- Inf

xDiscretized <- rep(NA, length(x))
xDiscretized
xDiscretized[bin1Min < x & x <= bin1Max] <- "Low"
xDiscretized[bin1Max < x & x <= bin2Max] <- "Medium"
xDiscretized[bin2Max < x & x <= bin3Max] <- "High"
xDiscretized

# Equalization -3 bins with nearly equal size
sort(x)
size<-length(x)/3
bin1=x[1:size]
bin2=x[(size+1):(2*size)]
bin3=x[(2*size):length(x)+1]
#verify
x
length(x)
bin1
length(bin1)
bin2
length(bin2)
bin3
length(bin3)
