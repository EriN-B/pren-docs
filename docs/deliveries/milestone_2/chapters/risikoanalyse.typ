// ─────────────────────────────────────────────────────────────
//  Kapitel: Risikoanalyse der gewählten Lösungsvariante
//  Quelle: Projektunterlagen/Dokumente/Konzeption/Risikoanalyse.xlsx
//          (Blatt «Analyse», Stand Anfang PREN1, Skala 1–4 nach ALARP)
//  Basiert auf milestone_1/chapters/risikoanalyse.typ, Skala auf 1–4 erweitert.
//  Texte wortgetreu aus dem Excel, nur eindeutige Tippfehler korrigiert.
//  «Massnahmen» → Verhindern, «Schadensbegrenzung» → Begrenzen.
//  Wird in «doc.typ» per #include eingebunden.
// ─────────────────────────────────────────────────────────────

// ── Hilfsfunktionen ──────────────────────────────────────────

// Grenzen der Risikoklassen (R = W × A, max. 16) gemäss ALARP-Matrix im Excel:
// grün 1–4, gelb 6–9, rot 12–16
#let grenze-hoch = 12
#let grenze-mittel = 6

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

Gemäss der Rückmeldung zu Meilenstein 1 wurde die Bewertungsskala verfeinert: Eintrittswahrscheinlichkeit (W) und Schadensausmass (A) werden neu auf einer Skala von 1 bis 4 bewertet (@tab-risiko-skala). Das Produkt ergibt die Risikozahl R = W × A (maximal 16). Die Einteilung in die Klassen gering, mittel und hoch folgt dem ALARP-Prinzip. Risiken, deren Eintritt durch einen Entscheid ausgeschlossen wurde, sind mit W = 0 erfasst.

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
    [#risikozahl(3, 4) #h(0.2em) 12–16: hoch],
    [#risikozahl(2, 3) #h(0.2em) 6–9: mittel],
    [#risikozahl(1, 2) #h(0.2em) 1–4: gering],
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
    name: [Raspberry-Pi 4 hat zu wenig Rechenleistung],
    text: [Der Raspberry Pi 4 hat zu wenig Leistung für die Software.],
    verhindern: ([Möglichst viel der Software bereits in PREN1 entwickeln, damit Tests auf dem Raspberry Pi gemacht werden können.],),
    begrenzen: (),
    w: 2, a: 3,
  ),
  (
    nr: [R02], funktion: [Objekterkennung],
    name: [Kamera ist zu teuer],
    text: [Die für die visuelle Erkennung benötigte Kamera erweist sich als zu teuer.],
    verhindern: ([Bereits nach möglichen Kameramodulen suchen und Tests durchführen.],),
    begrenzen: (),
    w: 0, a: 3,
  ),
  (
    nr: [R03], funktion: [Material und Design],
    name: [Gewicht überschritten],
    text: [Weil zu viele Motoren benötigt werden, wird das vorgegebene maximal Gewicht überschritten.],
    verhindern: ([Design nach Gewicht optimieren.],),
    begrenzen: ([Unwichtige Komponenten entfernen (z.B. Schwanz).],),
    w: 4, a: 4,
  ),
  (
    nr: [R04], funktion: [Audio-Erfassung],
    name: [Mikrophon Qualität zu schlecht],
    text: [Die Audioqualität des Mikrophons erweist sich als zu schlecht um die Sprachbefehle zuverlässig erkennen zu können. Noch unklar wie laut es wird bei der Vorführung.],
    verhindern: ([Test mit der Spracherkennung in einer lärmigen Umgebung zuerst mit Laptop Mikrophon und später mit dem richtigen Mikrophon.],),
    begrenzen: ([Die Zuschauer um Ruhe bitten und nochmal versuchen.],),
    w: 2, a: 4,
  ),
  (
    nr: [R05], funktion: [Material und Design],
    name: [Gewinde bei 3D gedruckten Teilen (Kunststoff)],
    text: [Gewinde im Kunststoff reissen aus oder passen nicht.],
    verhindern: ([Tests mit Gewinden im Kunststoff durchführen oder alternative Montagemethoden verwenden.],),
    begrenzen: ([Sekundenkleber und Klebeband.],),
    w: 2, a: 4,
  ),
  (
    nr: [R06], funktion: [Audio-Erfassung],
    name: [Audioortung],
    text: [Es ist nicht klar ob der Roboter beim Befehl «Hier» zu der Person drehen muss von der der Befehl kam. In diesem Fall müsste man evtl. über ein Mikrophon-array Orten können.],
    verhindern: ([Abklären ob die Person die den Befehl gibt direkt vor dem Roboter steht oder nicht. Falls nein, muss eine Lösung entwickelt werden.],),
    begrenzen: (),
    w: 0, a: 4,
  ),
  (
    nr: [R07], funktion: [Material und Design],
    name: [Ein Bauteil bricht],
    text: [Bei Tests oder an der Aufführung kommt es zu einem Versagen eines Bauteils.],
    verhindern: ([Hoch belastete Bauteile 2 mal drucken/herstellen.],),
    begrenzen: ([Sekundenkleber und Klebeband.],),
    w: 2, a: 4,
  ),
  (
    nr: [R08], funktion: [Objekterkennung],
    name: [Kamerabereich zu klein],
    text: [Der sichtbare Bereich der Kamera reicht nicht aus, um den Knochen in der Nähe noch zu erkennen.],
    verhindern: ([Kamerabereich testen, Antriebsmöglichkeiten für Kameraschwenk ausarbeiten. Eventuell eine separate Erkennung für die Nähe (Distanzsensoren Laser/Ultraschall).],),
    begrenzen: ([Im Navigationsalgorithmus stetig Position des Objekts schätzen und beim Verschwinden auf diesen Daten weiterarbeiten (Object-Permanence).],),
    w: 1, a: 4,
  ),
  (
    nr: [R09], funktion: [Energie-?versorgung],
    name: [Akkulaufzeit reicht nicht],
    text: [Die Akkulaufzeit reicht nicht für den ganzen Wettbewerb.],
    verhindern: ([Ausführliche Berechnungen.],),
    begrenzen: ([Akku überdimensionieren.],),
    w: 2, a: 4,
  ),
  (
    nr: [R10], funktion: [Projekt],
    name: [Person fällt aus],
    text: [Ein Teammitglied fällt aus und kann nicht mehr am Projekt weiterarbeiten.],
    verhindern: (),
    begrenzen: ([Aufgaben des ausfallenden Teammitglieds auf andere aufteilen.],),
    w: 1, a: 3,
  ),
  (
    nr: [R11], funktion: [Fortbewegung],
    name: [Boden zu glatt],
    text: [Der Boden ist zu glatt und verursacht überspulen/überschreiten --> Strecken Programm/Real stimmen nicht mehr überein.],
    verhindern: ([Vorgängig den Austragungsort definieren lassen und Tests durchführen. Kontaktflächen aus Materialien mit möglichst hohem Reibungskoeffizient zum Boden herstellen.],),
    begrenzen: ([Zusatzgewicht als «DownForce».],),
    w: 2, a: 4,
  ),
  (
    nr: [R12], funktion: [Kommunikations-?schnittstellen],
    name: [Störungen durch Abstrahlungen (Noise)],
    text: [Durch unvorteilhaftes Design können Befehle oder Informationen von Sensoren verfälscht werden.],
    verhindern: ([Kritische Schnittstellen / Sensorleitungen schirmen oder räumlich von Leistungselektronik trennen.],),
    begrenzen: ([In der Software aufgrund von vergangenen Werten abschätzen ob Sensordaten realistisch sind und gegebenenfalls mit Schätzwert rechnen wenn dies nötig ist oder auf das nächste Datenpaket warten.],),
    w: 2, a: 3,
  ),
  (
    nr: [R13], funktion: [Fortbewegung],
    name: [Nicht genug Drehmoment/Kraft],
    text: [Durch falsches auslegen der Motoren oder anderen Antrieben kann es sein, dass die Kraft/ das Drehmoment nicht ausreicht für die Aufgabe.],
    verhindern: ([Auftretende Kräfte und Drehmomente im vorhinein rechnen und einen grosszügigen Sicherheitsfaktor einrechnen.],),
    begrenzen: ([Gewicht einsparen/loswerden.],),
    w: 2, a: 4,
  ),
  (
    nr: [R14], funktion: [Material und Design],
    name: [Gesamtlösung überschreitet Masse],
    text: [Gewicht oder Längenabmasse werden überschritten. -> Führt zu Punktabzügen.],
    verhindern: ([Masse bei der Entwicklung immer beachten. Innerhalb gegebener Limiten planen. Teilsysteme wenn möglich wägen und Gesamtgewicht abschätzen.],),
    begrenzen: ([Schwanz abschneiden.],),
    w: 1, a: 2,
  ),
  (
    nr: [R15], funktion: [Objekterkennung],
    name: [Kamera unzureichend],
    text: [Die Auflösung der Kamera ist unzureichend, um die nötige Präzision zu erreichen.],
    verhindern: ([Bessere Kamera kaufen, im Simulator ausführlich testen.],),
    begrenzen: ([Teurere Kamera kaufen.],),
    w: 2, a: 4,
  ),
  (
    nr: [R16], funktion: [Kommunikations-?schnittstellen],
    name: [Kommunikation Embedded PC & MCU],
    text: [Schnittstelle geht nicht oder verursacht Fehler .],
    verhindern: ([ACK&NACK implementieren, Testen der Verbindung.],),
    begrenzen: (),
    w: 1, a: 3,
  ),
  (
    nr: [R17], funktion: [Objekterkennung],
    name: [False Positives Objekt- und Audioerkennung],
    text: [Der Roboter erkennt fälschlicherweise einen Knochen, eine Geste oder einen Sprachbefehl. Dadurch kann eine unbeabsichtigte Aktion ausgelöst werden.],
    verhindern: ([Erkennungen über mehrere Kamerabilder bestätigen und Sprachbefehle müssen akustisch alleinstehen.],),
    begrenzen: (),
    w: 2, a: 3,
  ),
  (
    nr: [R18], funktion: [Objekterkennung],
    name: [False Negatives Objekt- und Audioerkennung],
    text: [Ein vorhandener Knochen, eine Geste oder ein Sprachbefehl wird nicht erkannt. Dadurch führt der Roboter die gewünschte Aktion nicht aus.],
    verhindern: ([Konfidenzgrenzwerte optimieren und Bildgrösse bei verarbeitung gross behalten.],),
    begrenzen: ([Warten auf nächsten Befehl/Wiederholung.],),
    w: 3, a: 2,
  ),
  (
    nr: [R19], funktion: [Rechenplattform],
    name: [CPU-Überlastung],
    text: [Die gleichzeitige Ausführung von Objekt-, Gesten- und Spracherkennung überlastet den Prozessor. Dadurch entstehen Verzögerungen oder Funktionsausfälle.],
    verhindern: ([Raspberry Pi 5 einsetzen, Prozesse priorisieren und Parallelbetrieb testen.],),
    begrenzen: ([Bildauflösung oder Bildverarbeitungsfrequenz reduzieren und weniger wichtige Prozesse pausieren.],),
    w: 3, a: 4,
  ),
  (
    nr: [R20], funktion: [Projekt],
    name: [Budgetüberschreitung],
    text: [Wenn in allen Teilbereichen auf die hochwertigen Komponenten Gesetzt wird summiert sich alles zusammen. Das Budget wird gesprengt.],
    verhindern: ([Grobe Budgetplanung vor Nutzwertanalyse.],),
    begrenzen: ([Vor Bestellen auf billigere Komponenten umrüsten.],),
    w: 4, a: 3,
  ),
  (
    nr: [R21], funktion: [Navigation],
    name: [Navigationsprobleme],
    text: [Roboter kommt aus dem Spielfeld hinaus während der Suche/Rückkehr.],
    verhindern: ([Viele Tests im Simulator und wenn möglich auch real.],),
    begrenzen: ([Wenn keine grosse Überschreitung, Punkteabzug hinnehmen.],),
    w: 1, a: 2,
  ),

) <tab-risikoanalyse>
]
