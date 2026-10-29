#import "../../library/template.typ": pren-report

#show: pren-report.with(
  title: "Konzeptbericht Meilenstein 2",
  module: "PREN1 – Produktentwicklung HS26",
  team: "Team 03",
  members: ("Frick Eric Alexander", "Gerber Cédric", "Felder Samuel Sven", "Grisiger Jan Luca", "Kürsener Lee" ,"Erin Bachmann"),
  coach: "Markus Thalmann",
  milestone: "Meilenstein 2",
  date: datetime(year: 2026, month: 10, day: 30),
  logo: image("../../library/assets/hslu-logo.png"),
)

// Meilenstein 2 gemäss Aufgabenstellung (Abschnitt 4.3):
// «Evaluation der Lösungsprinzipien, Auswahl der optimalen Lösungskombination(en)»
// Aufbau angelehnt an die Vorlage PREN1_T15_Abgabe_Meilenstein2 (OneDrive/Vorlagen_Beispiele)

#include "chapters/einleitung.typ"

#include "chapters/projektplanung.typ"

#include "chapters/loesungsprinzipien.typ"

#include "chapters/loesungsvarianten.typ"

#include "chapters/loesungskombination.typ"

#include "chapters/risikoanalyse.typ"

#bibliography("../../library/quellen.bib", title: "Quellenverzeichnis", style: "ieee")
