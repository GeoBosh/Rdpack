# In RStudio, call reprompt on function that cursor is pointing to.

RStudio_reprompt <- function(verbose = TRUE) {

    if (!requireNamespace("rstudioapi") || !requireNamespace("rprojroot"))
        stop("RStudio support requires you to install the 'rprojroot' and 'rstudioapi' packages")

    sourceContext <- rstudioapi::getSourceEditorContext()
    infile <- sourceContext$path

    if(length(infile) == 0)
        stop("Nothing to do. See ?Rdpack::RStudio_reprompt for information about this add-in.")

    if (grepl("[.][rR]d$", infile))  # editing a help file
        reprompt(infile = infile, filename = infile, verbose = verbose)

    else if (grepl("[.][rRsSq]$", infile)) {  # editing R source
        pkgdir <- rprojroot::find_package_root_file(path = dirname(infile))
        pkg <- basename(pkgdir)

        if (length(sourceContext$selection) == 1) {
            fnname <- sourceContext$selection[[1]]$text
        } else
            fnname <- ""
        if (!nchar(fnname))
            stop("Select a function name")

        if (!exists(fnname))
            stop("Object ", sQuote(fnname), " not found.  Run 'Install and Restart'?")

        existing <- help(fnname)
        ## Subset to the ones in the current package
        existing <- existing[basename(dirname(dirname(existing))) == pkg]

        if (length(existing) == 1) {
            infile <- file.path(pkgdir, "man", paste0(basename(existing), ".Rd"))
            reprompt(infile = infile, filename = infile, verbose = verbose)
        } else if (!length(existing))
            infile <- reprompt(fnname,
                               filename = file.path(pkgdir, "man", paste0(fnname, ".Rd")),
                               verbose = verbose)
        else
            stop("Multiple matches to ", sQuote(fnname), ".  Open one help file manually.")
    } else
        stop("This tool only works on .Rd or .R files.")

    rstudioapi::navigateToFile(infile)
}
