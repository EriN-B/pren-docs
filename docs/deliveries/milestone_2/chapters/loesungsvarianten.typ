// ─────────────────────────────────────────────────────────────
//  Kapitel: Lösungsvarianten
//  Quellen (OneDrive Projektunterlagen/Dokumente/Evaluation):
//    Loesungsvarianten.docx (Stand 30.10.2026)
//    morphologischer_kasten.typ (Seite «Varianten im Vergleich»)
//  Texte aus Loesungsvarianten.docx übernommen (von den Verfassenden manuell geschrieben).
//  Korrigiert wurden nur Rechtschreibung/Grammatik und Schreibweisen (Raspberry Pi,
//  Mikrocontroller, LiFePO4, LEDs). Inhalte, die in allen Varianten gleich sind
//  («Siehe Variante 3» im Word), stehen gesammelt unter «Gemeinsame Basis».
//  Wird in «doc.typ» per #include eingebunden.
// ─────────────────────────────────────────────────────────────

// ── Hilfsfunktionen ──────────────────────────────────────────

// Sichtbarer Platzhalter für noch fehlenden Inhalt (vor der Abgabe entfernen!)
#let offen(body) = text(fill: rgb("#b91c1c"), style: "italic")[[Offen: #body]]

// Unnummerierte Zwischenüberschrift innerhalb eines Unterkapitels (nicht im Inhaltsverzeichnis).
// Bewusst keine 4. Gliederungsebene (4.3.1.1), damit Nummerierung und Inhaltsverzeichnis schlank bleiben.
#let thema(titel) = {
  show heading: it => block(above: 1.3em, below: 0.6em, sticky: true, {
    set text(size: 10pt, weight: "semibold", fill: rgb("#1f2937"))
    box(width: 3pt, height: 0.85em, baseline: 0.1em, fill: rgb("#1f2937").lighten(30%))
    h(0.5em)
    it.body
  })
  heading(level: 4, numbering: none, outlined: false, bookmarked: false, titel)
}

// Vorteile / Risiken als Box mit zwei farbigen Spalten
#let farbe-vorteil = rgb("#15803d")
#let farbe-risiko = rgb("#b45309")
#let vor-risiko(vorteile, risiken) = {
  let spalte(titel, symbol, farbe, punkte) = {
    block(below: 0.5em, text(size: 8.5pt, weight: "bold", fill: farbe, tracking: 0.04em, upper(titel)))
    if punkte.len() == 0 {
      text(size: 9pt, fill: luma(130), style: "italic")[keine erfasst]
    } else {
      set text(size: 9pt)
      set par(justify: false, leading: 0.55em)
      list(
        marker: text(fill: farbe, weight: "bold", symbol),
        spacing: 0.55em, indent: 0pt, body-indent: 0.5em,
        ..punkte,
      )
    }
  }
  block(
    breakable: false, width: 100%, above: 0.9em, below: 1.3em,
    inset: (x: 10pt, y: 9pt), radius: 3pt,
    fill: luma(248), stroke: 0.5pt + luma(220),
    grid(
      columns: (1fr, 1fr), column-gutter: 14pt,
      grid.vline(x: 1, stroke: 0.5pt + luma(215), position: start),
      spalte("Vorteile", "+", farbe-vorteil, vorteile),
      pad(left: 4pt, spalte("Risiken", "–", farbe-risiko, risiken)),
    ),
  )
}

// Variantenfarben wie in morphologischer_kasten.typ
#let farbe-schnell = rgb("#D64545")
#let farbe-stabil = rgb("#E8971C")
#let farbe-spass = rgb("#2B3A55")

#let chip(farbe, n) = box(baseline: 20%, circle(radius: 5pt, fill: farbe, inset: 0pt,
  align(center + horizon, text(size: 6.5pt, fill: white, weight: "bold", str(n)))))

