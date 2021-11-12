################
### grafiken ###
################

# setup
library(dplyr)
library(here)
library(ggplot2)
library(readxl)


### daten

### 

p <- mtcars %>% 
  ggplot(aes(wt, mpg)) +
  geom_point() 
plotly::ggplotly(p)
