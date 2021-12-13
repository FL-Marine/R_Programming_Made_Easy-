# Import Dataset ----
titanic <- read.csv("~/R Projects/R Programming Made Easy - Dave Langer/R_Programming_Made_Easy-/TitanicTrain.csv")

# Inspect the structure of the data frame ----
str(titanic)

# opens the help console displaying documentation about a function
?str

# Inspecting using tables ----
# opens the help console displaying documentation about a function
?table

# Use table function to get survival counts
table(titanic$Survived)
# 342 out of 891 passengers survived
# 0 = FALSE, 1 = TRUE

# help documentation for the prop.table function
?prop.table

# Getting a percentage of passenger survival rate
prop.table(table(titanic$Survived))
# Approximately 38.38% of the passengers survived.

# Passengers by Pclass ----
table(titanic$Pclass)

prop.table(table(titanic$Pclass))

# Passengers by Sex ----
table(titanic$Sex)

prop.table(table(titanic$Sex))

# Factors ----
# The following aren't really integers they are categorical
# Categories are best shown as factors 

?as.factor
titanic$Survived <- as.factor(titanic$Survived)

titanic$Pclass <- as.factor(titanic$Pclass)

titanic$Sex <- as.factor(titanic$Sex)

# Inspecting updated data frame structure ----
str(titanic)

# What factor(s) are disproportionately associated with survival? ----

## Data is saying ----
# 1. 38.4% passenger survival rate
# 2. Most passengers were male 64.76%
# 3. Over half 55.11% of passengers traveled in 3rd class

# Exploring data by Pclass ----

# Creating logical filtering vector for 1st class passengers
first_index <- titanic$Pclass == "1"
table(first_index)

## Creating new data frame ----
titanic_first <- titanic[first_index,]
View(titanic_first)

## First class survival rate ----
prop.table(table(titanic_first$Survived))
# 63%

## male vs female in 1st class ----
prop.table(table(titanic_first$Sex))
# Slightly more females in 1st class compared to the overall proportion

## Creating logical filtering vector for 1st class females ----
first_female_index <- titanic_first$Sex == "female"

## 1st class female survival rate ----
prop.table(table(titanic_first$Survived[first_female_index]))
# 97% of 1st class females survived

## Survival rate 1st class males ----
prop.table(table(titanic_first$Survived[!first_female_index]))
# ! is logical NOT operator
# Instead of recreating a first_male_index the NOT operator was used
# Survival rate was 36%

# 1st class passengers insights ----

# 1. Females in 1st class are slightly overrepresented (43.42%) compared to passengers all up (35.24%).
# 2. Females in 1st class overwhelmingly survived (96.81%)
# 3. Males in 1st class had a slightly worse survival rate (36.89%) compared to passengers all up (38.38%)

# 2nd class passenger analysis ----

## Logical filtering vector 2nd class passengers ----
second_index <- titanic$Pclass == "2"
table(second_index)
View(second_index)
# Only 184 of total passengers were 2nd class

## New 2nd class data frame ----
titanic_second <-titanic[second_index,]
View(titanic_second)

## 2nd class survival rate ----
prop.table(table(titanic_second$Survived))
# 47% survival rate

## 2nd class male vs female proportion ----
prop.table(table(titanic_second$Sex))
#female 41%
#male 58%

## Logical vector 2nd class females ----
second_female_index <- titanic_second$Sex == "female"

## Survival rate 2nd class females ----
prop.table(table(titanic_second$Survived[second_female_index]))
# 2nd class female survival rate 92%

## 2nd class male survival rate
prop.table(table(titanic_second$Survived[!second_female_index]))
# 15% survival rate among 2nd class males

# 2nd class passengers insights ----
# 1. Females in 2nd class make up 41% compared to the rest of passengers
# 2. Females in 2nd class had a 92% survival rate
# 3. Males in 2nd class had a survival rate of only 15%

# 3rd class passenger insights ----

## Logical filtering vector 3rd class passengers ----
third_index <- titanic$Pclass == "3"
table(third_index)
View(third_index)
# Also half of  total passengers were 3rd class, qty 491

## New 3rd class data frame ----
titanic_third <-titanic[third_index,]
View(titanic_third)

## 3rd class survival rate ----
prop.table(table(titanic_third$Survived))
# 24% survival rate

## 3rd class male vs female proportion ----
prop.table(table(titanic_third$Sex))
#female 29%
#male 70%

## Logical vector 3rd class females ----
third_female_index <- titanic_third$Sex == "female"

## Survival rate 3rd class females ----
prop.table(table(titanic_third$Survived[third_female_index]))
# 3rd class female survival rate 50/50 chance.

## 3rd class male survival rate
prop.table(table(titanic_third$Survived[!third_female_index]))
# 4 13.5% survival rate among 2nd class males

# 3rd class passengers insights ----
# 1. 3rd class passengers make up almost half of total passengers
# 2. Females in 3rd class had a 50/50 survival rate
# 3. Males in 3rd class had a survival rate of only 13.5%


