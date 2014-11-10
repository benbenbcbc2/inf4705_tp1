# Commands
MAKE=make
RM=rm
PDFLATEX=pdflatex

# File and directory locations
IMG_DIRS=dia
SOURCE=rapport.tex
BIBFILE=$(SOURCE:%.tex=%.bib)

.PHONY: all clean cleanall images ${IMG_DIRS}

all: $(SOURCE:%.tex=%.pdf)

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
            $(SOURCE:%.tex=%.bbl) $(SOURCE:%.tex=%.blg)


cleanall: clean
	for SUBDIR in ${IMG_DIRS}; do \
		$(MAKE) clean -C $$SUBDIR; \
	done
