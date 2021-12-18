# Dave initial examples ----

## Importing data frame using "Import Dataset under environment ----
iris_data <- read.csv("~/R Projects/R Programming Made Easy - Dave Langer/R_Programming_Made_Easy-/iris.csv")

## Viewing dataframe ----
View(iris_data)

## Looking at 1 column ----
iris_data$Petal.Width

## Looking at specified row and column range ----
iris_data[37:84, 4]

## Using sum() function on specified row and column range ----
sum(iris_data[37:84, 4])

## Showing table for specific column by name ---
table(iris_data$Species)

## Showing table for specific column by number ---
table(iris_data[, 5])
 
# Vector types ----
#double vectors are the most common numeric data type

## Creating a double vector ----
double_vector <- c(1.1, 2.2, 3.3, 4.4)
typeof(double_vector)
# ^ describes the data type

## Creating a double vector pt 2 ---- 
dbl_vector <- c(1, 2, 3, 4)
typeof(dbl_vector)

## Integer vector
# not as common as doubles
integer_vector <- c(1L, 2L, 3L, 4L)
typeof(integer_vector)

## Characters Vectors
# collection of text values R does not automatically treat character data as categories
# factor vectors are used to store categories
# if text is desired to be treated as category then must make that column a factor type
char_vector <- c("R", "rules", ",", "dude!")
typeof(char_vector)

## Creating factor vector ----
factor_vector <- factor(c("Bronze", "Silver", "Gold"))
typeof(factor_vector)

## Logical Vectors ----
# true/false
# used to filter data
# R will treat trues as 1s and falses as 0s
logical_vector <- c(TRUE, FALSE, FALSE, TRUE)
typeof(logical_vector)
# R expects values to be in CAPS

## Date/time vectors ----
date_vector <- as.Date(c("2020-01-01 13:13:13", 
                          "2020-02-01 13:13:13"))
typeof(date_vector)
#date vectors have no time component

## Including time with date ----
date_vector_2 <- as.POSIXct(c("2020-01-01 13:13:13", 
                         "2020-02-01 13:13:13"))
typeof(date_vector_2)

# Math with Vectors ----
iris_data$Petal.Avg <- (iris_data$Petal.Length + iris_data$Petal.Width) / 2

# Petal.Avg doesn't exist a $ sign makes new column
# Everything to the right of the assignment operator <- is the calculation.

## "Direct" Vector Math ----
vector_one <- c(37, 12, 44, 17, 21)
vector_two <- c(1, 2, 3, 4, 5)

vector_one + vector_two
# R lines up vector then adds up element by element

vector_one * vector_two

vector_one ^ vector_two

# If vectors are diff lengths R recycles aka starts over from the shortest
# and continues with the operation.

# Exercise # 3 - Fun with Vectors ----
double_vector_1 <- c(1.1, 2, 3.3, 4.4, 5)
double_vector_2 <- c(10, 20, 30, 40, 50)

double_vector_1 + double_vector_2

double_vector_1 * double_vector_2

double_vector_3 <- c(0, 1, 2)

double_vector_2 * double_vector_3

## char_vectors ----
char_vector_1 <- c("R", "Programming", "Made", "Easy")

length(char_vector_1)

typeof(char_vector_1)

char_vector_1

paste(char_vector_1, collapse = " ")
?paste

## factor vectors----
#factors is how R explicitly store categories 
factor_vector_1 <- factor(c("A", "B", "A", "B", "B", "C"))

length(factor_vector_1)

typeof(factor_vector_1)
#behind the scenes a factor is a integer

factor_vector_1
# output shoes Levels: A B C meaning being put in a category

table(factor_vector_1)

## logical vectors ----
logical_vector_1 <- c(TRUE, FALSE, TRUE, TRUE, FALSE, TRUE)

table(logical_vector_1)

# Can do mathematical operations on logical vectors
sum(logical_vector_1)


sum(logical_vector_1) / length(logical_vector_1)

#Filtering with Logic ----

# R has logical operators like & which is similar to Excel Logical functions
# These operators are used to build filtering vectors

setosa_index <- ifelse(iris_data$Species == "setosa", TRUE, FALSE)
# Dave uses _index as his personal preference as naming convention 
# To store filtered values can be whatever I want
# What the code is doing is checking each value of the species column
#if it is equal to "setosa" return TRUE otherwise FALSE

# This code does the same thing
setosa_index <- iris_data$Species == "setosa"

## Most used logical operators ----

# AND & 
# OR |
# NOT !

complex_index <-iris_data$Species == "setosa" & iris_data$Petal.Width == 1

complex_index <-iris_data$Species == "setosa" & (iris_data$Petal.Width == 1 | iris_data$Petal.Width == 0.2)
#to make things easier group the ORs

