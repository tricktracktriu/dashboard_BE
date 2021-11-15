##########################
### aufbereitung daten ###
##########################

#setup
library(dplyr)
library(tidyr)


### daten einlesen

df_sek <- readxl::read_excel(here::here("data", "Challenge Bista Hackdays 2021-11_preproc.xlsx"),
                     sheet = "Sekquote") %>% 
  janitor::clean_names()


### absolute zahlen berechne

# annahme 1: ProzentBasis ist das Total an SuS im Verwaltungskreis
# annahme 2: Verteilung ist innerhalb des Geschlechts 
# (Bsp.: Jura -> 69% der Maenner tretten in die Sek ueber und 31% machen einen anderen Weg)
# da die Verteilung von M und F nicht bekannt ist kann kein Wert berechnet werden
# annahme 3: Vom Total (= ProzentBasis) sind 50% M und 50% W

df_sek <- df_sek %>% 
  mutate(uebertritt_absolut = prozent_basis*total) %>% 
  mutate(m_absolut = round(uebertritt_absolut/2*manner)) %>% 
  mutate(f_absolut = round(uebertritt_absolut/2*frauen)) %>% 
  rename(uebertritt_anteil = total) %>% 
  rename(m_anteil = manner) %>% 
  rename(f_anteil = frauen) %>% 
  rename(sus_6kl_absolut = prozent_basis) 


### format zu long anpassen

df_1 <- df_sek %>% 
  pivot_longer(cols = m_absolut:f_absolut,
               names_to = "geschlecht",
               values_to = "uebertritt_geschlecht_absolut") %>%
  relocate(geschlecht, .after = geo_einheit) %>% 
  mutate(geschlecht = case_when(
    geschlecht == "m_absolut" ~ "m",
    geschlecht == "f_absolut" ~ "f")) %>% 
  mutate(uebertritt_kat = case_when(
    uebertritt_anteil >= 0.525 & uebertritt_anteil < 0.555 ~ "52.5%-55.4%",
    uebertritt_anteil >= 0.555 & uebertritt_anteil < 0.585 ~ "55.5%-58.4%",
    uebertritt_anteil >= 0.585 & uebertritt_anteil < 0.595 ~ "58.5%-59.4%",
    uebertritt_anteil >= 0.595 & uebertritt_anteil < 0.645 ~ "59.5%-64.5%",
    uebertritt_anteil >= 0.645 ~ "64.5%-73.5%"
    )) 

df_2 <- df_sek %>% 
  pivot_longer(cols = m_anteil:f_anteil,
             names_to = "geschlecht",
             values_to = "uebertritt_geschlecht_anteil") %>%
  mutate(geschlecht = case_when(
    geschlecht == "m_anteil" ~ "m",
    geschlecht == "f_anteil" ~ "f")) %>% 
  select(geo_id, geschlecht, uebertritt_geschlecht_anteil)

df_sek <- left_join(df_1, df_2) %>%
  relocate(uebertritt_geschlecht_anteil, .after = uebertritt_anteil) %>% 
  select(!(m_anteil:f_anteil)) 


### daten speichern

write.csv2(df_sek, here::here("data", "daten_sek.csv"), 
           row.names = FALSE)

