
# Boxplots ----------------------------------------------------------------

# Very useful when first exploring a dataset
# Power of boxplots is the ability to see the distribution of numeric columns by categories

# Interpreting Boxplots
  # Line in middle of box is median (50th percentile) half data is less and more of this value
  # Upper boundary of box is 75th percentile and 75% of data is less then 75th percentile
  # Lower bound is 25th percentile, 25% of data values are less then the lower bound of the box
  # IQR is 75 percentile - 25 percentile
  # Lines is whisker which could mean max data value or 75th percentile + 1.5 * IQR whichever is SMALLER
  # Lower whisker is min data value or 25th percentile - 1.5 * IQR whichever is LARGER 

library(dplyr)
library(ggplot2)
# ggplot2 works best with factors

iris_data <- iris %>% 
  mutate(Species = as.factor(Species))
# Transforming species into factors

ggplot(iris_data) + 
  geom_boxplot(mapping = aes(x = Species, y = Sepal.Length))
# 1st layer is the data frame to use in viz
# 2nd layer is geometry or viz
# aes stands for aesthetic defines how data will be used and aspects of final appearance

  
ggplot(iris_data) + 
  theme_bw() +
  # theme_nw is black/white
  geom_boxplot(mapping = aes(x = Species, y = Sepal.Length))


# Histograms --------------------------------------------------------------

# Quintessential viz for distributions of numeric data
# Essentially a bell curve distribution
# x axis is the numeric variable 
# y axis is count of values
# Based on bins the histogram shows the count of those values in the bins
# Look at 1 variable at a time
# Appearance can vary based on bins width used

ggplot(iris_data) +
  theme_bw() +
  geom_histogram(mapping = aes(x = Sepal.Length), binwidth = 1.0)


ggplot(iris_data) +
  theme_bw() +
  geom_histogram(mapping = aes(x = Sepal.Length), binwidth = 0.5)
# More bins since width is smaller

# Understand units of measurement for data
# Look at data column in question 
# Understand distribution of data use summary function

## Faceting ----------------------------------------------------------------

# Automatically pivot viz's based on categorical aka factor variables

ggplot(iris_data) +
  theme_bw() +
  facet_wrap(~ Species) +
  geom_histogram(mapping = aes(x = Sepal.Length), binwidth = 1.0)
# facet_wrap create a viz by species


## Filled Histograms -------------------------------------------------------
# using a factor ggplot1 can fill viz's with colors by factor level

ggplot(iris_data) +
  theme_bw() +
  geom_histogram(mapping = aes(x = Sepal.Length, fill = Species), binwidth = 1.0)
# Color coded each value in histogram
# Bin widths are one
# Middle part of range versicolors and virginica's have alot in common
# As sepal lengths increase virginica begins to dominate
# Small end  of range setosa  dominates with some versicolor and 1 virginica


# Bar Charts --------------------------------------------------------------

# Bar charts are go-to viz for counts of categorical aka factor data.
# Business data is rich with factor data.
# Adding dimensions to business data viz's make the patterns pop
# One of the easiest ways to add dimensions to bar charts is to use facet_wrap

sub_cat <- rep(c("A", "B", "C"), 50)
# made a sub-category

iris_data <- iris_data %>% 
  mutate(Species = as.factor(Species),
         Sub.Cat = as.factor(sub_cat))
# Changed Species and sub_cat into factors

ggplot(iris_data) +
  theme_bw() +
  facet_wrap(~ Species) +
  geom_bar(aes(x = Sub.Cat)) +
  labs(x = "Sub.Cat", y = "Count",
       title = "Sub.Cat by Species")
# plot iris_data
# use black/white theme
# facet wrap by Species
# labs is adding custom labels

## Filled Bar Charts -------------------------------------------------------

# Facet wrap and fill allows for adding of many dimensions to bar charts

sub_cat <- rep(c("A", "B", "C"), 50)
sub_sub_cat <- rep(c("D", "E"), 75)
# Made a sub sub category to use facet wrap and fill

iris_data <- iris_data %>% 
  mutate(Species = as.factor(Species),
         Sub.Cat = as.factor(sub_cat),
         Sub.Sub.Cat = as.factor(sub_sub_cat))