// Legende der Variantenfarben in den Kasten-Grafiken
#let varianten-legende = {
  set text(size: 8.5pt)
  align(center, grid(
    columns: 4, column-gutter: 1.6em, align: horizon,
    [#chip(farbe-schnell, 1) #h(0.2em) Schnell],
    [#chip(farbe-stabil, 2) #h(0.2em) Stabiles System],
    [#chip(farbe-spass, 3) #h(0.2em) Spass],
    text(fill: luma(120))[grau = nicht gewählt],
  ))
}

// Steckbrief am Anfang jeder Variante: Leitidee + Kernmerkmale
#let steckbrief(farbe, n, leitidee, merkmale) = block(
  width: 100%, inset: (x: 10pt, y: 8pt), radius: 3pt, breakable: false,
  fill: farbe.lighten(90%), stroke: (left: 3pt + farbe),
  above: 0.6em, below: 1.2em,
)[
  #chip(farbe, n) #h(0.3em) #emph(leitidee)
  #v(0.2em)
  #set text(size: 9pt)
  #grid(columns: (auto, 1fr), column-gutter: 10pt, row-gutter: 4pt,
    ..merkmale.map(((k, v)) => ([*#k*], v)).flatten())
]

// ─────────────────────────────────────────────────────────────

= Lösungsvarianten <kap-loesungsvarianten>

Aus dem morphologischen Kasten (@fig-morph-kasten) wurden drei Lösungsvarianten mit unterschiedlicher Zielsetzung kombiniert: «Schnell» (leicht und einfach), «Stabiles System» (robust und sicher) und «Spass» (ausdrucksstark). Viele Parameter sind in allen drei Varianten gleich gewählt, weil sich in der Evaluation eine Ausprägung klar durchgesetzt hat.

Das Kapitel ist deshalb in zwei Teile gegliedert: @kap-gemeinsame-basis beschreibt die Lösungsprinzipien, die alle Varianten teilen. Die Abschnitte @kap-variante-schnell bis @kap-variante-spass beschreiben danach je Variante nur die Unterschiede in Mechanik, Elektronik, Reaktion und Simulation. @tab-varianten-uebersicht und @fig-morph-unterschiede fassen diese Unterschiede zusammen.

// TODO: Rechenplattform: Texte unten nennen den Raspberry Pi 4, Kapitel 3 (Testdokument) bevorzugt
//       den Raspberry Pi 5 – nach Teamentscheid angleichen.

== Übersicht <kap-varianten-uebersicht>

#figure(
  {
    set text(size: 9pt)
    set par(justify: false)
    table(
      columns: (auto, 1fr, 1fr, 1fr),
      align: left + horizon,
      table.header(
        [Parameter],
        [#chip(farbe-schnell, 1) Schnell],
        [#chip(farbe-stabil, 2) Stabiles System],
        [#chip(farbe-spass, 3) Spass],
      ),
      table.cell(colspan: 4, fill: luma(235))[*Mechanik*],
      [Beindesign], [Knickbeine (Skizze C)], [Teleskopbeine (Skizze A)], [Knickbeine (Skizze C)],
      [Antrieb Beine], [DC-Motor mit Endlagenschaltern], [Linearaktuator], [Servomotor],
      [Antrieb Räder], [DC-Motor ohne Encoder], [DC-Motor mit Encoder], [DC-Motor mit Encoder],
      table.cell(colspan: 4, fill: luma(235))[*Elektronik*],
      [Akku], [LiPo], [LiPo oder LiFePO4 + USV-HAT], [LiFePO4],
      [Akkuüberwachung], [Spannungsmessung (ADC)], [–], [Strommessung (z. B. INA228)],
      table.cell(colspan: 4, fill: luma(235))[*Reaktion*],
      [Ausgabeelemente], [Lautsprecher], [Lautsprecher], [Lautsprecher, LED-Augen],
      [Bewegung], [keine], [Schwanz], [Schwanz, neigbarer Kopf],
      table.cell(colspan: 4, fill: luma(235))[*Simulation*],
      [Visualisierung], [im Simulator], [im Simulator], [im Simulator + Rerun],
    )
  },
  caption: [Unterschiede der drei Lösungsvarianten],
) <tab-varianten-uebersicht>
// TODO: Akkuüberwachung «Stabiles System» im Word nicht beschrieben – ergänzen oder Zeile anpassen.

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
      caption: [Unterschiede und gemeinsame Basis der Lösungsvarianten im morphologischen Kasten],
    ) <fig-morph-unterschiede>
  ]
]

== Gemeinsame Basis <kap-gemeinsame-basis>

Die folgenden Lösungsprinzipien sind in allen drei Varianten identisch.

=== Fortbewegung <kap-basis-fortbewegung>

Der Roboterhund bewegt sich auf vier Beinen fort, an deren Enden je ein Rad sitzt. Die eigentliche Fortbewegung erfolgt rollend über die Räder, während die Beine für die Höhenverstellung und die Körperhaltungen «Sitz», «Platz» und «Auf» genutzt werden. Gelenkt wird über unterschiedliche Raddrehzahlen der linken und rechten Seite (Differenzialantrieb). Dadurch kann sich der Roboter auch an Ort drehen, beispielsweise beim Befehl «Such» in Richtung Suchbereich.

Gegenüber Laufbeinen ist die Fortbewegung auf Rädern deutlich schneller, energieeffizienter und einfacher zu regeln, da kein Gleichgewicht beim Gehen gehalten werden muss. Durch die Beine bleibt das Erscheinungsbild eines Hundes trotzdem erhalten.

=== Steuerungsarchitektur <kap-basis-steuerung>

Für die Steuerung kommt eine kombinierte Architektur aus Raspberry Pi 4 und Mikrocontroller (Raspberry Pi Pico 2) zum Einsatz. Der Raspberry Pi übernimmt die Objekt-, Gesten- und Spracherkennung sowie die Ausgabe von akustischen Signalen, während der Mikrocontroller für die hardwarenahe Steuerung zuständig ist, also für die Motorimpulse, die Aktoren für Reaktionen und die Überwachung von Tastern und Hauptschalter.

Diese Trennung gewährleistet, dass zeitkritische Abläufe unabhängig vom Betriebssystem des Raspberry Pi ausgeführt werden können. Die Kommunikation zwischen beiden Komponenten erfolgt über eine serielle Schnittstelle und ist mit UART einfach, robust und zuverlässig umsetzbar.
#vor-risiko(
  ([Trennung von zeitkritischen und zeitunkritischen Prozessen],),
  ([Kommunikation mittels UART funktioniert nicht ordnungsgemäss], [Rechenleistung des Raspberry Pi 4 ist zu schwach]),
)

#pagebreak()
=== Navigation <kap-basis-navigation>

Die Navigation des Roboters wird über eine Positionsschätzung durch Odometrie aus den Daten der Encoder und der IMU realisiert, da dies für den kleinen Such- und Aufenthaltsbereich der Aufgabenstellung als ausreichend erachtet wird. Dabei werden die Rückmeldungen des Mikrocontrollers (zurückgelegte Strecken links und rechts) und der IMU (Beschleunigung → Geschwindigkeit, Winkel) miteinander verglichen und die Position im Raum mit einem geeigneten Mittelungsverfahren approximiert. Diese wird mit dem geschätzten Zielort des Knochens bzw. der Person verglichen und daraus ein zielführender Weg berechnet.

Eine höhere Präzision liesse sich durch ein Umgebungsmapping über Kamera oder LiDAR erreichen (SLAM- bzw. VSLAM-Algorithmus). Dies erweist sich jedoch als zu rechenintensiv und ist mit der dafür nötigen Hardware im Rahmen des Budgets nicht umsetzbar.
#vor-risiko(
  ([Kostengünstig], [Einfache Umsetzung]),
  ([Zu geringe Präzision kann zu langsamer Zielerreichung führen],),
)

=== Sensorik <kap-basis-sensorik>

#thema[Visuelle Erfassung]
Für die visuelle Erkennung von Objekten oder Gesten wird eine RGB-Kamera eingesetzt, welche am Kopf des Hundes montiert wird. Zusätzlich sorgt ein Ultraschallsensor am vorderen Ende (Bodennähe) des Hundes für die Distanzeinschätzung, wenn sich der Roboter in der Nähe des Knochens befindet.
#vor-risiko(
  (),
  ([Kabelführung Kamera zu Raspberry Pi beachten (kurze Distanzen, Schirmung)],),
)
// TODO: Vorteile Visuelle Erfassung im Word leer – ergänzen.

