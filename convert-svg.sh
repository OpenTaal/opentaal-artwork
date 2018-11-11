cd svg
for i in `ls *.svg|sort`; do
	inkscape -z -f $i -e ../png/`basename $i svg`png
	inkscape -z -f $i -e ../jpg/`basename $i svg`jpg
done
