#!/bin/bash

asciidoc -b docbook index.adoc
# convert docbook to markdown
pandoc -f docbook -t markdown_strict index.xml -o ../README.md

rm index.xml
