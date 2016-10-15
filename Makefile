# Commands
MAKE=make
RM=rm
PDFLATEX=pdflatex

# File and directory locations
IMG_DIRS=dia
M4SOURCE=rapport.m4
SOURCE=rapport.tex
BIBFILE=$(SOURCE:%.tex=%.bib)

.PHONY: all test clean cleanall images ${IMG_DIRS}

all: test $(SOURCE:%.tex=%.pdf)

test:
	python3 -m unittest -v

images : ${IMG_DIRS}

${IMG_DIRS} :
	$(MAKE) -C $@

${SOURCE} : ${M4SOURCE}
	m4 ${@:%.tex=%.m4} > $@

$(SOURCE:%.tex=%.pdf) : images ${SOURCE} ${BIBFILE}
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


cleanall: clean
	for SUBDIR in ${IMG_DIRS}; do \
		$(MAKE) clean -C $$SUBDIR; \
	done
