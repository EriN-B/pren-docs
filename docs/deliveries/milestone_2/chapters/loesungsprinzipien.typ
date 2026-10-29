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

Die Lösungsfindung orientiert sich am systematischen Vorgehen nach Pahl/Beitz @pahl-beitz: Ausgehend von der Funktionszerlegung aus Meilenstein 1 wurden für jede Teilfunktion Lösungsprinzipien recherchiert und bewertet (Technologierecherche). Die Lösungsprinzipien werden im morphologischen Kasten gegenübergestellt (@kap-morph-kasten) und anhand von Recherche und ersten Tests evaluiert (@kap-eval-teilfunktionen). Durch Kombination je einer Ausprägung pro Parameter entstehen drei Lösungsvarianten (@kap-loesungsvarianten), die mit einem paarweisen Vergleich und einer Nutzwertanalyse bewertet werden (@kap-loesungskombination).

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

== Evaluation pro Teilfunktion <kap-eval-teilfunktionen>

// TODO: Pro Teilfunktion 2–4 Sätze: Welche Ausprägung wird bevorzugt und warum (Bezug auf
//       Bewertung in der Technologierecherche MS1, Tests, Anforderungen). Verantwortliche gemäss
//       Sprint 3 (Sprintplanung_v1.xlsx) in Klammern.

=== Mechanik

==== Fortbewegung
#entscheid(
  gewaehlt: [Beine mit Rädern (Gelenk)],
  verworfen: [Laufbeine; Beine mit Rädern (starr); Beine mit Rädern (ein- und ausfahrbar)],
)
Das Fortbewegungskonzept ist in allen drei Lösungsvarianten gleich und in @kap-gemeinsame-basis beschrieben.
// TODO: Bewertung/Begründung ergänzen (Jan Grisiger, Lee Kürsener).

==== Design (Beingeometrie)
#entscheid(
  gewaehlt: [je nach Variante: A · Beine starr bzw. C · Knickbeine],
  verworfen: [B · Beine an der Hüfte schwenkbar],
)
#offen[Begründung Designentscheid und Skizzen A–C (Jan Grisiger, Lee Kürsener)]

==== Antriebskonzepte
#entscheid(
  gewaehlt: [Räder: DC-Motor mit Encoder bzw. DC-Motor; Beine: Servomotor, DC-Motor mit Endlagenschalter oder Linearaktuator (je nach Variante)],
  verworfen: [Schrittmotor; Servomotor (Räder); Linearmotor],
)
#offen[Begründung, erste Auslegung Drehmoment/Kraft (Jan Grisiger, Lee Kürsener)]

#pagebreak()
=== Elektronik

==== Energie
#entscheid(
  gewaehlt: [je nach Variante: LiPo-Akku, LiFePO4-Akku oder mehrere Akkus als USV],
  verworfen: [Powerbank (USB-C); kommerzieller Akku mit DC/DC-Konverter],
)
#offen[Begründung, grobe Energiebilanz für einen Lauf von ca. 4 min (Eric Frick, Samuel Felder)]

==== Rechenplattform <kap-eval-rechenplattform>
#entscheid(
  gewaehlt: [#offen[Raspberry Pi 4 (4 GB) oder Raspberry Pi 5 (4 GB) – Teamentscheid]],
  verworfen: [NVIDIA Jetson Orin Nano (Budget)],
)
// TODO: ENTSCHEID NÖTIG – Der Text unten (aus «Sprach- und Objekterkennung.docx») bevorzugt den
//       Raspberry Pi 5, Morph. Kasten, Lösungsvarianten, Nutzwertanalyse und Budget gehen vom
//       Raspberry Pi 4 aus. Nach dem Entscheid Box oben und ggf. die anderen Kapitel anpassen.
// Text wörtlich aus «Sprach- und Objekterkennung.docx» (Abschnitt Rechenarchitektur).
Die bisherigen Tests wurden auf einem Raspberry Pi 4 mit vier CPU-Kernen durchgeführt. Die gemessenen CPU-Auslastungen ermöglichen eine erste Abschätzung des gleichzeitigen Betriebs (@tab-cpu-kombination).