## IN operator ----
#%in% operator groups a bunch of OR logical conditions together

complex_index <-iris_data$Species == "setosa" & iris_data$Petal.Width %in% c(0.1, 0.2, 0.3)
# saves time writing a bunch of OR operators

filtered_iris <- iris_data[complex_index,]
# this returns all rows where rows are TRUE and all columns

# Filtering the R way ----

## 6:10 implicit vector ----
# result is 6 7 8 9 10 gives you a vector of numbers only exists for short time

## explicit vector gives you vectors filtering options by specific rows and columns
row_index <- c(6, 22, 78, 99, 127)

col_index <- c(1, 3, 5)
col_index

## Filtering with names ----
col_names <- c("Sepal.Length", "Petal.Length", "Species")
col_names

View(iris_data[row_index, col_names])

# implicit vector of string values
View(iris_data[row_index, c("Sepal.Length", "Petal.Length", "Species")])

## Direct logic filtering ----
View(iris_data[iris_data$Petal.Width <= 0.5,])
#Viewing Petal.Width column with values only of less than or equal to 0.5
#49 entries are the results ^

View(iris_data[iris_data$Petal.Width <= 0.5 & iris_data$Species != "setosa",])
# result is Petal.Width where it is less than 0.5 & Species is not equal to setosa

# More logic in code makes it ugly dplyr makes it much more elegant. 

# Exercise # 4 - More Tables ----
#explore dataset
head(iris_data)

#more data how many lines I want
head(iris_data, n = 10)

#check structure of object/dataframe
?str

str(iris_data)
# list column and row features 
#species is factor not a character because it is a category/labels

iris_data$Species <- as.factor(iris_data$Species)
#species column should no longer be what it currently is. Overwrite with something new.
#creating a new factor

#checking structure again
str(iris_data)
#species is now a factor w/ 3 levels

#subset df to setosa flower type to check all values if match to setosa by showing TRUE/FALSE
setosa_index <- iris_data$Species == "setosa"
#no matter id datatype is chr or factor use == 
table(setosa_index)

#subset new df
setosa_data <- iris_data[setosa_index,]
#go to iris_data df access using [] only give me rows where setosa_index is true and all columns

versicolor_data <- iris_data[iris_data$Species == "versicolor",]
# same thing just with versicolor

#mean
mean(setosa_data[, 4])
mean(versicolor_data[, "Petal.Width"])
mean(iris_data$Petal.Width[iris_data$Species == "virginica"])

# Missing data ----
#R incorporates missing data using value of NA
#Missing value commonly occur when importing data into R e.g. from csv files

my_vector <- c(33.2, 6, 44.2, NA, 3, 17.9, 5)
my_vector

## Check missing values ----
is.na(my_vector)

## remove missing values ----
sum(my_vector, na.rm = TRUE)
#na.rm removes NA's
 
# Common stats functions ----

# excel stats functions are the same in R

## min ----
min(iris_data$Petal.Width)

## mean ----
mean(iris_data$Petal.Width)

## median ----
median(iris_data$Petal.Width)

## max ----
max(iris_data$Petal.Width)

## quantile 25% ----
quantile(iris_data$Petal.Width, 0.25)

## quantile 75% ----
quantile(iris_data$Petal.Width, 0.75)

## IQR interquantile range ----
IQR(iris_data$Petal.Width) 
# is the difference between the previous 2 quantiles

## standard deviation ----
sd(iris_data$Petal.Width)

# Summary Function ----
# Calculates summary statistics
summary(iris_data)

## Changes to fit what is being passed thru ----
iris_data$Species <- as.factor(iris_data$Species)
summary(iris_data)

## Change be used to tell if you have missing values ----
num_vector <- c(33.3, 44.4, 55.5, NA, 6.66, 7.77, NA)
num_vector
summary(num_vector)

# The data.frame function ----
# Step 1 need some vectors

my_df <- data.frame(vector_one, vector_two, char_vector_1)
str(my_df)
# Can make using explicit vectors

# or can name them differently
my_df <- data.frame(Vector.One = vector_one, vector.Two = vector_two, Vector.Three = vector_three)
str(my_df)

# summary function for building own data frame returns only 6 factor levels and a 7th bucketing the rest due to default settings
# can use the following to show more factor levels
summary(my_df, maxsum = 10)

# The cbind and rbind Functions ----
# Use these to mix and match data from different data frames

## cbind function ----
# To combine objects column- wise use cbind function
#cbind is most often used in conjunction with data frames
vector_one <- c("A", "B", "C")
my_iris <- cbind(iris_data, vector_one)
# creates new data frame and stored in my_iris

