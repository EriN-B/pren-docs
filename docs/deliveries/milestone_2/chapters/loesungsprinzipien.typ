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

// ─────────────────────────────────────────────────────────────

= Evaluation der Lösungsprinzipien <kap-loesungsprinzipien>

== Vorgehen <kap-vorgehen>

Die Lösungsfindung orientiert sich am systematischen Vorgehen nach Pahl/Beitz @pahl-beitz: Ausgehend von der Funktionszerlegung aus Meilenstein 1 wurden für jede Teilfunktion Lösungsprinzipien recherchiert und bewertet (Technologierecherche). Die Lösungsprinzipien werden im morphologischen Kasten gegenübergestellt (@kap-morph-kasten) und anhand von Recherche und ersten Tests evaluiert (@kap-eval-teilfunktionen). Durch Kombination je einer Ausprägung pro Parameter entstehen drei Lösungsvarianten (@kap-loesungsvarianten), die mit einem paarweisen Vergleich und einer Nutzwertanalyse bewertet werden (@kap-loesungskombination).

// TODO: Prüfen, ob die Parameter des Kastens 1:1 der Funktionszerlegung aus MS1 entsprechen
//       (MS1: 12 Funktionsbereiche; Kasten: 17 Parameter in 5 Bereichen). Abweichungen begründen.

== Morphologischer Kasten <kap-morph-kasten>

Der morphologische Kasten umfasst 17 Parameter in den fünf Bereichen Mechanik, Elektronik, Wahrnehmung, Reaktion und Simulation (@fig-morph-kasten). Für jeden Parameter sind die Ausprägungen aus der Technologierecherche aufgeführt. Die farbigen Markierungen zeigen, welche Ausprägung in welcher Lösungsvariante gewählt wurde.

#figure(
  image("../assets/morphologischer-kasten.png", width: 100%),
  caption: [Morphologischer Kasten mit den drei Lösungsvarianten],
) <fig-morph-kasten>

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
Die Fortbewegung erfolgt rollend über Räder an den Beinenden; die Beine dienen der Höhenverstellung und den Körperhaltungen «Sitz», «Platz» und «Auf». Gelenkt wird über einen Differenzialantrieb, wodurch der Roboter an Ort drehen kann. Gegenüber Laufbeinen ist diese Lösung schneller, energieeffizienter und einfacher zu regeln.
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

=== Elektronik

==== Energie
#entscheid(
  gewaehlt: [je nach Variante: LiPo-Akku, LiFePO4-Akku oder mehrere Akkus als USV],
  verworfen: [Powerbank (USB-C); kommerzieller Akku mit DC/DC-Konverter],
)
#offen[Begründung, grobe Energiebilanz für einen Lauf von ca. 4 min (Eric Frick, Samuel Felder)]

==== Rechenplattform <kap-eval-rechenplattform>
#entscheid(
  gewaehlt: [Raspberry Pi 4 (4 GB)],
  verworfen: [NVIDIA Jetson Orin Nano (Budget)],
)
Die Modelle für Objekt- und Spracherkennung wurden auf einem Raspberry Pi 4 mit vier CPU-Kernen getestet (siehe @kap-eval-objekterkennung und @kap-eval-spracherkennung). @tab-cpu-kombination zeigt die addierte CPU-Auslastung bei gleichzeitigem Betrieb; 100 % entsprechen einem voll ausgelasteten Kern, verfügbar sind 400 %.

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

Die bevorzugte Kombination aus YOLOE-26n und Vosk lässt rechnerisch rund 121 % CPU-Leistung für Gestenerkennung, Navigation und Systemprozesse frei. Ob diese Reserve ausreicht, ist noch offen.
// TODO: ENTSCHEID NÖTIG – Widerspruch in den Unterlagen: «Sprach- und Objekterkennung.docx» bevorzugt
//       Raspberry Pi 5 (4 GB) für die weitere Konzeptentwicklung, Morph. Kasten, Nutzwertanalyse und
//       Budget gehen vom Raspberry Pi 4 aus. Entscheid hier und in der Nutzwertanalyse festhalten.

==== Steuerung
#entscheid(
  gewaehlt: [Raspberry Pi Pico 2 als Mikrocontroller für hardwarenahe Aufgaben],
  verworfen: [TinyK22; ESP32-S3; ESP32 (C-Series / Classic)],
)
Die Steuerung ist zweigeteilt: Der Raspberry Pi übernimmt Objekt-, Gesten- und Spracherkennung sowie die Audioausgabe, der Mikrocontroller die zeitkritischen Aufgaben wie Motoransteuerung, Aktoren und Überwachung von Tastern und Hauptschalter. Ein erster Test hat gezeigt, dass der Pico 2 geeignet ist (Sitzung vom 09.10.2026).
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
Für die Software wurden YOLO-World @ultralytics-yoloworld und YOLOE-26n @ultralytics-yoloe auf einem Raspberry Pi 4 mit drei Bildern mit Knochen und zwei Bildern ohne Knochen verglichen (@tab-test-objekterkennung). YOLO26n @ultralytics-yolo26 wurde nicht getestet, da es ein eigenes Training erfordert. YOLOE-26n wurde im NCNN-Format exportiert, auf Bounding Boxes ohne Segmentierung reduziert und mit einer Eingabeauflösung von 512 × 384 Pixeln, einem Konfidenzschwellwert von 0.30 und den Textbeschreibungen «bone», «dog bone», «dog chew bone» und «chew toy» betrieben.

