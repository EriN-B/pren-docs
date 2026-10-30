// ─────────────────────────────────────────────────────────────
//  Kapitel: Lösungsvarianten
//  Quellen (OneDrive Projektunterlagen/Dokumente/Evaluation):
//    Loesungsvarianten.docx (V1.1, 21.10.2026)
//    morphologischer_kasten.typ (Seite «Varianten im Vergleich»)
//  Texte wörtlich aus Loesungsvarianten.docx übernommen (von den Verfassenden manuell
//  geschrieben). Korrigiert wurden nur Rechtschreibung/Grammatik und Schreibweisen
//  (Raspberry Pi, Mikrocontroller, LiFePO4, LEDs).
//  Wird in «doc.typ» per #include eingebunden.
// ─────────────────────────────────────────────────────────────

// ── Hilfsfunktionen ──────────────────────────────────────────

// Sichtbarer Platzhalter für noch fehlenden Inhalt (vor der Abgabe entfernen!)
#let offen(body) = text(fill: rgb("#b91c1c"), style: "italic")[[Offen: #body]]

// Vorteile / Risiken nebeneinander
#let vor-risiko(vorteile, risiken) = block(breakable: false, above: 0.8em, below: 1.2em, grid(
  columns: (1fr, 1fr), column-gutter: 12pt,
  [*Vorteile* #if vorteile.len() == 0 [\ –] else { list(..vorteile) }],
  [*Risiken* #if risiken.len() == 0 [\ –] else { list(..risiken) }],
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

Aus dem morphologischen Kasten (@fig-morph-kasten) wurden drei Lösungsvarianten mit unterschiedlicher Zielsetzung kombiniert: «Schnell» (leicht und einfach), «Stabiles System» (robust und sicher) und «Spass» (ausdrucksstark). Viele Parameter sind in allen drei Varianten gleich gewählt, weil sich in der Evaluation eine Ausprägung klar durchgesetzt hat. Diese gemeinsame Basis ist in @kap-gemeinsame-basis beschrieben, die Unterschiede in Design, Antrieb, Energieversorgung und Reaktion in den folgenden Abschnitten (@fig-morph-unterschiede).

// TODO: Rechenplattform: Texte unten nennen den Raspberry Pi 4, Kapitel 3 (Testdokument) bevorzugt
//       den Raspberry Pi 5 – nach Teamentscheid angleichen.

== Gemeinsame Basis <kap-gemeinsame-basis>

Die folgenden Lösungsprinzipien sind in allen drei Varianten identisch.

*Fortbewegung.* Der Roboterhund bewegt sich auf vier Beinen fort, an deren Enden je ein Rad sitzt. Die eigentliche Fortbewegung erfolgt rollend über die Räder, während die Beine für die Höhenverstellung und die Körperhaltungen «Sitz», «Platz» und «Auf» genutzt werden. Gelenkt wird über unterschiedliche Raddrehzahlen der linken und rechten Seite (Differenzialantrieb). Dadurch kann sich der Roboter auch an Ort drehen, beispielsweise beim Befehl «Such» in Richtung Suchbereich.

Gegenüber Laufbeinen ist die Fortbewegung auf Rädern deutlich schneller, energieeffizienter und einfacher zu regeln, da kein Gleichgewicht beim Gehen gehalten werden muss. Durch die Beine bleibt das Erscheinungsbild eines Hundes trotzdem erhalten.

*Steuerungsarchitektur.* Für die Steuerung kommt eine kombinierte Architektur aus Raspberry Pi 4 und Mikrocontroller (Raspberry Pi Pico 2) zum Einsatz. Der Raspberry Pi übernimmt die Objekt-, Gesten- und Spracherkennung sowie die Ausgabe von akustischen Signalen, während der Mikrocontroller für die hardwarenahe Steuerung zuständig ist, also für die Motorimpulse, die Aktoren für Reaktionen und die Überwachung von Tastern und Hauptschalter.

Diese Trennung gewährleistet, dass zeitkritische Abläufe unabhängig vom Betriebssystem des Raspberry Pi ausgeführt werden können. Die Kommunikation zwischen beiden Komponenten erfolgt über eine serielle Schnittstelle und ist mit UART einfach, robust und zuverlässig umsetzbar.

#pagebreak()

#vor-risiko(
  ([Trennung von zeitkritischen und zeitunkritischen Prozessen],),
  ([Kommunikation mittels UART funktioniert nicht ordnungsgemäss], [Rechenleistung des Raspberry Pi 4 ist zu schwach]),
)

*Visuelle Erfassung.* Für die visuelle Erkennung von Objekten oder Gesten wird eine RGB-Kamera eingesetzt, welche am Kopf des Hundes montiert wird. Zusätzlich sorgt ein Ultraschallsensor am vorderen Ende (Bodennähe) des Hundes für die Distanzeinschätzung, wenn sich der Roboter in der Nähe des Knochens befindet.
#vor-risiko(
  (),
  ([Kabelführung Kamera zu Raspberry Pi beachten (kurze Distanzen, Schirmung)],),
)
// TODO: Vorteile Visuelle Erfassung im Word leer – ergänzen.

