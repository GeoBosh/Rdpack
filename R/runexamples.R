
## see also > utils::example
run_examples <- function(excontent,     # package = NULL, lib.loc = NULL, character.only = FALSE,
                         give.lines = FALSE,
                         local = TRUE,            # in utils::example()  it is:  local = FALSE,
                         echo = TRUE,
                         verbose = getOption("verbose"),
                         setRNG = FALSE,
                         ask = FALSE,             # in utils::example() it is:  getOption("example.ask"),
                         ## prompt.prefix = "Rdpack" # in utils::example() it is:  abbreviate(topic, 6),
                         prompt.echo = "Rdpack> ",
                         continue.echo = prompt.echo,
                         run.dontrun = FALSE,
                         run.donttest = FALSE,     # in utils::example() it is:  interactive()
                         Rdsection = "\\examples"
                         ){

    saveRDS(excontent, "excontent.RDS")

    excontent <- deparse(excontent)
    excontent <- gsub("^[ ]*\\{", "", excontent)
    excontent <- gsub("\\}[ ]*$", "", excontent)

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

    wrk <- capture.output(
        source(tf, local, echo = echo,
               prompt.echo = prompt.echo,     # paste0(prompt.prefix, getOption("prompt")),
               continue.echo = continue.echo, # paste0(prompt.prefix, getOption("continue")),
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
    wrk[!flags] <- paste0("#> ", wrk[!flags])
    wrk <- gsub(paste0("^", prompt.echo), "", wrk)

    res <- paste0(paste0(wrk, collapse = "\n"), "\n")

    if(is.character(Rdsection)){
        res <- paste0(Rdsection, "{", res, "}\n")
    }

    # if(interactive())
    #     browser()
    res
}