#thema[Audioerfassung]
Für die Audioerfassung wird ein USB-Mikrofon verwendet, welches direkt am Raspberry Pi eingesteckt werden kann. Somit ist die Audioerfassung komplett von der Mikrocontroller-Steuerung entkoppelt, und das digitale Audiosignal kann vom Raspberry Pi verarbeitet werden.
#vor-risiko(
  ([Zeitunkritische Audioerfassung vom Mikrocontroller ausgelagert],),
  ([Qualität des Mikrofons unzureichend, um Sprache zu erkennen],),
)

#pagebreak()
=== Erkennung von Objekten, Gesten und Sprache <kap-basis-erkennung>

#thema[Objekterkennung]
Für die Erkennung des Knochens kommt das KI-Modell YOLOE-26n zum Einsatz. Dieses wird im NCNN-Format auf dem Raspberry Pi ausgeführt und verarbeitet die Bilder der RGB-Kamera. Das Modell benötigt kein zusätzliches Training und erkennt den Knochen anhand vordefinierter Objektbeschreibungen. Die erkannten Objekte werden durch Bounding Boxes im Kamerabild lokalisiert.

Bei bisherigen Tests auf dem Raspberry Pi 4 konnte das Modell durchschnittlich 4.2 Bilder pro Sekunde verarbeiten und alle fünf Testbilder korrekt auswerten.
#vor-risiko(
  ([Kein zusätzliches Training des Modells erforderlich], [Gute Erkennungsresultate bei bisherigen Tests], [Deutlich schnellere Verarbeitung als YOLO-World]),
  ([Hohe CPU-Auslastung bei der Bilderkennung], [Erkennung noch nicht mit der endgültigen Kamera getestet], [Zuverlässigkeit bei unterschiedlichen Lichtverhältnissen und Knochenpositionen noch unklar]),
)

