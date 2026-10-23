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

#include "chapters/loesungsprinzipien.typ"

#include "chapters/loesungskombination.typ"

#bibliography("../../library/quellen.bib", title: "Quellenverzeichnis", style: "ieee")