#figure(
  {
    set text(size: 9pt)
    table(
      columns: (1fr, auto, auto),
      align: (x, _) => if x == 0 { left } else { center },
      table.header([Modellkombination], [Addierte CPU-Auslastung], [Verbleibende Kapazität]),
      [YOLOE-26n + Vosk], [279 %], [121 %],
      [YOLO-World + Vosk], [236 %], [164 %],
      [YOLOE-26n + Whistle], [565 %], [keine],
      [YOLOE-26n + Whisper], [547 %], [keine],
    )
  },
  caption: [Abschätzung der CPU-Auslastung auf dem Raspberry Pi 4 bei gleichzeitigem Betrieb],
) <tab-cpu-kombination>

Da maximal 400 % CPU-Leistung zur Verfügung stehen, können die Kombinationen mit Whisper und Whistle ihre einzeln gemessene Verarbeitungsgeschwindigkeit bei gleichzeitiger Ausführung nicht aufrechterhalten. Dadurch wären Verzögerungen zu erwarten.

YOLOE-26n und Vosk benötigen zusammen rechnerisch ungefähr 279 % CPU-Leistung. Damit verbleiben rund 121 % für Gestenerkennung, Navigation und weitere Systemprozesse. Wobei aber nicht alle gleichzeitig laufen werden.

Der Raspberry Pi 4 könnte die bevorzugte Modellkombination somit grundsätzlich bewältigen. Allerdings ist unklar, ob die verbleibende Rechenleistung für alle weiteren Funktionen ausreicht.

Der Raspberry Pi 5 bietet durch seinen leistungsfähigeren Prozessor zusätzliche Reserven. Falls im Verlauf weiterer Tests Bedenken zur Rechenkapazität aufkommen, sollte ein Wechsel zu dieser Plattform diskutiert werden.

Für die weitere Konzeptentwicklung wird der Raspberry Pi 5 mit 4 GB RAM bevorzugt. Die zusätzliche Rechenleistung reduziert das Risiko von Engpässen und ermöglicht mehr Spielraum für spätere Anpassungen. Der Raspberry Pi 4 bleibt jedoch eine realistische Alternative, da die bevorzugten Modelle bereits darauf funktionieren.

#pagebreak()
==== Steuerung
#entscheid(
  gewaehlt: [Raspberry Pi Pico 2 als Mikrocontroller für hardwarenahe Aufgaben],
  verworfen: [TinyK22; ESP32-S3; ESP32 (C-Series / Classic)],
)
Die Steuerungsarchitektur ist in allen drei Lösungsvarianten gleich und in @kap-gemeinsame-basis beschrieben. Ein erster Test hat gezeigt, dass der Pico 2 geeignet ist (Sitzung vom 09.10.2026).
// TODO: Testergebnis Pico 2 konkretisieren (was wurde getestet? PWM?) – Samuel Felder.

==== Schnittstelle / Kommunikation
#entscheid(
  gewaehlt: [UART zwischen Raspberry Pi und Mikrocontroller],
  verworfen: [SPI; I²C; WLAN (MQTT)],
)
#offen[Begründung, Protokoll (z. B. ACK/NACK, siehe Risiko R16) – Eric Frick, Samuel Felder]

=== Wahrnehmung

==== Navigation
#entscheid(
  gewaehlt: [Odometrie (Encoder + IMU)],
  verworfen: [SLAM / V-SLAM],
)
#offen[Begründung; Suchstrategie im 30°-Segment; Rückkehr ins Startfeld (Cédric Gerber, Erin Bachmann, Eric Frick, Samuel Felder)]

==== Objekterkennung <kap-eval-objekterkennung>
#entscheid(
  gewaehlt: [RGB-Kamera am Kopf und Ultraschallsensor in Bodennähe; Software YOLOE-26n],
  verworfen: [Lidar; Time-of-Flight-, KI- und Stereo-Kamera; YOLO-World; YOLO26n],
)
// Text wörtlich aus «Sprach- und Objekterkennung.docx» (Abschnitt Objekterkennung);
// Dezimalkomma → Dezimalpunkt gemäss Berichtskonvention, Quellenangaben ergänzt.
Zur Erkennung des Knochens wurden YOLO-World @ultralytics-yoloworld und YOLO-26n @ultralytics-yolo26 vorgesehen. Da YOLO-26n Fine-Tuning benötigt, ist es kaum sinnvoll. Bei der genaueren Evaluation von YOLO-World ist uns jedoch das Modell YOLOE-26n @ultralytics-yoloe aufgefallen. Es ist kleiner als das World-Modell, benötigt aber kein eigenes Training. Beide wurden dann auf einem Raspberry Pi 4 getestet. Dabei wurden drei Positivbilder mit Knochen und zwei Negativbilder ohne Knochen verwendet (@tab-test-objekterkennung).

