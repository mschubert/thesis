LATEXMK = latexmk -xelatex

LYX = $(sort $(wildcard *.lyx))
TEX = $(LYX:%.lyx=%.tex)

#.INTERMEDIATE: $(TEX)

all: thesis.pdf

# Use `print-VARNAME` to print arbitrary variables
print-%: ; @echo $* = $($*)

thesis.pdf: thesis.tex config.tex $(TEX)
	$(LATEXMK) thesis

%.tex: %.lyx Makefile
	lyx --force-overwrite --export xetex $<
	@sed -i '/\\begin{document}/,/\\end{document}/!d' $@
	@sed -i '/\\begin{document}/d' $@
	@sed -i '/\\end{document}/d' $@
	@sed -i '/\\bibliography/d' $@
	@sed -i 's/\\lyxdot /./g' $@

clean:
	rm -f thesis.{aux,bbl,bcf,blg,fdb_latexmk,fls,log,out,pdf,run.xml}
	rm -f $(TEX)
	rm -f *~
