# Dave initial examples ----

## Importing data frame using "Import Dataset under environment ----
iris_data <- read.csv("~/R Projects/R Programming Made Easy - Dave Langer/iris.csv")

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
 