#thema[Gestenerkennung]
Für die Erkennung der drei Handgesten «Sitz», «Platz» und «Auf» wird MediaPipe Hand Landmarker verwendet. Das Modell erkennt die Gelenkpunkte der Hand und liefert deren Koordinaten. Anhand dieser Positionen werden die einzelnen Gesten durch einen k-Nearest-Neighbors-Klassifikator unterschieden und den entsprechenden Roboterbefehlen zugeordnet.

MediaPipe wurde bereits auf einem Laptop getestet und aufgrund des geringen Rechenaufwands und der Qualität gegenüber MobileCLIP2-S2 bevorzugt.
#vor-risiko(
  ([Geringer Rechenaufwand im Vergleich zu MobileCLIP2-S2], [Verwendung derselben RGB-Kamera wie bei der Objekterkennung], [Gesten können durch eigene Logik definiert und angepasst werden]),
  ([Gestenerkennung wurde noch nicht auf dem Raspberry Pi 4 getestet], [Ähnliche Fingerstellungen können zu Fehlinterpretationen führen], [Zusätzlicher Implementierungsaufwand für die Unterscheidung der Gesten]),
)

#pagebreak()
#thema[Spracherkennung]
Für die Spracherkennung wird die Software Vosk auf dem Raspberry Pi eingesetzt. Die über das USB-Mikrofon aufgenommenen Sprachsignale werden lokal verarbeitet und auf die vier definierten Befehle «Hier», «Brav», «Sitz» und «Such» überprüft. Erkannte Befehle werden anschliessend an die Steuerungslogik weitergegeben.

Bei bisherigen Tests auf dem Raspberry Pi 4 konnte Vosk eine Audioaufnahme von 12.14 Sekunden innerhalb von 2.76 Sekunden verarbeiten. Dabei wurde durchschnittlich ungefähr ein CPU-Kern ausgelastet. Im Vergleich zu Whisper und Whistle benötigt Vosk somit deutlich weniger Rechenleistung.
#vor-risiko(
  ([Geringer Rechenaufwand im Vergleich zu Whisper und Whistle], [Erfolgreiche Erkennung aller bisherigen Testwörter]),
  ([Erkennung über das Mikrofon im Livebetrieb noch nicht getestet], [Gleichzeitige Ausführung mit anderen Modellen könnte die CPU überlasten]),
)

=== Akustische Ausgabe <kap-basis-ausgabe>

Alle Varianten verfügen über einen Lautsprecher mit Verstärker am Raspberry Pi. Ein akustisches Signal ist gemäss Aufgabenstellung zwingend: Die sitzende Endposition im Startfeld muss akustisch unterstützt werden @aufgabe. Der Lautsprecher ist deshalb in allen Lösungsvarianten integriert.

#pagebreak()
=== Simulation und Ablauflogik <kap-basis-simulation>

#thema[Simulationsumgebung]
Der Simulator wird als Eigenentwicklung (Python oder Web) umgesetzt. Er zeigt das Spielfeld mit Startfeld, Suchbereich, Knochen und Roboter in einer 2D- oder 3D-Ansicht. Die Bewegung wird über ein einfaches Modell des Differenzialantriebs berechnet. Für die Gesten- und Spracherkennung werden Webcam und Mikrofon des Laptops verwendet, sodass MediaPipe und Vosk mit demselben Code laufen wie auf dem Raspberry Pi. Die Knochenerkennung wird über eine aus Tests ermittelte Erkennungsrate nachgebildet.

