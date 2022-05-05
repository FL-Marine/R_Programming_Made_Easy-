
# Loading Data & Libraries ------------------------------------------------

titanic_features <- read.csv("~/R Projects/R Programming Made Easy - Dave Langer/R_Programming_Made_Easy-/TitanicFeatures.csv")

library(dplyr)
library(ggplot2)

# Changing data types to factors ------------------------------------------

# ggplot2 works best with explicit factor variables

titanic_features <- titanic_features %>% 
  mutate(Survived = as.factor(Survived),
         Pclass = as.factor(Pclass),
         Sex = as.factor(Sex),
         Embarked = as.factor(Embarked),
         Title = as.factor(Title))

str(titanic_features)
# Check the transformation by calling the str function on titanic_features


# Exploration -------------------------------------------------------------

## Age ----
titanic_has_age <- titanic_features %>% 
  filter(!is.na(Age))
# Subsetting titanic_features to only those passengers with Age values
# !is.na finds values that are not NA

ggplot(titanic_has_age) +
  theme_bw() +
  geom_boxplot(aes(x = Survived, y = Age)) +
  labs(title = "Distribution of Age by Survived")

# How “clean” is the separation of the Age distributions by Survived?
  # It seems that the separation is minimal between age of perished vs survived 

# What can be gleaned from this visualization?
  # Age ranged for non-survivors is slightly bigger then survived as shown by the larger box
  # Outliers exist for older passengers above the age of 60, 80 is the oldest person to survive
  # Between ages of 70-75 for non-survivors and around 61-63 for survivors

# What additional variables (i.e., dimensions) might make this visualization “pop”?
  # Adding Pclass to see data on non-survived vs survived based on age and class
  # Gender to determine ages of non-survived vs survived

ggplot(titanic_has_age) +
  theme_bw() +
  facet_wrap(~ Pclass) +
  geom_boxplot(aes(x = Survived, y = Age)) +
  labs(title = "Distribution of Age by Survived")

# What insights can you glean from your faceted box plot?
# Are there any area of non-overlap?
#   Overlaps exist mostly in the max age for all pclass for non-survived passengers
#   Pclass 2 the overlap is greater for survived
#   Pclass 2 Younger individuals were more likely to survive
#   Pclass 3 Had the most older passengers perish between ages of 55-75
#   Median age across classes are higher for non-survivors

ggplot(titanic_has_age) +
  theme_bw() +
  geom_histogram(aes(x = Age, fill = Survived),
                 binwidth = 5) +
  labs(y = "Passenger Count", x = "Passenger Age",
       title = "Distribution of Age by Pclass and Survived")

# Per this visualization, what is the survival rates of  children?
  # The survival rate for children seems low going from ages 0 - 15

# What bins indicate more than a 50% survival rate?
  # Bin ages 25-45

# Are there any other features that might make this visualization pop?
  # Unsure how else to make this histogram pop more, perhaps facet wrap?

ggplot(titanic_has_age) +
  theme_bw() +
  geom_histogram(aes(x = AvgFare, fill = Survived),
                 binwidth = 5) +
  labs(y = "Passenger Count", x = "AvgFare",
       title = "Histogram of AvgFare Filled by Survived")

# What insights can you glean from your visualization?
  # Passengers that spent $10-$30 were mostly likely non-survivors
  # Bulk of survivors spent $0-$55 on their tickets

ggplot(titanic_has_age) +
  theme_bw() +
  geom_point(aes(x = Age, y = AvgFare, color = Survived),
             position = "jitter") +
  labs(title = "Survived by Age and AvgFare")

# What, if any, insights are provided by the combination of Age and AvgFare?
  # Spending more on a fare indicates being in a higher Pclass which shows a higher chance of survival
  # Younger people who could not afford higher fares perished

#  Are there any clusters of points?
  # There is a cluster of big non-survived on fares $10-$20 between ages 1-40
  # Cluster of survived is greater once fares rise above $25

