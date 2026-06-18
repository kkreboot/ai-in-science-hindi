# विज्ञान में कृत्रिम बुद्धिमत्ता · Artificial Intelligence in Science

*सिद्धांत, अनुप्रयोग एवं भविष्य — Principles, Applications and Future*

An activity- and project-based Hindi science book that introduces **Artificial
Intelligence** through Physics, Chemistry, Biology and Data Science — aimed at
RBSE Class 11–12 students and young science enthusiasts.

**Author:** Krishna Kumar Godara · Department of Physics, IIT Jodhpur
**License:** [CC BY-NC 4.0](https://creativecommons.org/licenses/by-nc/4.0/)
(educational, non-commercial use)

---

## What's inside

- 6 chapters (AI intro, AI in Physics / Chemistry / Biology, Data & experiments, Ethics & future)
- Glossary, answer key, references, project-assessment rubrics, errata page
- Hands-on activities, projects, MCQs, "AI in India" spotlights, an AI timeline
- Companion **Colab notebooks** (see [`notebooks/`](notebooks/)) for every code listing

## Companion Colab notebooks

| Notebook | Open in Colab |
|----------|---------------|
| Ch 2 — spring / regression | [ch2-spring.ipynb](https://colab.research.google.com/github/kkreboot/ai-in-science-hindi/blob/main/notebooks/ch2-spring.ipynb) |
| Ch 3 — solubility | [ch3-solubility.ipynb](https://colab.research.google.com/github/kkreboot/ai-in-science-hindi/blob/main/notebooks/ch3-solubility.ipynb) |
| Ch 4 — DNA / GC content | [ch4-dna.ipynb](https://colab.research.google.com/github/kkreboot/ai-in-science-hindi/blob/main/notebooks/ch4-dna.ipynb) |
| Ch 5 — regression + plot | [ch5-regression-plot.ipynb](https://colab.research.google.com/github/kkreboot/ai-in-science-hindi/blob/main/notebooks/ch5-regression-plot.ipynb) |

## Build

Requires XeLaTeX (TeX Live), `makeindex`, and — for the EPUB — `pandoc` + `dvisvgm`.

```bash
make          # build the PDF  (xelatex ×3 + makeindex)
make epub     # build the EPUB
make all      # both
```

Outputs: `main.pdf` and `epub/विज्ञान-में-कृत्रिम-बुद्धिमत्ता.epub`.

## Repository layout

```
main.tex              # master document
style/aibook.sty      # all styling (palette, Baloo fonts, boxes, chapter openers)
chapters/             # front matter, 6 chapters, appendices, covers
images/               # figures (public-domain) + QR codes + ISBN barcode
fonts/                # Baloo 2 (OFL) display font
notebooks/            # companion Colab notebooks (.ipynb)
epub/                 # EPUB build pipeline (preprocess.pl, metadata, css)
print/                # press-ready wraparound cover spread (bleed + crop marks)
```

## Credits

Public-domain imagery from NASA, ESA, CERN, EMBL-EBI/NCBI and Wikimedia Commons.
Free tools referenced: Google Teachable Machine & Colab, Phyphox, Orange Data
Mining, MolView. Display font: **Baloo 2** (SIL Open Font License).
