#!/bin/bash

# remove include variables in single files
for i in $( grep "^include::config_vars.adoc"  [0-9]*.adoc| cut -d: -f1) ; do 
       	sed -i -e 's/^\(include::config_vars.adoc.*\)/\/\/ \1)/g' $i
done

asciidoctor -b docbook5 index.adoc
# convert docbook to markdown
pandoc -f docbook -t markdown_strict index.xml -o ../README.md
rm index.xml

sed -i -e 's/\(\[e2e-infra-layout\]\).*/\1\(img\/infra_layout.png\)/g' ../README.md
sed -i -e 's/\(\[rhpds-catalog]\).*/\1\(img\/rhpds01.png\)/g'  ../README.md
sed -i -e 's/\(\[rhpds-submit]\).*/\1\(img\/rhpds02.png\)/g'  ../README.md
