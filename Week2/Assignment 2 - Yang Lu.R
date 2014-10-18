# Lecture 2 assignment

# 1. Using R Data Preparation
# 1.a. Get Indian Liver Patient Dataset
url <- "http://archive.ics.uci.edu/ml/machine-learning-databases/00225/Indian%20Liver%20Patient%20Dataset%20(ILPD).csv"

ILPD <- read.csv(url, header=FALSE, stringsAsFactors=FALSE)

# 1.b. Get the column headers
colnames(ILPD)

# 1.c. Manually construct a vector of columns
headers <- c("Age", "Gender", "TB", "DB", "AAP", "Sgpt", "Sgot", "TP", "ALB", "A/G", "Selector field")

# 1.d. Associate names with the dataframe
names(ILPD) <- headers

# 2. Using R Data Exploration on ILPD
# 2.a. Use head(ILPD) to view the first 6 rows.
head(ILPD)

# 2.b. Determine the mean, median, and standard deviation (sd) of each column.
# Remove Gender and Selector field columns for mean, median, and sd calculation.
ILPDSubset <- subset(ILPD, select = -2)
ILPDSubset <- subset(ILPDSubset, select = -10)

# Remove the N/A values and get mean, median, and sd.
sapply(ILPDSubset, mean, na.rm = TRUE)
sapply(ILPDSubset, median, na.rm = TRUE)
sapply(ILPDSubset, sd, na.rm = TRUE)

# 2.c What does na.rm = TRUE do in sd(x, na.rm = TRUE)?
# Answer: It ignores N/A values when it applies sd function.

# 2.d Create Histograms (hist) for each column where possible
hist(ILPD$"Age", col=rgb(0,1,0,.5))
hist(ILPD$"TB", col=rgb(0,1,0,.5))
hist(ILPD$"DB", col=rgb(0,1,0,.5))
hist(ILPD$"AAP", col=rgb(0,1,0,.5))
hist(ILPD$"Sgpt", col=rgb(0,1,0,.5))
hist(ILPD$"Sgot", col=rgb(0,1,0,.5))
hist(ILPD$"TP", col=rgb(0,1,0,.5))
hist(ILPD$"ALB", col=rgb(0,1,0,.5))
hist(ILPD$"A/G", col=rgb(0,1,0,.5))
hist(ILPD$"Selector field", col=rgb(0,1,0,.5))

# 2.e Use the plot(ILPD) function on this data frame to present a general overview of the data.
# Since gender is not numeric, so I will generate the plots on the subset of ILPD, which has
# Gender column removed.
plot(ILPDSubset)

# 2.e.a What can you say about the data?
# From the plots, I can see there are a lot correlations in the data.

# 2.e.b How can you tell if a vector contains continuous numbers or binary data?
# if the vecotor contains binary data, it will show the dots on two distict lines on the plot. The two lines
# are either horizontal or vertical.

# 2.3.c How can you tell if two vectors are correlated?
# If two vectors are correlated, the dots will form a diagonal in the plot. the line is more straight and thiner,
# the correlation is stronger. For example, TB and DB seem to be strongly correlated. TP and ALB are somehow
# correlated. Age and ALB seem not correlated.

# 3. Using Data Preparation concepts Create examples of the following data preparation processes in R
# 3.a Remove Outliers: c(-1, 1, 5, 1, 1, 17, -3, 1, 1, 3)
x <- c(-1, 1, 5, 1, 1, 17, -3, 1, 1, 3)
highLimit <- mean(x) + 2*sd(x)
lowLimit <- mean(x) - 2*sd(x)
goodFlag <- (x < highLimit) & (x > lowLimit)
x <- x[goodFlag]
x

# 3.b Relabel: c('BS', 'MS', 'PhD', 'HS', 'Bachelors', 'Masters', 'High School', 'BS', 'MS', 'MS')
x <- c('BS', 'MS', 'PhD', 'HS', 'Bachelors', 'Masters', 'High School', 'BS', 'MS', 'MS')
x[x == "High School"] <- "HS"
x[x == "Bachelors"] <- "BS"
x[x == "Masters"] <- "MS"
x

# 3.c Normalize: c(-1, 1, 5, 1, 1, 17, -3, 1, 1, 3)
# 3.c.a Min-Max Normalization
x <- c(-1, 1, 5, 1, 1, 17, -3, 1, 1, 3)
a <- min(x)
b <- max(x) - min(x)
normalized <- (x - a) / b
normalized

# 3.c.b Z-score normalization
a <- mean(x)
b <- sd(x)
normalized <- (x - a) / b
normalized

#3.d Binarize: c('Red', 'Green', 'Blue', 'Blue', 'Blue', 'Blue', 'Blue', 'Red', 'Green', 'Blue')
x <- c('Red', 'Green', 'Blue', 'Blue', 'Blue', 'Blue', 'Blue', 'Red', 'Green', 'Blue')
isRed <- x == "Red"
isGreen <- x == "Green"
isBlue <- x == "Blue"
x

#3.e Discretize: c(3, 4, 4, 5, 5, 5, 5, 5, 5, 5, 5, 6, 6, 6, 6, 6, 7, 7, 7, 7, 8, 8, 9, 12, 23, 23, 25, 81)
x <- c(3, 4, 4, 5, 5, 5, 5, 5, 5, 5, 5, 6, 6, 6, 6, 6, 7, 7, 7, 7, 8, 8, 9, 12, 23, 23, 25, 81)

# 3.3.a 3 Bins of equal range
range <- max(x) - min(x)
binWidth <- range / 3
bin1Min <- -Inf
bin1Max <- min(x) + binWidth
bin2Max <- min(x) + 2*binWidth
bin3Max <- Inf
xDiscretized <- rep(NA, length(x))
xDiscretized
xDiscretized[bin1Min < x & x <= bin1Max] <- "Samll"
xDiscretized[bin1Max < x & x <= bin2Max] <- "Medium"
xDiscretized[bin2Max < x & x <= bin3Max] <- "Big"
xDiscretized


# 3.3.b 3 Bins Equal of near equal amounts
amount <- length(x) / 3
bin1 <- x[1:amount]
bin2 <- x[(amount+1):(2*amount)]
bin3 <- x[(2*amount+1):(length(x)+1)]
bin1
bin2
bin3
