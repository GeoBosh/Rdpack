# TODO: krapka!
.patch_latex <- function(txt){   # print(bibentry,"latex") inserts \bsl macros.
    gsub("\\bsl{}", "", txt, fixed=TRUE)
}

bibentry_key <- function(x){                                                     # 2013-03-29
    attr(unclass(x[[1]][[1]])[[1]], "key")
}

get_bibentries <- function(..., package = NULL, bibfile = "REFERENCES.bib", everywhere = TRUE){

    if(is.null(package))
        fn <- file.path(..., bibfile)
            # 2018-03-03 was:
            #     else fn <- system.file(..., bibfile, package = package, mustWork=TRUE)
    else if(file.exists(system.file("inst", bibfile, package = package)))
        ## development mode in "devtools"
        fn <- system.file("inst", ..., bibfile, package = package)
    else{
        fn <- system.file(..., bibfile, package = package)
        if(length(fn) == 1  &&  fn == ""  &&  !is.null(package))
            ## package "bibtex" emulates REFERENCES.bib for core R packages
            fn <- system.file("bib", sprintf("%s.bib", package), package = "bibtex")
    }

    if(length(fn) > 1){
        warning("More than one file found, using the first one only.")
        fn <- fn[1]
    }else if(length(fn) == 1  &&  fn == "")
        stop("Couldn't find file ", file.path(..., bibfile),
             if(!is.null(package)) paste0(" in package ", package) )


    ## 2018-02-14: TODO: this also needs adjustment to work in  development mode in RStudio,
    ##             without this adjustment read.bib can't find REFERENCES.bib
    ##             (see insert_ref())
    res <- read.bib(file = fn, package = package)

    ## 2016-07-26 Now do this only for versions of  bibtex < '0.4.0'.
    ##            From bibtex '0.4.0' read.bib() sets the names.
    if(packageVersion("bibtex") < '0.4.0'){
        names(res) <- sapply(1:length(res), function(x) bibentry_key(res[[x]][[1]]))
    }

    for(nam in names(res)){
        if(!is.null(res[nam]$url))
            res[nam]$url <- gsub("([^\\])%", "\\1\\\\%", res[nam]$url)

        if(everywhere){
            fields <- names(unclass(res[nam])[[1]])

            unclassed <- unclass(res[nam])
            flag <- FALSE
            for(field in fields){
                wrk <- unclass(res[nam])[[1]][[field]]
                if(is.character(wrk) && any(grepl("([^\\])%", wrk))){
                    flag <- TRUE
                    unclassed[[1]][[field]] <- gsub("([^\\])%", "\\1\\\\%", wrk)
                }
            }
            if(flag){
                class(unclassed) <- class(res[nam])
                res[nam] <- unclassed
            }
        }
    }


    ## 2018-03-03 new:
    class(res) <- c("bibentryRd", class(res))

    res
}

print.bibentryRd <- function (x, style = "text", ...){
    class(x) <- class(x)[-1]
    ## TODO: It would be better to modify the entries and then call
    ##       print(), rather than vice versa as now.
    res <- capture.output(print(x, style = style, ...))
    res <- switch(tolower(style),
                  r        = gsub("\\\\\\\\%", "%", res),
                  citation = ,
                  bibtex   = gsub("\\\\%", "%", res),

                  res
                  )
    cat(res, sep = "\n")
}

rebib <- function(infile, outfile, ...){                     # 2013-03-29
    rdo <- permissive_parse_Rd(infile)   ## 2017-11-25 TODO: argument for RdMacros!

    if(missing(outfile))
        outfile <- basename(infile)
    else if(identical(outfile, ""))  # 2013-10-23 else clause is new
        outfile <- infile

    rdo <- inspect_Rdbib(rdo, ...)

    Rdo2Rdf(rdo, file=outfile, srcfile=infile)

    rdo
}


