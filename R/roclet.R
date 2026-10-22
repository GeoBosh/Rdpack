## A roxygen2 roclet that expands the citation macros when roxygen2 writes the
## Rd files, rather than when the package is built.
##
## Each citation macro expands to \Sexpr[stage=build].  'R CMD build' must
## install a package before it can evaluate any build-stage \Sexpr, so a
## package with compiled code is compiled once to build its tarball and again
## to install it.  Rd files written by this roclet contain no such \Sexpr.

rdpack_roclet <- function() {
    if(!requireNamespace("roxygen2", quietly = TRUE))
        stop("rdpack_roclet() requires package 'roxygen2'")
    roxygen2::roclet(c("rdpack", "rd"))
}

roclet_process.roclet_rdpack <- function(x, blocks, env, base_path) {
    topics <- NextMethod()
    .refresh_package_bibs(base_path)
    for(topic in topics)
        topic$sections <- .expand_rd_sections(topic$sections)
    topics
}

## Read the package's own REFERENCES.bib from the source tree, so that edits
## made since the bib cache was filled are seen, whatever the working directory.
.refresh_package_bibs <- function(base_path) {
    package <- read.dcf(file.path(base_path, "DESCRIPTION"), fields = "Package")[1, 1]
    bibfile <- file.path(base_path, "inst", "REFERENCES.bib")
    if(file.exists(bibfile))
        .bibs_cache$.set_bibs0(package, get_bibentries(bibfile = bibfile))
}

## roxygen2 writes the sections of an Rd file in this order (RoxyTopic$format);
## \insertAllCited lists the citations that precede it, so expand in that order.
.rd_section_order <- c("backref", "docType", "encoding", "name", "alias", "title",
                       "format", "source", "usage", "param", "value", "description",
                       "details", "minidesc", "field", "slot", "rcmethods", "note",
                       "section", "examples", "references", "seealso", "author",
                       "concept", "keyword", "rawRd")

.expand_rd_sections <- function(sections) {
    cached_env <- new.env()
    first <- intersect(.rd_section_order, names(sections))
    for(type in c(first, setdiff(names(sections), first)))
        sections[[type]]$value <- .expand_rd_value(sections[[type]]$value, cached_env)
    sections
}

.expand_rd_value <- function(x, cached_env) {
    if(is.character(x))
        x[] <- vapply(x, .expand_rd_text, "", cached_env = cached_env, USE.NAMES = FALSE)
    else if(is.list(x))
        x[] <- lapply(x, .expand_rd_value, cached_env = cached_env)
    x
}

.citation_macro_pattern <- paste0(
    "\\\\(insertRef|insertCite|insertCiteOnly|insertNoCite)\\{([^{}]*)\\}\\{([^{}]*)\\}",
    "|\\\\(insertAllCited|insertCited)\\{\\}")

.expand_rd_text <- function(text, cached_env) {
    if(is.na(text))
        return(text)
    m <- gregexpr(.citation_macro_pattern, text)
    macros <- regmatches(text, m)[[1]]
    if(length(macros) == 0)
        return(text)
    ## sequential, as the \Sexpr's in an Rd file are evaluated
    expanded <- character(length(macros))
    for(i in seq_along(macros))
        expanded[i] <- .expand_citation_macro(macros[i], cached_env)
    regmatches(text, m) <- list(expanded)
    text
}

## Calls the same functions, with the same arguments, as the macros in
## man/macros/refmacros.Rd.
.expand_citation_macro <- function(macro, cached_env) {
    parts <- regmatches(macro, regexec(.citation_macro_pattern, macro))[[1]]
    name <- if(nzchar(parts[2])) parts[2] else parts[5]
    keys <- parts[3]
    package <- parts[4]
    res <- switch(name,
        insertRef      = insert_ref(key = keys, package = package),
        insertCite     = insert_citeOnly(keys = keys, package = package,
                                         cached_env = cached_env),
        insertCiteOnly = insert_citeOnly(keys = keys, package = package,
                                         cached_env = cached_env, cite_only = TRUE),
        insertNoCite   = insert_citeOnly(keys = keys, package = package,
                                         cached_env = cached_env, dont_cite = TRUE),
        insertAllCited = insert_all_ref(cached_env),
        insertCited    = insert_all_ref(cached_env, empty_cited = TRUE))
    paste0(res, collapse = "\n")
}