*Audioerfassung.* Für die Audioerfassung wird ein USB-Mikrofon verwendet, welches direkt am Raspberry Pi eingesteckt werden kann. Somit ist die Audioerfassung komplett von der Mikrocontroller-Steuerung entkoppelt, und das digitale Audiosignal kann vom Raspberry Pi verarbeitet werden.
#vor-risiko(
  ([Zeitunkritische Audioerfassung vom Mikrocontroller ausgelagert],),
  ([Qualität des Mikrofons unzureichend, um Sprache zu erkennen],),
)

*Objekterkennung.* Für die Erkennung des Knochens kommt das KI-Modell YOLOE-26n zum Einsatz. Dieses wird im NCNN-Format auf dem Raspberry Pi ausgeführt und verarbeitet die Bilder der RGB-Kamera. Das Modell benötigt kein zusätzliches Training und erkennt den Knochen anhand vordefinierter Objektbeschreibungen. Die erkannten Objekte werden durch Bounding Boxes im Kamerabild lokalisiert.

Bei bisherigen Tests auf dem Raspberry Pi 4 konnte das Modell durchschnittlich 4.2 Bilder pro Sekunde verarbeiten und alle fünf Testbilder korrekt auswerten.
#vor-risiko(
  ([Kein zusätzliches Training des Modells erforderlich], [Gute Erkennungsresultate bei bisherigen Tests], [Deutlich schnellere Verarbeitung als YOLO-World]),
  ([Hohe CPU-Auslastung bei der Bilderkennung], [Erkennung noch nicht mit der endgültigen Kamera getestet], [Zuverlässigkeit bei unterschiedlichen Lichtverhältnissen und Knochenpositionen noch unklar]),
)

*Gestenerkennung.* Für die Erkennung der drei Handgesten «Sitz», «Platz» und «Auf» wird MediaPipe Hand Landmarker verwendet. Das Modell erkennt die Gelenkpunkte der Hand und liefert deren Koordinaten. Anhand dieser Positionen werden die einzelnen Gesten durch einen k-Nearest-Neighbors-Klassifikator unterschieden und den entsprechenden Roboterbefehlen zugeordnet.

MediaPipe wurde bereits auf einem Laptop getestet und aufgrund des geringen Rechenaufwands und der Qualität gegenüber MobileCLIP2-S2 bevorzugt.
#vor-risiko(
  ([Geringer Rechenaufwand im Vergleich zu MobileCLIP2-S2], [Verwendung derselben RGB-Kamera wie bei der Objekterkennung], [Gesten können durch eigene Logik definiert und angepasst werden]),
  ([Gestenerkennung wurde noch nicht auf dem Raspberry Pi 4 getestet], [Ähnliche Fingerstellungen können zu Fehlinterpretationen führen], [Zusätzlicher Implementierungsaufwand für die Unterscheidung der Gesten]),
)

*Spracherkennung.* Für die Spracherkennung wird die Software Vosk auf dem Raspberry Pi eingesetzt. Die über das USB-Mikrofon aufgenommenen Sprachsignale werden lokal verarbeitet und auf die vier definierten Befehle «Hier», «Brav», «Sitz» und «Such» überprüft. Erkannte Befehle werden anschliessend an die Steuerungslogik weitergegeben.

Bei bisherigen Tests auf dem Raspberry Pi 4 konnte Vosk eine Audioaufnahme von 12.14 Sekunden innerhalb von 2.76 Sekunden verarbeiten. Dabei wurde durchschnittlich ungefähr ein CPU-Kern ausgelastet. Im Vergleich zu Whisper und Whistle benötigt Vosk somit deutlich weniger Rechenleistung.
#vor-risiko(
  ([Geringer Rechenaufwand im Vergleich zu Whisper und Whistle], [Erfolgreiche Erkennung aller bisherigen Testwörter]),
  ([Erkennung über das Mikrofon im Livebetrieb noch nicht getestet], [Gleichzeitige Ausführung mit anderen Modellen könnte die CPU überlasten]),
)

*Akustische Ausgabe.* Alle Varianten verfügen über einen Lautsprecher mit Verstärker am Raspberry Pi. Ein akustisches Signal ist gemäss Aufgabenstellung zwingend: Die sitzende Endposition im Startfeld muss akustisch unterstützt werden @aufgabe. Der Lautsprecher ist deshalb in allen Lösungsvarianten integriert.

