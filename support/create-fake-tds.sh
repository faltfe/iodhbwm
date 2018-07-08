#!/bin/bash

shopt -s extglob
latestTag=$(git describe --tags)

echo "Run create-bundle.sh script"
sh support/create-bundle.sh

echo "Start creating fake tds structure"
if [ -d release/$latestTag ]
then
	cd release
	if [ -d $latestTag-tds ]
	then
		rm -r $latestTag-tds
	fi
	mkdir -p $latestTag-tds/doc/latex/iodhbwm
	mkdir -p $latestTag-tds/tex/latex/iodhbwm
fi

echo "Start copying files"
cp -r $latestTag/iodhbwm/tex/* $latestTag-tds/tex/latex/iodhbwm
cp -r $latestTag/iodhbwm/doc/*.pdf $latestTag-tds/doc/latex/iodhbwm

echo "Finish copying files"

