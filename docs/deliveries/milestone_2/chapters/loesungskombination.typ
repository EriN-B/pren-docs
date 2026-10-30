// ─────────────────────────────────────────────────────────────
//  Kapitel: Bewertung und Auswahl der optimalen Lösungskombination
//  Quellen (OneDrive Projektunterlagen/Dokumente/Evaluation):
//    Paarweiser-Vergleich-Nutzwertanalyse_alle_Unterkategorien.xlsx
//    Nutzwertanalyse_Fliesstext.docx
//  Werte unten 1:1 aus dem Excel übernommen – bei Änderungen dort hier nachführen.
//  Wird in «doc.typ» per #include eingebunden.
// ─────────────────────────────────────────────────────────────

// ── Hilfsfunktionen ──────────────────────────────────────────

// Sichtbarer Platzhalter für noch fehlenden Inhalt (vor der Abgabe entfernen!)
#let offen(body) = text(fill: rgb("#b91c1c"), style: "italic")[[Offen: #body]]

// ─────────────────────────────────────────────────────────────

= Bewertung und Auswahl der Lösungskombination <kap-loesungskombination>

Zur Auswahl der optimalen Lösungskombination wurde eine Nutzwertanalyse durchgeführt. Als Kriterien dienen die 13 Parameter des morphologischen Kastens, von der Fortbewegung bis zum Simulator. Da sie unterschiedlich viel zum Erfolg beitragen, wurden sie zuerst mit einem paarweisen Vergleich gewichtet (@kap-paarweiser-vergleich) und danach pro Variante bewertet (@kap-nutzwertanalyse).

// TODO: Kasten hat 17 Parameter (mit Unterparametern, z. B. Antrieb Räder/Beine, Objekterkennung
//       Hardware/Software), die Nutzwertanalyse 13 Kriterien. Zuordnung kurz erklären; «Objekterkennung»
//       heisst in der NWA «Visuelle Erfassung», Gestenerkennung fehlt als eigenes Kriterium.

== Paarweiser Vergleich <kap-paarweiser-vergleich>

Im paarweisen Vergleich wurde jedes Kriterium mit jedem anderen verglichen (2 = wichtiger, 1 = gleich wichtig, 0 = weniger wichtig). Massgebend war die Frage, welches der beiden Kriterien stärker zum Erfolg im Wettbewerb beiträgt. Die Zeilensumme ergibt die Gewichtung (@tab-paarweiser-vergleich).

#[
  #figure(
    {
      set text(size: 7.5pt)
      set par(justify: false)
      table(
        columns: (auto, 3.4cm) + (1fr,) * 13 + (auto, auto),
        inset: (x: 2.5pt, y: 4pt),
        align: (x, _) => if x == 1 { left + horizon } else { center + horizon },
        table.header([], [Kriterium], [Fb], [De], [An], [En], [Re], [St], [Ko], [Na], [VE], [AE], [Sp], [RE], [Si], [Σ], [%]),
      [Fb], [Fortbewegung], table.cell(fill: luma(235))[], [2], [1], [0], [1], [1], [0], [1], [1], [1], [1], [2], [1], [12], [7.7],
      [De], [Design], [0], table.cell(fill: luma(235))[], [0], [0], [0], [0], [0], [0], [0], [0], [0], [1], [0], [1], [0.6],
      [An], [Antriebskonzepte], [1], [2], table.cell(fill: luma(235))[], [0], [1], [1], [1], [1], [2], [1], [1], [2], [1], [14], [9.0],
      [En], [Energie], [2], [2], [2], table.cell(fill: luma(235))[], [2], [2], [2], [2], [2], [2], [2], [2], [2], [24], [15.4],
      [Re], [Rechenplattform], [1], [2], [1], [0], table.cell(fill: luma(235))[], [1], [1], [2], [1], [1], [1], [2], [2], [15], [9.6],
      [St], [Steuerung], [1], [2], [1], [0], [1], table.cell(fill: luma(235))[], [1], [1], [1], [1], [1], [2], [1], [13], [8.3],
      [Ko], [Schnittstelle / Kommunikation], [2], [2], [1], [0], [1], [1], table.cell(fill: luma(235))[], [2], [2], [2], [2], [2], [2], [19], [12.2],
      [Na], [Navigation], [1], [2], [1], [0], [0], [1], [0], table.cell(fill: luma(235))[], [1], [1], [1], [2], [2], [12], [7.7],
      [VE], [Visuelle Erfassung], [1], [2], [0], [0], [1], [1], [0], [1], table.cell(fill: luma(235))[], [1], [1], [2], [1], [11], [7.1],
      [AE], [Audioerfassung], [1], [2], [1], [0], [1], [1], [0], [1], [1], table.cell(fill: luma(235))[], [1], [2], [1], [12], [7.7],
      [Sp], [Spracherkennung], [1], [2], [1], [0], [1], [1], [0], [1], [1], [1], table.cell(fill: luma(235))[], [2], [1], [12], [7.7],
      [RE], [Reaktion / Emotion], [0], [1], [0], [0], [0], [0], [0], [0], [0], [0], [0], table.cell(fill: luma(235))[], [1], [2], [1.3],
      [Si], [Simulator], [1], [2], [1], [0], [0], [1], [0], [0], [1], [1], [1], [1], table.cell(fill: luma(235))[], [9], [5.8],
        table.cell(colspan: 15, align: right)[*Total*], [*156*], [*100.0*],
      )
    },
    caption: [Paarweiser Vergleich der Kriterien (Zeile im Vergleich zu Spalte)],
  ) <tab-paarweiser-vergleich>
]