*Navigation und Simulation.* Alle Varianten setzen auf Odometrie mit Rad-Encodern und IMU sowie auf eine Eigenentwicklung des Simulators mit Python-Statemachine (@fig-morph-kasten).
// TODO: Abschnitte Navigation, Antriebskonzepte, Simulationsumgebung und Ablauflogik/Visualisierung
//       sind im Word noch leer – Texte ergänzen. Navigation bei «Schnell» prüfen (DC-Motor ohne Encoder).

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

*Design.* Die Beingeometrie entspricht Design C (Knickbeine, Skizze C). Um Gewicht zu sparen, wird der Rumpf möglichst leicht und kompakt gebaut. So braucht es nicht so starke Motoren für den Mechanismus am Bein. Mit diesem Mechanismus können die verschiedenen Positionen schnell verstellt werden.

*Energie.* Für die Energieversorgung kommt ein LiPo-Akku zum Einsatz, welcher die Steuerung sowie die Peripherie mit Strom versorgt. Die Versorgung soll dabei in Peripherie und Steuerung getrennt werden, damit bei Betätigung des Hauptschalters nur die Versorgung zur Peripherie getrennt wird und Störungen durch Aktoren die Versorgung der Steuerung nicht beeinflussen. Verschiedene Spannungspegel für Motoren, Sensoren oder Steuerung werden mit DC/DC-Konvertern realisiert.

Die Spannungsüberwachung mittels ADC am Mikrocontroller erkennt den Akkuzustand sowie den Zustand des Hauptschalters und kann dies dem Raspberry Pi signalisieren. Einzelne Zellen mit einer Nennspannung von 3.7 V können in Serie geschaltet werden, um eine höhere Spannung für das Ansteuern von Motoren zu erreichen.
#vor-risiko(
  ([Hohe Energiedichte führt zu geringem Gewicht], [Flexible Formgebung (Pouch-Zellen)]),
  ([Spannung bricht ein bei Stromspitzen], [Brandgefahr von LiPo-Akkus], [Trennung der Spannungsversorgung von Steuerung und Peripherie (Störungen)]),
)

*Ausgabeelemente.* Ein Lautsprecher dient als einziges Ausgabeelement von Emotionen des Roboterhundes. Mit einem geeigneten Verstärker und einem kleinen Lautsprecher können vom Raspberry Pi aus direkt Audiosignale ausgegeben werden.
#vor-risiko(
  ([Einfache Implementierung], [Quittierung ist schnell erkennbar]),
  ([Steuerung des Audiosignals abhängig vom Raspberry Pi],),
)

*Verhalten und Bewegung.* Um den Roboter möglichst schnell an sein Ziel zu bringen, ist jedes zusätzliche Gewicht hinderlich, weshalb bei dieser Variante gänzlich auf Bewegungen als Reaktion verzichtet wird.
#vor-risiko(
  ([Kein Implementierungsaufwand], [Gewichteinsparung]),
  ([Keine Kopfbewegung, Kamerabereich zu klein],),
)

#pagebreak()
== Variante 2 «Stabiles System» <kap-variante-stabil>

_Robust und sicher: getrennte Versorgung (USV), selbsthemmender Linearaktuator, starre Beine._

#offen[Skizze der Variante (Lee Kürsener, Jan Grisiger)]

*Design.* Die Beine sind als gerade Teleskopbeine ausgeführt (Skizze A). Jedes Bein besteht aus einem Führungsrohr am Rumpf und einem darin gleitenden Innenteil, an dessen Ende das Rad sitzt. Ein Linearantrieb im Bein fährt das Innenteil ein und aus und verändert so die Beinlänge. Werden nur die Hinterbeine eingefahren, senkt sich das Heck und der Hund sitzt («Sitz»); werden alle Beine eingefahren, liegt er («Platz»). Da sich das Rad senkrecht unter der Hüfte bewegt, bleibt die Standfläche in jeder Stellung gleich und der Roboter steht stabil.

*Energie.* Für die Energieversorgung wird bei dieser Variante eine Kombination aus LiPo- oder LiFePO4-Akku mit einem USV-HAT für den Raspberry Pi verwendet. Dies garantiert eine vom Hauptakku unabhängige Versorgung des Raspberry Pi. Der zusätzliche Akku des USV-HATs puffert eine unterbrochene Versorgung des Raspberry Pi, bis er sauber heruntergefahren wurde.
#vor-risiko(
  ([Fix fertig erhältlich, kein Produktionsaufwand],),
  ([Hoher Preis],),
)