# Are there any outlier points?
  # 1 non-survived $50 fare < 
  # 1 survived $50 fare < 
  # 2 survived $100 fare < 

ggplot(titanic_features) + 
  theme_bw() +
  facet_wrap(~Pclass) +
  geom_bar(aes(x = Title, fill = Survived)) +
  labs(y = "Passenger Count", x = "Title",
       title = "Survivial by Pclass and Title - Counts")

# Based on the counts, where is the data “center of gravity”?
  # Miss and Mr

# By Title, which Pclass has the highest count of observations?
  # Mr acorss all 3 observations

# By Pclass, which Titles have the best survival rates?
  # Master - small male child
  # Miss - single women
  # Mrs - married women

ggplot(titanic_features) + 
  theme_bw() +
  facet_wrap(~Pclass) +
  geom_bar(aes(x = Title, fill = Survived), position = "fill") +
  labs(y = "Passenger Count", x = "Title",
       title = "Survival by Pclass and Title – Proportions")

# What insights can you glean from your visualization?
  # Master in Pclass 1 & 2 have a 100% survival rate
  # Miss's in Pclass 1 & 2 have over 90% survival rate
  # Mr has low survial rate among all Pclasses, worst being 2nd class
  # Pclass 3 has worst survival rate across all titles

titanic_third <- titanic_features %>% 
  filter(Pclass == "3")
# There are many 3rd class passengers sub-setting this data to further investigate

ggplot(titanic_third) +
  theme_bw() +
  facet_wrap(~Title) +
  geom_histogram(aes(x =TicketCount, fill = Survived),
                 binwidth = 1)+
  labs(y =  "Passenger Count",
       title = "3rd Class Survival by Title and TicketCount")

# Any patterns relating to TicketCount in terms of survival?  
  # All titles have low survival rates
  # Miss - Single woman survived more then other titles
  # Mr - had the highest rate of non-survivals

# Are these patterns Title-dependent?
  # Yes depending on the title in this Pclass 

ggplot(titanic_third) +
  theme_bw() +
  facet_wrap(~Title, scales = "free") +
  geom_histogram(aes(x = TicketCount, fill = Survived),
                 binwidth = 1) +
  labs(y = "Passenger Count", title = "3rd Class Survival by Title and TicketCount")

# In step 33, the counts of Mr. are so dominant in the bars for "3rd Class Survival by Title and TicketCount", that you can't really see the ranges well.
# I'm sure you thought this was beyond the scope of the class, but I couldn't resist researching it.
# For other students, an additional parameter to facet_wrap (scales = "free") will allow independent y axes:

# Ray Givler suggestion ^ on adding a independent y axis which gives chart in the facet a range 

titanic_third_miss_age <- titanic_third %>% 
  filter(Title == "Miss" & !is.na(Age))

# Drill-in on 3rd class passengers with the Title of Miss that have Age values 

ggplot(titanic_third_miss_age) +
  theme_bw() +
  geom_histogram(aes( x= Age, fill = Survived),
                 binwidth = 10) +
  labs(y = "Passenger Count",
       title = "3rd Class Miss Age Histogram Filled by Survived")

# Does this visualization provide any pattern(s) regarding Age and survival for the Title of Miss?
  # Single women were more likely to not survive past the age 20
  # Most survivors are considered to be younger girls to teenagers along with passengers in their 20s - 30s
  # No survivors past the age of 30

titanic_third_mr_age <- titanic_third %>% 
  filter(Title == "Mr" & !is.na(Age))
# Drill-in on 3rd class passengers with the Title of Mr that have Age values 

ggplot(titanic_third_mr_age) +
  theme_bw() +
  geom_histogram(aes( x= Age, fill = Survived),
                 binwidth = 10) +
  labs(y = "Passenger Count",
       title = "3rd Class Mr Age Histogram Filled by Survived")

# What insights does your visualization provide?
  # Survivor age range consists of passengers in their 20s-40s
  # Highest count of survivors seem to be at age 30 with count of >= 10

