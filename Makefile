# ============================================================
#  विज्ञान में कृत्रिम बुद्धिमत्ता — build automation
#  Usage:
#    make           # build the PDF (xelatex ×3 + makeindex)
#    make epub      # build the EPUB (figures + preprocess + pandoc)
#    make all       # PDF + EPUB
#    make figures   # (re)render TikZ figures to PNG for the EPUB
#    make clean      # remove aux files
#    make distclean  # remove aux + outputs
# ============================================================
MAIN    = main
LATEX   = xelatex -interaction=nonstopmode -halt-on-error
EPUBOUT = epub/विज्ञान-में-कृत्रिम-बुद्धिमत्ता.epub
CHAPTERS = chapters/00-copyright chapters/00-preface \
           chapters/01-intro-ai chapters/02-ai-physics chapters/03-ai-chemistry \
           chapters/04-ai-biology chapters/05-data-experiments chapters/06-ethics-future \
           chapters/A-glossary chapters/B-answers chapters/C-references

.PHONY: all pdf epub figures clean distclean

pdf: $(MAIN).pdf

$(MAIN).pdf: $(MAIN).tex style/aibook.sty chapters/*.tex
	$(LATEX) $(MAIN).tex
	-makeindex $(MAIN).idx
	$(LATEX) $(MAIN).tex
	$(LATEX) $(MAIN).tex
	@echo "✔ PDF built: $(MAIN).pdf ($$(pdfinfo $(MAIN).pdf 2>/dev/null | awk '/Pages/{print $$2}') pages)"

all: pdf epub

# --- EPUB pipeline (needs pandoc; see epub/) ---
figures:
	cd epub && xelatex -interaction=nonstopmode render-figs.tex >/dev/null 2>&1
	@echo "✔ figures rendered into epub/img/ (split via epub/ helper)"

epub:
	mkdir -p epub/pp
	@for f in 00-copyright:00 00-preface:00 01-intro-ai:01 02-ai-physics:02 \
	          03-ai-chemistry:03 04-ai-biology:04 05-data-experiments:05 \
	          06-ethics-future:06 A-glossary:AA B-answers:BB C-references:CC; do \
	    name=$${f%%:*}; num=$${f##*:}; \
	    perl epub/preprocess.pl $$num < chapters/$$name.tex > epub/pp/$$name.tex; \
	done
	sed -i '1i \\\chapter*{प्रकाशन एवं अधिकार (Imprint)}' epub/pp/00-copyright.tex
	pandoc $(addprefix epub/pp/, $(addsuffix .tex, $(notdir $(CHAPTERS)))) \
	  -f latex -t epub3 \
	  --metadata-file=epub/epub-meta.yaml \
	  --epub-cover-image=epub/cover.jpg --css=epub/style.css \
	  --toc --toc-depth=2 --mathml \
	  --resource-path=.:epub:images \
	  -o "$(EPUBOUT)"
	@echo "✔ EPUB built: $(EPUBOUT)"

clean:
	rm -f $(MAIN).aux $(MAIN).log $(MAIN).toc $(MAIN).lof $(MAIN).lot \
	      $(MAIN).idx $(MAIN).ind $(MAIN).ilg $(MAIN).out

distclean: clean
	rm -f $(MAIN).pdf "$(EPUBOUT)"
