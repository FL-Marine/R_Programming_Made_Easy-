# Upload Titanic df ----
titanic <- read.csv("C:/Users/abedi/Downloads/TitanicTrain.csv")
View(titanic)

## Viewing df structure ----
str(titanic)

## Summary of df ----
summary(titanic)
# Note - 177 NA values for Age column
# Focus is on Age for this lab

# Transforming columns that are character types but should be factors aka categorical data ----

## Transform the Survived column to a factor ----
titanic$Survived <- as.factor(titanic$Survived)

## Transform the Pclass column to a factor ----
titanic$Pclass <- as.factor(titanic$Pclass)

## Transform the Sex column to a factor ----
titanic$Sex <- as.factor(titanic$Sex)

## Transform the Embarked column to a factor ----
titanic$Embarked <- as.factor(titanic$Embarked)

# Confirming previous 4 changes are now factors ----
str(titanic)
summary(titanic)

# Investigating Age Columns ----

## Create logical filtering vector for people without Age values using is na.function ----
no_age_index <- is.na(titanic$Age)

## Check TRUE/FALSE count using table function ----
table(no_age_index)
# Missing values are TRUE

# Subset the titanic data set ----

## Create a subset data frame for passengers with Age values ----
titanic_has_age <- titanic[!no_age_index,]
# Notice the usage of the logical NOT operator “!”

## Create a subset data frame for passengers without Age values ----
titanic_no_age <- titanic[no_age_index,]

# What is the survival rate across the Age subsets? ----
prop.table(table(titanic_has_age$Survived))
# Passengers with age are slightly more likely to survive 40.62%

## No age passengers ----
prop.table(table(titanic_no_age$Survived))
# Passengers with no age less likely to survive 29%

# What are the Pclass rates across the Age subsets? ----
prop.table(table(titanic_has_age$Pclass))

## Passengers without Age values were more likely to be in 3rd class.----
prop.table(table(titanic_no_age$Pclass))

# What are the gender rates across the Age subsets?----
prop.table(table(titanic_has_age$Sex))
  
## Passengers without age values ----
prop.table(table(titanic_no_age$Sex))
# Less likely to be female

# Drill-in on the 1st class passengers with Age values ----

## Create a new df that is subset of 1st class passengers that have Age values ----
first_has_age <-  titanic_has_age[titanic_has_age$Pclass == "1",]

### Use first_has_age with the aggregate function ----
aggregate(Age ~Sex, first_has_age, summary)

### Aggregate Age by Survived ----
aggregate(Age ~Survived, first_has_age, summary)

# Aggregate Age by Survived + Sex ----
aggregate(Age ~Survived + Sex, first_has_age, summary)
# 1st class females that survived tended to be older, this is unexpected
# 1st class males that survived tended to be younger, as expected

# Examine surviving 1st class males with Age values using the data viewer in RStudio ----
View(first_has_age[first_has_age$Sex == "male" & first_has_age$Survived == "1",])
# Names include titles of Master, Major, Sir, Dr. These probably mean they were of "importance."
mean(first_has_age$Sex == "male" & first_has_age$Survived == "1")
# Avg age is 21 years old for males that survived in 1st class

# Examine non-surviving 1st class females with Age values using the data viewer in RStudio. ----
View(first_has_age[first_has_age$Sex == "female" & first_has_age$Survived == "0",])
# 2 of the 3 women were single
mean(first_has_age$Sex == "female" & first_has_age$Survived == "0")

# Examine all the observations where Ticket is equivalent to “113781”. ----
View(titanic[titanic$Ticket == "113781",])
# People by themselves or small children are more likely to survive.

# Analyzing 2nd class passengers ----
## Create a new df that is subset of 2nd class passengers that have Age values ----
second_has_age <-  titanic_has_age[titanic_has_age$Pclass == "2",]

### Use second_has_age with the aggregate function ----
aggregate(Age ~Sex, second_has_age, summary)
# 2nd class passengers with age are mostly even across the board

