// ─────────────────────────────────────────────────────────────
//  Kapitel: Projektplanung (Soll-Ist-Vergleich)
//  Quellen: Projektunterlagen/Planung/Sprintplanung_v1.xlsx,
//           Projektplan_v1.xlsx (OneDrive / SharePoint)
//  Wird in «doc.typ» per #include eingebunden.
// ─────────────────────────────────────────────────────────────

// ── Hilfsfunktionen ──────────────────────────────────────────

// Abweichung in Stunden mit Vorzeichen, negativ = weniger Aufwand als geplant
#let abw(h) = if h == none [–] else if h > 0 [+#h] else [#h]

// Phasen-/Gruppenzeile über alle Spalten
#let gruppe(n, titel) = table.cell(colspan: n, fill: luma(235))[*#titel*]

// ─────────────────────────────────────────────────────────────

= Projektplanung <kap-projektplanung>

Seit Meilenstein 1 wird der Projektplan mit einer Sprintplanung ergänzt. Jeder Sprint hat ein Sprintziel, und jede Aufgabe wird mit einer geschätzten Soll-Zeit und der effektiv aufgewendeten Ist-Zeit erfasst. Damit lässt sich die Planung laufend mit der Realität vergleichen. Die Sprintplanung ist im Team-SharePoint abgelegt und zeigt den Stand zum Zeitpunkt der Abgabe.
// TODO: Link auf Sprintplanung_v1.xlsx (SharePoint) als Fussnote ergänzen, analog Projektplan in MS1.

== Soll-Ist-Vergleich <kap-soll-ist>

@tab-sprints fasst die Sprints zusammen. Die Abweichung ist negativ, wenn weniger Zeit aufgewendet wurde als geplant.

