# Anleitung: An der Dokumentation mitarbeiten

Diese Anleitung richtet sich an alle im Team, die noch nie mit Git, GitHub oder
Typst gearbeitet haben. Sie führt Schritt für Schritt von der Installation bis
zur eigenen Änderung im Bericht. Du brauchst keine Vorkenntnisse.

**Inhalt**

1. [Worum geht es? (5 Minuten Theorie)](#1-worum-geht-es-5-minuten-theorie)
2. [Nur anschauen – ganz ohne Installation](#2-nur-anschauen--ganz-ohne-installation)
3. [Einmalige Einrichtung](#3-einmalige-einrichtung)
4. [Der Arbeitsablauf für jede Änderung](#4-der-arbeitsablauf-für-jede-änderung)
5. [Typst-Grundlagen](#5-typst-grundlagen)
6. [Feedback geben, ohne selbst zu ändern](#6-feedback-geben-ohne-selbst-zu-ändern)
7. [Probleme und Lösungen](#7-probleme-und-lösungen)
8. [Spickzettel](#8-spickzettel)
9. [Glossar](#9-glossar)

---

## 1. Worum geht es? (5 Minuten Theorie)

### Die drei Werkzeuge

| Werkzeug    | Was es ist                                                                                   | Vergleich                                             |
|-------------|----------------------------------------------------------------------------------------------|-------------------------------------------------------|
| **Typst**   | Eine Sprache, in der wir den Bericht schreiben. Aus Textdateien (`.typ`) entsteht ein PDF.  | Wie Word, nur dass man Text mit ein paar Zeichen formatiert statt mit Knöpfen. |
| **Git**     | Ein Programm, das jede Änderung an den Dateien speichert und nachvollziehbar macht.          | Wie der Versionsverlauf in Word/OneDrive, nur genauer. |
| **GitHub**  | Die Webseite, auf der unser Projekt liegt: <https://github.com/EriN-B/pren-docs>            | Wie ein gemeinsamer SharePoint-Ordner für Git.        |

Dazu kommt **VS Code**, ein Editor, in dem du die Dateien bearbeitest, das PDF
live siehst und Git per Mausklick bedienst. Ein Terminal brauchst du nur ganz
kurz bei der Einrichtung.

### Warum nicht einfach Word?

- Alle können gleichzeitig an verschiedenen Kapiteln arbeiten, ohne sich gegenseitig zu überschreiben.
- Jede Änderung ist mit Name, Datum und Begründung gespeichert und lässt sich rückgängig machen.
- Layout, Nummerierung, Verzeichnisse und Quellen macht die Vorlage automatisch – alle Berichte sehen gleich aus.
- Bei jeder Änderung baut GitHub automatisch ein PDF zum Anschauen.

### Das Wichtigste in einem Bild

![Ablauf: 1 Pull, 2 Branch erstellen, 3 auf dem Laptop bearbeiten, prüfen und committen, 4 Push, 5 Pull Request, 6 Merge in main](anleitung/git-ablauf.svg)

- **`main`** ist der offizielle Stand des Berichts. Dort arbeitet niemand direkt.
- Für jede Änderung erstellst du einen eigenen **Branch** (eine Abzweigung, eine Art Kopie zum Ausprobieren).
- Du speicherst deine Arbeit in **Commits** (Zwischenstände mit kurzer Beschreibung).
- Mit **Push** lädst du deine Commits auf GitHub hoch.
- Mit einem **Pull Request (PR)** schlägst du vor, deine Änderungen in `main` zu übernehmen. Jemand schaut drüber, dann wird er **gemergt** (übernommen).

Die Nummern im Bild entsprechen genau der Reihenfolge, in der du später arbeitest (siehe [Kapitel 4](#4-der-arbeitsablauf-für-jede-änderung)).

Mehr braucht es nicht. Die Fachbegriffe stehen nochmals im [Glossar](#9-glossar).

---

## 2. Nur anschauen – ganz ohne Installation

Wenn du nur lesen willst, brauchst du nichts zu installieren.

### Das fertige PDF herunterladen

1. Öffne <https://github.com/EriN-B/pren-docs/releases>.
2. Jeder Eintrag ist eine freigegebene Version einer Abgabe, z. B. `milestone_1/v1.2.0`.
3. Klicke beim gewünschten Eintrag unter **Assets** auf die PDF-Datei (beginnt mit `TEAM3-…`).

### Den Entwurf eines Pull Requests anschauen

1. Öffne <https://github.com/EriN-B/pren-docs/pulls>.
2. Klicke auf einen Pull Request.
3. Weiter unten hat ein Bot einen Kommentar mit einem **Download-Link** zum Vorschau-PDF geschrieben. Dieses PDF hat das Wasserzeichen «ENTWURF».

### Die Quelltexte anschauen

Auf <https://github.com/EriN-B/pren-docs> kannst du dich durch die Ordner klicken.
Die Kapitel liegen in `docs/deliveries/<abgabe>/chapters/`, zum Beispiel
`docs/deliveries/milestone_2/chapters/`.

---

## 3. Einmalige Einrichtung

Plane dafür etwa 30 Minuten ein. Du machst das nur einmal pro Laptop.

### 3.1 GitHub-Konto erstellen

1. Gehe auf <https://github.com/signup> und erstelle ein Konto (gratis). Die HSLU-Mailadresse geht, eine private auch.
2. Schicke deinen **GitHub-Benutzernamen** an Erin.
3. Erin lädt dich ins Projekt ein. Du bekommst eine E-Mail von GitHub – klicke darin auf **Accept invitation**. (Alternativ: <https://github.com/EriN-B/pren-docs/invitations> öffnen.)

Ohne angenommene Einladung kannst du später nichts hochladen.

### 3.2 Git installieren

<details open>
<summary><b>Windows</b></summary>

1. Lade Git herunter: <https://git-scm.com/downloads/win> (der Download startet meist automatisch, sonst «64-bit Git for Windows Setup» wählen).
2. Starte den Installer. Du kannst überall **Next** klicken, mit zwei Ausnahmen:
   - Bei «Choosing the default editor used by Git» wählst du **Use Visual Studio Code as Git's default editor** (falls VS Code noch nicht installiert ist, geht auch die Voreinstellung).
   - Bei «Adjusting the name of the initial branch» wählst du **Override the default branch name** und trägst `main` ein.
3. Am Ende **Finish**.

</details>

<details open>
<summary><b>macOS</b></summary>

1. Öffne das Programm **Terminal** (Cmd + Leertaste, «Terminal» tippen, Enter).
2. Tippe folgenden Befehl ein und drücke Enter:
   ```sh
   xcode-select --install
   ```
3. Es erscheint ein Fenster – klicke **Installieren** und warte, bis es fertig ist (einige Minuten).
4. Falls die Meldung «command line tools are already installed» kommt: Git ist schon da, alles gut.

</details>

**Prüfen:** Öffne ein Terminal (Windows: Startmenü → «Git Bash»; macOS: Terminal) und tippe:

```sh
git --version
```

Es sollte etwas wie `git version 2.47.0` erscheinen. Die genaue Zahl spielt keine Rolle.

### 3.3 Git sagen, wer du bist

Jeder Commit wird mit deinem Namen gespeichert. Tippe im selben Terminal diese
zwei Zeilen ein (mit deinem Namen und der E-Mail deines GitHub-Kontos):

```sh
git config --global user.name "Vorname Nachname"
git config --global user.email "deine.mail@example.com"
```

Es erscheint keine Ausgabe – das ist korrekt.

### 3.4 VS Code installieren

1. Lade VS Code herunter: <https://code.visualstudio.com/download>.
2. Installieren:
   - **Windows:** Installer ausführen. Setze im Schritt «Select Additional Tasks» die Häkchen bei **Add "Open with Code" action…** (beide) und **Add to PATH**.
   - **macOS:** Die heruntergeladene ZIP-Datei öffnen und **Visual Studio Code** in den Ordner **Programme** ziehen.
3. VS Code starten. Optional auf Deutsch umstellen: Links auf das Symbol mit den vier Quadraten (**Extensions**) klicken, «German Language Pack» suchen, **Install**, VS Code neu starten.

> In dieser Anleitung stehen die Menübegriffe auf Englisch und in Klammern
> auf Deutsch, damit du beides findest.

### 3.5 Das Projekt herunterladen («klonen»)

1. In VS Code: links auf das Symbol mit den drei verbundenen Punkten klicken (**Source Control** / **Quellcodeverwaltung**), oder `Ctrl+Shift+G` (Mac: `Cmd+Shift+G`).
2. Klicke **Clone Repository** (**Repository klonen**).
3. Oben erscheint ein Eingabefeld. Füge diese Adresse ein und drücke Enter:
   ```
   https://github.com/EriN-B/pren-docs.git
   ```
4. Wähle einen Ordner, in dem das Projekt liegen soll, z. B. `Dokumente/HSLU`. VS Code legt darin den Ordner `pren-docs` an.
5. Frage «Would you like to open the cloned repository?» → **Open** (**Öffnen**).
6. Frage «Do you trust the authors of the files in this folder?» → **Yes, I trust the authors**.

Links im **Explorer** (oberstes Symbol, zwei Blätter) siehst du jetzt die Projektdateien.

### 3.6 Typst-Erweiterung «Tinymist» installieren

Tinymist bringt Typst mit – du musst Typst nicht separat installieren.

1. Beim Öffnen des Projekts zeigt VS Code unten rechts evtl. «Do you want to install the recommended extensions?» → **Install**. Fertig.
2. Falls nicht: Links auf **Extensions** (vier Quadrate) klicken, «Tinymist» suchen, bei **Tinymist Typst** auf **Install** klicken.

Die nötigen Einstellungen (Schriftart, Projektordner) sind schon im Projekt in
`.vscode/settings.json` hinterlegt. Du musst nichts konfigurieren.

### 3.7 Test: PDF-Vorschau öffnen

1. Im Explorer `docs` → `deliveries` → `milestone_2` → **`doc.typ`** öffnen.
2. Oben rechts im Editor auf das Vorschau-Symbol (Lupe auf einem Blatt, Tooltip «Preview») klicken. Alternativ: `Ctrl+Shift+P` (Mac: `Cmd+Shift+P`), «Typst Preview» tippen, **Typst Preview: Preview Opened File** wählen.
3. Rechts erscheint der Bericht. Wenn du jetzt Text änderst, aktualisiert sich die Vorschau sofort.

> **Wichtig:** Öffne die Vorschau immer über die `doc.typ` der Abgabe, nicht
> über ein einzelnes Kapitel. Die Kapitel funktionieren nur zusammen mit der
> `doc.typ`. Die Vorschau bleibt offen und aktualisiert sich auch, wenn du
> danach ein Kapitel bearbeitest.

Mach die Test-Änderung rückgängig (`Ctrl+Z` / `Cmd+Z`). Die Einrichtung ist abgeschlossen. 🎉

### 3.8 Beim ersten Hochladen: bei GitHub anmelden

Beim ersten **Push** (siehe 4.6) fragt VS Code, ob es sich bei GitHub anmelden
darf. Klicke **Allow** / **Sign in with your browser**, melde dich im Browser an
und bestätige. Das passiert nur einmal.

---

## 4. Der Arbeitsablauf für jede Änderung

Diese Schritte machst du **jedes Mal**, wenn du etwas ändern willst. Nach zwei,
drei Malen geht das in einer Minute.

```
4.1 main aktualisieren  →  4.2 Branch erstellen  →  4.3 Bearbeiten
→  4.4 Prüfen  →  4.5 Commit  →  4.6 Push  →  4.7 Pull Request  →  4.8 Review & Merge
```

### Orientierung in VS Code

- **Unten links in der blauen/grauen Statusleiste** steht der Name des Branches, auf dem du gerade bist (z. B. `main`). Ein Klick darauf öffnet das Branch-Menü.
- **Source Control** (`Ctrl+Shift+G` / `Cmd+Shift+G`) zeigt alle geänderten Dateien. Eine Zahl auf dem Symbol zeigt, wie viele es sind.

### 4.1 Neuesten Stand holen

Bevor du anfängst, holst du dir die Änderungen der anderen.

1. Prüfe unten links: Steht dort `main`? Falls nicht: darauf klicken und `main` auswählen.
2. Source Control öffnen → oben beim Titel **…** (drei Punkte) → **Pull**.
   Oder unten links neben dem Branch-Namen auf das Symbol mit den kreisenden Pfeilen klicken (**Synchronize Changes**).

### 4.2 Einen neuen Branch erstellen

1. Unten links auf `main` klicken.
2. Oben erscheint ein Menü → **+ Create new branch…** (**Neuen Branch erstellen…**).
3. Namen eingeben und Enter drücken. Namensschema (klein, mit Bindestrichen, keine Umlaute, keine Leerzeichen):
   ```
   docs/<abgabe>-<thema>
   ```
   Beispiele: `docs/milestone-2-loesungsprinzipien`, `docs/milestone-2-antrieb`, `fix/tippfehler-risikoanalyse`.
4. Unten links steht jetzt dein neuer Branch-Name. Alles, was du ab jetzt änderst, landet auf diesem Branch – `main` bleibt unberührt.

> Ein Branch pro Thema. Wenn du an zwei unabhängigen Dingen arbeitest, mach zwei
> Branches. Dann können sie unabhängig voneinander übernommen werden.

### 4.3 Bearbeiten

1. Öffne die Vorschau über die `doc.typ` der Abgabe (siehe 3.7).
2. Öffne das Kapitel, das du ändern willst, z. B. `docs/deliveries/milestone_2/chapters/loesungsprinzipien.typ`.
3. Schreib los. Wie Typst funktioniert, steht in [Kapitel 5](#5-typst-grundlagen).
4. Speichern: `Ctrl+S` / `Cmd+S`. (Tipp: **File → Auto Save** aktivieren.)

### 4.4 Prüfen

- Schau in der Vorschau, ob alles richtig aussieht.
- Gibt es einen Fehler, wird die Stelle rot unterstrichen, und unten in der Leiste erscheint ein rotes ✕. Fahr mit der Maus über die rote Stelle, um die Meldung zu lesen. Unter **View → Problems** (`Ctrl+Shift+M` / `Cmd+Shift+M`) siehst du alle Fehler gesammelt.
- Ein Dokument mit Fehlern wird auf GitHub nicht gebaut. Bitte nur fehlerfreie Stände hochladen.

### 4.5 Commit: einen Zwischenstand speichern

1. Source Control öffnen. Unter **Changes** siehst du alle geänderten Dateien. Ein Klick auf eine Datei zeigt links alt und rechts neu.
2. Fahr mit der Maus über **Changes** und klicke auf das **+** (**Stage All Changes**). Die Dateien wandern nach **Staged Changes**.
   - Willst du nur einzelne Dateien committen, klickst du auf das **+** bei der jeweiligen Datei.
3. Schreib oben ins Textfeld **Message** eine kurze Beschreibung, was du gemacht hast. Schema:
   ```
   docs(<abgabe>): Was wurde gemacht
   ```
   Beispiele:
   - `docs(milestone_2): Lösungsprinzipien Antrieb ergänzt`
   - `fix(milestone_1): Tippfehler in Risikoanalyse korrigiert`
4. Klicke **✓ Commit**.

Kommt die Meldung «There are no staged changes to commit. Would you like to stage all your changes and commit them directly?», kannst du **Yes** klicken.

Du kannst beliebig viele Commits machen, z. B. nach jedem fertigen Abschnitt.
Ein Commit ist erst auf deinem Laptop gespeichert – noch nicht auf GitHub.

### 4.6 Push: auf GitHub hochladen

- Beim **ersten** Mal auf einem neuen Branch: In Source Control erscheint der Knopf **Publish Branch** (**Branch veröffentlichen**). Klicken.
- Danach heisst der Knopf **Sync Changes** (**Änderungen synchronisieren**) mit einer Zahl und Pfeil nach oben. Klicken.

Beim allerersten Mal meldest du dich bei GitHub an (siehe 3.8).

> Tipp: Lade auch Zwischenstände hoch, z. B. am Ende des Tages. Dann ist deine
> Arbeit gesichert, auch wenn der Laptop kaputtgeht.

### 4.7 Pull Request erstellen

1. Öffne <https://github.com/EriN-B/pren-docs>.
2. Oben erscheint ein gelber Balken «*dein-branch* had recent pushes» → **Compare & pull request** klicken.
   (Falls nicht: Reiter **Pull requests** → **New pull request** → bei **compare:** deinen Branch wählen → **Create pull request**.)
3. Prüfe oben: **base: main** ← **compare: dein-branch**.
4. **Titel:** kurz, wie eine Commit-Nachricht, z. B. «Lösungsprinzipien Antrieb ergänzt».
5. **Beschreibung:** Was hast du geändert, wo soll jemand besonders hinschauen, gibt es offene Fragen?
6. Rechts bei **Reviewers** Erin (oder die zuständige Person) auswählen.
7. **Create pull request** klicken.

Nach wenigen Minuten baut GitHub automatisch das Vorschau-PDF und schreibt den
Link als Kommentar in den PR. Ein grüner Haken ✓ bedeutet: Das Dokument lässt
sich bauen. Ein rotes ✕ bedeutet einen Fehler – meist Typst, siehe
[Probleme](#7-probleme-und-lösungen).

**Labels** (rechts beim PR) steuern die Versionsnummer des PDFs. Diese setzt
Erin vor dem Mergen – du musst dich nicht darum kümmern.

### 4.8 Review, Korrekturen, Merge

- Andere kommentieren deine Änderungen im PR (siehe [Kapitel 6](#6-feedback-geben-ohne-selbst-zu-ändern)).
- **Korrekturen einarbeiten:** Bleib in VS Code auf deinem Branch (unten links prüfen!), ändere die Dateien, dann wieder **Commit** (4.5) und **Sync Changes** (4.6). Der PR aktualisiert sich automatisch, inklusive Vorschau-PDF. Du musst keinen neuen PR erstellen.
- **Merge:** Wenn alles passt, klickt Erin auf **Merge pull request**. Danach ist deine Änderung in `main`, und GitHub erstellt automatisch das neue PDF unter **Releases**.
- **Aufräumen:** Nach dem Merge in VS Code unten links auf den Branch-Namen klicken → `main` wählen → **Pull** (4.1). Der alte Branch wird nicht mehr gebraucht. Für die nächste Änderung wieder bei 4.2 beginnen.

---

## 5. Typst-Grundlagen

### Wo liegt was?

```
docs/
  deliveries/                 Eine Abgabe pro Ordner
    milestone_1/
      doc.typ                 Hauptdatei: Titelseite und Reihenfolge der Kapitel
      chapters/               Die einzelnen Kapitel – hier schreibst du meistens
      assets/                 Bilder, die nur diese Abgabe braucht
    milestone_2/
      …
  library/                    Gemeinsam für alle Abgaben – nur nach Absprache ändern
    template.typ              Vorlage (Layout, Schrift, Titelseite)
    quellen.bib               Quellenverzeichnis für alle Abgaben
    assets/                   Gemeinsame Bilder (z. B. Logo)
```

> Eine Abgabe, die bereits freigegeben wurde, ändern wir nur noch für
> Korrekturen. Neue Inhalte kommen in die aktuelle Abgabe.

### Text schreiben

Normaler Text wird einfach geschrieben. Eine **leere Zeile** beginnt einen neuen
Absatz. Ein einfacher Zeilenumbruch im Editor hat keine Wirkung.

| Du schreibst                    | Ergebnis                                  |
|---------------------------------|-------------------------------------------|
| `= Kapitel`                     | Kapitelüberschrift (beginnt neue Seite)   |
| `== Unterkapitel`               | Unterkapitel                              |
| `=== Abschnitt`                 | Abschnitt                                 |
| `*fett*`                        | **fett**                                  |
| `_kursiv_`                      | *kursiv*                                  |
| `- Punkt`                       | Aufzählung mit Punkten                    |
| `+ Punkt`                       | nummerierte Aufzählung                    |
| `// Kommentar`                  | erscheint nicht im PDF                    |
| `// TODO: …`                    | Merkzettel für offene Punkte              |
| `\#`, `\*`, `\_`, `\@`          | das Zeichen selbst, ohne Spezialbedeutung |

Nummerierung, Inhaltsverzeichnis, Seitenzahlen, Abbildungs- und
Tabellenverzeichnis macht die Vorlage automatisch. Nichts von Hand nummerieren.

Beispiel:

```typst
== Antrieb <kap-antrieb>

Für den Antrieb wurden zwei Lösungsprinzipien untersucht:

- *Räder:* einfach umzusetzen, hohe Geschwindigkeit
- *Beine:* hundeähnlicher, aber deutlich aufwendiger

Die Bewertung ist in @tab-antrieb dargestellt.
```

### Schreibregeln für den Bericht

- **Schweizer Rechtschreibung:** `ss` statt `ß` (gross, Strasse, Massnahme).
- **Anführungszeichen:** «so» – am einfachsten hier kopieren: « »
- **Zahlen:** Dezimalpunkt (`0.5 m/s`), Geldbeträge als `CHF 200.–`.
- Ganze Sätze, sachlicher Berichtsstil.

### Verweise (Labels)

Kapitel, Tabellen und Abbildungen bekommen ein Label in spitzen Klammern. Darauf
verweist du mit `@`. Typst setzt die richtige Nummer ein, z. B. «Kapitel 3.2»
oder «Tabelle 4».

```typst
== Sensorik <kap-sensorik>           // Label setzen
Wie in @kap-sensorik beschrieben …   // darauf verweisen
```

Namensschema: `<kap-…>` für Kapitel, `<tab-…>` für Tabellen, `<fig-…>` für
Abbildungen. Klein, mit Bindestrichen, ohne Umlaute. Bestehende Labels nicht
umbenennen – andere Kapitel verweisen vielleicht darauf.

### Tabellen

```typst
Die Varianten sind in @tab-antrieb verglichen.

#figure(
  table(
    columns: (auto, 1fr, 1fr),                       // 3 Spalten: schmal, breit, breit
    table.header([Kriterium], [Räder], [Beine]),     // Kopfzeile
    [Kosten], [gering], [hoch],
    [Geschwindigkeit], [hoch], [gering],
  ),
  caption: [Vergleich der Antriebsvarianten],
) <tab-antrieb>
```

- Pro Zeile kommen so viele `[…]` wie Spalten.
- Linien und Farben macht die Vorlage – nicht selbst einfärben.
- Viele Kapitel haben oben eigene Hilfsfunktionen für Tabellen (z. B. `bewertung` oder `tech-tabelle` im Kapitel Technologierecherche von Meilenstein 1). Schau dir das Kapitel an und kopiere ein bestehendes Beispiel, statt neu anzufangen.

### Bilder

1. Bild (PNG oder JPG) in den Ordner `assets/` der Abgabe legen, z. B. `docs/deliveries/milestone_2/assets/antrieb.png` (Ordner anlegen, falls er fehlt). Dateiname klein, ohne Umlaute und Leerzeichen.
2. Im Kapitel einbinden. Der Pfad ist relativ zur Kapiteldatei, darum `../assets/…`:

```typst
Der Aufbau ist in @fig-antrieb dargestellt.

#figure(
  image("../assets/antrieb.png", width: 70%),
  caption: [Skizze des Antriebs],
) <fig-antrieb>
```

### Quellen

Alle Quellen stehen in `docs/library/quellen.bib`. Ein Eintrag für eine Webseite:

```bib
@online{reichelt-pi5,
  title  = {Raspberry Pi 5, 8 GB RAM},
  author = {{reichelt elektronik}},
  url    = {https://www.reichelt.com/...},
}
```

Im Text zitierst du mit `@reichelt-pi5`, mehrere Quellen mit `@quelle-a @quelle-b`.
Das Quellenverzeichnis entsteht automatisch. Die Aufgabenstellung zitierst du mit
`@aufgabe`.

- Neue Einträge unter das passende Thema (die Abschnitte sind mit `% ── Thema ───` markiert).
- Schlüssel klein mit Bindestrichen: `<quelle>-<ding>`.
- Keine bestehenden Einträge löschen – ältere Abgaben brauchen sie vielleicht noch.
- Die URL muss vollständig und echt sein; Links werden jede Woche automatisch geprüft.

### Ein neues Kapitel anlegen

1. Neue Datei in `chapters/`, z. B. `chapters/antrieb.typ` (klein, ohne Umlaute).
2. Oben den Kopfkommentar und die Überschrift einfügen (von einem bestehenden Kapitel abschauen):
   ```typst
   // ─────────────────────────────────────────────────────────────
   //  Kapitel: Antrieb
   //  Wird in «doc.typ» per #include eingebunden.
   // ─────────────────────────────────────────────────────────────

   = Antrieb <kap-antrieb>
   ```
3. In der `doc.typ` an der richtigen Stelle (vor `#bibliography(…)`) einbinden:
   ```typst
   #include "chapters/antrieb.typ"
   ```

### Typst lernen

- Offizielles Tutorial (Englisch, sehr gut): <https://typst.app/docs/tutorial/>
- Nachschlagewerk: <https://typst.app/docs/reference/>
- Im Editor: Mit der Maus über einen Befehl fahren zeigt die Dokumentation an. `Ctrl+Leertaste` schlägt Befehle vor.

---

## 6. Feedback geben, ohne selbst zu ändern

Du musst nicht selbst Dateien ändern, um mitzuarbeiten. Kommentare im Pull
Request sind oft der schnellste Weg.

### Allgemeiner Kommentar

PR öffnen → ganz nach unten scrollen → Text ins Kommentarfeld → **Comment**.

### Kommentar zu einer bestimmten Zeile

1. PR öffnen → Reiter **Files changed**.
2. Mit der Maus über die Zeile fahren → links erscheint ein blaues **+** → klicken.
3. Kommentar schreiben → **Start a review** (wenn du mehrere Kommentare sammeln willst) oder **Add single comment**.
4. Bei «Start a review»: Am Schluss oben rechts **Submit review** → wählen:
   - **Comment** – nur Anmerkungen
   - **Approve** – passt so, kann übernommen werden
   - **Request changes** – bitte zuerst korrigieren

### Konkreten Textvorschlag machen

Beim Zeilenkommentar auf das Symbol **±** (**Add a suggestion**) klicken. Den
vorgeschlagenen Text direkt im Kästchen ändern. Die Autorin oder der Autor kann
den Vorschlag dann mit einem Klick übernehmen.

### Kleine Korrektur direkt im Browser

Für einen Tippfehler brauchst du VS Code nicht:

1. Auf GitHub die Datei öffnen (z. B. `docs/deliveries/milestone_2/chapters/loesungskombination.typ`).
2. Oben rechts auf den **Stift** (**Edit this file**) klicken.
3. Ändern.
4. **Commit changes…** → Nachricht eingeben → **Create a new branch for this commit and start a pull request** auswählen (nicht direkt in `main`!) → **Propose changes** → **Create pull request**.

Nachteil: keine Vorschau. Das Vorschau-PDF kommt nach ein paar Minuten im PR.

---

## 7. Probleme und Lösungen

### «Ich habe aus Versehen auf `main` gearbeitet»

Solange du noch **nicht committet** hast: Kein Problem. Unten links auf `main`
klicken → **Create new branch…** → Namen eingeben. Deine Änderungen kommen mit
auf den neuen Branch.

Wenn du schon committet, aber nicht gepusht hast: Melde dich bei Erin, das lässt
sich in einer Minute beheben. Nicht auf `main` pushen.

### «Push abgelehnt» / «Can't push refs to remote»

Jemand anders hat in der Zwischenzeit auf denselben Branch hochgeladen. Klicke
auf **Sync Changes** (holt zuerst die fremden Änderungen und lädt dann deine
hoch). Bei der Frage nach «merge» oder «rebase» ist «merge» die sichere Wahl.

### Merge-Konflikt

Passiert, wenn zwei Personen dieselbe Zeile geändert haben. VS Code markiert die
Datei unter **Merge Changes** mit einem **!**. In der Datei siehst du:

```
<<<<<<< HEAD
deine Version
=======
die andere Version
>>>>>>> main
```

1. Über dem Block klickst du **Accept Current Change** (deine), **Accept Incoming Change** (die andere) oder **Accept Both Changes** – oder du bearbeitest den Text von Hand und löschst die Zeilen mit `<<<<<<<`, `=======` und `>>>>>>>`.
2. Datei speichern, mit **+** stagen, **Commit**, **Sync Changes**.

Wenn du unsicher bist: Lass es, melde dich bei Erin. Kaputt machen kannst du
nichts, solange du nicht pushst.

Vorbeugen: Vor dem Start immer 4.1 (Pull), kleine Branches, kurz absprechen,
wer an welchem Kapitel arbeitet.

### «Mein Branch ist veraltet, `main` hat neue Änderungen»

Im PR auf GitHub steht dann «This branch is out-of-date with the base branch».
Klicke dort **Update branch**. Danach in VS Code **Sync Changes**, damit du den
neuen Stand auch lokal hast.

### Die Vorschau zeigt nichts oder einen Fehler

- Hast du die Vorschau über die `doc.typ` geöffnet (nicht über ein Kapitel)? Vorschau schliessen und über `doc.typ` neu öffnen.
- Rote Fehler in `View → Problems` anschauen. Häufige Ursachen:
  - Eine Klammer `(`, `[` oder `{` wurde nicht geschlossen.
  - Ein Label wird verwendet, das es nicht gibt (`@tab-xyz` ohne `<tab-xyz>`).
  - Eine Quelle `@xyz` fehlt in `quellen.bib`.
  - Ein Bildpfad stimmt nicht (Gross-/Kleinschreibung beachten).
  - Ein `#`, `*`, `_` oder `@` im Text, das als Befehl verstanden wird → mit `\` davor schreiben.
- Nichts hilft? `Ctrl+Shift+P` / `Cmd+Shift+P` → **Developer: Reload Window**.

### Der Haken im PR ist rot ✕

Klicke im PR unten auf **Details** neben dem roten ✕. Ganz unten im Log steht
die Fehlermeldung von Typst mit Datei und Zeile. Das Gleiche siehst du lokal in
`View → Problems`.

### Ich sehe meine Änderungen auf GitHub nicht

- Gespeichert (`Ctrl+S`)?
- Committet (4.5)?
- Gepusht – also **Publish Branch** bzw. **Sync Changes** geklickt (4.6)?
- Auf GitHub den richtigen Branch angeschaut? (Auf der Startseite oben links steht `main` – dort auf deinen Branch umstellen.)

### VS Code fragt nach Benutzername/Passwort

Nicht das GitHub-Passwort eingeben. Stattdessen den Dialog abbrechen und unten
links auf das Personen-Symbol (**Accounts**) → **Sign in with GitHub** klicken.
Danach nochmals pushen.

---

## 8. Spickzettel

**Jedes Mal:**

| Schritt                  | Wo in VS Code                                             |
|--------------------------|-----------------------------------------------------------|
| 1. Auf `main` wechseln   | Unten links auf Branch-Name → `main`                      |
| 2. Neuesten Stand holen  | Source Control → **…** → **Pull**                         |
| 3. Neuen Branch          | Unten links → **Create new branch…** → `docs/…`           |
| 4. Vorschau öffnen       | `doc.typ` öffnen → Vorschau-Symbol oben rechts            |
| 5. Bearbeiten, speichern | `Ctrl+S` / `Cmd+S`                                        |
| 6. Commit                | Source Control → **+** → Nachricht → **✓ Commit**         |
| 7. Hochladen             | **Publish Branch** bzw. **Sync Changes**                  |
| 8. Pull Request          | github.com → **Compare & pull request**                   |
| 9. Nach dem Merge        | Zurück zu Schritt 1                                       |

**Tastenkürzel** (Mac: `Cmd` statt `Ctrl`):

| Kürzel             | Funktion                    |
|--------------------|-----------------------------|
| `Ctrl+Shift+G`     | Source Control              |
| `Ctrl+Shift+E`     | Explorer (Dateien)          |
| `Ctrl+Shift+P`     | Befehl suchen               |
| `Ctrl+Shift+M`     | Fehlerliste                 |
| `Ctrl+P`           | Datei nach Namen öffnen     |
| `Ctrl+F`           | Suchen in Datei             |
| `Ctrl+Shift+F`     | Suchen im ganzen Projekt    |
| `Ctrl+Z`           | Rückgängig                  |
| `Ctrl+/`           | Zeile auskommentieren       |

**Für Terminal-Fans** (in VS Code: **Terminal → New Terminal**):

```sh
git switch main                        # auf main wechseln
git pull                               # neuesten Stand holen
git switch -c docs/milestone-2-thema   # neuen Branch erstellen
git status                             # was ist geändert?
git add .                              # alle Änderungen stagen
git commit -m "docs(milestone_2): …"   # Commit
git push -u origin HEAD                # erster Push eines Branches
git push                               # weitere Pushes
```

---

## 9. Glossar

| Begriff             | Bedeutung                                                                                  |
|---------------------|--------------------------------------------------------------------------------------------|
| **Repository (Repo)** | Das Projekt mit allen Dateien und dem ganzen Verlauf. Unseres heisst `pren-docs`.        |
| **Klonen (clone)**  | Das Repository einmalig auf den eigenen Laptop herunterladen.                              |
| **Branch**          | Eine Abzweigung vom Hauptstand, auf der man Änderungen macht, ohne `main` zu stören.       |
| **`main`**          | Der Haupt-Branch mit dem offiziellen Stand.                                                |
| **Commit**          | Ein gespeicherter Zwischenstand mit Beschreibung, Name und Datum.                          |
| **Stage**           | Dateien für den nächsten Commit auswählen (das **+** in VS Code).                          |
| **Push**            | Eigene Commits auf GitHub hochladen.                                                       |
| **Pull**            | Neue Commits von GitHub herunterladen.                                                     |
| **Sync**            | Pull und Push in einem Schritt.                                                            |
| **Pull Request (PR)** | Antrag auf GitHub, die Änderungen eines Branches in `main` zu übernehmen. Ort für Diskussion und Review. |
| **Review**          | Jemand anders schaut sich die Änderungen an und kommentiert.                               |
| **Merge**           | Änderungen eines Branches in einen anderen übernehmen (meist in `main`).                   |
| **Merge-Konflikt**  | Zwei Personen haben dieselbe Stelle unterschiedlich geändert; ein Mensch muss entscheiden. |
| **Release**         | Eine freigegebene Version einer Abgabe mit PDF, z. B. `milestone_2/v1.0.0`.                |
| **Label**           | Etikett an einem PR, bei uns für die Versionsnummer (`release:major` usw.).                |
| **Tinymist**        | Die VS-Code-Erweiterung für Typst (Vorschau, Fehleranzeige, Vorschläge).                   |
| **`.typ`**          | Dateiendung von Typst-Dateien.                                                             |
| **`.bib`**          | Dateiendung der Quellendatei.                                                              |

---

Fragen? Melde dich bei Erin – oder schreib einen Kommentar in einen Pull Request.