inspect_Rdbib <- function(rdo, force = FALSE, ...){               # 2013-03-29
                   # 2013-12-08 was: pos <- Rdo_locate_predefined_section(rdo, "\\references")
    pos <- Rdo_which_tag_eq(rdo, "\\references")

    if(length(pos) > 1)
        stop(paste("Found", length(pos), "sections `references'.\n",
                   "There should be only one."
                   ))
    else if(length(pos) == 0)  # no section "refeences".
        return(rdo)

    bibs <- get_bibentries(...)

    fkey <- function(x){
                 m <- gregexpr("[ ]+", x)
                 rm <- regmatches(x, m, invert = TRUE)[[1]]
                 if(length(rm) >= 2 && rm[2] != "bibentry:")
                     rm[2]   # e.g. bibentry:all
                 else if(length(rm) < 3)     # % bibentry: xxx_key_xxx
                     ""   # NA_character_
                 else
                     rm[3]
             }

    fbib <- function(x) grepl("[ ]+bibentry:", x)
    posbibs <-  Rdo_locate(rdo[[pos]], f = fbib, pos_only = fkey)
    poskeys <- sapply(posbibs, function(x) x$value)

    print(posbibs)

    fendkey <- function(x){
                 m <- gregexpr("[ ]+", x)
                 rm <- regmatches(x, m, invert = TRUE)[[1]]
                 if(length(rm) >= 2 && rm[2] != "end:bibentry:")
                     rm[2]   # e.g. end:bibentry:all
                 else if(length(rm) < 3)     # % end:bibentry: xxx_key_xxx
                     ""   # NA_character_
                 else
                     rm[3]
             }

    fendbib <- function(x) grepl("end:bibentry:", x)
    posendbibs <-  Rdo_locate(rdo[[pos]], f = fendbib, pos_only = fendkey)
    posendkeys <- sapply(posendbibs, function(x) x$value)

    toomit <- which(poskeys %in% posendkeys)  # note: en@bibkeys:all is different! todo:
    if(length(toomit) > 0  && !force){
        poskeys <- poskeys[-toomit]
        posbibs <- posbibs[-toomit]
    }

    if(length(poskeys)==0)
        "nothing to do."
    else if(any(poskeys == "bibentry:all")){
        poskey <- posbibs[[ which(poskeys == "bibentry:all") ]]$pos

        bibstxt <- capture.output(print(bibs, "latex"))

        bibstxt <- .patch_latex(bibstxt)  # TODO: krapka!

        bibstxt <- paste(c("", bibstxt), "\n", sep="")
        endbibline <- Rdo_comment("% end:bibentry:all")

        keyflag <- "end:bibentry:all" %in% posendkeys
        if(keyflag && force){              #todo: more careful!
            endposkey <- posendbibs[[ which(posendkeys == "end:bibentry:all") ]]$pos
            rdo[[pos]] <- Rdo_flatremove(rdo[[pos]], poskey+1, endposkey)
        }

        if(!keyflag || force){
            rdo[[pos]] <- Rdo_flatinsert(rdo[[pos]], list(endbibline), poskey,
                                         before = FALSE)
            rdo[[pos]] <- Rdo_flatinsert(rdo[[pos]], bibstxt, poskey,
                                         before = FALSE)
        }
    }else{
        for(i in length(poskeys):1){
            bibkey <- posbibs[[i]]$value
            poskey <- posbibs[[i]]$pos

            bibstxt <- capture.output(print(bibs[poskeys[i]],"latex"))

            bibstxt <- .patch_latex(bibstxt)  # TODO: krapka!

            bibstxt <- list( paste( c("", bibstxt), "\n", sep="") )
            endbibline <- Rdo_comment(paste("% end:bibentry: ", bibkey))

            keyflag <- bibkey %in% posendkeys
            if(keyflag && force){                                       #todo: more careful!
                endposkey <- posendbibs[[ which(posendkeys == bibkey) ]]$pos
                rdo[[pos]] <- Rdo_flatremove(rdo[[pos]], poskey+1, endposkey)
            }

            if(!keyflag || force){ # this is always TRUE here but is left for common look
                                   # with "all". todo: needs consolidation
                rdo[[pos]] <- Rdo_flatinsert(rdo[[pos]], list(endbibline), poskey,
                                             before = FALSE)
                rdo[[pos]] <- Rdo_flatinsert(rdo[[pos]], bibstxt, poskey,
                                             before = FALSE)
            }
        }
    }

    rdo
}

