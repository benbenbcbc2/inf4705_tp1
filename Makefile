# Commands
MAKE=make
RM=rm
PDFLATEX=pdflatex
ZIPNAME=matricule1_matricule2_tp1

# File and directory locations
M4SOURCE=rapport.m4
SOURCE=rapport.tex
BIBFILE=$(SOURCE:%.tex=%.bib)

.PHONY: all test clean dist

all: test $(SOURCE:%.tex=%.pdf)

test:
	python3 -m unittest -v

${SOURCE} : ${M4SOURCE}
	m4 ${@:%.tex=%.m4} > $@

$(SOURCE:%.tex=%.pdf) : ${SOURCE} ${BIBFILE}
	pdflatex --shell-escape $(@:%.pdf=%.tex)
	bibtex $(@:%.pdf=%.aux)
	pdflatex --shell-escape $(@:%.pdf=%.tex)
	pdflatex --shell-escape $(@:%.pdf=%.tex)

clean:
	-rm $(SOURCE:%.tex=%.pdf) $(SOURCE:%.tex=%.aux) \
            $(SOURCE:%.tex=%.out) $(SOURCE:%.tex=%.log) \
            $(SOURCE:%.tex=%.bbl) $(SOURCE:%.tex=%.blg) \
            $(SOURCE:%.tex=%.toc)
	find -name '__pycache__' | xargs -r rm -r
	-rm *.eps *converted-to.pdf *.gnuplot *gnuplottex*

dist: all
	zip ${ZIPNAME} algorithms/*.py script/*.{py,sh} tests/*.py results/*.dat
	zip ${ZIPNAME} Makefile README.md rapport.{m4,bib,pdf} tp.sh sorting.conf
