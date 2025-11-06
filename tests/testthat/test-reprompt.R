context("reprompt")

test_that("reprompt works fine", {
    tmpfn <- tempfile(fileext = rep(".Rd",  4))
    on.exit(unlink(tmpfn))
    reprompt("viewRd", filename = tmpfn[1])
    reprompt(infile = tmpfn[1], filename = tmpfn[2])

    fn1  <- system.file("examples/reprompt.Rd", package = "Rdpack")
    reprompt(fn1, filename = tmpfn[2])

    ## contains S3 method as.character.f_usage
    reprompt(as.character.f_usage)

    ## S4

    ## from package "methods" - this page is peculiar; eg has no section 'arguments'
    reprompt("ts", type = "class")
    reprompt("show", type = "methods", package = "methods")

    ## (TODO: investigate) Need 'expect_warning' here since the following warning is issued
    ##                     for the S4 reprompt's:
    ##   Calling 'structure(NULL, *)' is deprecated, as NULL cannot have attributes.
    ##     Consider 'structure(list(), *)' instead.
    ##   Backtrace:
    ##    1. Rdpack::reprompt("initialize", type = "methods", package = "methods") test-reprompt.R:20:4
    ##    2. Rdpack::inspect_Rd(rdo, package = package) /home/georgi/repos/private/Rdpack/R/repromptAny.R:65:8
    ##    3. Rdpack::inspect_Rdfun(rdo) /home/georgi/repos/private/Rdpack/R/inspect.R:60:4
    ##    4. Rdpack::inspect_usage(rdo) /home/georgi/repos/private/Rdpack/R/inspect.R:148:4
    ##    5. Rdpack::get_usage_text(rdo) /home/georgi/repos/private/Rdpack/R/usage.R:2:4
    ##    6. base::structure(rdo_u, Rd_tag = "Rd") /home/georgi/repos/private/Rdpack/R/manip.R:260:4

    if(getRversion() >= "4.6.0") {
        expect_error(reprompt("initialize", type = "methods", package = "methods"))
        expect_error(reprompt("classRepresentation", type = "class"))

    } else {
        expect_warning(reprompt("initialize", type = "methods", package = "methods"))
        expect_warning(reprompt("classRepresentation", type = "class"))
    }

    setClass("Seq", slots = c(from = "numeric", to = "numeric", by = "numeric"))
    setMethod("show", "Seq",
              function(object){
                  print(c(from = object@from, to = object@to, by = object@by))
              })

    ## this doesn't include "Seq" - TODO: investigate
    reprompt("show-methods", filename = tmpfn[2])

    ## myshow <- function(object) NULL # this doesn't work here TODO: why?
    setGeneric("myshow", function(object) NULL)
    setMethod("myshow", "Seq",
              function(object){
                  print(c(from = object@from, to = object@to, by = object@by))
              })
    reprompt(myshow, type = "methods")



    ## this doesn't work in R CMD check:
    ##   reprompt("Seq", type = "class", filename = tmpfn[2])


    ## adapted reprompt.Rd

    tmpdir <- tempdir()
    old_wd <- setwd(tmpdir)
    on.exit({setwd(old_wd); unlink(tmpdir)}, add = TRUE)

    ## as for prompt() the default is to save in current dir as "seq.Rd".
    ## the argument here is a function, reprompt finds its doc and
    ## updates all objects described along with `seq'.
    ## (In this case there is nothing to update, we have not changed `seq'.)

    fnseq <- reprompt(seq)

    ## let's parse the saved Rd file (the filename is returned by reprompt)
    rdoseq <- tools::parse_Rd(fnseq)   # parse fnseq to see the result.
    Rdo_show(rdoseq)

    ## we replace usage statements with wrong ones for illustration.
    ## (note there is an S3 method along with the functions)
    dummy_usage <- char2Rdpiece(paste("seq()", "\\\\method{seq}{default}()",
                       "seq.int()", "seq_along()", "seq_len()", sep="\n"),
                       "usage")
    rdoseq_dummy <- Rdo_replace_section(rdoseq, dummy_usage)
    Rdo_show(rdoseq_dummy)  # usage statements are wrong

    ## TODO: this works in the examples but fails devtools::test()
    ##   reprompt(rdoseq_dummy, filename = "seqA.Rd")
    ##   Rdo_show(tools::parse_Rd("seqA.Rd"))  # usage ok after reprompt

    ## define function myseq()
    myseq <- function(from, to, x){
        if(to < 0) {
            seq(from = from, to = length(x) + to)
        } else seq(from, to)
    }

    reprompt(myseq, filename = "tmp.Rd")

    ## we wish to describe  myseq() along with seq();
    ##    it is sufficient to put myseq() in the usage section
    ##    and let reprompt() do the rest
    rdo2 <- Rdo_modify_simple(rdoseq, "myseq()", "usage")
    reprompt(rdo2, file = "seqB.Rd")  # updates usage of myseq

    ## show the rendered result:
    Rdo_show(tools::parse_Rd("seqB.Rd"))

    ## Run this if you wish to see the Rd file:
    ##   file.show("seqB.Rd")

    reprompt(infile = "seq.Rd", filename = "seq2.Rd")
    reprompt(infile = "seq2.Rd", filename = "seq3.Rd")

    ## Rd objects for installed help may need some tidying for human editing.
    #hseq_inst <- help("seq")
    #rdo <- utils:::.getHelpFile(hseq_inst)
    rdo <- Rdo_fetch("seq", "base")
    rdo
    rdo <- Rdpack:::.Rd_tidy(rdo)          # tidy up (e.g. insert new lines
                                           #          for human readers)
    reprompt(rdo) # rdo and rdoseq are equivalent
    all.equal(reprompt(rdo), reprompt(rdoseq)) # TRUE

})




