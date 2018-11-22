# png
mkdir tmp
cd svg
for i in `ls *.svg|sort`; do
	inkscape -z -f $i -e ../tmp/`basename $i svg`png 2>&1 >/dev/null
done
cd ../tmp
for i in `ls *.png|sort`; do
	mv -f $i ../png/`basename $i .png`-`file $i|awk '{print $5$6$7}'|sed -e 's/,//'`.png
done
cd ..
rm -rf tmp
# custom sizes
i=logo-shape-trans
inkscape -z -f svg/$i.svg -w 341 -e png/$i-341x192.png 2>&1 >/dev/null
i=icon-shape-trans
inkscape -z -f svg/$i.svg -w 200 -h 200 -e png/$i-200x200.png 2>&1 >/dev/null
inkscape -z -f svg/$i.svg -w 64 -h 64 -e png/$i-64x64.png 2>&1 >/dev/null

# ico
convert png/icon-shape-trans-512x512.png -define icon:auto-resize=64,48,32,16 ico/icon-shape-trans-64-48-32-16.ico
convert png/favicon-text-grad-512x512.png -define icon:auto-resize=64,48,32,16 ico/favicon-text-grad-64-48-32-16.ico

# for sorting purposes
touch png/* ico/*
