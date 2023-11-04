library("ggplot2")
set.seed(1289)

data(diamonds, package = "ggplot2")

# Basic Histogram
ggplot(data = diamonds, mapping = aes(x = carat)) +
  geom_histogram(bins = 200)

# Line Plot
ggplot(data = diamonds, mapping = aes(x = price, colour = cut)) +
  geom_freqpoly(binwidth = 500)

# Scatter Plot
ggplot(data = diamonds, mapping = aes(x = carat, y = price)) +
  geom_point()

# Scatter Plot with best fit line and log scales
ggplot(data = diamonds, mapping = aes(x = carat, y = price)) +
  geom_point(colour = "blue") +
  geom_smooth(colour = "black", linetype = "dashed", size = 0.5, se = FALSE) +
  scale_x_log10() +
  scale_y_log10()

# Scatter Plot with categories and log scales
ggplot(data = diamonds, mapping = aes(x = carat, y = price, colour = cut)) +
  geom_point() +
  scale_x_log10() +
  scale_y_log10()


# Violin plots of diamond grades
diamonds |>
  dplyr::filter(carat < 1.75) |>
  ggplot(mapping = aes(x = cut, y = price)) +
  geom_violin() +
  scale_y_log10() +
  facet_wrap(facets = vars(color))

# Function plot
ggplot() +
  xlim(c(0, 5)) +
  geom_function(fun = \(x) sqrt(x) * x - 1) +
  geom_abline(intercept = 0, slope = 1, colour = "blue", linetype = "dashed")
