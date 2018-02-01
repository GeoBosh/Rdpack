# In RStudio, call reprompt on function that cursor is pointing to.

RStudio_reprompt <- function(verbose = TRUE) {
        
  if (!requireNamespace("rstudioapi") || !requireNamespace("rprojroot"))
    stop("RStudio support requires you to install the 'rprojroot' and 'rstudioapi' packages")
        
  sourceContext <- rstudioapi::getSourceEditorContext()
  infile <- sourceContext$path
  
  if (grepl("[.]Rd$", infile))  # editing a help file
    reprompt(infile = infile, filename = infile, verbose = verbose)
  
  else if (grepl("[.][rR]$", infile)) {  # editing R source
    pkgdir <- rprojroot::find_package_root_file(path = dirname(infile))
    pkg <- basename(pkgdir)
    if (length(sourceContext$selection) == 1) {
      fnname <- sourceContext$selection[[1]]$text
    } else
      fnname <- ""
    if (!nchar(fnname))
      stop("Select a function name")
    if (!exists(fnname))
      stop("Object ", sQuote(fnname), " not found.  Run require('", 
           dirname(pkgdir), "')?")
    existing <- help(fnname)
    if (length(existing) == 1) {
      if (basename(pkgdir) != basename(dirname(dirname(existing))))
        stop(sQuote(fnname), " does not appear to be in package ", sQuote(pkg))
      infile <- file.path(pkgdir, "man", paste0(basename(existing), ".Rd"))
      reprompt(infile = infile, filename = infile, verbose = verbose)
    } else if (!length(existing))
      infile <- reprompt(fnname, filename = file.path(pkgdir, "man", paste0(fnname, ".Rd")),
               verbose = verbose)
    else
      stop("Multiple matches to ", sQuote(fnname))
  } else
    stop("This tool only works on .Rd or .R files.")
  
  rstudioapi::navigateToFile(infile)
}