#figure(
  {
    set text(size: 9pt)
    table(
      columns: (1fr, auto, auto),
      align: (x, _) => if x == 0 { left } else { center },
      table.header([Kriterium], [YOLO-World], [YOLOE-26n]),
      [Ø Inferenzzeit], [2.06 s], [0.235 s],
      [Bilder pro Sekunde], [0.12], [4.20],
      [Ø CPU-Auslastung], [136 %], [179 %],
      [True Positives], [2 / 3], [3 / 3],
      [False Positives], [1 / 2], [0 / 2],
      [Korrekte Ergebnisse], [3 / 5], [5 / 5],
    )
  },
  caption: [Vergleich der Objekterkennung auf dem Raspberry Pi 4],
) <tab-test-objekterkennung>

YOLOE-26n wird bevorzugt, da alle fünf Testbilder korrekt ausgewertet wurden und die Verarbeitung rund 17-mal schneller ist. Die Tests erfolgten noch nicht mit der endgültigen Kamera.
// TODO: Widerspruch klären – Text im Testdokument: «YOLO-World erkannte nur eines der drei Positivbilder»
//       und «beide Modelle wiesen die Negativbilder korrekt zurück», Tabelle sagt 2/3 TP und 1/2 FP.

==== Gestenerkennung
#entscheid(
  gewaehlt: [MediaPipe Hand Landmarker mit k-Nearest-Neighbors-Klassifikator],
  verworfen: [MobileCLIP2-S2],
)
MediaPipe @mediapipe erkennt die Gelenkpunkte der Hand; anhand dieser Koordinaten werden die Gesten «Sitz», «Platz» und «Auf» klassifiziert. In Tests auf einem Laptop zeigte MediaPipe eine bessere Erkennung bei geringerem Rechenaufwand als MobileCLIP2-S2 @mobileclip. Ein Test auf dem Raspberry Pi 4 steht noch aus.
// TODO: Testaufbau/Resultate Laptop-Test quantifizieren (Anzahl Gesten, Personen, Erkennungsrate).

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
Whisper @whisper, Whistle und Vosk @vosk wurden auf einem Raspberry Pi 4 mit einer Aufnahme von 12.14 s Länge verglichen (@tab-test-spracherkennung). Alle drei Modelle erkannten die sechs gesprochenen Testwörter korrekt.

#figure(
  {
    set text(size: 9pt)
    table(
      columns: (1fr, auto, auto, auto),
      align: (x, _) => if x == 0 { left } else { center },
      table.header([Modell], [Verarbeitungszeit], [CPU-Auslastung], [Testwörter erkannt]),
      [Whisper], [50.87 s], [362.6 %], [6 / 6],
      [Whistle], [5.18 s], [353.1 %], [6 / 6],
      [Vosk], [2.76 s], [99 %], [6 / 6],
    )
  },
  caption: [Vergleich der Spracherkennung auf dem Raspberry Pi 4 (Aufnahme 12.14 s)],
) <tab-test-spracherkennung>

Vosk wird bevorzugt, da es die kürzeste Verarbeitungszeit und mit rund einem Kern die mit Abstand geringste CPU-Auslastung aufweist. Offen sind die Unterscheidung zwischen eigenständigen Befehlen und Wörtern in Sätzen sowie ein Test über das Mikrofon im Live-Betrieb.
// TODO: Picovoice Rhino – Begründung, weshalb nicht getestet.

=== Reaktion

==== Ausgabeelemente und Verhalten
#entscheid(
  gewaehlt: [je nach Variante: LED-Matrix, Lautsprecher, Piezo-Buzzer; wedelnder Schwanz, neigbarer Kopf],
  verworfen: [Einzelne LEDs; OLED-Displays; Kreis drehen; Revier markieren],
)
#offen[Begründung (Eric Frick, Samuel Felder); Bezug zu Anforderung 1.13 (akustisches Signal am Suchende)]

=== Simulation

==== Simulator
#entscheid(
  gewaehlt: [Eigenentwicklung (2D-Welt in Python) mit Python-Statemachine; Variante «Spass» zusätzlich Rerun zur Visualisierung],
  verworfen: [IR-SIM; Webots; CoppeliaSim; Gazebo + ROS 2; PyBullet; Behaviour Trees; NiceGUI],
)
#offen[Begründung; Architektur (Austausch von Simulator und Roboter über gemeinsame Schnittstellen, Anforderung 6.02) – Cédric Gerber, Erin Bachmann]
