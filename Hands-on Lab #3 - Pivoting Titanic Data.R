
# Import Datasets ---------------------------------------------------------

titanic_train <- read.csv("~/R Projects/R Programming Made Easy - Dave Langer/R_Programming_Made_Easy-/TitanicTrain.csv")
View(titanic_train)

titanic_test <- read.csv("~/R Projects/R Programming Made Easy - Dave Langer/R_Programming_Made_Easy-/TitanicTest.csv")
View(titanic_test)

# Loading libraries -------------------------------------------------------

library(dplyr)

# Combining datasets ------------------------------------------------------

titanic_combined <- rbind(titanic_train %>% select(-PassengerId, -Survived),
                          titanic_test %>% select(-PassengerId))
# rbind needs to have the same columns and rows, this function combines data frames by rows.

str(titanic_combined)


## Loading libraries #2 ----------------------------------------------------

library(stringr)
# The tidyverse package stringr provides functions for working with character data

# Extracting titles -------------------------------------------------------

titanic_combined <- titanic_combined %>% 
  mutate(Title = str_extract(Name, "(?<=.,\\s)(.*?)(?=\\..)"))

# stringr function str_extract and a regular expression to extract the Title feature

# Used regular expressions to make a new column of the title only

table(titanic_combined$Title)

titanic_combined <- titanic_combined %>% 
  mutate(Title = ifelse(Title %in% c("Capt", "Col", "Major"), "Mr", Title),
         Title = ifelse(Title %in% c("Don", "Jonkheer", "Sir", "Dr", "Rev"), "Mr", Title),
         Title = ifelse(Title %in% c("Dona", "Lady", "the Countess", "Mme"), "Mrs", Title),
         Title = ifelse(Title %in% c("Mlle", "Ms"), "Miss", Title))
# This demonstrates having historical knowledge or "business knowledge" is crucial to cleaning a df.

table(titanic_combined$Title)

# Only 15.36% of passengers are married/widowed adult females

prop.table(table(titanic_combined$Title))

# Only 4.66% of passengers were male children

View(titanic_combined %>% filter(Sex == "male" & Title %in% c("Miss", "Mrs")))

# Check the mappings of Title to male passengers by entering and running the code to the right.

View(titanic_combined %>% filter(Sex == "female" & Title %in% c("Master", "Mr")))

# There's a mapping error for females, Dr. Leader has the title of Mr and not Mrs

View(titanic_train %>% filter(Ticket == "17465"))

titanic_combined$Title[797] <- "Mrs"

# Assigned Dr. Leader the correct title of Mrs

View(titanic_combined %>% filter(Ticket == "17465"))

# All of this is important to check work after mutating data

# Tickets  ----------------------------------------------------------------

# Previous investigation into the data revealed that families appear to share Ticket numbers. Create Ticket-based features:

ticket_features <- titanic_combined %>% 
  group_by(Ticket) %>% 
  summarize(TicketCount = n(),
            TicketFare = max(Fare),
            AvgFare = max(Fare) / n(),
            MissingAgeCount = sum(is.na(Age)),
            MissCount = sum(Title == "Miss"),
            MrsCount = sum(Title == "Mrs"))
            
# n() counts number of rows 

summary(ticket_features)

titanic_train <- titanic_train %>% 
  select(-PassengerId) %>% 
  mutate(Title = titanic_combined$Title[1:891]) %>% 
  left_join(ticket_features, by = "Ticket")

# Remove the PassengerId column
# Add the first 891 Titles
# Select the code and Run it

summary(titanic_train)

# As left_join will produce NAs where there are no matches, verify the data:
# Run summary on the new titanic_train
# No missing (NA) values in the Ticket-based features

titanic_train <- titanic_train %>% 
  mutate(Survived = as.factor(Survived),
         Pclass = as.factor(Pclass),
         Sex = as.factor(Sex),
         Embarked = as.factor(Embarked),
         Title = as.factor(Title))

summary(titanic_train)

# Note the various factor level (e.g., "Master") counts
# There was a Ticket with 11 passengers
# The median AvgFare is 8.050
# There was a Ticket with 10 missing Age values
# There was a Ticket with 2 passengers with the title of "Mrs"

# Create a grouped/summarized data frame

ticket_count_stats <- titanic_train %>% 
  group_by(Sex, Pclass, Survived) %>% 
  summarize(PassengerCount = n(),
            MinTicketCount = min(TicketCount),
            MedianTicketCount = median(TicketCount),
            MeanTicketCount = mean(TicketCount),
            MaxTicketCount = max(TicketCount))

View(ticket_count_stats)

# For 1st class female passengers, the median TicketCount (i.e., the number of passengers on the Ticket) of survivors is 3 vs 6 for those that perished.
# For 3rd class female passengers, the mean TicketCount of survivors is 1.92 vs 3.29 for those that perished.
# Generally, male passengers are traveling in smaller parties


# My Analysis -------------------------------------------------------------

ticket_features <- titanic_combined %>% 
  group_by(Ticket) %>% 
  summarize(TicketCount = n(),
            TicketFare = max(Fare),
            AvgFare = max(Fare) / n(),
            MissingAgeCount = sum(is.na(Age)),
            MissCount = sum(Title == "Miss"),
            MrsCount = sum(Title == "Mrs"),
            MasterCount = sum(Title == "Master"),
            MrCount = sum(Title == "Mr"))

# First, expand the ticket_features data frame with the following additional features:
# Add MasterCount that has the counts of passengers with the Title of "Master" by Ticket number
# Add MrCount that has the counts of passengers with the Title of "Mr" by Ticket number

ticket_count_stats <- titanic_train %>% 
  group_by(Sex, Pclass, Survived) %>% 
  summarize(PassengerCount = n(),
            MinTicketCount = min(TicketCount),
            MedianTicketCount = median(TicketCount),
            MeanTicketCount = mean(TicketCount),
            MaxTicketCount = max(TicketCount))

View(ticket_count_stats)

# Create two grouped/summarized data frames like ticket_count_stats:
# Create the avg_fare_stats data frame grouped by Sex, Pclass, Survived with summarized AvgFare data

avg_fare_stats <- titanic_train %>% 
  group_by(Sex, Pclass, Survived) %>% 
  summarize(PassengerCount = n(),
            MinAvgFare = min(AvgFare),
            MedianAvgFare = median(AvgFare),
            MeanAvgFare = mean(AvgFare),
            MaxAvgFare = max(AvgFare))

View(avg_fare_stats)

# Create the ticket_count_stats_title data frame grouped by Title, Pclass, Survived with summarized TicketCount data
# Title gives 4 data points to look vs gender where there is only 2 points

ticket_count_stats_title <- titanic_train %>% 
  group_by(Title, Pclass, Survived) %>% 
  summarize(PassengerCount = n(),
            MinTicketCount = min(TicketCount),
            MedianTicketCount = median(TicketCount),
            MeanTicketCount = mean(TicketCount),
            MaxTicketCount = max(TicketCount))

View(ticket_count_stats_title)

