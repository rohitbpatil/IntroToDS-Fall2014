# Assignment 2, Intro to Data Science

library(dplyr)    # I've been trying to learn dplyr, so even though it's
                  # a bit heavyweight for some of these tasks, I've used
                  # it to practice.

library(ggplot2)  # I'll be using ggplot2 for similar reasons!

# Question 1

# Get the patient data and add the correct headers

url <- "http://archive.ics.uci.edu/ml/machine-learning-databases/00225/
        Indian%20Liver%20Patient%20Dataset%20(ILPD).csv"
ILPD <- read.csv(url, header=FALSE, stringsAsFactors=FALSE)
headers <- c("Age", "Gender", "TB", "DB", "Alkphos", "Sgpt", "Sgot", 
             "TP", "ALB", "AG_Ratio", "Selector")
names(ILPD) <- headers

ILPD <- tbl_df(ILPD) # Convert to a dplyr dataframe

# Question 2

# Report mean, median and standard deviation of each column
# I have ignored Gender and Selector here

head(ILPD)
ILPD %>% summarise_each(funs(mean(., na.rm=TRUE)), Age, TB, DB, Alkphos,
                        Sgpt, Sgot, TP, ALB, AG_Ratio)

ILPD %>% summarise_each(funs(median(., na.rm=TRUE)), Age, TB, DB, Alkphos,
                        Sgpt, Sgot, TP, ALB, AG_Ratio)

ILPD %>% summarise_each(funs(sd(., na.rm=TRUE)), Age, TB, DB, Alkphos,
                        Sgpt, Sgot, TP, ALB, AG_Ratio)

# na.rm=TRUE removes NA values before computing the standard deviation

# Create histograms for the columns where it makes sense
# I think it makes sense for all columns, as using ggplot2
# we can get bar charts for discrete variables like gender
# and Selector

qplot(Age, data=ILPD, geom="histogram")
qplot(Gender, data=ILPD, geom="histogram")
qplot(TB, data=ILPD, geom="histogram")
qplot(DB, data=ILPD, geom="histogram")
qplot(Alkphos, data=ILPD, geom="histogram")
qplot(Sgpt, data=ILPD, geom="histogram")
qplot(Sgot, data=ILPD, geom="histogram")
qplot(TP, data=ILPD, geom="histogram")
qplot(ALB, data=ILPD, geom="histogram")
qplot(AG_Ratio, data=ILPD, geom="histogram")
qplot(Selector, data=ILPD, geom="histogram")

# Use the plot function to get an overview of the data
# To do this we need to change Gender
ILPD_Gender_Binary <- mutate(ILPD, Gender = Gender=="Male")
head(ILPD_Gender_Binary)  # Checking whether it worked

plot(ILPD_Gender_Binary)  # I used the plot function because I couldn't
                          # find a ggplot2 alternative. Do you know any?


# What can you say about the data? 
# We can see various correlations in the data, some stronger than others. 
# TB and DB, for example, are strongly correlated, while ALB and age 
# seem uncorrelated, for example

# How can you tell if a vector contains continuous numbers or binary data? 
# It is clear from the graph that when there are two distinct lines
# we have a binary variable.

# How can you tell if two vectors are correlated?
# When the points form a straight line we can see linear correlation.

# Question 3

# Remove outliers:
x <- c(-1, 1, 5, 1, 1, 17, -3, 1, 1, 3)
highLimit <- mean(x) + 2*sd(x)
lowLimit <- mean(x) - 2*sd(x)
withinLimits <- (x < highLimit) & (x > lowLimit)
x <- x[withinLimits]
x

# Relabel
x <- c('BS', 'MS', 'PhD', 'HS', 'Bachelors', 'Masters', 'High School', 
       'BS', 'MS', 'MS')
x[x == "High School"] <- "HS"
x[x == "Masters"] <- "MS"
x[x == "Bachelors"] <- "BS"
x

# Normalize
# Min-Max Normalization
x <- c(-1, 1, 5, 1, 1, 17, -3, 1, 1, 3)
a <- min(x)
b <- max(x) - min(x)
normalized <- (x - a) / b
normalized

# Z-score normalization
x <- c(-1, 1, 5, 1, 1, 17, -3, 1, 1, 3)
a <- mean(x)
b <- sd(x)
normalized <- (x - a) / b
normalized

#Binarize
x <- c('Red', 'Green', 'Blue', 'Blue', 'Blue', 'Blue', 'Blue', 'Red', 
       'Green', 'Blue')
isRed <- x == "Red"
isGreen <- x == "Green"
isBlue <- x == "Blue"

# Discretize
x <- c(3, 4, 4, 5, 5, 5, 5, 5, 5, 5, 5, 6, 6, 6, 6, 6, 7, 7, 7, 7, 
       8, 8, 9, 12, 23, 23, 25, 81)
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

# Equalise
sort(x)
number_in_bin <- length(x) / 3
number_in_bin # We need 9, 10 and 9
bin1 <- c(3, 4, 4, 5, 5, 5, 5, 5, 5)
bin2 <- c(5, 5, 6, 6, 6, 6, 6, 7, 7, 7)
bin3 <- c(7, 8, 8, 9, 12, 23, 23, 25, 81)

