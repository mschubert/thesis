LATEXMK = latexmk -xelatex

LYX = $(wildcard *.lyx)
TEX = $(LYX:%.lyx=%.tex)

#.INTERMEDIATE: $(TEX)

all: thesis.pdf

thesis.pdf: thesis.tex $(TEX)
	$(LATEXMK) thesis

%.tex: %.lyx Makefile
	lyx --force-overwrite --export xetex $<
	@sed -i '/\\begin{document}/,/\\end{document}/!d' $@
	@sed -i '/\\begin{document}/d' $@
	@sed -i '/\\end{document}/d' $@
	@sed -i '/\\bibliography/d' $@
