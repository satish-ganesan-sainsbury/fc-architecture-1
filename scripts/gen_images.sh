#!/bin/sh
# converts all puml files to svg

# Run from fc-architecture directory as
# scripts/gen_images.sh $1 $2
# $1 - workstream
# $2 - diagram type
# $3 - * or file

BASEDIR=$(pwd)
echo 'Base Dir: ' $BASEDIR
mkdir -p $BASEDIR/$1/$2/dist

for FILE in $BASEDIR/$1/$2/puml/$3 
do
 echo 'File: ' $FILE
 java -jar $PLANTUML/plantuml.jar -tsvg -output $BASEDIR/$1/$2/dist/svg $FILE
 #java -jar $PLANTUML/plantuml.jar -tpdf -output $BASEDIR/$1/$2/dist/pdf $FILE
 java -jar $PLANTUML/plantuml.jar -tpng -output $BASEDIR/$1/$2/dist/png $FILE
done

echo done