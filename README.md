# iodhbwm bundle
Stable: [![Build Status](https://travis-ci.org/faltfe/iodhbwm.svg?branch=master)](https://travis-ci.org/faltfe/iodhbwm) Develop: [![Build Status](https://travis-ci.org/faltfe/iodhbwm.svg?branch=develop)](https://travis-ci.org/faltfe/iodhbwm)

Das Projekt stellt eine _inoffizelle_ Vorlage der [DHBW Mannheim](http://www.dhbw-mannheim.de) für die Erstellung einer Bachelorarbeit, Studienarbeit oder Projektarbeit bereit. Das Bundle ist unterteilt in eine Klasse und ein Paket. Eine unabhängige Benutzung ist möglich, wird jedoch **nicht** empfohlen.

## Klasse iodhbwm
Die Klasse ist zuständig für die Bereitstellung eines einheitlichen Design. Außerdem können durch Optionen, die in der [Dokumentation](iodhbwm.pdf) beschrieben werden, zusätzliche Funktionalitäten aktiviert werden.

   - Weitere Pakete laden, welche häufig verwendet werden
   - Automatisches Erstellen eines Literaturverzeichnis
   - Laden des Paket iodhbwm-templates

## Paket iodhbwm-templates
Das Paket ermöglicht das Einbinden DHBW spezifischer Formulierung, Darstellungen oder ähnliches. Es werden unter anderem verschiedene Titelseiten und eine Eigenständigkeitserklärung zur Verfügung gestellt.

## Für Entwickler
Mithilfe des Scripts `support/create-bundle.sh` ist es möglich, sich lokal ein eigenes Bundel zu erstellen. Das Script sammelt dabei alle wichtigen Dateien des **aktuellen** Branch zusammen. Das erstellte Bundel wird im Ordner `release` gespeichert.

Wenn neue Beispiele hinzugefügt werden, sind diese innerhalb der ./.travic.yml ebenfalls einzutragen.

# Kontakt
Das iodhbwm Bundle besitzt nach LPPL den Maintenance Status `maintained`. Feature Requests, Bugs oder Fragen sind über den [Issue-Tracker](https://github.com/faltfe/iodhbwm/issues) zu erstellen.
