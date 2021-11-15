# Data Hackdays BE 2021

[Challenge C26: Uebertrittsquote Schulen](https://hack.opendata.ch/project/774)

## Ziel

Visualisierungen der Karten in der [Bildungsstatistik](https://www.erz.be.ch/erz/de/index/direktion/organisation/generalsekretariat/statistik.assetref/dam/documents/ERZ/GS/de/GS-biev-statistik/BKD_INS_2021_Bildungsstatistik_Kt_BE_Basisdaten_2020.pdf) sollen interaktiv im Web verfuegbar sein.

[Quelle](https://www.erz.be.ch/erz/de/index/direktion/organisation/generalsekretariat/statistik.html)

## Datenaufbereitung

Skript: daten_aufbereiten.R

### Vorbereitung der Daten im Excel

Die Zeilen 2:5 werden im Sheet Sekquote manuell im Excel gelöscht und die Spalten A:C ebenfalls. Als Vereinfachung wird bei der Auswertung die Sprache nicht beruecksichtig. Sie koennten aber noch integriert werden. Die Zahl fuer den gesamten Kanton wird nicht benoetigt. Sie kann mit den einzelnen Verwaltungskreisen (Geo_Einheit) berechnet werden. Spalten mit Prozentwerten werden in Numeric/Zahl umgewandelt. Absolute (Originaldaten) sind besser geeignet. Prozentwerte koennen einfach berechnet werden


[Daten fuer Power BI-Ansatz](https://github.com/brodrigues12345/Uebertrittsquoten_Schule)

## Dashboard

[Vorlage Dashboard fuer R](https://tricktracktriu.github.io/dashboard_BE/)




