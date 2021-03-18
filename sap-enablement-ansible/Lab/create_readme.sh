#!/bin/bash

asciidoctor -b docbook5 index.adoc
# convert docbook to markdown
pandoc -f docbook -t markdown_strict index.xml -o ../README.md
rm index.xml

sed -i -e 's/\(\[e2e-infra-layout\]\).*/\1\(img\/infra_layout.png\)/g' ../README.md
sed -i -e 's/\(\[rhpds-catalog]\).*/\1\(img\/rhpds01.png\)/g'  ../README.md
sed -i -e 's/\(\[rhpds-submit]\).*/\1\(img\/rhpds02.png\)/g'  ../README.md