### Aggregate Age by Survived ----
aggregate(Age ~Survived, second_has_age, summary)
# Younger passengers survived 

# Aggregate Age by Survived + Sex ----
aggregate(Age ~Survived + Sex, second_has_age, summary)
# 2nd class females that survived tended to be younger, this is expected
# 2nd class males that survived tended to be younger, as expected

# Examine surviving 2nd class females with Age values using the data viewer in RStudio ----
View(second_has_age[second_has_age$Sex == "female" & second_has_age$Survived == "1",])
prop.table(table(second_has_age$Sex == "female"& second_has_age$Survived == "1"))
# 39% of 2nd class females with age survived

# Examine non-surviving 2nd class females with Age values using the data viewer in RStudio. ----
View(second_has_age[second_has_age$Sex == "female" & second_has_age$Survived == "0",])
# 50 % of women were married 
prop.table(table(second_has_age$Sex == "female"& second_has_age$Survived == "0"))
# Only 3.4% of 2nd class females with age survived

# Examine surviving 2nd class males with Age values using the data viewer in RStudio ----
View(second_has_age[second_has_age$Sex == "male" & second_has_age$Survived == "1",])
prop.table(table(second_has_age$Sex == "male"& second_has_age$Survived == "1"))
# 8.6% of males survived with age

# Examine non-surviving 2nd class males with Age values using the data viewer in RStudio. ----
View(second_has_age[second_has_age$Sex == "male" & second_has_age$Survived == "0",])
prop.table(table(second_has_age$Sex == "male"& second_has_age$Survived == "0"))
# Just under 50% of males with age survived 

# 2nd class findings ----
# 1. Younger children both sex's more likely to survive
# 2. Less than 10% of males w/o age perished 
# 3. 2nd class females without age survival % as compared to males was substantially lower 3.4 % vs 48.5%

# 3rd class survival ----

## Create a new df that is subset of 3rd class passengers that have Age values ----
third_has_age <-  titanic_has_age[titanic_has_age$Pclass == "3",]

### Use third_has_age with the aggregate function ----
aggregate(Age ~Sex, third_has_age, summary)


### Aggregate Age by Survived ----
aggregate(Age ~Survived, third_has_age, summary)
# Younger passengers survived 

# Aggregate Age by Survived + Sex ----
aggregate(Age ~Survived + Sex, third_has_age, summary)
# 3rd class females that survived tended to be younger, this is expected
# 3rd class males that survived tended to be younger, as expected

# Examine surviving 3rd class females with Age values using the data viewer in RStudio ----
View(third_has_age[third_has_age$Sex == "female" & third_has_age$Survived == "1",])
prop.table(table(third_has_age$Sex == "female"& third_has_age$Survived == "1"))
# 13% of 3rd class females with age survived

# Examine non-surviving 3rd class females with Age values using the data viewer in RStudio. ----
View(third_has_age[third_has_age$Sex == "female" & third_has_age$Survived == "0",])
# 50 % of women were married 
prop.table(table(third_has_age$Sex == "female" & third_has_age$Survived == "0"))
# Only 15% of 3rd class females with age survived

# Examine surviving 3rd class males with Age values using the data viewer in RStudio ----
View(third_has_age[third_has_age$Sex == "male" & third_has_age$Survived == "1",])
prop.table(table(third_has_age$Sex == "male" & third_has_age$Survived == "1"))
# 10% of males survived with age

# Examine non-surviving 3rd class males with Age values using the data viewer in RStudio. ----
View(third_has_age[third_has_age$Sex == "male" & third_has_age$Survived == "0",])
prop.table(table(third_has_age$Sex == "male"& third_has_age$Survived == "0"))
# 60% males 

# 3rd class findings ----
# 1. Younger males and females are more likely to survived
# 2. 13% of 3rd class females with age survived
# 3. # 10% of males survived with age
