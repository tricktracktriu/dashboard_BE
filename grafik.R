################
### grafiken ###
################

# setup
library(dplyr)
library(here)
library(ggplot2)
library(readxl)


### daten

### plot

# ggplot(data = filter(df, ubertritt == "sek"), 
#        aes(fill = geschlecht , 
#            y = ubertritt_total, 
#            x = geschlecht)) +
#            #x = filter(geschlecht == ends_with("_m")))) + # geschlecht
#   geom_bar(position = "fill", 
#            stat="identity") +
#   #geom_text(aes(y = label_y, label = Weight), colour = "white")
#   coord_flip() + 
#   scale_y_continuous(labels = scales::percent) +
#   theme_minimal() +
#   theme(legend.position="none") +
#   xlab(NULL) +
#   ylab(NULL)

ggplot(data = filter(df, geo_einh == "Jura bernois"), 
       aes(fill = ubertritt, 
           y = ubertritt_total, 
           x = sprache)) +
  geom_bar(position = "fill", 
           stat="identity") +
  #geom_text(aes(y = label_y, label = Weight), colour = "white")
  coord_flip() + 
  scale_y_continuous(labels = scales::percent) +
  theme_minimal() +
  theme(legend.position="none") +
  xlab(NULL) +
  ylab(NULL)