Kamera, Mikrofon und Antriebe sind über austauschbare Schnittstellen angebunden. Die Ablauflogik bleibt gleich, egal ob simulierte oder echte Komponenten angeschlossen sind (Anforderung 6.02). So kann der Simulator in PREN2 oder schon früher als Testumgebung für die reale Hardware dienen, auch in Mischformen (z. B. echte Kamera mit simuliertem Antrieb).

Gegenüber Webots, CoppeliaSim oder Gazebo mit ROS 2 braucht die Eigenentwicklung kein detailliertes Robotermodell und keine Einarbeitung in ROS. Als mögliche Erweiterung wird ein physikbasierter Simulator wie ManiSkill geprüft, sobald die Eigenentwicklung läuft. Dank der austauschbaren Schnittstellen wäre er ohne Änderung der Ablauflogik anbindbar.
#vor-risiko(
  ([Volle Kontrolle über Darstellung und Bedienung], [Leichtgewichtig und bis Meilenstein 3 lauffähig umsetzbar], [Gleicher Code für Ablauflogik und Erkennung in Simulator und Roboter], [Testszenarien mit Befehlen und Knochenposition frei einstellbar]),
  ([Keine echte Physik: Schlupf, Trägheit und Ungenauigkeit der Odometrie werden nur vereinfacht abgebildet], [Kamerabild des Roboters wird nicht simuliert; die simulierte Knochenerkennung ist nur so gut wie die gemessenen Erkennungsraten], [Aufwand für Darstellung und Bedienelemente liegt vollständig beim Team]),
)

#thema[Ablauflogik]
Die Ablauflogik wird als Zustandsautomat mit der Bibliothek python-statemachine umgesetzt. Die Zustände bilden den Ablauf gemäss Aufgabenstellung ab, z. B. «Warten auf Befehl», «Befehl quittieren», «Suchen», «Knochen gefunden», «Zurück zur Person» und «Sitz». Übergänge werden durch erkannte Befehle, Erkennungen der Kamera oder Rückmeldungen der Steuerung ausgelöst. Jeder Übergang wird mit Zeitstempel und Grund protokolliert (z. B. «Knochen erkannt, Konfidenz 0.82»). Aus dem Code lässt sich automatisch ein Zustandsdiagramm erstellen, das direkt in die Dokumentation übernommen werden kann. Der aktuelle Zustand wird im Simulator angezeigt. Die Varianten unterscheiden sich nur in der zusätzlichen Visualisierung mit Rerun (@kap-spass-simulation).
#vor-risiko(
  ([Zustände und Übergänge übersichtlich und nachvollziehbar], [Zustandsdiagramm für die Dokumentation automatisch generierbar], [Prozessschritte, Befehlserkennung und Suche werden visualisiert (Anforderung 6.01)]),
  (),
)


== Variante 1 «Schnell» <kap-variante-schnell>

#steckbrief(farbe-schnell, 1, [Leicht und einfach: möglichst wenig Gewicht und Komponenten, damit der Roboter schnell am Ziel ist.], (
  ([Mechanik], [Knickbeine, DC-Motoren ohne Encoder, Endlagenschalter]),
  ([Elektronik], [LiPo-Akku, Spannungsüberwachung per ADC]),
  ([Reaktion], [nur Lautsprecher, keine Bewegungen]),
))

#offen[Skizze der Variante (Lee Kürsener, Jan Grisiger)]

=== Mechanik <kap-schnell-mechanik>

#thema[Design]
Die Beingeometrie entspricht Design C (Knickbeine, Skizze C). Um Gewicht zu sparen, wird der Rumpf möglichst leicht und kompakt gebaut. So braucht es weniger starke Motoren für den Mechanismus am Bein. Mit diesem Mechanismus können die verschiedenen Positionen schnell verstellt werden.

