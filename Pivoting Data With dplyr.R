# Introducing dplyr ----
# Is about of tidyverse library
# dplyr provides a "grammar of data manipulation 
# dplyr provides functions for working with entire tables of data
# Similar to SQL
# Allows for "data wrangling"

## Functions ----
### mutate - adds columns, perform vector based operations ----

### select - pick columns by names ----

### filter - pick rows by logical conditions ----

### group_by - combine rows of data ----

### summarize - single calculation from a group of values ----

### _join - creates new tables by combing 2 + tables ----

### arrange - order rows ----

# Tibble ----
## tidyverse version of dataframe ----
## tibble is a type of dataframe w/ additional functionality----
## If there is a problem with tibble convert to dataframe using as.data.frame ----

# Mutating Data ----

# Creating new columns = mutating

# Mutate functions performs vector-based operations

## mutating example ----
library(dplyr)

iris_data <- read.csv("~/R Projects/R Programming Made Easy - Dave Langer/R_Programming_Made_Easy-/iris.csv")

iris_data <- iris_data %>% 
# %>% is a pipe which builds pipelines of data wrangling from one to the next
# taking iris_data, then piping to mutate 
mutate(My.Feature = Petal.Length / Petal.Width)
# creating a 6th column My.Feature

# dont need to use $ to call column names in dplyr

# Vectorize Data ----

# Need to use calculations and function calls that produce back vectors of values

# Example vector mathematics, is.na function & substr function
# All returns vector data ^

## substr function is way of extracting substrings of chr data----

## mutuate function doesn't recycle vectors ----

# if # of values does not match # of rows error will be result
iris_data <-  iris_data %>% 
  mutate(My.Feature1 = Petal.Length / Petal.Width,
         My.Feature2 = is.na(Petal.Width),
         My.Feature3 = rep(c("A", "B", "C"), 50))
# workaround is using replicate function rep 3 values 50x 

## rep function(replicate) ----
### base R has vector recycling ----
### dplyr doesn't have vector recycling need to explicit right # of elements in mutate column----

iris_data <-  iris_data %>% 
  mutate(My.Feature1 = Petal.Length / Petal.Width,
         My.Feature2 = is.na(Petal.Width), #returns missing values, returns TRUE OR FALSE
         My.Feature3 = substr(Species, 1, 3)) # returns 1st 3 characters for all 150 values related to species

# Grab dataframe, pipe into function, mutate, adding 3 new columns of data to df
# Mutating original df

# Selecting and Filtering Data ----

## Selecting Data ----
my_iris1 <- iris_data %>% 
  select(Petal.Length, Petal.Width, Species)
# Calling iris df piping into my_iris1, selecting these 3 columns

### Selecting data with minus - sign ----
my_iris2 <- iris_data %>% 
  select(-Sepal.Length, - Sepal.Width)
# - sign means select everything but these columns
# take iris_data df pipe into my_iris2 and give everything but -Sepal.Length, - Sepal.Width

## Select helper functions ----

### starts_with ----
my_iris3 <-  iris_data %>% 
  select(starts_with("sep"))
# Selects any columns that start only with "sep"
# case insentivity parameter
# can change if want

### ends_with ----
my_iris4 <-  iris_data %>% 
  select(ends_with("dth"))
# Selects columns that end with "dth"
# same rules apply as starts_width just with ending words
# only 2 end in dth

### contains ----
my_iris5 <-  iris_data %>% 
  select(contains("s"))
# select columns that contain only letter S whether lower or upper case

# Most business data has trends in naming conventions these last 3 functions are super helpful----

### between and including ----
my_iris6 <-  iris_data %>% 
  select(Petal.Length:Species)
# take iris_data store in my_iris6 pipe
# Grabs columns between Petal.Length & Species

# Filtering Data ----
# Pretty much same as base

my_iris <- iris_data %>% 
  filter(Species == "setosa") %>% 
# filter function defines what rows going to KEEP in data.keeps specices only = to setosa
select(-Sepal.Length, -Sepal.Width)
# pipe over to select function and give all columns except -Sepal.Length, -Sepal.Width

## filter example 2 ----
another_iris <- iris_data %>% 
  filter(Petal.Length >= 0.5 &
           Petal.Width >= 0.5) %>% 
select(-Sepal.Length, -Sepal.Width)
# same thing as above only with length & width less than or = to 0.5 then select everything put-Sepal.Length, -Sepal.Width 

last_iris <- iris_data %>% 
  filter((Petal.Length >= 0.5 &
           Petal.Width >= 0.5) |
           (Sepal.Length <= 5.0 &
              Sepal.Width <= 5.0))
# same thing but selecting all the columns by name and various operators


# Exercise #6 - Basic dplyr -----------------------------------------------

library(dplyr)
iris_data <- read.csv("~/R Projects/R Programming Made Easy - Dave Langer/R_Programming_Made_Easy-/iris.csv")

