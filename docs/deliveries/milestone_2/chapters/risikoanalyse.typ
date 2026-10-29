// ─────────────────────────────────────────────────────────────
//  Kapitel: Risikoanalyse der gewählten Lösungsvariante
//  Quelle: Projektunterlagen/Dokumente/Konzeption/Risikoanalyse.xlsx
//          (Blatt «Analyse», Stand Anfang PREN1, Skala 1–4 nach ALARP)
//  Basiert auf milestone_1/chapters/risikoanalyse.typ, Skala auf 1–4 erweitert.
//  Wird in «doc.typ» per #include eingebunden.
// ─────────────────────────────────────────────────────────────

// ── Hilfsfunktionen ──────────────────────────────────────────

// Grenzen der Risikoklassen (R = W × A, max. 16)
// TODO: Grenzen im Team festlegen (ALARP-Matrix im Excel hat keine Farbgrenzen hinterlegt).
#let grenze-hoch = 9
#let grenze-mittel = 5

// Risikozahl R = W × A als farbiges Badge, none = nicht bewertet
#let risikozahl(w, a) = {
  if w == none or a == none { return text(fill: luma(150))[–] }
  let r = w * a
  let c = if r >= grenze-hoch { rgb("#b91c1c") } else if r >= grenze-mittel { rgb("#b45309") } else { rgb("#15803d") }
  box(
    fill: c.lighten(88%),
    stroke: 0.5pt + c.lighten(60%),
    inset: (x: 5pt, y: 3pt),
    radius: 3pt,
    text(fill: c, weight: "bold", size: 8.5pt, str(r)),
  )
}

// Kompakte Massnahmenliste
#let punkte(items) = {
  if items.len() == 0 { return text(fill: luma(150))[–] }
  grid(
    columns: (0.8em, 1fr),
    row-gutter: 0.45em,
    ..items.map(i => (text(weight: "bold", "-"), i)).flatten()
  )
}

