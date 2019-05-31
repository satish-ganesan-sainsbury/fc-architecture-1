#!/bin/sh
# converts all puml files to svg

# Run from fc-architecture directory as
# scripts/gen_images.sh $1 $2
# $1 - workstream
# $2 - diagram type
# $3 - * or file

BASEDIR=$(pwd)
echo 'Base Dir: ' $BASEDIR
export SVG="$BASEDIR/dist/$1/$2/svg/"
export PNG="$BASEDIR/dist/$1/$2/png/"
mkdir -p "$SVG"
mkdir -p "$PNG"

for FILE in "$BASEDIR/$1/$2/puml/$3" 
do
  echo 'File: ' "$FILE"
  echo "$SVG"
  echo "$PNG"
  java -Dplantuml.include.path=included -jar "$PLANTUML/plantuml.jar" "$1/$2/puml/$3" -tsvg -output "$SVG" 
  java -Dplantuml.include.path=included -jar "$PLANTUML/plantuml.jar" "$1/$2/puml/$3" -tpng -output "$PNG"
done


echo done