my_iris <- iris_data %>% 
  mutate(Species = as.factor(Species)) %>% 
  mutate(My.Feature1 = Sepal.Length / Sepal.Width, 
         My.Feature2 = Petal.Length / Petal.Width,
         My.Feature3 = Sepal.Length / Petal.Length,
         My.Feature4 = Sepal.Width / Petal.Width)
# Taking iris_data df 
# Mutating Species as factor since it is a category 
# Create new feature and then store in new df my_iris

#Checking structure of new data frame
str(my_iris)


## Sub-setting data ---------------------------------------------------------

setosa_data <- my_iris %>% 
  filter(Species == "setosa") %>% 
  select(starts_with("my."))
# Sub-setting newly created my_iris df
# Filtering to see setosa species 
# Selecting the new columns that start with my.

# Summary stats of setosa_data
summary(setosa_data)

summary(my_iris %>% filter(Species == "versicolor") %>% select(starts_with("my.")))
# Getting summary of my.features for only versicolor


summary(my_iris %>% filter(Species == "virginica") %>% select(starts_with("my.")))
# Same thing but for virginica


### Analysis & Rules ----------------------------------------------------

# Example look at My.Feature4
# 1. My.Feature4 Min value is 5.833
# 2. Compare same feature 4 setosa has a bigger min then the max of versicolor and virginica
# 3. Now there is a rule or pattern if flower has my.feature4 > 4 then it predicate it is a setosa, no other species is close to 4

# My.Feature3 has least overlap between flowers

feature_explore <- my_iris %>% 
  filter(My.Feature3 < 2.526 & My.Feature3 >= 1.176)
# From setosa_data only giving values less then 2.526 rule has been established above that any flower greater then 4 is setosa

prop.table(table(feature_explore$Species))
# Testing to see if rule worked


# Grouping & Summarizing Data ---------------------------------------------

# Excel uses pivot table to group and summarize data

library(dplyr)

iris_data <- read.csv("~/R Projects/R Programming Made Easy - Dave Langer/R_Programming_Made_Easy-/iris.csv")

iris_pivot <- iris_data %>% 
  mutate(Species = as.factor(Species)) %>% 
  group_by(Species) %>% 
  summarize(Mean.Sepal.Length = mean(Sepal.Length),
            Mean.Sepal.Width = mean(Sepal.Width),
            Mean.Petal.Length = mean(Petal.Length),
            Mean.Petal.Width = mean(Petal.Width))
# Grab iris_data pipe into mutate to change Species into factor since it is a category not a chr
# Group_by Species is the same as excel pivot table
# pipe into summarize which will calculate what was in group_by
# Takes the calculation into new df


## group_by function -------------------------------------------------------

# Can be used with numeric, character, and factor data types
# Can you multiple columns for grouping

### WHEN USING NUMERIC DATA, GROUP_BY USES EVERY DISTINCT NUMERIC VALUE, DONT REALLY GROUP BY NUMERIC VALUES ----

# grouping by 2 variables instead of 1
iris_pivot <- iris_data %>% 
  mutate(Species = as.factor(Species),
         Sub.Group = rep(c("A", "B"), 75)) %>% 
  group_by(Species, Sub.Group) %>% 
  summarize(Mean.Sepal.Length = mean(Sepal.Length),
            Mean.Sepal.Width = mean(Sepal.Width),
            Mean.Petal.Length = mean(Petal.Length),
            Mean.Petal.Width = mean(Petal.Width))

# grouping by numeric
petal.pivot <- iris_data %>% 
  group_by(Petal.Width) %>% 
  summarize(Mean.Sepal.Length = mean(Sepal.Length))
# Going to find each distinct value of Petal.Width
# Pipe into summarize and then calculate the mean of Sepal.Length
# Finding the distinct value and then calculating the mean
# DONT GROUP_BY NUMBERIC #'S


# Summarize Function ------------------------------------------------------

# summarize function performs calculations based on groupings defined by group_by

# Want single value produced per grouping

## summarize with ifelse function ----

iris_pivot <- iris_data %>% 
  mutate(Species = as.factor(Species)) %>% 
  group_by(Species) %>% 
  summarize(Max.Petal.Width = max(Petal.Width),
            Big.Petal.Width = ifelse(max(Petal.Width) >= 1.8, TRUE, FALSE))
# Same thing with converting species to factor as before
# group_by species create 3 groups aka the flowers in this dataset
# For each group give the max petal width
# Making Big.Petal.Width column will return a TRUE/FALSE based on if the max of petal width is greater than or equal to 1.8


# Joining Data ------------------------------------------------------------

# Take multiple data frame and join into various ways

# Excel example - vlookup is essentially join condition left and right table. 

# All rows from left tables are preserved. No value or can't find result will be N/A not to be confused with SQL join just a different way to think about it.


## Left Joins in dplyr - Part 1 --------------------------------------------

# left_join function implements left join functionality