## rename vector name ----
my_iris <- cbind(iris_data, Vector.One =  vector_one)
# Vector.One will be the vector name

# Always use a name for vectors!

# Combine objects row-wise use rbind function ----
# This will be used in conjunction with data frames
my_iris <- cbind(iris_data, Vector.One =  vector_one)

setosa_data <- iris_data[iris_data$Species == "setosa", ]
virginica_data <- iris_data[iris_data$Species == "virginica",]

# combining these row wise
another_iris <- rbind(setosa_data, virginica_data)

## When using rbind data types and order matter ----
#  number of columns and data types must match for code to run

## R coercion rules ----
# logicals TRUE = 1 FALSE = 0
# rbind coerces a numeric into chr if one is different from the other
# factors are coerced into chrs
# chr are coerced into factors 
# logical goes straight to chr

# The Aggregate Function ----

# Aggregation of data is one of the most common tasks in R

# R aggregate function has the ability to perform pivot table like calculations over groups of data

## Aggregate function 3 pieces of information ----

# 1. Formula that specifies the features to use for calculations and grouping
# 2. Data frame that contains the specified features
# 3. The calculation to perform

aggregate(Petal.Width ~ Species, iris_data, sum)

# aggregate is formula
# formula is Petal.Width ~ Species ~ is to be considered like English word by
# everything to the right of ~ is considered grouping variables typically strings or factor variables
# aggregating Petal.Width BY species
# data frame is iris_data 
# sum is calculation

## Aggregate Formulas ----

# Using formulas can specify multiple features for groupings and calculations
aggregate(cbind(Sepal.Length, Sepal.Width, Petal.Length, Petal.Width) ~ Species, iris_data, sum)
# use cbind function for multiple feature calculations
# whats going on is getting the aggregation of columns (combination of numeric vectors) grouped by Species
# using multiple numeric columns in a data frame with aggregate function by cbind them together

## More examples----

### mean ----
aggregate(cbind(Sepal.Length, Sepal.Width, Petal.Length, Petal.Width) ~ Species, iris_data, mean)
#swap out sum with mean

# Multiple different feature calculations are not possible in R only 1 calculation at a time
# Multiple columns are good to go
# dplyr will help with this issue

### count ----
aggregate(cbind(Sepal.Length, Sepal.Width, Petal.Length, Petal.Width) ~ Species, iris_data, FUN = length)

#### Subgroup example ----
iris_data$Sub.Group <- rep(c("A", "B", "C"), 50)
# create this vector of A, B, C and replicate it 50 times because their is 150 values which will give 150 rows
?rep
# rep() replicates values in x

aggregate(cbind(Sepal.Length, Sepal.Width, Petal.Length, Petal.Width) ~ Species + Sub.Group , iris_data, sum)
# made another sub group
# can use multiple grouping features by using the + symbol
# pivot all of these columns ^ by Species and subgroup

# Exercise # 5 - Some functions ----
# change species into a category because factors are categories
iris_data$Species <-  as.factor(iris_data$Species)
# verify structure was changed
str(iris_data)
#summary of data 
summary(iris_data)

# summary of data frame but not of all rows just setosas
summary(iris_data[iris$Species == "setosa",])
# species is now factor variable can confirm only getting 50 setosas

# same thing but for versicolor
summary(iris_data[iris$Species == "versicolor",])
# only get versicolor

# same thing but for virginica
summary(iris_data[iris$Species == "virginica",])

## Aggregate function practice ----
### mean ----
aggregate(cbind(Sepal.Length, Sepal.Width, Petal.Length, Petal.Width) ~ Species, iris_data, mean)
# running an aggregation over all these columns grouped by species 

### median ----
aggregate(cbind(Sepal.Length, Sepal.Width, Petal.Length, Petal.Width) ~ Species, iris_data, median)
# median is dead center of IQR
# median is 50%

### IQR ----
aggregate(cbind(Sepal.Length, Sepal.Width, Petal.Length, Petal.Width) ~ Species, iris_data, IQR)
# IQR wraps median
# IQR goes from 25% up to 75% tiles

# Create new columns of data ----

## creating new ratio of petal length/ petal width
my_feature <- iris_data$Petal.Length / iris_data$Petal.Width
# store result in my_feature

## New data frame with manufactured feature ----
my_iris <- cbind(iris_data, My.Feature = my_feature)
# added the My.Feature column to the my_iris data frame
str(my_iris)
summary(my_iris)

## Aggregate new column ----
aggregate(My.Feature ~ Species, my_iris, mean)

## median new column ----
aggregate(My.Feature ~ Species, my_iris, median)
# median is in middle of IQR

# IQR new column ----
aggregate(My.Feature ~ Species, my_iris, IQR)
