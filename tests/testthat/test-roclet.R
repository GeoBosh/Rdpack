context("roclet")

test_that("rdpack_roclet() writes citations into the Rd files", {
    skip_if_not_installed("roxygen2", "7.1.0")
    skip_if_not_installed("pkgload")

    pkg <- file.path(tempfile(), "rocletTest")
    dir.create(file.path(pkg, "R"), recursive = TRUE)
    dir.create(file.path(pkg, "inst"))
    on.exit(unlink(dirname(pkg), recursive = TRUE), add = TRUE)

    writeLines(c("Package: rocletTest",
                 "Title: Test",
                 "Version: 0.0.1",
                 "Description: Test.",
                 "License: GPL-2",
                 "Encoding: UTF-8",
                 "Roxygen: list(markdown = TRUE)"),
               file.path(pkg, "DESCRIPTION"))
    writeLines(c("@article{alpha,",
                 "  author = {Ann Alpha},",
                 "  title = {First},",
                 "  journal = {Journal},",
                 "  year = {2001}",
                 "}",
                 "@article{beta,",
                 "  author = {Bob Beta},",
                 "  title = {Second},",
                 "  journal = {Journal},",
                 "  year = {2002}",
                 "}"),
               file.path(pkg, "inst", "REFERENCES.bib"))
    writeLines(c("#' Eff",
                 "#'",
                 "#' Follows \\insertCite{alpha;textual}{rocletTest}.",
                 "#' @param x After \\insertCite{beta}{rocletTest}.",
                 "#' @references \\insertAllCited{}",
                 "#' @export",
                 "f <- function(x) x",
                 "",
                 "#' Gee",
                 "#'",
                 "#' No citation of its own.",
                 "#' @inheritParams f",
                 "#' @references \\insertAllCited{}",
                 "#' @export",
                 "g <- function(x) x"),
               file.path(pkg, "R", "f.R"))

    suppressMessages(roxygen2::roxygenise(pkg, roclets = "Rdpack::rdpack_roclet"))

    f_rd <- paste(readLines(file.path(pkg, "man", "f.Rd")), collapse = "\n")
    g_rd <- paste(readLines(file.path(pkg, "man", "g.Rd")), collapse = "\n")

    expect_false(grepl("\\insert", f_rd, fixed = TRUE))
    expect_false(grepl("\\Sexpr", f_rd, fixed = TRUE))
    expect_true(grepl("Follows Alpha (2001).", f_rd, fixed = TRUE))
    expect_true(grepl("After (Beta 2002).", f_rd, fixed = TRUE))
    expect_true(grepl("Alpha A (2001)", f_rd, fixed = TRUE))
    expect_true(grepl("Beta B (2002)", f_rd, fixed = TRUE))

    ## a citation inherited from f() is listed by g()'s \insertAllCited{}
    expect_true(grepl("After (Beta 2002).", g_rd, fixed = TRUE))
    expect_true(grepl("Beta B (2002)", g_rd, fixed = TRUE))
    expect_false(grepl("Alpha A (2001)", g_rd, fixed = TRUE))

    ## REFERENCES.bib is re-read on each run, and unchanged pages are left alone
    bib <- readLines(file.path(pkg, "inst", "REFERENCES.bib"))
    writeLines(sub("Second", "Revised", bib), file.path(pkg, "inst", "REFERENCES.bib"))
    suppressMessages(roxygen2::roxygenise(pkg, roclets = "Rdpack::rdpack_roclet"))
    g_rd <- paste(readLines(file.path(pkg, "man", "g.Rd")), collapse = "\n")
    expect_true(grepl("Revised", g_rd, fixed = TRUE))

    rerun <- capture.output(
        roxygen2::roxygenise(pkg, roclets = "Rdpack::rdpack_roclet"),
        type = "message")
    expect_false(any(grepl("Writing", rerun)))
})
