
.comment <- function(x){
    x
    invisible(NULL)
}

## see also > utils::example
run_examples <- function(excontent,     # package = NULL, lib.loc = NULL, character.only = FALSE,
                         give.lines = FALSE,
                         local,            # in utils::example()  it is:  local = FALSE,
                         echo = TRUE,
                         verbose = getOption("verbose"),
                         setRNG = FALSE,
                         ask = FALSE,             # in utils::example() it is:  getOption("example.ask"),
                         ## prompt.prefix = "Rdpack" # in utils::example() it is:  abbreviate(topic, 6),
                         prompt.echo = "Rdpack> ",
                         continue.echo = prompt.echo,
                         run.dontrun = FALSE,
                         run.donttest = FALSE,     # in utils::example() it is:  interactive()
                         Rdsection = "examples",
                         escape = TRUE
                         ){
    ## set the environment where source() evaluates the code;
    ## 2018-08-13 todo: it is not clear if this is the best choice;
    ##     maybe could pass an environment from the macro \printExample, similarly
    ##     to the citation macros (but first need to check if the cause is the choice
    ##     made here:
    if(missing(local))
        local <- parent.frame()

    # dontshow <- function(x){
    #     x
    # }

        # saveRDS(excontent, "excontent.RDS")

    excontent <- deparse(excontent)
    excontent <- gsub("^[ ]*\\{", "", excontent)
    excontent <- gsub("\\}[ ]*$", "", excontent)

    excontent <- gsub(paste0("^[ ]*", ".comment", "[ ]*\\(\"(.*)\"\\)[ ]*$"), "\\1", excontent)

    ## if(interactive())
    ##     browser()


    # file <- tempfile(fileext = ".Rd")

    tf <- tempfile("Rex")
    ## tools::Rd2ex(.getHelpFile(file), tf, commentDontrun = !run.dontrun,
    ##              commentDonttest = !run.donttest)
    writeLines(excontent, tf)
    ## if (!file.exists(tf)) {
    ##     if (give.lines)
    ##         return(character())
    ##     warning(gettextf("%s has a help file but no examples",
    ##         sQuote(topic)), domain = NA)
    ##     return(invisible())
    ## }

    on.exit(unlink(tf))
    ## if (give.lines)
    ##     return(readLines(tf))

    ## if (pkgname != "base")
    ##     library(pkgname, lib.loc = lib, character.only = TRUE)
    if (!is.logical(setRNG) || setRNG) {
        if ((exists(".Random.seed", envir = .GlobalEnv))) {
            oldSeed <- get(".Random.seed", envir = .GlobalEnv)
            on.exit(assign(".Random.seed", oldSeed, envir = .GlobalEnv),
                add = TRUE)
        }
        else {
            oldRNG <- RNGkind()
            on.exit(RNGkind(oldRNG[1L], oldRNG[2L]), add = TRUE)
        }
        if (is.logical(setRNG)) {
            RNGkind("default", "default")
            set.seed(1)
        }
        else eval(setRNG)
    }
    zz <- readLines(tf, n = 1L)
    skips <- 0L
    ## if (echo) {
    ##     zcon <- file(tf, open = "rt")
    ##     while (length(zz) && !length(grep("^### \\*\\*", zz))) {
    ##         skips <- skips + 1L
    ##         zz <- readLines(zcon, n = 1L)
    ##     }
    ##     close(zcon)
    ## }
    if (ask == "default")
        ask <- echo && grDevices::dev.interactive(orNone = TRUE)
    if (ask) {
        if (.Device != "null device") {
            oldask <- grDevices::devAskNewPage(ask = TRUE)
            if (!oldask)
                on.exit(grDevices::devAskNewPage(oldask), add = TRUE)
        }
        op <- options(device.ask.default = TRUE)
        on.exit(options(op), add = TRUE)
    }

    ## TODO: argument 'spaced' (and maybe others?) were introduced in R-3.4.0.
    wrk <- capture.output(
        if(getRversion() >= '3.4.0')
            source(tf, local, echo = echo,
                   prompt.echo = prompt.echo,     # paste0(prompt.prefix, getOption("prompt")),
                   continue.echo = continue.echo, # paste0(prompt.prefix, getOption("continue")),
                   spaced = FALSE, # do not print empty line before each source line
                   verbose = verbose, max.deparse.length = Inf,
                   encoding = "UTF-8", skip.echo = skips, keep.source = TRUE)
        else
            source(tf, local, echo = echo,
                   prompt.echo = prompt.echo,     # paste0(prompt.prefix, getOption("prompt")),
                   continue.echo = continue.echo, # paste0(prompt.prefix, getOption("continue")),
                   # spaced = FALSE, - no such argument before R-3.4.0
                   verbose = verbose, max.deparse.length = Inf,
                   encoding = "UTF-8", skip.echo = skips, keep.source = TRUE)
    )


        # \Sexpr[stage=build,results=rd]{
        #     paste0("\\\\examples{", {
        #         pf <- "Rdpack"
        #         tmp <- capture.output(utils::example("ES", prompt.prefix = pf))
        #         flags <- grepl("Rdpack> ", tmp)
        #         tmp[!flags] <- paste0("#> ", tmp[!flags])
        #         tmp <- gsub("Rdpack> ", "", tmp)
        #         res <- paste0(tmp, collapse = "\n")
        #     }, "}", collapse = "\n")}

    # browser()

    flags <- grepl(paste0("^", prompt.echo), wrk)
    outflags <- !flags & !grepl("^[ ]*$", wrk)
    wrk[outflags] <- paste0("##: ", wrk[outflags])
    wrk <- gsub(paste0("^", prompt.echo, "[ ]*"), "", wrk)
    ## wrk <- gsub(paste0("^[ ]*", "identity", "[ ]*\\(\"(.*)\"\\)[ ]*$"), "\\1", wrk)
    wrk <- gsub("^## *$", "", wrk)

    res <- paste0(paste0(wrk, collapse = "\n"), "\n")

    if(escape)  # 2018-08-25
        res <- .bspercent(res)

    ## TODO: prefix with spaces to indent from surrounding text?
    if(is.character(Rdsection)){
        res <- paste0("\\", Rdsection, "{", res, "}\n")
    }

#    if(interactive())
#        browser()
    res
}


