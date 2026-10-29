// ─────────────────────────────────────────────────────────────
//  Kapitel: Einleitung und Rückmeldungen zu Meilenstein 1
//  Quellen: Bewertet_TEAM3-Konzeptbericht-Meilenstein-1-v1.0.0.pdf,
//           Protokoll_SW4.docx (OneDrive)
//  Wird in «doc.typ» per #include eingebunden.
// ─────────────────────────────────────────────────────────────

= Einleitung <kap-einleitung>

// TODO: Einleitung prüfen/ergänzen (Zweck MS2, Aufbau des Berichts).
Dieser Bericht dokumentiert den Stand von Team 03 zu Meilenstein 2. Gemäss Aufgabenstellung umfasst Meilenstein 2 die Evaluation der Lösungsprinzipien und die Auswahl der optimalen Lösungskombination @aufgabe. Grundlage bilden die Anforderungsliste, die Funktionszerlegung und die Technologierecherche aus Meilenstein 1.

Der Bericht ist wie folgt aufgebaut: @kap-projektplanung zeigt den Projektstand mit einem Soll-Ist-Vergleich. @kap-anforderungen enthält die nachgeführte Anforderungsliste. @kap-loesungsprinzipien beschreibt das Vorgehen und die Evaluation der Lösungsprinzipien im morphologischen Kasten. Daraus abgeleitet werden in @kap-loesungsvarianten drei Lösungsvarianten beschrieben, die in @kap-loesungskombination mit einem paarweisen Vergleich und einer Nutzwertanalyse bewertet werden. @kap-risikoanalyse enthält die Risikoanalyse der gewählten Lösungsvariante.

== Rückmeldungen zu Meilenstein 1 <kap-rueckmeldungen>

Die Rückmeldungen der Betreuung zu Meilenstein 1 wurden im Team besprochen (Sitzung vom 09.10.2026). @tab-rueckmeldungen zeigt, wie sie umgesetzt wurden.

#figure(
  {
    set text(size: 9pt)
    set par(justify: false, leading: 0.55em)
    table(
      columns: (3cm, 1fr, 1fr),
      align: left + top,
      table.header([Kapitel], [Rückmeldung], [Umsetzung]),
      [Projektplanung], [Keine Planung, nur Ist-Zustand; Soll-Ist-Vergleich fehlt], [Sprintplanung mit Soll- und Ist-Stunden pro Aufgabe eingeführt (@kap-projektplanung)],
      [Anforderungsliste], [Gesten- und Sprachbefehle doppelt erfasst (1.09/1.10 und Wettbewerb)], [Doppelte Anforderungen entfernt, Zeitvorgaben aufgeteilt, Geschwindigkeit als Mindestanforderung (@kap-anforderungen)],
      [Funktionszerlegung], [Genügend detailliert?], [// TODO: Umsetzung festhalten (Funktionszerlegung verfeinert? Teilfunktionen im morphologischen Kasten?)
        _offen_],
      [Technologierecherche], [Nicht bewertete Varianten: bis wann?], [Designvarianten in der Nutzwertanalyse bewertet (@kap-loesungskombination)],
      [Technologierecherche], [Üblich ist die Bewertung der Informationsquelle, nicht der Eignung], [Bewertungsgrundlage im Bericht zu Meilenstein 1 erklärt: bewertet wird das Lösungsprinzip, nicht die Quelle],
      [Rechenplattform], [Raspberry Pi 4 war vor einigen Jahren ein Top-Gerät], [Leistungstests auf dem Raspberry Pi 4 durchgeführt, Raspberry Pi 5 als Alternative evaluiert (@kap-eval-rechenplattform)],
      [Navigation], [SLAM und V-SLAM getrennt betrachten], [// TODO: Umsetzung festhalten
        _offen_],
      [Risikoanalyse], [Massnahmen nach Verhinderung und Schadensbegrenzung trennen; Skala sehr grob], [Massnahmen aufgeteilt, Skala auf 1–4 erweitert (@kap-risikoanalyse)],
    )
  },
  caption: [Umsetzung der Rückmeldungen zu Meilenstein 1],
) <tab-rueckmeldungen>
