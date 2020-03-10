main:
	xelatex -shell-escape main.tex
	# bibtex main
	xelatex -shell-escape main.tex
	xelatex -shell-escape main.tex

clean:
	rm -rf main.log main.out main.bbl main.bcf main.blg main.nav main.run.xml main.snm main.toc *aux