## cat(Rdpack:::run_examples(quote({2+2
## ## trig
## sin(pi)})))
##
## withAutoprint(quote({2+2
## ## trig
## sin(pi)}))
##
## e1 <-
## (quote({2+2
## ## trig
## sin(pi)}))
##
## attr(e1, "wholeSrcref")
##
##
## e2 <-
## quote({2+2
## ## trig
## sin(pi)})
##
## attr(e2, "wholeSrcref")
##
## e2a <-
## quote({2+2
## sin(pi)})
##
## attr(e2a, "wholeSrcref")
##
## unclass(attr(e2a, "wholeSrcref"))
##
## e3 <-
## quote(2+2)
##
## attr(e3, "wholeSrcref")


## Rdpack:::run_examples(quote({cvar::VaR(qnorm, x = c(0.01, 0.05), dist.type = "qf"); 2*3;  2 + 2; a <- 2 - 2; b <- 2/3 }))


insert_fig <- function(file, package, code, insert = TRUE){
    res <- if(insert)
               paste0("\\figure{", file, "}")
           else
               file

    dirs <- c("./man/", file.path(".", package, "man"))
    w <- sapply(dirs, dir.exists)
    dcur <- dirs[w]
    if(length(dcur) == 2) { # both, ./man and ./package/man exist
        warning(paste0("Ambiguity: both, './man' and './", package, "/man' exist,",
                       "choosing the latter."))
        dcur <- dcur[2]
    } else if(length(dcur) == 0) {
        ## try harder
        pat <- paste0("^", package, ".+") # dir name is pkg followed by something else (e.g. version)
        wrk <- intersect(dir(pattern = pat), list.dirs(full.names = FALSE, recursive = FALSE))

        if(length(wrk) == 0) {
            warning("Unable to locate 'man/figure/' to write the graphics,\n",
                    "please contact the maintainer of 'Rdpack';\n\n",
                    "using previously created figure, if available.")

            return(res)
        }

        man_dir <- character(0)
        for(wdir in wrk) {
            dirs <- c(file.path(".", wdir, "man"), file.path(".", wdir, package, "man"))
            w <- sapply(dirs, dir.exists)
            man_dir <- c(man_dir, dirs[w])
        }

        if(length(man_dir) == 1) {
            dcur <- man_dir
        } else if(length(man_dir) > 1) {
            warning("Ambiguity: more than one package directories found:\n",
                    "    ", paste(man_dir, collapse = ", "), "\n",
                    "please contact the maintainer of 'Rdpack';\n\n",
                    "writing to the last directory found.")

            ## TODO: probably should not write to a potentially unexpected directory;
            ##       should just return(res), as above.
            dcur <- man_dir[length(man_dir)]
        } else { # length(man_dir) == 0
            warning("Unable to locate 'man/figure/' to write the graphics,\n",
                    "please contact the maintainer of 'Rdpack';\n\n",
                    "using previously created figure, if available.")

            return(res)
        }
    }
  
    figpath <- file.path(dcur, "figures")
    if(!dir.exists(figpath)) {
        flag <- dir.create(figpath)
        if(!flag) {
            warning("Unable to create 'man/figure/' to write the graphics,\n",
                    "using previously created figure, if available.")
            return(res)
        }
    }

    grDevices::png(file.path(figpath, file))
    on.exit(grDevices::dev.off())
  
    force(code)

    res
}
