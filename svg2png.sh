for i in `ls *.svg|sort`; do
	inkscape -z -f $i -e `basename $i svg`png
done
