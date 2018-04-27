#pandoc abstract.md -o latex/abstract.tex --top-level-division=chapter
pandoc thesis.md -o latex/thesis.tex --top-level-division=chapter
sed -i '' 's/.png//g' latex/thesis.tex

cd latex
pdflatex Container\ Based\ Execution\ Stack\ for\ Neural\ Networks.tex
bibtex Container\ Based\ Execution\ Stack\ for\ Neural\ Networks
pdflatex Container\ Based\ Execution\ Stack\ for\ Neural\ Networks.tex
#pdflatex --shell-escape Container\ Based\ Execution\ Stack\ for\ Neural\ Networks.tex