Für den späteren Videobetrieb wurde YOLOE-26n auf die Ausgabe von Bounding Boxes ohne Segmentierung reduziert und im NCNN-Format exportiert. Das Modell verwendet eine feste Eingabeauflösung von 512 × 384 Pixeln und einen Konfidenzschwellwert von 0.30. Die vier Textbeschreibungen «bone», «dog bone», «dog chew bone» und «chew toy» sind im exportierten Modell fest hinterlegt. Neue Beschreibungen erfordern einen erneuten Export.

#figure(
  {
    set text(size: 9pt)
    table(
      columns: (1fr, auto, auto),
      align: (x, _) => if x == 0 { left } else { center },
      table.header([Kriterium], [YOLO-World], [YOLOE-26n]),
      [Ø Inferenzzeit], [2.06 s], [0.235 s],
      [FPS], [0.12], [4.20],
      [Ø CPU-Auslastung], [136 %], [179 %],
      [True Positives], [2/3], [3/3],
      [False Positives], [1/2], [0/2],
      [Total Ergebnisse], [3/5], [5/5],
    )
  },
  caption: [Vergleich der Objekterkennung auf dem Raspberry Pi 4],
) <tab-test-objekterkennung>

YOLOE-26n mit NCNN wird bevorzugt, da alle fünf Testbilder korrekt ausgewertet wurden und der separate Leistungstest durchschnittlich 4.26 Bilder pro Sekunde erreichte. YOLO-World erkannte im letzten Vergleichstest nur eines der drei Positivbilder. Bei beiden Modellen wurden die zwei Negativbilder korrekt zurückgewiesen.
// TODO: Widerspruch klären – Tabelle: YOLO-World 2/3 TP und 1/2 FP; Text: 1/3 erkannt, beide
//       Negativbilder korrekt zurückgewiesen, aber im nächsten Absatz «ein False Positive».

YOLOE-26n mit NCNN benötigt während der Inferenz zwar mehr CPU-Leistung, verarbeitet die Bilder jedoch wesentlich schneller. Bei YOLO-World trat zudem ein False Positive auf (@fig-yoloworld-fp). Aufgrund der längeren Inferenzzeit und geringeren Zuverlässigkeit wird dieses Modell nicht weiter priorisiert.

#figure(
  image("../assets/yoloworld-false-positive.jpg", width: 70%),
  caption: [False Positive von YOLO-World: Murmeltier als «dog chew bone» erkannt (Konfidenz 0.357)],
) <fig-yoloworld-fp>

Hierbei ist noch wichtig zu erwähnen, dass das Ganze nicht auf der schlussendlichen Kamera getestet werden konnte.

==== Gestenerkennung
#entscheid(
  gewaehlt: [MediaPipe Hand Landmarker mit k-Nearest-Neighbors-Klassifikator],
  verworfen: [MobileCLIP2-S2],
)
// Text wörtlich aus «Sprach- und Objekterkennung.docx» (Abschnitt Gestenerkennung).
Für die Erkennung der drei Handgesten «Sitz», «Platz» und «Auf» wurden MediaPipe Hand Landmarker @mediapipe und MobileCLIP2-S2 @mobileclip untersucht.

MediaPipe wurde bereits auf einem Laptop getestet und wird für die weitere Entwicklung bevorzugt. Das Modell erkennt die Gelenkpunkte der Hand, anhand derer die drei Gesten durch eine eigene Logik unterschieden werden können. MobileCLIP2-S2 wird aufgrund der schlechten Erkennung und des höheren Rechenaufwands verworfen.

Ein Test auf dem Raspberry Pi 4 wurde nicht gemacht und wird auch nicht als nötig empfunden. Da MediaPipe für ressourcenbeschränkte Geräte optimiert ist und die Gestenerkennung auf einem vergleichsweise leichtgewichtigen Modell mit anschliessender Auswertung der Gelenkpunkte basiert, wird die Ausführung auf dem Raspberry Pi 4 als sehr sicher lauffähig eingeschätzt. Es bestehen keine Bedenken diesbezüglich. Die tatsächliche CPU-Auslastung und Erkennungsgeschwindigkeit müssen jedoch im Betrieb gemessen werden.
// TODO: Letzter Satz im Original unvollständig («müssen jedoch im werden») – Ergänzung «Betrieb gemessen» prüfen.

