#pandoc abstract.md -o latex/abstract.tex --top-level-division=chapter
pandoc thesis.md -o latex/thesis.tex --top-level-division=chapter
sed -i '' 's/.png//g' latex/thesis.tex