ggplot(iris_data) +
  theme_bw() +
  facet_wrap(~ Species) +
  geom_bar(aes(x = Sub.Cat, fill = Sub.Sub.Cat)) +
  labs(x = "Sub.Cat", y = "Count",
       title = "Sub.Cat and Sub.Sub.Cat by Species")


## Proportion Bar Charts ---------------------------------------------------

# Many times data is desired to see bar charts in terms of proportions rather than counts

ggplot(iris_data) +
  theme_bw() +
  facet_wrap(~ Species) +
  geom_bar(aes(x = Sub.Cat, fill = Sub.Sub.Cat), position = "fill") +
  labs(x = "Sub.Cat", y = "Proportion",
       title = "Sub.Cat and Sub.Sub.Cat by Species")

# position = "fill" is presenting viz as proportion
# position = "fill" ia parameter call on geom_bar not aes 
# Having viz of both counts and proportions is extremely useful in understanding business data

# Scatter Plots -----------------------------------------------------------

# Scatter plots are best way to show relationships between 2 numerical variables
# Adding a 3rd dimension of color makes viz and data pop

ggplot(iris_data) +
  theme_bw() +
  geom_point(aes(x = Sepal.Width, y = Sepal.Length)) +
  labs(x = "Sepal.Width (cm)", y = "Sepal.Length (cm)",
       title = "Sepal.Width vs Sepal.Length")

# geom_point is used for scatter plots
# x = Sepal.Width, y = Sepal.Length are numeric variables
# ^ Not as useful due to no color or lines
# ^ 2 dimension base scatter plot


## 3-D Dimensional Scatter Plots -------------------------------------------

# 3rd dimension to add is factor

ggplot(iris_data) +
  theme_bw() +
  geom_point(aes(x = Sepal.Width, y = Sepal.Length, color = Species), size = 3) +
  labs(x = "Sepal.Width (cm)", y = "Sepal.Length (cm)",
       title = "Sepal.Width vs Sepal.Length")

# color = Species is adding color by species
# size = 3 increase size to 3 and is parameter to geom_point not aes
# setosa has large sepal.width and not length


# Exercise # 8 - ggplot2 --------------------------------------------------

library(dplyr)
library(ggplot2)

sub_cat <- rep(c("A", "B", "C"), 50)
sub_sub_cat <- rep(c("D", "E"), 75)

iris_data <- iris_data %>% 
  mutate(Species = as.factor(Species),
         Sub.Cat = as.factor(sub_cat),
         Sub.Sub.Cat = as.factor(sub_sub_cat))

str(iris_data)

ggplot(iris_data) +
  theme_bw() +
  geom_boxplot(aes(x = Species, y = Petal.Width)) +
  labs(title = "Boxplot of Petal.Width by Species")

# If value of petal width is below .75 it is a setosa 
# Outliers for setosa are well underneath versicolor whisker
# Middle part of both veriscolor and virginica are nicely separated
# Bottom 25% of whisker for virginica overlapes veriscolor a bit
# If petal width is 2.5 or higher it is virginica

ggplot(iris_data) +
  theme_bw() +
  geom_histogram(aes(x = Petal.Width, fill = Species),
                 binwidth = 0.25) +
  labs(y = "Count", title = "Distribution of Petal.Width by Species")

# 1st dimension is Petal.Width
# 2nd dimension is  fill = Species
# Some overlap between versicolor and virginica

ggplot(iris_data) +
  theme_bw() +
  facet_wrap(~ Species) +
  geom_bar(aes(x = Sub.Cat, fill = Sub.Sub.Cat), position = "fill") +
  labs(y = "Proportion", x = "Sub.Cat", title = "Proportions Bar Chart")
# ~ is called a tilda used for facet wrapping

ggplot(iris_data) +
  theme_bw() +
  geom_point(aes(x = Petal.Width, y = Petal.Length, color = Species), size = 3) +
  labs(title = "Species by Petal.Width and Petal.Length")

# Setosa is all by itself
# Overlap between Virginica and Versicolor could be problem


