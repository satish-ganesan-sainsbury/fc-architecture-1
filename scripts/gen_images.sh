#!/bin/sh
# converts all puml files to svg

BASEDIR=$(dirname "$1")
echo $BASEDIR
mkdir -p $BASEDIR/dist
rm $BASEDIR/dist/*
for FILE in $BASEDIR/puml/*.puml; do
 echo Converting $FILE..
 echo $PLANTUML
 java -jar $PLANTUML/plantuml.jar -tsvg -output $BASEDIR/dist/svg $FILE
 java -jar $PLANTUML/plantuml.jar -tpdf -output $BASEDIR/dist/pdf $FILE
 java -jar $PLANTUML/plantuml.jar -tpng -output $BASEDIR/dist/png $FILE
done
#mv $BASEDIR/*.svg $BASEDIR/dist/
#mv $BASEDIR/*.pdf $BASEDIR/dist/
echo Done