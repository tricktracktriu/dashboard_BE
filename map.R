###########
### map ###
###########


#setup

#library(RSwissMaps)
#library(rgdal)
library(ggplot2)
library(sf)
library(here)
library(dplyr)
library(readxl)

### übertrittsdaten einlesen

df <- readxl::read_excel(here("daten", "Challenge Bista Hackdays 2021_tidy.xlsx")) %>%  #sheet = "abck"
  janitor::clean_names()

# df <- read.table(here("daten", "stw_2021.csv"),
#                     header = TRUE,
#                     sep = ";")


####################
# Uebertrittsquoten #
####################

### map grenzen einlesen
grenzen_ver <- st_read(here("daten",
                        "Verwaltungskreisgrenzen",
                        "Verwaltungskreise_2020.shp"))

# karten daten mit schuldaten verbinden
map_kanton <- left_join(grenzen_ver, df, by = c("V_KREISNR" = "geo_id"))
map_kanton$ubertritt[map_kanton$V_KREISNR == 0] <- "see"

# einzelne verwaltungskreise filtern
map_v_kreis <- map_kanton %>% filter(V_KREIS == "Thun") #c("Thun", "Thunersee"))



### plot übertrittsquote verwaltungskreis
sf_map <- ggplot() +
  geom_sf(data = filter(map_kanton, ubertritt != "gym"), 
          #data = map_v_kreis,
          aes(fill = uber_kat),
          color = "white") +
  coord_sf(datum = NA) +  
  theme_void() + #Koordinatennetz verbergen
  theme(legend.key.size = unit(1, "line"),                                       
        legend.key.height = unit(0.5, "line")) +
  scale_fill_continuous(name = "Legende") +
  labs(title = "Titel",
       subtitle = "Beschrieb", x="", y="")

sf_map



# ################
# # Tagesschulen #
# ################
# 
# ### map grenzen einlesen
# grenzen_gem <- st_read(here("daten",
#                         "Gemeindegrenzen",
#                         "Gemeindegrenzen_2020.shp"))
# 
# # karten daten mit schuldaten verbinden
# map_kanton_gem <- left_join(grenzen_gem, df_ts, by = c("GMDE" = "geo_id"))
# 
# # einzelne gemeinden filtern
# map_v_kreis <- map_kanton %>% filter(NAME == "Thun") # oder GMDE
# 
# 
# 
# ### plot tagesschulen gemeinden
# sf_map <- ggplot() +
#   geom_sf(data = map_kanton_gem, 
#           aes(fill = uber_kat),
#           color = "white") +
#   # geom_sf(data = #see, fill = "#518FB5") +
#   # geom_sf(data = #lake, fill = "#518FB5", size = 1.2) +
#   coord_sf(datum = NA) +  
#   theme_void() + #Koordinatennetz verbergen
#   theme(legend.key.size = unit(1, "line"),                                       
#         legend.key.height = unit(0.5, "line")) +
#   scale_fill_continuous(name = "Legende") +
#   labs(title = "Titel",
#        subtitle = "Beschrieb", x="", y="")
# 
# sf_map