// Risikotabelle
// Zeile: (nr, funktion, name, text, verhindern: (..), begrenzen: (..), w, a)
//   w: Eintrittswahrscheinlichkeit 0–4, a: Schadensausmass 1–4 (weglassen = nicht bewertet)
#let risiko-tabelle(caption, ..zeilen) = figure(
  kind: table,
  caption: caption,
  {
    set text(size: 8pt)
    set par(justify: false, leading: 0.5em)
    set table.cell(breakable: false)
    table(
      columns: (0.9cm, 2.4cm, 1.3fr, 1fr, 1fr, auto, auto, auto),
      align: (x, _) => if x >= 5 { center + horizon } else { left + top },
      table.header([Nr.], [Funktion], [Risiko], [Massnahmen Verhindern], [Massnahmen Schadens-?begrenzung], [W], [A], [R]),
      ..zeilen.pos().map(z => {
        let w = z.at("w", default: none)
        let a = z.at("a", default: none)
        (
          [#z.nr],
          z.funktion,
          [*#z.name* #if z.at("text", default: none) != none { linebreak(); z.text }],
          punkte(z.at("verhindern", default: ())),
          punkte(z.at("begrenzen", default: ())),
          if w == none [–] else [#w],
          if a == none [–] else [#a],
          risikozahl(w, a),
        )
      }).flatten(),
    )
  },
)

// ─────────────────────────────────────────────────────────────

= Risikoanalyse <kap-risikoanalyse>

Die Risikoanalyse aus Meilenstein 1 wurde für die Lösungsvarianten überarbeitet und erweitert. Die Massnahmen sind in zwei Gruppen unterteilt: Massnahmen zum *Verhindern* senken die Eintrittswahrscheinlichkeit, Massnahmen zur *Schadensbegrenzung* verringern die Auswirkung, falls das Risiko trotzdem eintritt.

Gemäss der Rückmeldung zu Meilenstein 1 wurde die Bewertungsskala verfeinert: Eintrittswahrscheinlichkeit (W) und Schadensausmass (A) werden neu auf einer Skala von 1 bis 4 bewertet (@tab-risiko-skala). Das Produkt ergibt die Risikozahl R = W × A (maximal 16). Risiken, deren Eintritt durch einen Entscheid ausgeschlossen wurde, sind mit W = 0 erfasst.

// TODO: Bedeutung der Stufen 1–4 im Team definieren (im Excel nicht beschrieben) und Tabelle prüfen.
#figure(
  {
    set par(justify: false)
    set text(size: 9pt)
    table(
      columns: (auto, 1fr, 1fr),
      align: left + top,
      table.header([Wert], [Eintrittswahrscheinlichkeit (W)], [Schadensausmass (A)]),
      [1], [sehr gering], [gering – kaum Einfluss auf Termine, Kosten oder Funktion],
      [2], [gering – Eintritt möglich], [mittel – Mehraufwand, Ziele bleiben erreichbar],
      [3], [mittel – Eintritt wahrscheinlich], [hoch – Anforderung oder Meilenstein gefährdet],
      [4], [hoch – Eintritt sehr wahrscheinlich], [sehr hoch – Funktion im Wettbewerb nicht erfüllbar],
    )
  },
  caption: [Bewertungsskala der Risikoanalyse],
) <tab-risiko-skala>

#align(center)[
  #set text(size: 8.5pt)
  #grid(
    columns: 4,
    column-gutter: 1.4em,
    align: horizon,
    [#risikozahl(3, 3) #h(0.2em) ab #grenze-hoch: hoch],
    [#risikozahl(2, 3) #h(0.2em) #grenze-mittel–#(grenze-hoch - 1): mittel],
    [#risikozahl(1, 2) #h(0.2em) bis #(grenze-mittel - 1): gering],
    [#risikozahl(none, none) #h(0.2em) nicht bewertet],
  )
]

Die erfassten Risiken sind in @tab-risikoanalyse aufgeführt. Am höchsten bewertet sind das Überschreiten des Maximalgewichts (R03), die CPU-Überlastung (R19) und die Budgetüberschreitung (R20).
// TODO: Risiken gezielt auf die gewählte Variante beziehen (z. B. LiFePO4-Gewicht, LED-Matrix stört Kamera,
//       Pin-Anzahl Pico 2, Servos Beine) – Risiken aus «Risiken» in Loesungsvarianten.docx ergänzen.
// TODO: Funktionszuordnung (Spalte «Funktion») prüfen – im Excel nicht erfasst, hier aus dem Inhalt abgeleitet.
// TODO: R06 «Audioortung» – Antwort der Betreuung festhalten (W = 0 bedeutet geklärt?).

// Querformat, Risikotabelle darf über mehrere Seiten umbrechen
#[
#set page(flipped: true)
#show figure.where(kind: table): set block(breakable: true)

#risiko-tabelle(
  [Risikoanalyse (Stand Meilenstein 2)],
  (
    nr: [R01], funktion: [Rechenplattform],
    name: [Raspberry Pi 4 hat zu wenig Rechenleistung],
    text: [Der Raspberry Pi 4 hat zu wenig Leistung für die Software.],
    verhindern: ([Möglichst viel der Software bereits in PREN1 entwickeln, damit Tests auf dem Raspberry Pi gemacht werden können],),
    begrenzen: (),
    w: 2, a: 3,
  ),
  (
    nr: [R02], funktion: [Objekterkennung],
    name: [Kamera ist zu teuer],
    text: [Die für die visuelle Erkennung benötigte Kamera erweist sich als zu teuer.],
    verhindern: ([Bereits nach möglichen Kameramodulen suchen und Tests durchführen],),
    begrenzen: (),
    w: 0, a: 3,
  ),
  (
    nr: [R03], funktion: [Material und Design],
    name: [Gewicht überschritten],
    text: [Weil zu viele Motoren benötigt werden, wird das vorgegebene Maximalgewicht überschritten.],
    verhindern: ([Design nach Gewicht optimieren],),
    begrenzen: ([Unwichtige Komponenten entfernen (z. B. Schwanz)],),
    w: 4, a: 4,
  ),
  (
    nr: [R04], funktion: [Audio-Erfassung],
    name: [Mikrofonqualität zu schlecht],
    text: [Die Audioqualität des Mikrofons reicht nicht, um die Sprachbefehle zuverlässig zu erkennen. Noch unklar ist, wie laut es bei der Vorführung wird.],
    verhindern: ([Spracherkennung in lärmiger Umgebung testen, zuerst mit Laptop-Mikrofon, später mit dem gewählten Mikrofon],),
    begrenzen: ([Zuschauer um Ruhe bitten und Befehl wiederholen],),
    w: 2, a: 4,
  ),
  (
    nr: [R05], funktion: [Material und Design],
    name: [Gewinde in 3D-gedruckten Teilen],
    text: [Gewinde im Kunststoff reissen aus oder passen nicht.],
    verhindern: ([Tests mit Gewinden im Kunststoff durchführen oder alternative Montagemethoden verwenden],),
    begrenzen: ([Sekundenkleber und Klebeband],),
    w: 2, a: 4,
  ),
  (
    nr: [R06], funktion: [Audio-Erfassung],
    name: [Audioortung],
    text: [Unklar ist, ob sich der Roboter beim Befehl «Hier» zur Person drehen muss, von der der Befehl kam. In diesem Fall müsste die Person evtl. über ein Mikrofon-Array geortet werden.],
    verhindern: ([Abklären, ob die Person, die den Befehl gibt, direkt vor dem Roboter steht; falls nein, Lösung entwickeln],),
    begrenzen: (),
    w: 0, a: 4,
  ),
  (
    nr: [R07], funktion: [Material und Design],
    name: [Ein Bauteil bricht],
    text: [Bei Tests oder an der Vorführung versagt ein Bauteil.],
    verhindern: ([Hoch belastete Bauteile doppelt drucken bzw. herstellen],),
    begrenzen: ([Sekundenkleber und Klebeband],),
    w: 2, a: 4,
  ),
  (
    nr: [R08], funktion: [Objekterkennung],
    name: [Kamerabereich zu klein],
    text: [Der sichtbare Bereich der Kamera reicht nicht aus, um den Knochen in der Nähe noch zu erkennen.],
    verhindern: ([Kamerabereich testen],[Antriebsmöglichkeiten für einen Kameraschwenk ausarbeiten],[Evtl. separate Erkennung für die Nähe (Distanzsensor Laser/Ultraschall)],),
    begrenzen: ([Position des Objekts im Navigationsalgorithmus laufend schätzen und beim Verschwinden mit diesen Daten weiterarbeiten (Object Permanence)],),
    w: 1, a: 4,
  ),
  (
    nr: [R09], funktion: [Energieversorgung],
    name: [Akkulaufzeit reicht nicht],
    text: [Die Akkulaufzeit reicht nicht für den ganzen Wettbewerb.],
    verhindern: ([Ausführliche Berechnungen],),
    begrenzen: ([Akku überdimensionieren],),
    w: 2, a: 4,
  ),
  (
    nr: [R10], funktion: [Projekt],
    name: [Person fällt aus],
    text: [Ein Teammitglied fällt aus und kann nicht mehr am Projekt weiterarbeiten.],
    verhindern: (),
    begrenzen: ([Aufgaben des ausfallenden Teammitglieds auf andere aufteilen],),
    w: 1, a: 3,
  ),
  (
    nr: [R11], funktion: [Fortbewegung],
    name: [Boden zu glatt],
    text: [Ein zu glatter Boden verursacht Durchdrehen der Räder; die im Programm berechnete und die reale Strecke stimmen nicht mehr überein.],
    verhindern: ([Austragungsort vorgängig definieren lassen und dort testen],[Kontaktflächen aus Material mit möglichst hohem Reibungskoeffizienten herstellen],),
    begrenzen: ([Zusatzgewicht für mehr Anpressdruck],),
    w: 2, a: 4,
  ),
  (
    nr: [R12], funktion: [Kommunikationsschnittstellen],
    name: [Störungen durch Abstrahlung],
    text: [Durch unvorteilhaftes Design werden Befehle oder Sensordaten verfälscht.],
    verhindern: ([Kritische Schnittstellen und Sensorleitungen schirmen oder räumlich von der Leistungselektronik trennen],),
    begrenzen: ([In der Software anhand vergangener Werte prüfen, ob Sensordaten plausibel sind, und ggf. mit Schätzwert rechnen oder auf das nächste Datenpaket warten],),
    w: 2, a: 3,
  ),
  (
    nr: [R13], funktion: [Fortbewegung],
    name: [Nicht genug Drehmoment bzw. Kraft],
    text: [Durch falsche Auslegung der Motoren oder anderer Antriebe reicht die Kraft bzw. das Drehmoment nicht aus.],
    verhindern: ([Kräfte und Drehmomente im Voraus berechnen und einen grosszügigen Sicherheitsfaktor einrechnen],),
    begrenzen: ([Gewicht einsparen],),
    w: 2, a: 4,
  ),
  (
    nr: [R14], funktion: [Material und Design],
    name: [Gesamtlösung überschreitet Abmessungen],
    text: [Gewicht oder Länge werden überschritten, was zu Punkteabzug führt.],
    verhindern: ([Abmessungen bei der Entwicklung immer beachten und innerhalb der Limiten planen],[Teilsysteme wenn möglich wägen und Gesamtgewicht abschätzen],),
    begrenzen: ([Verzichtbare Teile entfernen (z. B. Schwanz)],),
    w: 1, a: 2,
  ),
  (
    nr: [R15], funktion: [Objekterkennung],
    name: [Kamera unzureichend],
    text: [Die Auflösung der Kamera reicht nicht, um die nötige Präzision zu erreichen.],
    verhindern: ([Im Simulator ausführlich testen],),
    begrenzen: ([Bessere Kamera kaufen],),
    w: 2, a: 4,
  ),
  (
    nr: [R16], funktion: [Kommunikationsschnittstellen],
    name: [Kommunikation Raspberry Pi und Mikrocontroller],
    text: [Die Schnittstelle funktioniert nicht oder verursacht Fehler.],
    verhindern: ([ACK/NACK implementieren],[Verbindung testen],),
    begrenzen: (),
    w: 1, a: 3,
  ),
  (
    nr: [R17], funktion: [Objekterkennung],
    name: [False Positives bei Objekt- und Spracherkennung],
    text: [Der Roboter erkennt fälschlicherweise einen Knochen, eine Geste oder einen Sprachbefehl und löst eine unbeabsichtigte Aktion aus.],
    verhindern: ([Erkennungen über mehrere Kamerabilder bestätigen],[Sprachbefehle nur als alleinstehende Wörter akzeptieren],),
    begrenzen: (),
    w: 2, a: 3,
  ),
  (
    nr: [R18], funktion: [Objekterkennung],
    name: [False Negatives bei Objekt- und Spracherkennung],
    text: [Ein vorhandener Knochen, eine Geste oder ein Sprachbefehl wird nicht erkannt; der Roboter führt die gewünschte Aktion nicht aus.],
    verhindern: ([Konfidenzschwellen optimieren],[Bildgrösse bei der Verarbeitung gross halten],),
    begrenzen: ([Auf nächsten Befehl bzw. Wiederholung warten],),
    w: 3, a: 2,
  ),
  (
    nr: [R19], funktion: [Rechenplattform],
    name: [CPU-Überlastung],
    text: [Die gleichzeitige Ausführung von Objekt-, Gesten- und Spracherkennung überlastet den Prozessor; es entstehen Verzögerungen oder Ausfälle.],
    verhindern: ([Raspberry Pi 5 einsetzen],[Prozesse priorisieren und Parallelbetrieb testen],),
    begrenzen: ([Bildauflösung oder Verarbeitungsfrequenz reduzieren und weniger wichtige Prozesse pausieren],),
    w: 3, a: 4,
  ),
  (
    nr: [R20], funktion: [Projekt],
    name: [Budgetüberschreitung],
    text: [Wird in allen Teilbereichen auf hochwertige Komponenten gesetzt, summieren sich die Kosten und das Budget wird überschritten.],
    verhindern: ([Grobe Budgetplanung vor der Nutzwertanalyse],),
    begrenzen: ([Vor der Bestellung auf günstigere Komponenten umstellen],),
    w: 4, a: 3,
  ),
  (
    nr: [R21], funktion: [Navigation],
    name: [Navigationsprobleme],
    text: [Der Roboter verlässt während der Suche oder Rückkehr das Spielfeld.],
    verhindern: ([Viele Tests im Simulator und wenn möglich real],),
    begrenzen: ([Bei geringer Überschreitung Punkteabzug in Kauf nehmen],),
    w: 1, a: 2,
  ),
) <tab-risikoanalyse>
]