Rdo_flatremove <- function(rdo, from, to){  # 2013-03-30 todo: more careful!
    res <- rdo[-(from:to)]
    attributes(res) <- attributes(rdo)             # todo: more guarded copying of attributes?
    res
}

                                        # todo: move to another file later
Rdo_flatinsert <- function(rdo, val, pos, before = TRUE){                        # 2013-03-29
    depth <- length(pos)
    if(depth > 1){
        rdo[[pos]] <- Recall(rdo[[ pos[-depth] ]], val, pos[-depth])
        # todo: dali zapazva attributite na rdo?
        return(rdo)
    }

    n <- length(rdo)
    if(!before)
        pos <- pos + 1

    res <- if(pos==1)        c(val, rdo)
           else if(pos==n+1) c(rdo, val)
           else              c( rdo[1:(pos-1)], val, rdo[pos:n])
    attributes(res) <- attributes(rdo)             # todo: more guarded copying of attributes?
    res
}


## additions on 2016-07-24 and later (all code to the end of this file)

## TODO: auto-deduce 'package'?
insert_ref <- function(key, package = NULL, ...) { # bibfile = "REFERENCES.bib"
    if(is.null(package))
        stop("argument 'package' must be provided")

    ## leave this to read.bib()
    ##     bibfile <- system.file(bibfile, package = package, mustWork = TRUE)

    ## TODO: "names<-()" may change some keys since bibtex keys are not necessarilly R
    ##       syntactic names.
    ##
    ## 2018-02-14: adjust to work in  development mode in RStudio,
    ##             without this adjustment read.bib can't find REFERENCES.bib
    ##
    ## It would probably be more robust to use rstudioapi::isAvailable()
    ##   but then "rstudioapi" woud have to be moved from "Suggests:" to "Imports:"
    ##
    ## TODO: actually need to check if the package is in development mode in RStudio
    ##
    ## Simplitying this:
    ##   if(identical(.Platform$GUI, "RStudio")){
    ##       ## TODO: take care for the case when bibfile contains path
    ##       ##       and also that builtin packages are treated specially by read.bib
    ##       bibfile_path <- system.file("inst", "REFERENCES.bib", package = package)
    ##       if(!file.exists(bibfile_path))
    ##           bibfile_path <- system.file("REFERENCES.bib", package = package)
    ##       bibs <- read.bib(file = bibfile_path) # TODO: drops ...; handle at least "encoding"?
    ##   }else{
    ##       ## 2018-02-14 the above change is needed also when using devtools::load_all()
    ##       ##            outside RStudio
    ##       bibfile_path <- system.file("inst", "REFERENCES.bib", package = package)
    ##       if(file.exists(bibfile_path)){
    ##           ## devtools development mode
    ##           bibs <- read.bib(file = bibfile_path) # TODO: drops ...; handle at least "encoding"?
    ##       }else{
    ##           ## not in development mode - keep the old call
    ##           bibs <- read.bib(package = package, ...)
    ##       }
    ##   }

    ## this simplifies the above change:
    bibfile_path <- system.file("inst", "REFERENCES.bib", package = package)
    if(file.exists(bibfile_path)){
        ## devtools development mode
        bibs <- read.bib(file = bibfile_path) # TODO: drops ...; handle at least "encoding"?
    }else{
        ## not in development mode - keep the old call
        ##    Strictly speaking, "REFERENCES.bib" does not exist for bult-in packages, but
        ##    read.bib simulates it for them, see bibtex:::findBibFile().  So, if package is
        ##    such a package we may be in development mode here, and the following call may
        ##    fail.  BUT is this possible or even realistic scenario for such packages would
        ##    be under developed with devtools::load_all(), etc.?
        bibs <- read.bib(package = package, ...)
    }

    if(packageVersion("bibtex") < '0.4.0'){
        names(bibs) <- sapply(1:length(bibs), function(x) bibentry_key(bibs[[x]][[1]]))
    }
        # 2018-01-25: was:
        #     wrk <- toRd(bibs[[key]]) # TODO: add styles? (doesn't seem feasible here)
        # adding a check to give user more informative message (than 'key out of bounds')

    ## Catch the warning only if length(key) == 1, since otherwise it would be better to process
    ## the remaining keys anyway
    ##
    ## TODO: on the other hand, the function is documented to work for one key,
    ##       maybe check this? Alternatively, document that more keys are acceptable.

        # item <- if(length(key) == 1){
        #             tryCatch(bibs[[key]],
        #                      warning = function(c) {
        #                          ## tell the user the offending key.
        #                          s <- paste0("possibly non-existing key '", key, "'")
        #                          c$message <- paste0(c$message, " (", s, ")")
        #                          warning(c)
        #                          res <- paste0("\nInserting reference '", key,
        #                                        "' from package '", package, "' - ",
        #                                        s, ".\n")
        #                          return(res)
        #                      })
        #         }else{
        #             bibs[[key]]
        #         }

    if(length(key) == 1){
        item <- tryCatch(bibs[[key]],
                         warning = function(c) {
                             ## tell the user the offending key.
                             s <- paste0("possibly non-existing key '", key, "'")
                             c$message <- paste0(c$message, " (", s, ")")
                             warning(c)
                             res <- paste0("\nWARNING: failed to insert reference '", key,
                                           "' from package '", package, "' - ",
                                           s, ".\n")
                             return(res)
                         })

        ## 2018-03-01 Bug: Unexpected END_OF_INPUT error (URL parsing?) #3
        ##     I don't know why toRd() doesn't do this...
        ##
        ## escape percents that are not preceded by backslash
        if(!is.null(item$url))
            item$url <- gsub("([^\\])%", "\\1\\\\%", item$url)

        toRd(item) # TODO: add styles? (doesn't seem feasible here)
    }else{
        ## key is documented to be of length one, nevertheless handle it too
        kiki <- FALSE
        items <- withCallingHandlers(bibs[[key]], warning = function(w) {kiki <<- TRUE})
        ## TODO: deal with URL's as above
        txt <- toRd(items)

        if(kiki){ # warning(s) in bibs[[key]]
            s <- paste0("WARNING: failed to insert ",
                        "one or more of the following keys in REFERENCES.bib:\n",
                        paste(key, collapse = ", \n"), ".")
            warning(s)
            txt <- c(txt, s)
        }
        paste0(paste(txt, collapse = "\n\n"), "\n")
    }
}