#thema[Antrieb]
Für die Antriebe sind bei dieser Variante einfache DC-Motoren ohne Encoder vorgesehen, die sowohl die Beine als auch die Räder antreiben. Damit der Roboter erkennt, wann die Beine komplett ein- oder ausgefahren sind, werden zusätzlich Endlagenschalter verbaut. Diese Lösung ist etwas günstiger als die anderen Varianten. Sie hat aber den Nachteil, dass die Beine nicht exakt angesteuert werden können, was mögliche Kunststücke einschränkt, und dass die gefahrene Distanz nur abgeschätzt werden kann, was die Navigation erschwert.
// TODO: Navigation (Gemeinsame Basis) setzt Rad-Encoder voraus – für «Schnell» klären,
//       wie die Odometrie ohne Encoder umgesetzt wird.

=== Elektronik <kap-schnell-elektronik>

#thema[Energie]
Für die Energieversorgung kommt ein LiPo-Akku zum Einsatz, welcher die Steuerung sowie die Peripherie mit Strom versorgt. Die Versorgung soll dabei in Peripherie und Steuerung getrennt werden, damit bei Betätigung des Hauptschalters nur die Versorgung zur Peripherie getrennt wird und Störungen durch Aktoren die Versorgung der Steuerung nicht beeinflussen. Verschiedene Spannungspegel für Motoren, Sensoren oder Steuerung werden mit DC/DC-Konvertern realisiert.

Die Spannungsüberwachung mittels ADC am Mikrocontroller erkennt den Akkuzustand sowie den Zustand des Hauptschalters und kann dies dem Raspberry Pi signalisieren. Einzelne Zellen mit einer Nennspannung von 3.7 V können in Serie geschaltet werden, um eine höhere Spannung für das Ansteuern von Motoren zu erreichen.
#vor-risiko(
  ([Hohe Energiedichte führt zu geringem Gewicht], [Flexible Formgebung (Pouch-Zellen)]),
  ([Spannung bricht bei Stromspitzen ein], [Brandgefahr von LiPo-Akkus], [Trennung der Spannungsversorgung von Steuerung und Peripherie (Störungen)]),
)

=== Reaktion <kap-schnell-reaktion>

#thema[Ausgabeelemente]
Ein Lautsprecher dient als einziges Ausgabeelement für Emotionen des Roboterhundes. Mit einem geeigneten Verstärker und einem kleinen Lautsprecher können vom Raspberry Pi aus direkt Audiosignale ausgegeben werden.
#vor-risiko(
  ([Einfache Implementierung], [Quittierung ist schnell erkennbar]),
  ([Steuerung des Audiosignals abhängig vom Raspberry Pi],),
)

#thema[Verhalten und Bewegung]
Um den Roboter möglichst schnell an sein Ziel zu bringen, ist jedes zusätzliche Gewicht hinderlich, weshalb bei dieser Variante gänzlich auf Bewegungen als Reaktion verzichtet wird.
#vor-risiko(
  ([Kein Implementierungsaufwand], [Gewichtseinsparung]),
  ([Keine Kopfbewegung, Kamerabereich zu klein],),
)

=== Simulation <kap-schnell-simulation>

Simulator und Ablauflogik entsprechen der gemeinsamen Basis (@kap-basis-simulation). Auf Rerun wird verzichtet; die Visualisierung erfolgt nur im Simulator.


#pagebreak()
== Variante 2 «Stabiles System» <kap-variante-stabil>

#steckbrief(farbe-stabil, 2, [Robust und sicher: bewährte Fertigkomponenten und eine abgesicherte Energieversorgung.], (
  ([Mechanik], [Teleskopbeine mit Linearaktuatoren, DC-Motoren mit Encoder]),
  ([Elektronik], [LiPo- oder LiFePO4-Akku, USV-HAT für den Raspberry Pi]),
  ([Reaktion], [Lautsprecher, wedelnder Schwanz]),
))

#offen[Skizze der Variante (Lee Kürsener, Jan Grisiger)]

=== Mechanik <kap-stabil-mechanik>

#thema[Design]
Die Beine sind als gerade Teleskopbeine ausgeführt (Skizze A). Jedes Bein besteht aus einem Führungsrohr am Rumpf und einem darin gleitenden Innenteil, an dessen Ende das Rad sitzt. Ein Linearantrieb im Bein fährt das Innenteil ein und aus und verändert so die Beinlänge. Werden nur die Hinterbeine eingefahren, senkt sich das Heck und der Hund sitzt («Sitz»); werden alle Beine eingefahren, liegt er («Platz»). Da sich das Rad senkrecht unter der Hüfte bewegt, bleibt die Standfläche in jeder Stellung gleich und der Roboter steht stabil.

