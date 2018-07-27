# LaTeX _iodhbwm_ Paket

[![Latest release](https://img.shields.io/github/release/faltfe/iodhbwm.svg?style=flat-square)](https://github.com/faltfe/iodhbwm/releases)
[![Downloads](https://img.shields.io/github/downloads/faltfe/iodhbwm/total.svg?style=flat-square)](https://github.com/faltfe/iodhbwm/releases)
[![GitHub license](https://img.shields.io/github/license/faltfe/iodhbwm.svg?style=flat-square)](https://github.com/faltfe/iodhbwm/blob/master/LICENSE)
[![Build Status](https://img.shields.io/travis/faltfe/iodhbwm/master.svg?style=flat-square)](https://travis-ci.org/faltfe/iodhbwm)

Das Projekt stellt eine _inoffizelle_ Vorlage der [DHBW Mannheim](http://www.dhbw-mannheim.de) für die Erstellung von Bachelor-, Studien- oder Projektarbeit mit _LaTeX_ bereit. Das Ziel des Paket ist die schnelle Erstellung eines Grundgerüst ohne viel Aufwand. Schließlich hat ein Student bekanntlich wenig Zeit :beer:

> **Hinweis**
> Das Paket unterstützt derzeit ausschließlich pdfLaTeX. Die Verwendung von XeLaTex oder LuaLaTeX wird noch nicht unterstützt.

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

1. Der größte Vorteil besteht in der Verwendung einer _LaTeX_-Klasse. Gegenüber einem Template müssen dann keine unzähligen zusätzlichen Dateien mehr kopiert und konfiguriert werden.
2. Umfangreiche Konfigurationsmöglichkeiten
3. Individuelle Gestaltungen sind weiterhin möglich. Die Klasse bietet nur die Möglichkeiten für ein vorgegebenes Design und einer festen Struktur an.

## Funktionsumfang

Das Paket besteht im Wesentlichen aus der Klasse `iodhbwm` und einem Paket `iodhbwm-templates`. Zusätzlich werden mehrere vordefinierte Titelseiten, eine Eigenständigkeitserklärung sowie Beispiele mitgeliefert.

### Klasse iodhbwm

Die Klasse ist zuständig für die Bereitstellung eines einheitlichen Design. Außerdem können durch Optionen, die in der [Dokumentation](doc/iodhbwm.pdf) beschrieben werden, zusätzliche Funktionalitäten aktiviert werden.

- Weitere Pakete laden, welche häufig verwendet werden
- Automatisches Einbinden eines Literaturverzeichnis
- Laden des Paket `iodhbwm-templates`
- Eingeschränkte Unterstützung mehrerer Sprachen

### Paket iodhbwm-templates

Das Paket ermöglicht das Einbinden DHBW spezifischer Formulierung, Darstellungen oder ähnliches. Es werden unter anderem verschiedene Titelseiten und eine Eigenständigkeitserklärung zur Verfügung gestellt.

- Automatisches Erstellen der Titelseite und Inhaltsverzeichnisse
- Befehle zur strukturierten Gestaltung
- Einbindung und Formatieren eines Anhangs einschließlich der Erstellung eines Anhangsverzeichnis

## Beispiele

Für ein besseres Verständnis, wie das Paket anzuwenden ist, werden mehrere Beispiele mitgeliefert. Diese befinden sich im Ordner [doc/examples](doc/examples)

- [Allgemeine Beispiele](doc/examples/basic-usage) Die Beispiele veranschaulichen die allgemeine Benutzung der Klasse mit unterschiedlichen Optionen
  1. Grundgerüst für alle auf `iodhbwm` basierenden Dokumente
  2. Erstellen einer schwarz/weiß Ausgabe
  3. Automatisiertes Erstellen _aller_ notwendigen Verzeichnisse
  4. Verwendung eines Abstrakt
- [Quellcode](doc/examples/listings) Verwendung von Quellcode und Anpassung der Erscheinung
- [Literatur](doc/examples/references) Literaturverzeichnis und Querverweise
  1. Manuelle Anpassung der Farben von Links
  2. Änderung des gewünschten Zitierstils
  3. Verwendung von Fußnoten zur Angabe von Quellen
- [Titelseiten](doc/examples/titlepages) Verwendung unterschiedlicher Titelseiten
  1. Setzen des Firmenlogos
  2. Verwenden einer selbst definierten Titelseite
- [Abkürzungen](doc/examples/acronyms) Einbinden eines Abkürzungsverzeichnis am Beispiel von `acro`
- [Anhang](doc/examples/appendix) Verwendung eines Anhangs

## Installationshinweis

Das Paket befindet sich derzeit noch nicht in den offizellen Paketquellen von [CTAN](https://ctan.org/). Daher ist eine manuelle Installtion in einem lokalen `texmf`-Verzeichnis notwendig. In der Dokumentation sind jeweils kurze Anleitungen für die Installation unter MiKTeX und TeXlive integriert.

Die neueste Version kann unter https://github.com/faltfe/iodhbwm/releases/latest heruntergeladen werden. Ab Version `v0.4-alpha` enthalten Downloads eine TDS-konforme Ordnerstruktur.

## Für Entwickler

Die Entwicklung erfolgt nach [git-flow](https://danielkummer.github.io/git-flow-cheatsheet/). Das heißt, dass die Entwicklung auf dem `develop`-Branch stattfindet.

[![Build Status](https://img.shields.io/travis/faltfe/iodhbwm/develop.svg?style=flat-square)](https://travis-ci.org/faltfe/iodhbwm)

### Eigenes Release erstellen
Mithilfe des Scripts `support/create-fake-tds.sh` ist es möglich, sich lokal ein eigenes Bundel zu erstellen. Das Script sammelt dabei alle wichtigen Dateien des **aktuellen** Branch zusammen. Das erstellte Bundle wird im Ordner `release/v0.x-xxx` gespeichert. Es werden zwei Ordner erstellt. Der Ordner mit dem Präfix `*-tds` kann direkt in das lokale `texmf`-Verzeichnis kopiert werden.

### Pull Request

PR sind bevorzugt in den `develop` zu mergen. Es sollte eine aussagekräftige Beshcreibung der vorgenommenen Änderungen beigefügt werden.

## Kontakt

Das iodhbwm Bundle besitzt nach LPPL den Maintenance Status `maintained`. Feature Requests, Bugs oder Fragen sind über den [Issue-Tracker](https://github.com/faltfe/iodhbwm/issues) zu erstellen.