## 2017-11-25 new
## see utils:::print.help_files_with_topic()
viewRd <- function(infile, type = "text", stages = NULL){
    infile <- normalizePath(infile)

    if(is.null(stages))
        # stages <- c("install", "render")
        stages <- c("build", "install", "render")
        # stages <- c("build", "render")
    else if(!is.character(stages) || !all(stages %in% c("build", "install", "render")))
        stop('stages must be a character vector containing one or more of the strings "build", "install", and "render"')

    ## here we need to expand the Rd macros, so don't use permissive_parse_Rd()
    ## TODO: (BUG) e is NULL under RStudio
    e <- tools::loadPkgRdMacros(system.file(package = "Rdpack"))
    ## Rdo <- parse_Rd(infile, macros = e)

    pkgname <- basename(dirname(dirname(infile)))
    outfile <- tempfile(fileext = paste0(".", type))

    ## can't do this, the file may be deleted before the browser opens it:
    ##        on.exit(unlink(outfile))
    switch(type,
           text = {
               temp <- tools::Rd2txt(infile, # was: Rdo,
                                     out = outfile, package = pkgname, stages = stages
                                     , macros = e)
               file.show(temp, delete.file = TRUE) # text file is deleted
           },
           html = {
               temp <- tools::Rd2HTML(infile, # was: Rdo,
                                      out = outfile, package = pkgname,
                                      stages = stages
                                      , macros = e)
               browseURL(temp)
               ## html file is not deleted
#browser()
           },
           stop("'type' should be one of 'text' or 'html'")
           )
}