Am höchsten gewichtet ist die Energie (15.4 %), da ohne netzunabhängige Versorgung keine Funktion läuft. Es folgt die Schnittstelle / Kommunikation (12.2 %), welche die Wahrnehmung mit der Ansteuerung der Aktoren verbindet. Rechenplattform, Antriebskonzepte und Steuerung liegen mit 8.3 bis 9.6 % im Mittelfeld. Die Kriterien für das Erkennen von Befehlen und das Finden des Knochens (Navigation, visuelle Erfassung, Audioerfassung, Spracherkennung) sowie die Fortbewegung folgen mit je 7.1 bis 7.7 %. Sie bringen direkt Punkte, setzen aber Energie und Kommunikation voraus. Der Simulator (5.8 %) wird im Wettbewerb nicht bewertet. Reaktion / Emotion (1.3 %) und Design (0.6 %) sind am tiefsten gewichtet, da eine einfache Quittierung genügt und das Design nur ein Wunsch ist.

// TODO: Gewichtung Reaktion/Emotion (1.3 %) kritisch prüfen: Quittierung der Befehle ist gefordert
//       (Aufgabenstellung Kap. 2), die Endposition muss akustisch unterstützt werden (Aufgabenstellung 3.5)
//       und das Kunststück bringt bis 20 Punkte (Publikumsvoting).

#pagebreak()
== Nutzwertanalyse <kap-nutzwertanalyse>

Die Varianten wurden pro Kriterium von 0 (nicht erfüllt) bis 10 (vollständig erfüllt) bewertet. Als Grundlage diente die Technologierecherche: Bewertet wurde, welche Technologie das Ziel der jeweiligen Variante am besten erreicht. Jedes Teammitglied bewertete selbständig; danach wurde der Durchschnitt bestimmt und gerundet übernommen. Der Nutzwert ergibt sich aus der Summe der mit der Gewichtung multiplizierten Bewertungen (@tab-nutzwertanalyse).

#figure(
  {
    set text(size: 8.5pt)
    set par(justify: false)
    table(
      columns: (1fr, auto, auto, auto, auto, auto, auto, auto),
      align: (x, _) => if x == 0 { left + horizon } else { center + horizon },
      table.header([Kriterium], [Gew. %], [Schnell], [Nutzen], [Stabil], [Nutzen], [Spass], [Nutzen]),
      [Fortbewegung], [7.7], [8], [0.62], [8], [0.62], [8], [0.62],
      [Design], [0.6], [8], [0.05], [8], [0.05], [8], [0.05],
      [Antriebskonzepte], [9.0], [5], [0.45], [8], [0.72], [8], [0.72],
      [Energie], [15.4], [8], [1.23], [8], [1.23], [9], [1.38],
      [Rechenplattform], [9.6], [5], [0.48], [5], [0.48], [5], [0.48],
      [Steuerung], [8.3], [9], [0.75], [9], [0.75], [9], [0.75],
      [Schnittstelle / Kommunikation], [12.2], [9], [1.10], [9], [1.10], [9], [1.10],
      [Navigation], [7.7], [9], [0.69], [9], [0.69], [9], [0.69],
      [Visuelle Erfassung], [7.1], [8], [0.56], [8], [0.56], [8], [0.56],
      [Audioerfassung], [7.7], [8], [0.62], [8], [0.62], [8], [0.62],
      [Spracherkennung], [7.7], [7], [0.54], [7], [0.54], [7], [0.54],
      [Reaktion / Emotion], [1.3], [4], [0.05], [3], [0.04], [10], [0.13],
      [Simulator], [5.8], [9], [0.52], [9], [0.52], [10], [0.58],
      [*Nutzwert (max. 10)*], [*100.0*], [], [*7.65*], [], [*7.91*], [], [*8.21*],
    )
  },
  caption: [Nutzwertanalyse der Lösungsvarianten],
) <tab-nutzwertanalyse>

Bei den meisten Kriterien wählen alle Varianten dieselbe Ausprägung und werden gleich bewertet. Unterschiede entstehen vor allem bei drei Kriterien: Beim Antrieb erhält «Schnell» nur eine 5, da die DC-Motoren ohne Encoder keine Rückmeldung liefern; «Stabiles System» und «Spass» erhalten eine 8. Bei der Energie überzeugt der LiFePO4-Akku von «Spass» durch Sicherheit und stabile Spannung (9), während LiPo («Schnell») und Akku mit USV («Stabiles System») je eine 8 erhalten. Bei Reaktion / Emotion erreicht «Spass» eine 10, weil LED-Matrix, Lautsprecher und Bewegung eine deutliche Quittierung ermöglichen.

// TODO: Bewertung Reaktion/Emotion neu prüfen: «Stabiles System» (3) wurde mit Piezo-Buzzer bewertet,
//       seit dem Teamentscheid vom 29.10.2026 haben alle Varianten einen Lautsprecher.
// TODO: Weitere Abweichungen begründen: Simulator (Spass 10 vs. 9, wegen Rerun?) und
//       Reaktion/Emotion Schnell 4 vs. Stabil 3.
// TODO: Kriterien Kosten/Budget und Gewicht fehlen in der NWA, obwohl Risiken R03 (Gewicht, R = 16) und
//       R20 (Budget, R = 12) hoch bewertet sind. Ergänzen oder im Text begründen.

#pagebreak()
== Ergebnis und gewählte Lösungskombination <kap-ergebnis>

Der Nutzwert beträgt bei maximal 10 Punkten 7.65 für «Schnell», 7.91 für «Stabiles System» und 8.21 für «Spass». Die Variante «Spass» liegt damit vorne, die Abstände sind jedoch gering.