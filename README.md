# LaTeX _iodhbwm_ Klasse

[![Latest
release](https://img.shields.io/github/release/faltfe/iodhbwm.svg?style=flat-square)](https://github.com/faltfe/iodhbwm/releases)
[![CTAN](https://img.shields.io/ctan/v/iodhbwm.svg)](https://www.ctan.org/pkg/iodhbwm)
[![Build Status](https://img.shields.io/travis/faltfe/iodhbwm/master.svg?style=flat-square)](https://travis-ci.org/faltfe/iodhbwm)
[![Downloads](https://img.shields.io/github/downloads/faltfe/iodhbwm/total.svg?style=flat-square)](https://github.com/faltfe/iodhbwm/releases)
[![GitHub license](https://img.shields.io/github/license/faltfe/iodhbwm.svg?style=flat-square)](https://github.com/faltfe/iodhbwm/blob/master/LICENSE)

---

## :bangbang: Maintainer wanted :bangbang:

This project is not maintained anymore. See #66 for more information.

---

Das Projekt stellt eine _inoffizelle_ Vorlage der [DHBW Mannheim](http://www.dhbw-mannheim.de) für
die Erstellung von Bachelor-, Studien- oder Projektarbeit mit _LaTeX_ bereit. Das Ziel des Paket ist
die schnelle Erstellung eines Grundgerüst ohne viel Aufwand. Schließlich hat ein Student bekanntlich
wenig Zeit :beer:

> **Hinweis** Das Paket wurde ausschließlich mit pdfLaTeX getestet. Die Verwendung von XeLaTex oder
> LuaLaTeX wurde nur rudimentär (fehlerfrei) überprüft.

```LaTeX
\documentclass[
    load-dhbw-templates,
    auto-intro-pages = default,
    add-tocs-to-toc,
    debug,
    language = ngerman
]{iodhbwm}
\usepackage[T1]{fontenc}

\dhbwsetup{%
    author                  = Felix Faltin,
    thesis type             = SA,
    thesis title            = Verwendung von iodhbwm,
    student id              = 12345,
    institute               = Masterfind Factory faltfe,
    course/id               = Txxxx,
    supervisor              = Pikachu und Enton,
    processing period       = {01.01.17 -- 31.01.17},
    location                = Dreamtown
}

\begin{document}
    \Blinddocument
\end{document}
```

Das Beispiel erzeugt automatisch

- eine Titelseite mit persönlichen Einstellungen,
- eine Eigenständigkeitserklärung
- ein Inhaltsverzeichnis

Und es muss nur **eine** einzige Datei :pencil: `hello-world.tex` angelegt werden :open_mouth:

## Vorteile des Paket gegenüber anderen Templates

1. Der größte Vorteil besteht in der Verwendung einer _LaTeX_-Klasse. Gegenüber einem Template
   müssen dann keine unzähligen zusätzlichen Dateien mehr kopiert und konfiguriert werden.
2. Umfangreiche Konfigurationsmöglichkeiten
3. Individuelle Gestaltungen sind weiterhin möglich. Die Klasse bietet nur die Möglichkeiten für ein
   vorgegebenes Design und einer festen Struktur an.

## Funktionsumfang

Das Paket besteht im Wesentlichen aus der Klasse `iodhbwm` und einem Paket `iodhbwm-templates`.
Zusätzlich werden mehrere vordefinierte Titelseiten, eine Eigenständigkeitserklärung sowie Beispiele
mitgeliefert.

### Klasse iodhbwm

Die Klasse ist zuständig für die Bereitstellung eines einheitlichen Design. Außerdem können durch
Optionen, die in der [Dokumentation](doc/iodhbwm.pdf) beschrieben werden, zusätzliche
Funktionalitäten aktiviert werden.

- Weitere Pakete laden, welche häufig verwendet werden
- Automatisches Erzeugen der Verzeichnisse in der korrekten Reihenfolge
- Automatisches Einbinden eines Literaturverzeichnis
- Laden des Paket `iodhbwm-templates`
- Eingeschränkte Unterstützung mehrerer Sprachen

### Paket iodhbwm-templates

Das Paket ermöglicht das Einbinden DHBW spezifischer Formulierung, Darstellungen oder ähnliches. Es
werden unter anderem verschiedene Titelseiten und eine Eigenständigkeitserklärung zur Verfügung
gestellt.

- Automatisches Erstellen der Titelseite und Inhaltsverzeichnisse
- Befehle zur strukturierten Gestaltung
- Einbindung und Formatieren eines Anhangs einschließlich der Erstellung eines Anhangsverzeichnis

## Beispiele

Für ein besseres Verständnis, wie das Paket anzuwenden ist, werden mehrere Beispiele mitgeliefert.
Diese befinden sich im Ordner [doc/examples](doc/examples)

- [How to use iodhbwm](doc/examples/how-to-use-iodhbwm)
  - Die Beispiele veranschaulichen die allgemeine Benutzung der Klasse mit unterschiedlichen Optionen
  - Grundgerüst für alle auf `iodhbwm` basierenden Dokumente
  - Automatisiertes Erstellen _aller_ notwendigen Verzeichnisse
  - Empfohlenes Grundgerüst für alle neuen Dokumente
- [Quellcode](doc/examples/listings)
  - Verwendung von Quellcode und Anpassung der Erscheinung
- [Verweise](doc/examples/references)
  - Manuelle Anpassung der Farben von Links
- [Titelseiten](doc/examples/titlepages)
  - Verwendung unterschiedlicher Titelseiten
  - Setzen des Firmenlogos
  - Verwenden einer selbst definierten Titelseite
- [Abkürzungen](doc/examples/acronyms)
  - Einbinden eines Abkürzungsverzeichnis am Beispiel von `acro`
- [Anhang](doc/examples/appendix)
  - Verwendung eines Anhangs
  - Automatisierung der Einbindung eines Anhangs
- [Abstrakt](doc/examples/abstract)
  - Verwendung eines eigenen Abstakt
- [Literturverzeichnis](doc/examples/bibliography)
  - Änderung des gewünschten Zitierstils
  - Verwendung von Fußnoten zur Angabe von Quellen
  - Anpassung der Voreinstellung, z.B. Ausgabe der DOI
- [Customizing](doc/examples/customizing)
  - Umbenennung von `\part`
  - Erstellen einer schwarz/weiß Ausgabe
  - Römische Nummerierung vor dem Inhaltsverzeichnis

## Für Entwickler

Die Entwicklung erfolgt nach [git-flow](https://danielkummer.github.io/git-flow-cheatsheet/). Das
heißt, dass die Entwicklung auf dem `develop`-Branch stattfindet.

[![Build Status](https://img.shields.io/travis/faltfe/iodhbwm/develop.svg?style=flat-square)](https://travis-ci.org/faltfe/iodhbwm)

### Eigenes Release erstellen

Mithilfe des Scripts `support/create-fake-tds.sh` ist es möglich, sich lokal ein eigenes Bundel zu
erstellen. Das Script sammelt dabei alle wichtigen Dateien des **aktuellen** Branch zusammen. Das
erstellte Bundle wird im Ordner `release/vX.Y-ZZZ` gespeichert. Es werden zwei Ordner erstellt. Der
Ordner mit dem Präfix `*-tds` kann direkt in das lokale `texmf`-Verzeichnis kopiert werden.

### Pull Request

PR sind bevorzugt in den `develop` zu mergen. Es sollte eine aussagekräftige Beschreibung der
vorgenommenen Änderungen beigefügt werden.

## Kontakt

Das iodhbwm Bundle besitzt nach LPPL den Maintenance Status `maintained`. Feature Requests, Bugs
oder Fragen sind über den [Issue-Tracker](https://github.com/faltfe/iodhbwm/issues) zu erstellen.
