(TeX-add-style-hook
 "REFERENCES"
 (lambda ()
   (LaTeX-add-bibitems
    "Rpack:bibtex"
    "parseRd"
    "Rdevtools"))
 :bibtex)

