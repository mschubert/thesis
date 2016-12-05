LATEXMK = latexmk -xelatex -f

LYX = $(sort $(wildcard *.lyx))
TEX = $(LYX:%.lyx=%.tex) 7_appendix.tex

#.INTERMEDIATE: $(TEX)

all: thesis.pdf summary.pdf

# Use `print-VARNAME` to print arbitrary variables
print-%: ; @echo $* = $($*)

thesis.pdf: thesis.tex config.tex references.bib $(TEX) abstract.tex abbreviations.tex
	$(LATEXMK) thesis

summary.pdf: summary.tex config.tex abstract.tex
	$(LATEXMK) summary

%.tex: %.lyx Makefile
	lyx --force-overwrite --export xetex $<
	@sed -i '/\\begin{document}/,/\\end{document}/!d' $@
	@sed -i '/\\begin{document}/d' $@
	@sed -i '/\\end{document}/d' $@
	@sed -i '/\\bibliography/d' $@
	@sed -i 's/\\lyxdot /./g' $@
	@sed -i 's/\\part/\\chapter/g' $@
	@sed -i 's/\\cite{/\\citep{/g' $@

%.tex: %.Rnw
	R -e 'library(knitr);knit("$<")'

clean:
	rm -f thesis.{aux,bbl,bcf,blg,fdb_latexmk,fls,log,out,run.xml,lof,lot,toc,nlo}
	rm -f $(TEX)
	rm -f *~

distclean: clean
	rm -f thesis.pdf