## temporary; not exported
vigbib <- function(package, verbose = TRUE, ..., vig = NULL){
    if(!is.null(vig))
        return(makeVignetteReference(package, vig, ...))

    vigs <- vignette(package = package)
    if(nrow(vigs$results) == 0){
        if(verbose)
            cat("No vignettes found in package ", package, "\n")
        return(bibentry())
    }
    wrk <- lapply(seq_len(nrow(vigs$results)),
                  function(x) makeVignetteReference(package = package, vig = x,
                                                    verbose = FALSE, ...)
                  )
    res <- do.call("c", wrk)
    if(verbose)
        print(res, style = "Bibtex")
    invisible(res)
}


makeVignetteReference <- function(package, vig = 1, verbose = TRUE,
                                  title, author, type = "pdf",
                                  bibtype = "Article", key = NULL
                                  ){
    publisher <- NULL # todo: turn this into an argument some day ...

    if(missing(package))
        stop("argument 'package' is missing with no default")

    cranname <- "CRAN"
    cran <- "https://CRAN.R-Project.org"
    cranpack <- paste0(cran, "/package=", package)

    ## todo: for now only cran
    if(is.null(publisher)){
        publisher <- cran
        publishername <- cranname
        publisherpack <- cranpack
    }

    desc <- packageDescription(package)
    vigs <- vignette(package = package)

    if(is.character(vig)){
        vig <- pmatch(vig, vigs$results[ , "Item"])
        if(length(vig) == 1  &&  !is.na(vig)){
            wrk <- vigs$results[vig, "Title"]
        }else
            stop(paste0("'vig' must (partially) match one of:\n",
                        paste0("\t", 1:nrow(vigs$results), " ", vigs$results[ , "Item"], "\n",
                               collapse = "\n"),
                        "Alternatively, 'vig' can be the index printed in front of the name above."))
    }else if(1 <= vig  && vig <= nrow(vigs$results)){
        wrk <- vigs$results[vig, "Title"]
    }else{
        stop("not ready yet, should return all vigs in the package.")
    }


    if(missing(author))
        author <- desc$Author

    title <- gsub(" \\([^)]*\\)$", "", wrk)  # drop ' (source, pdf)'
    item <- vigs$results[vig, "Item"]
    vigfile <- paste0(item, ".", type)

    journal <- paste0("URL ", publisherpack, ".",
                      " Vignette included in R package ", package,
                      ", version ", desc$Version
                      )

    if(is.null(desc$Date)){ # built-in packages do not have field "year"
        if(grepl("^Part of R", desc$License[1])){
            ## title <- paste0(title, "(", desc$License, ")")
            publisherpack <- cran ## do not add package=... to https in this case
            journal <- paste0("URL ", publisherpack, ".",
                              " Vignette included in R package ", package,
                              " (", desc$License, ")"
                              )
        }
        year <- R.version$year
    }else
        year <- substring(desc$Date, 1, 4)

                 # stop(paste0("argument 'vig' must be a charater string or an integer\n",
                 #            "between 1 and the number of vignettes in the package"))

    if(is.null(key))
        key <- paste0("vig", package, ":", vigs$results[vig, "Item"])

    res <- bibentry(
        key = key,
        bibtype = bibtype,
        title = title,
        author = author,
        journal = journal,
        year = year,
        ## note = "R package version 1.3-4",
        publisher = publishername,
        url = publisherpack
    )

    if(verbose){
        print(res, style = "Bibtex")
        cat("\n")
    }
    res
}
