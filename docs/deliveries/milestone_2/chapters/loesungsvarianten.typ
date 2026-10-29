// ─────────────────────────────────────────────────────────────
//  Kapitel: Lösungsvarianten
//  Quellen (OneDrive Projektunterlagen/Dokumente/Evaluation):
//    Loesungsvarianten.docx (V1.1, 21.10.2026)
//    morphologischer_kasten.typ (Seite «Varianten im Vergleich»)
//  Wird in «doc.typ» per #include eingebunden.
// ─────────────────────────────────────────────────────────────

// ── Hilfsfunktionen ──────────────────────────────────────────

// Sichtbarer Platzhalter für noch fehlenden Inhalt (vor der Abgabe entfernen!)
#let offen(body) = text(fill: rgb("#b91c1c"), style: "italic")[[Offen: #body]]

// Vorteile / Risiken nebeneinander
#let vor-risiko(vorteile, risiken) = block(breakable: false, above: 0.8em, below: 1.2em, grid(
  columns: (1fr, 1fr), column-gutter: 12pt,
  [*Vorteile* #list(..vorteile)],
  [*Risiken* #list(..risiken)],
))


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

// ─────────────────────────────────────────────────────────────

= Lösungsvarianten <kap-loesungsvarianten>

Aus dem morphologischen Kasten (@fig-morph-kasten) wurden drei Lösungsvarianten mit unterschiedlicher Zielsetzung kombiniert: «Schnell» (leicht und einfach), «Stabiles System» (robust und sicher) und «Spass» (ausdrucksstark). Viele Parameter sind in allen drei Varianten gleich gewählt, weil sich in der Evaluation eine Ausprägung klar durchgesetzt hat (@kap-gemeinsame-basis). Die Unterschiede liegen in Design, Antrieb, Energieversorgung und Reaktion (@fig-morph-unterschiede).

// TODO: ABGLEICH NÖTIG – Kasten und Loesungsvarianten.docx widersprechen sich bei den Ausgabeelementen:
//       Schnell: Kasten = LED-Matrix, Word = nur Lautsprecher; Stabiles System: Kasten = «Nichts»,
//       Word = Piezo-Buzzer. Ausserdem: das geforderte akustische Signal am Suchende (Aufgabenstellung 3.5) wäre
//       bei «Stabiles System» ohne Buzzer nicht erfüllt. Kasten-Grafik ggf. neu exportieren.

== Gemeinsame Basis <kap-gemeinsame-basis>

Folgende Lösungsprinzipien sind in allen drei Varianten identisch:

- *Fortbewegung:* Vier Beine mit Rädern an den Enden (Gelenk). Der Roboter fährt auf den Rädern; die Beine dienen der Höhenverstellung und den Haltungen «Sitz», «Platz» und «Auf». Gelenkt wird über einen Differenzialantrieb, wodurch Drehen an Ort möglich ist, z. B. beim Befehl «Such».
- *Steuerungsarchitektur:* Raspberry Pi 4 für Objekt-, Gesten- und Spracherkennung sowie Audioausgabe; Raspberry Pi Pico 2 für Motoren, Aktoren, Taster und Hauptschalter. Kommunikation über UART. Zeitkritische Abläufe laufen so unabhängig vom Betriebssystem des Raspberry Pi.
- *Visuelle Erfassung:* RGB-Kamera am Kopf für Objekt- und Gestenerkennung, Ultraschallsensor vorne in Bodennähe für die Distanz zum Knochen.
- *Audioerfassung:* USB-Mikrofon direkt am Raspberry Pi.
- *Erkennung:* YOLOE-26n (Knochen), MediaPipe Hand Landmarker (Gesten), Vosk (Sprache), alle lokal auf dem Raspberry Pi.
- *Navigation:* Odometrie mit Rad-Encodern und IMU.
- *Simulation:* Eigenentwicklung mit Python-Statemachine.
- *Energie (Grundprinzip):* Getrennte Versorgung von Steuerung und Peripherie, sodass der Hauptschalter nur die Peripherie trennt und Störungen der Aktoren die Steuerung nicht beeinflussen. Spannungspegel über DC/DC-Konverter; Spannungsüberwachung per ADC am Mikrocontroller.

// TODO: Navigation bei «Schnell» prüfen – ohne Rad-Encoder (DC-Motor ohne Encoder) ist Odometrie nur
//       über IMU möglich. Bewertung «Navigation 9» in der Nutzwertanalyse für alle drei gleich?

// Querformat, damit die Grafik lesbar bleibt
#[
  #set page(flipped: true)
  #align(center + horizon)[
    #figure(
      {
        image("../assets/morphologischer-kasten-unterschiede.png", width: 100%)
        v(0.4em)
        varianten-legende
      },
      caption: [Unterschiede und gemeinsame Basis der Lösungsvarianten],
    ) <fig-morph-unterschiede>
  ]
]


== Variante 1 «Schnell» <kap-variante-schnell>

_Leicht und einfach: LiPo-Akku, Radantrieb ohne Encoder, Beine nur mit Endstellungen._

#offen[Skizze der Variante (Lee Kürsener, Jan Grisiger)]

