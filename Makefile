# Commands
MAKE=make
RM=rm
PDFLATEX=pdflatex

# File and directory locations
IMG_DIRS=dia
SOURCE=rapport.tex
BIBFILE=$(SOURCE:%.tex=%.bib)

.PHONY: all test clean cleanall images ${IMG_DIRS}

all: $(SOURCE:%.tex=%.pdf) test

test:
	python3 -m unittest -v

images : ${IMG_DIRS}

${IMG_DIRS} :
	$(MAKE) -C $@

$(SOURCE:%.tex=%.pdf) : images ${SOURCE} ${BIBFILE}
	pdflatex $(@:%.pdf=%.tex)
	bibtex $(@:%.pdf=%.aux)
	pdflatex $(@:%.pdf=%.tex)
	pdflatex $(@:%.pdf=%.tex)

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
