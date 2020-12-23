# png
mkdir tmp
cd svg
for i in `ls *.svg|sort`; do
	inkscape $i -C -o ../tmp/`basename $i svg`png 2>&1 >/dev/null
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
inkscape svg/$i.svg -w $d -C -o png/$i-$d'x'360.png 2>&1 >/dev/null
i=logo-shape-trans
inkscape svg/$i.svg -w $d -C -o png/$i-$d'x'360.png 2>&1 >/dev/null

i=logo-shape-trans
d=341
inkscape svg/$i.svg -w $d -C -o png/$i-$d'x'192.png 2>&1 >/dev/null
optipng -quiet png/$i-$d'x'192.png -out png/$i-$d'x'192.png
i=icon-shape-trans
for d in 57 64 114 200; do
	inkscape svg/$i.svg -w $d -h $d -C -o png/$i-$d'x'$d.png 2>&1 >/dev/null
	optipng -quiet png/$i-$d'x'$d.png -out png/$i-$d'x'$d.png
done

# ico
convert png/icon-shape-trans-512x512.png -define icon:auto-resize=64,48,32,16 ico/icon-shape-trans-64-48-32-16.ico
convert png/favicon-text-grad-512x512.png -define icon:auto-resize=64,48,32,16 ico/favicon-text-grad-64-48-32-16.ico

# for sorting purposes
touch png/* ico/*
