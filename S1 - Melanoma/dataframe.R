library("ggplot2")
library("patchwork")

## Dataframes

# Simple dataframe
data.frame(
  type = c("A", "B", "C"),
  value = c(1, 2, 3)
)

data.frame(gene = c("DNMT3A", "NPM1", "RAS", "FLT3"),
           nReads.tumour = c(87, 54, 67, 72),
           nReads.normal = c(21, 70, 84, 48))

# Read from file
df <- read.table("/Users/alisamar/Desktop/spedex/S1 - Melanoma/USmelanoma.csv")
df
summary(df)

df$mortality
df$latitude
df$ge ## partial name matching


# Consider the data set USmelanoma from Seminar 1d,
# how do you generate a parallel boxplot in vertical orientation
# (i.e. the metric variable on they-axis) that contrasts
# the mortality rate between ocean states with non-ocean states?

ggplot(data = df, mapping = aes(x = ocean, y = mortality)) +
  geom_boxplot() +
  labs(x = "Contiguous to an ocean?", y = "Mortality Rate")

# common elements for the plots
ggp <- ggplot(data = df, aes(x = mortality)) +
  xlim(80.5, 234.5)

ggbp <- ggp + geom_boxplot() + labs(x = NULL)

gghist <- ggp +
  geom_histogram(mapping = aes(y = after_stat(density)), binwidth = 7) +
  geom_density(colour = "red")

# package patchwork provides function plot_layout
# install it first if not done yet for your R-installation
ggbp + gghist +
  plot_layout(nrow = 2, heights = c(1, 4))