*Mechanik.* Knickbeine (Design C). Der Rumpf wird möglichst leicht und kompakt gebaut, damit für den Beinmechanismus schwächere Motoren genügen und die Positionen schnell verstellt werden können. Räder mit DC-Motoren ohne Encoder, Beine mit DC-Motoren und Endlagenschaltern.
// TODO: Antriebskonzept ausformulieren (Word: Abschnitt leer).

*Energie.* LiPo-Akku; einzelne Zellen mit 3.7 V Nennspannung werden für die Motorspannung in Serie geschaltet.
#vor-risiko(
  ([Hohe Energiedichte, dadurch geringes Gewicht], [Flexible Formgebung (Pouch-Zellen)]),
  ([Spannungseinbruch bei Stromspitzen], [Brandgefahr], [Störungen trotz Trennung von Steuerung und Peripherie]),
)

*Reaktion.* Ein Lautsprecher mit Verstärker am Raspberry Pi dient als einziges Ausgabeelement. Auf Bewegungen als Reaktion wird zugunsten des Gewichts verzichtet.
#vor-risiko(
  ([Einfache Implementierung], [Quittierung schnell erkennbar], [Gewichtseinsparung]),
  ([Audioausgabe abhängig vom Raspberry Pi], [Kein neigbarer Kopf: Kamerabereich evtl. zu klein]),
)

#pagebreak()
== Variante 2 «Stabiles System» <kap-variante-stabil>

_Robust und sicher: getrennte Versorgung (USV), selbsthemmender Linearaktuator, starre Beine._

#offen[Skizze der Variante (Lee Kürsener, Jan Grisiger)]

*Mechanik.* Gerade Teleskopbeine (Design A): Ein Führungsrohr am Rumpf nimmt ein gleitendes Innenteil mit dem Rad auf; ein Linearaktuator verändert die Beinlänge. Werden nur die Hinterbeine eingefahren, sitzt der Hund («Sitz»), werden alle eingefahren, liegt er («Platz»). Da sich das Rad senkrecht unter der Hüfte bewegt, bleibt die Standfläche in jeder Stellung gleich. Räder mit DC-Motoren und Encodern.

*Energie.* LiPo- oder LiFePO4-Akku kombiniert mit einem USV-HAT für den Raspberry Pi. Dessen Zusatzakku überbrückt einen Ausfall der Hauptversorgung, bis der Raspberry Pi sauber heruntergefahren ist.
#vor-risiko(
  ([Fertig erhältlich, kein Produktionsaufwand], [Raspberry Pi unabhängig vom Hauptakku versorgt]),
  ([Hoher Preis],),
)
// TODO: Akkutyp festlegen (LiPo oder LiFePO4?) und Preis USV-HAT beziffern.

*Reaktion.* Ein Piezo-Buzzer am Mikrocontroller quittiert das Ende der Suche akustisch; als emotionales Feedback dient ein wedelnder Schwanz mit einem Servomotor.
#vor-risiko(
  ([Wenige Komponenten], [Buzzer direkt über den Mikrocontroller ansteuerbar], [Einfache Mechanik (ein Servo)]),
  ([Reaktion schwer erkennbar], [Wenig emotionales Feedback], [Kein neigbarer Kopf: Kamerabereich evtl. zu klein]),
)

#pagebreak()
== Variante 3 «Spass» <kap-variante-spass>

_Ausdrucksstark: Servobeine mit Zwischenstellungen, Lautsprecher, LED-Augen, Schwanz und Kopf._

#offen[Skizze der Variante (Lee Kürsener, Jan Grisiger)]

*Mechanik.* Knickbeine (Design C) mit Servomotoren, die auch Zwischenstellungen erlauben. Leichter, kompakter Rumpf. Räder mit DC-Motoren und Encodern.

*Energie.* LiFePO4-Akku; Zellen mit 3.2 V Nennspannung werden für die Motorspannung in Serie geschaltet.
#vor-risiko(
  ([Spannung bricht unter Last kaum ein], [Sicherer als LiPo]),
  ([Hohes Gewicht (viele Aktoren erfordern grössere Kapazität)], [Störungen trotz Trennung von Steuerung und Peripherie]),
)

*Reaktion.* LED-Matrizen als Augen, einzeln adressierbar über den Mikrocontroller, und ein Lautsprecher mit Verstärker am Raspberry Pi. Zusätzlich ein wedelnder Schwanz (Servo) und ein neigbarer Kopf, mit dem sich auch der Kamerabereich verändern lässt.
#vor-risiko(
  ([Emotionen gut darstellbar], [Kameraausrichtung steuerbar]),
  ([Hoher Strombedarf der LEDs ohne Helligkeitsbegrenzung], [LED-Helligkeit kann die Kamera stören], [Viele Aktoren, begrenzte Pins am Mikrocontroller], [Kopf muss für die Kamera stabil sein]),
)

*Simulation.* Zusätzlich zur Python-Statemachine wird Rerun @rerun zur Visualisierung eingesetzt.
// TODO: Simulationsumgebung und Ablauflogik für alle Varianten ausformulieren (Word: Abschnitte leer).
