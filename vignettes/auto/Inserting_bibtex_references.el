(TeX-add-style-hook
 "Inserting_bibtex_references"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-class-options
                     '(("article" "12pt" "a4paper")))
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("natbib" "authoryear" "round" "longnamesfirst")))
   (add-to-list 'LaTeX-verbatim-environments-local "alltt")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperref")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperimage")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperbaseurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "nolinkurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "url")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "path")
   (add-to-list 'LaTeX-verbatim-macros-with-delims-local "url")
   (add-to-list 'LaTeX-verbatim-macros-with-delims-local "path")
   (TeX-run-style-hooks
    "latex2e"
    "article"
    "art12"
    "a4wide"
    "graphicx"
    "color"
    "alltt"
    "natbib"
    "hyperref")
   (TeX-add-symbols
    '("email" 1)
    "E"
    "VAR"
    "COV"
    "p"
    "ui"
    "oi")
   (LaTeX-add-labels
    "sec:devtools"
    "sec:insert-refer-inter")
   (LaTeX-add-environments
    "smallexample")
   (LaTeX-add-color-definecolors
    "Red"
    "Blue"
    "hellgrau")))