==== Audioerfassung
#entscheid(
  gewaehlt: [USB-Mikrofon direkt am Raspberry Pi],
  verworfen: [Spracherkennungsmodul],
)
#offen[Begründung – Spracherkennungsmodul vs. Mikrofon (Samuel Felder, Cédric Gerber)]

==== Spracherkennung <kap-eval-spracherkennung>
#entscheid(
  gewaehlt: [Vosk],
  verworfen: [OpenAI Whisper; Whistle; Picovoice Rhino],
)
// Text wörtlich aus «Sprach- und Objekterkennung.docx» (Abschnitt Spracherkennung).
Für die Spracherkennung wurden Whisper @whisper, Whistle und Vosk @vosk auf einem Raspberry Pi 4 verglichen. Alle drei Modelle erkannten die sechs gesprochenen Testwörter korrekt (@tab-test-spracherkennung).

#figure(
  {
    set text(size: 9pt)
    table(
      columns: (1fr, auto, auto, auto),
      align: (x, _) => if x == 0 { left } else { center },
      table.header([Modell], [Verarbeitungszeit (12.14 s Audio)], [CPU-Auslastung], [Testergebnisse]),
      [Whisper], [50.87 s], [362.6 %], [Alle bestanden],
      [Whistle], [5.18 s], [353.1 %], [Alle bestanden],
      [Vosk], [2.76 s], [99 %], [Alle bestanden],
    )
  },
  caption: [Vergleich der Spracherkennung auf dem Raspberry Pi 4],
) <tab-test-spracherkennung>

Die CPU-Auslastung bezieht sich auf die vier Kerne des Raspberry Pi 4, wobei 100 % einem vollständig ausgelasteten Kern entsprechen.

Vosk wird bevorzugt, da es die kürzeste Verarbeitungszeit und mit Abstand die geringste CPU-Auslastung aufwies.

Whisper wird aufgrund der sehr langen Verarbeitungszeit ausgeschlossen. Bereits bei alleiniger Ausführung benötigte das Modell rund 50 Sekunden für eine zwölf Sekunden lange Aufnahme.

Whistle verarbeitet die Aufnahme zwar schneller als in Echtzeit, beansprucht dabei jedoch nahezu alle vier CPU-Kerne. Bei gleichzeitiger Objekterkennung ist deshalb mit erheblichen Leistungseinbussen zu rechnen.

Vosk beansprucht dagegen nur ungefähr einen CPU-Kern und lässt somit deutlich mehr Ressourcen für die Bildverarbeitung frei.

Die Unterscheidung zwischen eigenständigen Sprachbefehlen und Wörtern innerhalb gewöhnlicher Sätze muss noch verbessert werden. Auch die Erkennung über ein Mikrofon im Livebetrieb steht noch aus.
// TODO: Picovoice Rhino – Begründung, weshalb nicht getestet.

#pagebreak()
=== Reaktion

==== Ausgabeelemente und Verhalten
#entscheid(
  gewaehlt: [Lautsprecher (alle Varianten); zusätzlich LED-Matrix («Spass»); wedelnder Schwanz, neigbarer Kopf (je nach Variante)],
  verworfen: [Einzelne LEDs; OLED-Displays; Kreis drehen; Revier markieren],
)
#offen[Begründung (Eric Frick, Samuel Felder); Bezug zum akustischen Signal am Suchende (Aufgabenstellung 3.5)]

=== Simulation

==== Simulator
#entscheid(
  gewaehlt: [Eigenentwicklung (2D-Welt in Python) mit Python-Statemachine; Variante «Spass» zusätzlich Rerun zur Visualisierung],
  verworfen: [IR-SIM; Webots; CoppeliaSim; Gazebo + ROS 2; PyBullet; Behaviour Trees; NiceGUI],
)
#offen[Begründung; Architektur (Austausch von Simulator und Roboter über gemeinsame Schnittstellen, Anforderung 6.02) – Cédric Gerber, Erin Bachmann]