// Teamentscheid 29.10.2026: Lautsprecher ist in allen Varianten Pflicht. Ursprünglicher Text
// (Loesungsvarianten.docx) sah einen Piezo-Buzzer am Mikrocontroller vor.
*Ausgabeelemente.* Um eine möglichst fehlerfreie emotionale Reaktion zu zeigen, wird bei dieser Variante auf aufwändige Ausgabeelemente verzichtet. Ein Lautsprecher mit geeignetem Verstärker, welcher vom Raspberry Pi angesteuert wird, erfüllt das akustische Feedback, wenn die Suchfunktion beendet wurde.
#vor-risiko(
  ([Wenige Komponenten, welche angesteuert werden müssen], [Quittierung ist schnell erkennbar]),
  ([Steuerung des Audiosignals abhängig vom Raspberry Pi],),
)

*Verhalten und Bewegung.* Als einziges emotionales Feedback dient ein wedelnder Schwanz, welcher von einem Servomotor hin und her bewegt wird.
#vor-risiko(
  ([Nur ein Servomotor, einfache Mechanik],),
  ([Wenig emotionales Feedback], [Keine Kopfbewegung, Kamerabereich zu klein]),
)

#pagebreak()
== Variante 3 «Spass» <kap-variante-spass>

_Ausdrucksstark: Servobeine mit Zwischenstellungen, Lautsprecher, LED-Augen, Schwanz und Kopf._

#offen[Skizze der Variante (Lee Kürsener, Jan Grisiger)]

*Design.* Die Beingeometrie entspricht Design C (Knickbeine, Skizze C). Um Gewicht zu sparen, wird der Rumpf möglichst leicht und kompakt gebaut. So braucht es nicht so starke Motoren für den Mechanismus am Bein. Mit diesem Mechanismus können die verschiedenen Positionen schnell verstellt werden.

*Energie.* Für die Energieversorgung kommt ein LiFePO4-Akku zum Einsatz, welcher die Steuerung sowie die Peripherie mit Strom versorgt. Die Versorgung soll dabei in Peripherie und Steuerung getrennt werden, damit bei Betätigung des Hauptschalters nur die Versorgung zur Peripherie getrennt wird und Störungen durch Aktoren die Versorgung der Steuerung nicht beeinflussen. Verschiedene Spannungspegel für Motoren, Sensoren oder Steuerung werden mit DC/DC-Konvertern realisiert.

Die Spannungsüberwachung mittels ADC am Mikrocontroller erkennt den Akkuzustand sowie den Zustand des Hauptschalters und kann dies dem Raspberry Pi signalisieren. Einzelne Zellen mit einer Nennspannung von 3.2 V können in Serie geschaltet werden, um eine höhere Spannung für das Ansteuern von Motoren zu erreichen.

#pagebreak()

#vor-risiko(
  ([Spannung bricht unter Last kaum zusammen],),
  ([Hohes Gewicht (viele Aktoren erfordern grössere Kapazität)], [Trennung der Spannungsversorgung von Steuerung und Peripherie (Störungen)]),
)

*Ausgabeelemente.* Eine Kombination aus LED-Matrix und einem Lautsprecher soll die Emotion des Roboterhundes bestmöglich wiedergeben. Dabei werden LED-Matrizen als Augen des Hundes verwendet, welche einzeln adressierbar über den Mikrocontroller gesteuert werden können. Mit einem geeigneten Verstärker und einem kleinen Lautsprecher können vom Raspberry Pi aus direkt Audiosignale ausgegeben werden.
#vor-risiko(
  ([Emotionen werden gut dargestellt],),
  ([LEDs haben unter Umständen einen hohen Strombedarf ohne Helligkeitsbegrenzung], [LED-Helligkeit stört die Kamera], [Viele Aktoren, begrenzte Mikrocontroller-Pins]),
)

*Verhalten und Bewegung.* Für weiteres emotionales Feedback sorgen ein wedelnder Schwanz, welcher von einem Servomotor hin und her bewegt wird, sowie ein neigbarer Kopf. Der neigbare Kopf stellt zudem sicher, dass das Kamerabild über den Neigungswinkel verändert werden kann.
#vor-risiko(
  ([Kameraausrichtung lässt sich steuern], [Emotionen werden gut dargestellt]),
  ([Viele Aktoren, begrenzte Mikrocontroller-Pins], [Stabilität des Kopfs muss für die Kamera gewährleistet sein]),
)

// TODO: Mechanik «Spass»: Beinantrieb mit Servomotoren (laut Kasten) – im Word nicht beschrieben.
// TODO: Simulationsumgebung und Ablauflogik/Visualisierung – im Word leer (Kasten: «Spass» zusätzlich Rerun).