#figure(
  {
    set text(size: 9pt)
    set par(justify: false)
    table(
      columns: (auto, auto, 1fr, auto, auto, auto, auto),
      align: (x, _) => if x >= 3 { center + horizon } else { left + horizon },
      table.header([Sprint], [Zeitraum], [Inhalt], [Aufgaben], [Soll (h)], [Ist (h)], [Abw. (h)]),
      [1], [18.09.–01.10.2026], [Projektplanung], [4 / 4], [3], [3], [#abw(0)],
      [2], [25.09.–02.10.2026], [Technologierecherche, Abgabe MS1], [12 / 12], [24], [14.5], [#abw(-9.5)],
      [3], [02.10.–23.10.2026], [Evaluation der Lösungsansätze], [11 / 11], [22], [13.5], [#abw(-8.5)],
      [4], [16.10.–30.10.2026], [Auswahl Lösungsvarianten, Abgabe MS2], [3 / 4], [9], [5.5], [#abw(-1.5)],
      [5], [02.11.–13.11.2026], [Komponentenauswahl], [0 / 10], [24], [–], [–],
      [6], [16.11.–04.12.2026], [Hardware- und Softwaretests, Simulation, Abgabe MS3], [0 / 7], [–], [–], [–],
      table.cell(colspan: 3)[*Total (Stand Abgabe)*], [*30 / 48*], [*82*], [*36.5*], [*#abw(-19.5)*],
    )
  },
  caption: [Soll-Ist-Vergleich der Sprints (Stand Meilenstein 2)],
) <tab-sprints>

// TODO: Ist-Zeiten Sprint 4 nach Abgabe nachtragen (Aufgabe 2.3 noch «In Arbeit»).
// TODO: Interpretation prüfen – Ist-Zeiten pro Person oder pro Aufgabe? Erfassen alle Teammitglieder ihre Zeit?
In den Sprints 2 und 3 lag der effektive Aufwand rund 40 % unter der Schätzung. // TODO: Ursachen beschreiben (z. B. pauschale Schätzung von 2 h pro Recherchethema, nicht erfasste Zeiten) und Konsequenz für die Planung der Sprints 5 und 6 festhalten.

@tab-sprint4 zeigt die Aufgaben des laufenden Sprints 4, der mit dieser Abgabe abschliesst.

#figure(
  {
    set text(size: 9pt)
    set par(justify: false)
    table(
      columns: (auto, 1fr, auto, auto, auto, auto, auto),
      align: (x, _) => if x >= 3 { center + horizon } else { left + horizon },
      table.header([Nr.], [Aufgabe], [Zuständig], [Status], [Soll (h)], [Ist (h)], [Abw. (h)]),
      [2.2.1], [Morphologischer Kasten], [Eric Frick], [erledigt], [3], [2], [#abw(-1)],
      [2.2.2], [Nutzwertanalyse], [Jan Grisiger], [erledigt], [2], [2], [#abw(0)],
      [2.2.3], [Risikoanalyse], [Team], [erledigt], [2], [1.5], [#abw(-0.5)],
      [2.3], [Abgabe Meilenstein 2], [Erin Bachmann], [in Arbeit], [2], [–], [–],
    )
  },
  caption: [Aufgaben Sprint 4 «Auswahl Lösungsvarianten»],
) <tab-sprint4>

== Ausblick bis Meilenstein 3 <kap-ausblick>

Bis Meilenstein 3 (04.12.2026) folgen die Sprints 5 und 6. @tab-ausblick zeigt die geplanten Aufgaben.

#figure(
  {
    set text(size: 9pt)
    set par(justify: false, leading: 0.55em)
    table(
      columns: (auto, 1fr, auto, auto),
      align: (x, _) => if x == 3 { center + top } else { left + top },
      table.header([Nr.], [Aufgabe], [Zuständig], [Soll (h)]),
      gruppe(4)[Sprint 5 – Komponentenauswahl (02.11.–13.11.2026)],
      [3.1.1], [Finales Design des Prototyps evaluieren (Aufbau, Material, Abmessungen)], [Jan Grisiger, Lee Kürsener], [4],
      [3.1.2], [Blockschaltbild erstellen], [Eric Frick], [2],
      [3.1.3], [Ansteuerung Motor mit Pico testen], [Samuel Felder], [2],
      [3.1.4], [Komponentenauswahl Fortbewegung (Antrieb)], [Jan Grisiger, Lee Kürsener], [3],
      [3.1.5], [Konzept Energieversorgung], [Eric Frick], [3],
      [3.1.6], [Komponentenauswahl Reaktion/Emotion und Sprachsteuerung], [Eric Frick, Samuel Felder], [2],
      [3.1.7], [Simulator Setup], [Erin Bachmann], [3],
      [3.1.8], [Komponentenliste mit Kosten zusammenstellen], [Team, CFO], [2],
      [3.1.9], [Hardware bestellen (einzelne Komponenten, z. B. Kamera, Sensorik)], [Team, CFO], [1],
      [3.1.10], [Logik Roboter ausarbeiten], [Cédric Gerber], [2],
      gruppe(4)[Sprint 6 – Hardware- und Softwaretests, Simulation (16.11.–04.12.2026)],
      [3.2.1], [Dokumentation vervollständigen (Ziel: 80 % bis Meilenstein 3)], [Team], [–],
      [3.2.2], [Hardwaretest: Ansteuerung Antrieb/Motoren], [Jan Grisiger, Lee Kürsener], [–],
      [3.2.3], [Hardwaretest: Ansteuerung Kamera und Sensorik], [Cédric Gerber, Erin Bachmann], [–],
      [3.2.4], [Softwaretest im Simulator: Navigation], [Cédric Gerber, Erin Bachmann], [–],
      [3.2.5], [Softwaretest im Simulator: Objekterkennung], [Cédric Gerber, Erin Bachmann], [–],
      [3.2.6], [Gesamtkonzept für die Freigabe zusammenführen (Simulation, Doku)], [Team], [–],
      [3.2.7], [Abgabe Meilenstein 3], [Erin Bachmann], [–],
    )
  },
  caption: [Geplante Aufgaben bis Meilenstein 3],
) <tab-ausblick>

// TODO: Soll-Zeiten Sprint 6 in der Sprintplanung schätzen und hier nachtragen.
// TODO: Optional aktualisierten Zeitplan (Gantt) aus MS1 übernehmen – Helfer «zeitachse» in
//       milestone_1/chapters/projektplanung.typ; Kapitel dafür kopieren, nicht includen.
