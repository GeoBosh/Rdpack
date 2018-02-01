# In RStudio, call reprompt on function that cursor is pointing to.

RStudio_reprompt <- function(verbose = TRUE) {
        
  if (!require("rstudioapi"))
    stop("RStudio support requires you to install the rstudioapi package")
        
  sourceContext <- rstudioapi::getSourceEditorContext()
  infile <- sourceContext$path
  
  if (grepl("[.]Rd$", infile))  # editing a help file
    reprompt(infile = infile, filename = infile, verbose = verbose)
  
  else if (grepl("[.][rR]$", infile)) {  # editing R source
    dir <- file.path(dirname(dirname(infile)), "man")
    if (length(sourceContext$selection) == 1) {
      fnname <- sourceContext$selection[[1]]$text
    } else
      fnname <- ""
    if (!nchar(fnname))
      stop("Select a function name")
    existing <- help(fnname)
    if (length(existing) == 1) {
      infile <- file.path(dir, paste0(basename(existing), ".Rd"))
      reprompt(infile = infile, filename = infile, verbose = verbose)
    } else if (!length(existing))
      infile <- reprompt(fnname, filename = file.path(dir, paste0(fnname, ".Rd")),
               verbose = verbose)
    else
      stop("Multiple matches to ", dQuote(fnname))
  } else
    stop("Open R source or Rd source and try again")
  
  rstudioapi::navigateToFile(infile)
}