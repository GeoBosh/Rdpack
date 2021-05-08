context("bib")

test_that("bib works fine", {
    fn_rb <- system.file("REFERENCES.bib", package = "rbibutils")
    bibs_rb <- readBib(fn_rb)
    
    .toRd_styled(bibs_rb, "Rdpack")
    .toRd_styled(bibs_rb[["Rpackage:Rdpack"]], "Rdpack")    
    .toRd_styled(bibs_rb[["Rpackage:Rdpack"]], "rbibutils", style = "JSSRd")

    set_Rdpack_bibstyle("JSSRd")
    set_Rdpack_bibstyle("JSSLongNames")

    expect_equal(insert_citeOnly(names(bibs_rb)[2], package = "rbibutils"),
                 "(Boshnakov 2020)")
    expect_equal(insert_citeOnly(paste0(names(bibs_rb)[2], ";textual"), package = "rbibutils"),
                 "Boshnakov (2020)")

    insert_ref(names(bibs_rb)[2], package = "rbibutils")
    expect_warning(insert_ref("xxx", package = "rbibutils"))

    class(bibs_rb) <- c("bibentryRd", class(bibs_rb))
    expect_output(print(bibs_rb))

    # makeVignetteReference("Rdpack", 1)
    
    expect_true(TRUE)
})

