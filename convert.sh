#!/bin/bash
set -e

if [ $(flatpak list|grep org.inkscape.Inkscape|wc -l) -gt 0 ]; then
    EXE=$(echo flatpak run org.inkscape.Inkscape)
else
    EXE=$(echo inkscape)
fi

# png
mkdir tmp
cd svg
for i in `ls *.svg|sort`; do
	$EXE $i -TCo ../tmp/`basename $i svg`png 2>&1 >/dev/null
done
cd ../tmp
for i in `ls *.png|sort`; do
	mv -f $i ../png/`basename $i .png`-`file $i|awk '{print $5$6$7}'|sed -e 's/,//'`.png
done
cd ..
rm -rf tmp

# custom sizes
d=640
i=logo-shape-white
$EXE svg/$i.svg -w $d -TCo png/$i-$d'x'360.png 2>&1 >/dev/null
i=logo-shape-trans
$EXE svg/$i.svg -w $d -TCo png/$i-$d'x'360.png 2>&1 >/dev/null

i=logo-shape-trans
d=341
$EXE svg/$i.svg -w $d -TCo png/$i-$d'x'192.png 2>&1 >/dev/null
optipng -quiet png/$i-$d'x'192.png
i=icon-shape-trans
for d in 42 57 64 114 200; do
	$EXE svg/$i.svg -w $d -h $d -TCo png/$i-$d'x'$d.png 2>&1 >/dev/null
	optipng -quiet png/$i-$d'x'$d.png
done

# ico
convert png/icon-shape-trans-512x512.png -define icon:auto-resize=64,48,32,16 ico/icon-shape-trans-64-48-32-16.ico
convert png/favicon-text-grad-512x512.png -define icon:auto-resize=64,48,32,16 ico/favicon-text-grad-64-48-32-16.ico

# for sorting purposes
touch png/* ico/*
