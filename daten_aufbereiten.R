##########################
### aufbereitung daten ###
##########################

#setup
library(dplyr)
library(tidyr)


### daten einlesen

df_sek <- readxl::read_excel(here::here("daten", "Challenge Bista Hackdays 2021-11_preproc.xlsx"),
                     sheet = "Sekquote")


### absolute zahlen berechne

# annahme 1: ProzentBasis ist das Total an SuS im Verwaltungskreis
# annahme 2: Verteilung ist innerhalb des Geschlechts 
# (Bsp.: Jura -> 69% der Männer tretten in die Sek über und 31% machen einen anderen Weg)
# da die Verteilung von M und F nicht bekannt ist kann kein Wert berechnet werden
# annahme 3: Vom Total (= ProzentBasis) sind 50% M und 50% W

df_sek <- df_sek %>% 
  mutate(übertritt_absolut = ProzentBasis*Total) %>% 
  mutate(m_absolut = round(übertritt_absolut/2*Männer)) %>% 
  mutate(f_absolut = round(übertritt_absolut/2*Frauen)) %>% 
  rename(sus_6kl_absolut = ProzentBasis) %>% 
  select(!(Total:Frauen))


### format zu long anpassen

df_sek <- df_sek %>% 
  pivot_longer(cols = starts_with(c("m_", "f_")),
               names_to = "geschlecht",
               values_to = "übertritt_geschlecht_absolut") %>% 
  relocate(geschlecht, .after = Geo_Einheit) %>% 
  mutate(geschlecht = case_when(
    geschlecht == "m_absolut" ~ "m",
    geschlecht == "f_absolut" ~ "f")) 


### daten speichern

write.csv2(df_sek, here::here("daten", "daten_sek.csv"), 
           row.names = FALSE)

