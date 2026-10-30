// ─────────────────────────────────────────────────────────────
//  Kapitel: Evaluation der Lösungsprinzipien
//  Quellen (OneDrive Projektunterlagen/Dokumente/Evaluation):
//    morphologischer_kasten.typ / Morphologischer_Kasten_V1.docx (V1.1, 21.10.2026)
//    Sprach- und Objekterkennung.docx (Testresultate Raspberry Pi 4)
//  Wird in «doc.typ» per #include eingebunden.
// ─────────────────────────────────────────────────────────────

// ── Hilfsfunktionen ──────────────────────────────────────────

// Sichtbarer Platzhalter für noch fehlenden Inhalt (vor der Abgabe entfernen!)
#let offen(body) = text(fill: rgb("#b91c1c"), style: "italic")[[Offen: #body]]

// Kurzbeschreibung eines Teilfunktions-Entscheids
// gewaehlt: gewähltes Lösungsprinzip, verworfen: Alternativen aus dem Kasten
#let entscheid(gewaehlt: none, verworfen: none) = block(
  inset: (x: 8pt, y: 6pt), radius: 3pt, fill: luma(245), width: 100%,
  {
    set text(size: 9pt)
    grid(
      columns: (auto, 1fr), column-gutter: 8pt, row-gutter: 5pt,
      [*Gewählt:*], gewaehlt,
      [*Verworfen:*], if verworfen == none [–] else { verworfen },
    )
  },
)


// Legende der Variantenfarben in den Kasten-Grafiken (Farben wie in morphologischer_kasten.typ)
#let varianten-legende = {
  let chip(farbe, n) = box(baseline: 20%, circle(radius: 5pt, fill: farbe, inset: 0pt,
    align(center + horizon, text(size: 6.5pt, fill: white, weight: "bold", str(n)))))
  set text(size: 8.5pt)
  align(center, grid(
    columns: 4, column-gutter: 1.6em, align: horizon,
    [#chip(rgb("#D64545"), 1) #h(0.2em) Schnell],
    [#chip(rgb("#E8971C"), 2) #h(0.2em) Stabiles System],
    [#chip(rgb("#2B3A55"), 3) #h(0.2em) Spass],
    text(fill: luma(120))[grau = nicht gewählt],
  ))
}

// Teilfunktionen (Ebene 4) nicht nummeriert und nicht im Inhaltsverzeichnis
#show heading.where(level: 4): set heading(numbering: none, outlined: false)

// ─────────────────────────────────────────────────────────────

= Evaluation der Lösungsprinzipien <kap-loesungsprinzipien>

== Vorgehen <kap-vorgehen>

Die Lösungsfindung orientiert sich am systematischen Vorgehen nach Pahl/Beitz @pahl-beitz: Ausgehend von der Funktionszerlegung aus Meilenstein 1 wurden für jede Teilfunktion Lösungsprinzipien recherchiert und bewertet (Technologierecherche). Die Lösungsprinzipien werden im morphologischen Kasten gegenübergestellt (@kap-morph-kasten) und anhand von Recherche und ersten Tests evaluiert. Durch Kombination je einer Ausprägung pro Parameter entstehen drei Lösungsvarianten (@kap-loesungsvarianten), die mit einem paarweisen Vergleich und einer Nutzwertanalyse bewertet werden (@kap-loesungskombination).

// TODO: Prüfen, ob die Parameter des Kastens 1:1 der Funktionszerlegung aus MS1 entsprechen
//       (MS1: 12 Funktionsbereiche; Kasten: 17 Parameter in 5 Bereichen). Abweichungen begründen.

== Morphologischer Kasten <kap-morph-kasten>

Der morphologische Kasten umfasst 17 Parameter in den fünf Bereichen Mechanik, Elektronik, Wahrnehmung, Reaktion und Simulation (@fig-morph-kasten). Für jeden Parameter sind die Ausprägungen aus der Technologierecherche aufgeführt. Die farbigen Markierungen zeigen, welche Ausprägung in welcher Lösungsvariante gewählt wurde.

// Eigene Seite mit schmalen Rändern, damit der Kasten möglichst gross dargestellt wird
#[
  #set page(margin: (x: 1.5cm, top: 2.6cm, bottom: 2.2cm))
  #pagebreak(weak: true)
  #figure(
    {
      image("../assets/morphologischer-kasten.png", width: 100%)
      v(0.4em)
      varianten-legende
    },
    caption: [Morphologischer Kasten mit den drei Lösungsvarianten],
  ) <fig-morph-kasten>
]