#thema[Antrieb]
Für den Antrieb der Räder ist ein DC-Motor mit Encoder vorgesehen. Der Encoder meldet zurück, wie weit sich die Räder gedreht haben, und erleichtert damit die Navigation. Da die Beine linear bewegt werden, kommen Linearaktuatoren zum Einsatz. Die Umwandlung der Drehbewegung in eine Translation findet bereits im Aktuator statt und muss daher nicht mit einem selbst konstruierten Mechanismus gelöst werden. Der Mechanismus im Aktuator ist zudem deutlich kompakter als eine selbst entwickelte Alternative, da das Team in der Fertigung und der Materialwahl eingeschränkt ist.

=== Elektronik <kap-stabil-elektronik>

#thema[Energie]
Für die Energieversorgung wird bei dieser Variante eine Kombination aus LiPo- oder LiFePO4-Akku mit einem USV-HAT für den Raspberry Pi verwendet. Dies garantiert eine vom Hauptakku unabhängige Versorgung des Raspberry Pi. Der zusätzliche Akku des USV-HATs puffert eine unterbrochene Versorgung des Raspberry Pi, bis er sauber heruntergefahren wurde.
#vor-risiko(
  ([Fix fertig erhältlich, kein Produktionsaufwand],),
  ([Hoher Preis],),
)

#pagebreak()
=== Reaktion <kap-stabil-reaktion>

// Teamentscheid 29.10.2026: Lautsprecher ist in allen Varianten Pflicht. Loesungsvarianten.docx
// sieht hier weiterhin einen Piezo-Buzzer am Mikrocontroller vor – Word nachführen.
#thema[Ausgabeelemente]
Um eine möglichst fehlerfreie emotionale Reaktion zu zeigen, wird bei dieser Variante auf aufwändige Ausgabeelemente verzichtet. Ein Lautsprecher mit geeignetem Verstärker, welcher vom Raspberry Pi angesteuert wird, erfüllt das akustische Feedback, wenn die Suchfunktion beendet wurde.
#vor-risiko(
  ([Wenige Komponenten, welche angesteuert werden müssen], [Quittierung ist schnell erkennbar]),
  ([Steuerung des Audiosignals abhängig vom Raspberry Pi],),
)

#thema[Verhalten und Bewegung]
Als einziges emotionales Feedback dient ein wedelnder Schwanz, welcher von einem Servomotor hin und her bewegt wird.
#vor-risiko(
  ([Nur ein Servomotor, einfache Mechanik],),
  ([Wenig emotionales Feedback], [Keine Kopfbewegung, Kamerabereich zu klein]),
)

=== Simulation <kap-stabil-simulation>

Simulator und Ablauflogik entsprechen der gemeinsamen Basis (@kap-basis-simulation). Auf Rerun wird verzichtet; die Visualisierung erfolgt nur im Simulator.


#pagebreak()
== Variante 3 «Spass» <kap-variante-spass>

#steckbrief(farbe-spass, 3, [Ausdrucksstark: präzise Beinbewegungen und viele Reaktionen, damit der Roboter möglichst lebendig wirkt.], (
  ([Mechanik], [Knickbeine mit Servomotoren, DC-Motoren mit Encoder]),
  ([Elektronik], [LiFePO4-Akku, Strommessung (z. B. INA228)]),
  ([Reaktion], [Lautsprecher, LED-Augen, wedelnder Schwanz, neigbarer Kopf]),
))

#offen[Skizze der Variante (Lee Kürsener, Jan Grisiger)]

=== Mechanik <kap-spass-mechanik>

#thema[Design]
Die Beingeometrie entspricht Design C (Knickbeine, Skizze C). Um Gewicht zu sparen, wird der Rumpf möglichst leicht und kompakt gebaut. So braucht es weniger starke Motoren für den Mechanismus am Bein. Mit diesem Mechanismus können die verschiedenen Positionen schnell verstellt werden.

#thema[Antrieb]
Die Räder werden wie bei Variante 2 mit DC-Motoren mit Encoder angetrieben. Bei den Beinen werden jedoch Servomotoren eingesetzt. Der Vorteil gegenüber den DC-Motoren aus Variante 1 besteht darin, dass der Winkel der Beine genau angesteuert werden kann. Das ermöglicht flüssigere Bewegungen und dadurch mehr Möglichkeiten bei der Wahl des Kunststücks.

=== Elektronik <kap-spass-elektronik>