library(dplyr)

iris_data <- read.csv("~/R Projects/R Programming Made Easy - Dave Langer/R_Programming_Made_Easy-/iris.csv")

iris_stats <- iris_data %>%
  mutate(Species = as.factor(Species)) %>%
  group_by(Species) %>%
  summarize(Mean.Petal.Width = mean(Petal.Width))

# Code below is from previous examples Dave skipped the slide with iris_data
# iris_pivot <- iris_data %>% 
#   mutate(Species = as.factor(Species)) %>% 
#   group_by(Species) %>% 
#   summarize(Mean.Sepal.Length = mean(Sepal.Length),
#             Mean.Sepal.Width = mean(Sepal.Width),
#             Mean.Petal.Length = mean(Petal.Length),
#             Mean.Petal.Width = mean(Petal.Width))

new_iris_data <- iris_data %>% 
  left_join(iris_stats, by = "Species")
# NO match shows NA from right table.



## Joining Data in Excel - Part 2 ------------------------------------------

# Excel vlookups does not handle multiple values in the right table

# left_join always preserves data from left table

# This is not common when working with table based joining functions in R, SQL, Python, almost any tool.

# vlookup only uses FIRST MATCH from right table if there are 2 setosas with different values the first one will be used.

# The left_join function matches on every join condition value in both left table and right table.

# left_join matches 50 left table setosas to each of the 2 right table setosas, essentially doubling

### Inner_join ----

# Works like left join only 1 exception

# inner_join function returns matches on the join condition between both tables.

# No match for data between both tables means data will not be preserved.

#### Multiple join conditions ----
new_table <- left_table %>% 
  inner_join(right_table, by = c("FirstCategory" = "FirstCategory",
                                 "SecondCategory" = "SecondCategory"))


# Arranging Data ----------------------------------------------------------

# Sorting data in R is called arranging

# In dplyr combination of arrange and desc functions makes sorting data easy

# In excel using the sort option/multi-level sort

# R code to use sort data
library(dplyr)

iris_data <- read.csv("~/R Projects/R Programming Made Easy - Dave Langer/R_Programming_Made_Easy-/iris.csv")

my_iris <- iris_data %>% 
  arrange(desc(Petal.Width), Sepal.Width)
View(my_iris)
# Ascending order is the default, when descending is required used desc

# Exercise # 7 - More dplyr -----------------------------------------------

# Exercise focus 
# 1. Working with group_by & summarize
# 2. Working with dplyr joins

library(dplyr)

iris_data <- read.csv("~/R Projects/R Programming Made Easy - Dave Langer/R_Programming_Made_Easy-/iris.csv")
View(iris_data)

# Creating summary df grouped by species

iris_summary <- iris_data %>% 
  mutate(Species = as.factor(Species)) %>% 
  group_by(Species) %>% 
  summarize(Mean.Sepal.Length = mean(Sepal.Length),
            Mean.Sepal.Width = mean(Sepal.Width),
            Mean.Petal.Length = mean(Petal.Length),
            Mean.Petal.Width = mean(Petal.Width)) %>% 
  arrange(desc(Mean.Petal.Width))
View(iris_summary)

# Storing result of join

my_iris1 <-  iris_data %>% 
  left_join(iris_summary, by = "Species")
View(my_iris1)
str(my_iris1)
# iris_data is left table because of left join
# Everything in left table is preserved 
# iris_summary is right table
# Joining condition is Species since both tables have that in common

# Iris summary df with dummy/made up data

iris_sum_dummy <- data.frame(Species = c("setosa", "rose"), 
                             Mean.Sepal.Length = c(0.0, 0.0),
                             Mean.Sepal.Width = c(0.0, 0.0),
                             Mean.Petal.Length = c(0.0, 0.0),
                             Mean.Petal.Width = c(0.0,0.0))
View(iris_sum_dummy)

iris_sum_join <- rbind(iris_summary[2:3,], iris_sum_dummy)
View(iris_sum_join)
# No virginia, 2 setosas, and 1 rose

# left joining original df to latest dummy one
my_iris2 <- iris_data %>% 
  left_join(iris_sum_join, by = "Species")
View(my_iris2)
# There is 200 records now, with 100 setosas 
# In dummy join df there are 2 setosa rows
# left join matches all 50 of original df
# 50 rows of 0 values setosa was added on
# Still keep all virginica rows but nothing to join that's why there is no values it is preserved because it is in left table aka original
# duplicate matches will produce more rows matches on 0 and non zero 


## Inner Join --------------------------------------------------------------

# Says everything on left table join to right but only KEEP WHAT MATCHES ARE FOUND

my_iris3 <- iris_data %>% 
  inner_join(iris_sum_join, by = "Species")
View(my_iris3)
# Returning 100 setosas again due to 2 rows of setosaa 
# veriscolor is in both df's
# No virginica in right table so it is not joined
# No roses are return because it doesn't match up to anything.






