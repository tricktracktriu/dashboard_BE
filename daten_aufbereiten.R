##########################
### aufbereitung daten ###
##########################

#setup

library(here)
library(dplyr)
library(tidyr)
library(readxl)


### daten einlesen

df <- read_excel(here("daten", "Challenge Bista Hackdays 2021_tidy.xlsx")) %>%  #sheet = "abck"
  janitor::clean_names()


df_long <- df %>% 
  # pivot_longer(cols = starts_with("basis"),
  #            names_to = "basis_kat", 
  #            values_to = "basis_wert") %>% 
  # pivot_longer(cols = starts_with("ubertritt_"),
  #              names_to = "ubertritt_kat",
  #              values_to = "ubertritt_wert") %>% 
  pivot_longer(cols = ends_with("_m") | ends_with("_w"),
               names_to = "geschlecht",
               values_to = "geschlecht_wert")
  # pivot_longer(cols = ubertritt_m | ubertritt_w,
  #              names_to = "geschlecht",
  #              values_to = "geschlecht_übertritt")