#thema[Energie]
Für die Energieversorgung kommt ein LiFePO4-Akku zum Einsatz, welcher die Steuerung sowie die Peripherie mit Strom versorgt. Die Versorgung soll dabei in Peripherie und Steuerung getrennt werden, damit bei Betätigung des Hauptschalters nur die Versorgung zur Peripherie getrennt wird und Störungen durch Aktoren die Versorgung der Steuerung nicht beeinflussen. Verschiedene Spannungspegel für Motoren, Sensoren oder Steuerung werden mit DC/DC-Konvertern realisiert.

Die Überwachung des Ladezustands erfolgt über ein Strommessmodul (z. B. INA228), welches über einen Shuntwiderstand den Ausgangsstrom des Akkus misst und aus den Messwerten die Ladung des Akkus berechnet. Über eine I²C-Schnittstelle werden diese Messdaten digital an den Pico oder direkt an den Raspberry Pi übermittelt. Einzelne Zellen mit einer Nennspannung von 3.2 V können in Serie geschaltet werden, um eine höhere Spannung für das Ansteuern von Motoren zu erreichen.
#vor-risiko(
  ([Spannung bricht unter Last kaum zusammen], [Integriertes Batteriemanagementsystem (BMS) schützt vor Kurzschluss, Überspannung und Unterspannung]),
  ([Hohes Gewicht (viele Aktoren erfordern grössere Kapazität)], [Präzise Messung des Stromes erforderlich], [Teuer], [Trennung der Spannungsversorgung von Steuerung und Peripherie (Störungen)]),
)

=== Reaktion <kap-spass-reaktion>

#thema[Ausgabeelemente]
Eine Kombination aus LED-Matrix und einem Lautsprecher soll die Emotion des Roboterhundes bestmöglich wiedergeben. Dabei werden LED-Matrizen als Augen des Hundes verwendet, welche einzeln adressierbar über den Mikrocontroller gesteuert werden können. Mit einem geeigneten Verstärker und einem kleinen Lautsprecher können vom Raspberry Pi aus direkt Audiosignale ausgegeben werden.
#vor-risiko(
  ([Emotionen werden gut dargestellt],),
  ([LEDs haben unter Umständen einen hohen Strombedarf ohne Helligkeitsbegrenzung], [LED-Helligkeit stört die Kamera], [Viele Aktoren, begrenzte Mikrocontroller-Pins]),
)

#thema[Verhalten und Bewegung]
Für weiteres emotionales Feedback sorgen ein wedelnder Schwanz, welcher von einem Servomotor hin und her bewegt wird, sowie ein neigbarer Kopf. Der neigbare Kopf stellt zudem sicher, dass das Kamerabild über den Neigungswinkel verändert werden kann.
#vor-risiko(
  ([Kameraausrichtung lässt sich steuern], [Emotionen werden gut dargestellt]),
  ([Viele Aktoren, begrenzte Mikrocontroller-Pins], [Stabilität des Kopfs muss für die Kamera gewährleistet sein]),
)

=== Simulation und Visualisierung <kap-spass-simulation>

Zusätzlich zur gemeinsamen Basis (@kap-basis-simulation) wird Rerun für die Visualisierung und die Wiedergabe von Läufen eingesetzt. Rerun zeichnet das Kamerabild mit den erkannten Bounding Boxes und Hand-Landmarks, die erkannten Sprachbefehle, die Zustände, die Position und die Fahrbefehle auf einer gemeinsamen Zeitachse auf. Ein Lauf kann so im Nachhinein Schritt für Schritt zurückgespult und analysiert werden. Da Simulator und Roboter dieselben Daten aufzeichnen, können auch Läufe des echten Roboters im selben Viewer angeschaut werden. Die Aufzeichnung erfolgt auf dem Raspberry Pi, die Auswertung auf dem Laptop.
#vor-risiko(
  ([Läufe von Roboter und Simulator inkl. Kamerabild abspielbar und analysierbar (Anforderung 6.03)],),
  ([Aufzeichnung (insbesondere des Kamerabilds) belastet den Raspberry Pi 4 zusätzlich], [Zusätzliche Abhängigkeit und Einarbeitung in Rerun], [Rerun dient nur zur Anzeige, Bedienelemente müssen im eigenen Simulator umgesetzt werden], [Aufzeichnungen enthalten Bild und Ton von Personen (Datenschutz)]),
)
