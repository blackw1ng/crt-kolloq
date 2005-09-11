MAINFILE=master
TEX=latex
PDFVIEW=acroread
.SUFFIXES: .tex .dvi .ps .pdf 

all: print clean

dvi: $(MAINFILE).dvi
	xdvi $(MAINFILE).dvi

show: pdf
	$(PDFVIEW) $(MAINFILE).pdf
        
print: $(MAINFILE).pdf

halfpage: ${MAINFILE}.ps
	psnup -pa4 -Pa4 -l -2 < ${MAINFILE}.ps > ${MAINFILE}.twopage.ps
	ps2pdf -sPAPERSIZE=a4 $(MAINFILE).twopage.ps $(MAINFILE).twopage.pdf

net: $(MAINFILE).pdf
	thumbpdf --modes=ps2pdf $(MAINFILE).pdf
	$(TEX) $(MAINFILE).tex
	dvips -t a4 $(MAINFILE).dvi -o $(MAINFILE).ps
	ps2pdf $(MAINFILE).ps $(MAINFILE).pdf
	
clean: 
	rm -f *.{dvi,ps,blg,bbl,out,bm,toc,tpm,lof,lot,tmp}
	find . \( -name "*.aux" -o -name "*.log" \) -print | xargs rm -f

distclean:
	rm -f *.{dvi,ps,blg,bbl,out,bm,toc,tpm,lof,lot,tmp}
	find . \( -name "*.aux" -o -name "*.log" \) -print | xargs rm -f
	rm -f *.pdf

.tex.dvi: 
	#$(TEX) $<
	#bibtex $*
	$(TEX) $<
	$(TEX) $<

.dvi.ps:
	dvips -P pdf -z -t a4 $< -o $*.ps

.ps.pdf:
	ps2pdf $< $*.pdf
