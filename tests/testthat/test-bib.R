context("bib")

test_that("bib works fine", {
    fn_Rdpack <- system.file("REFERENCES.bib", package = "Rdpack")
    bibs_Rdpack <- if(packageVersion("rbibutils") >= '2.1.1')
                       readBib(fn_Rdpack) else readBib(fn_Rdpack, encoding = "UTF-8")

    fn_rb <- system.file("REFERENCES.bib", package = "rbibutils")
    bibs_rb <- if(packageVersion("rbibutils") >= '2.1.1')
                   readBib(fn_rb) else readBib(fn_rb, encoding = "UTF-8")
    
    .toRd_styled(bibs_rb, "Rdpack")
    .toRd_styled(bibs_rb[["Rpackage:Rdpack"]], "Rdpack")    
    .toRd_styled(bibs_rb[["Rpackage:Rdpack"]], "rbibutils", style = "JSSRd")

    set_Rdpack_bibstyle("JSSRd")
    set_Rdpack_bibstyle("JSSLongNames")

    ## parenthesised
    expect_equal(insert_citeOnly("Rpackage:Rdpack", package = "rbibutils"),
                 "(Boshnakov 2020)")
    expect_equal(insert_citeOnly("Rpackage:Rdpack;nobrackets", package = "rbibutils"),
                 "Boshnakov 2020")
    ## using @
    expect_equal(insert_citeOnly("@see also @Rpackage:Rdpack", package = "rbibutils"),
                 "(see also Boshnakov 2020)")
    expect_equal(insert_citeOnly("@see also @Rpackage:Rdpack;nobrackets", package = "rbibutils"),
                 "see also Boshnakov 2020")
    
    expect_equal(insert_citeOnly("@see also @Rpackage:Rdpack among others;nobrackets", package = "rbibutils"),
                 "see also Boshnakov 2020 among others")

    ## textual
    expect_equal(insert_citeOnly("Rpackage:Rdpack;textual", package = "rbibutils"),
                 "Boshnakov (2020)")
    expect_equal(insert_citeOnly("@@Rpackage:Rdpack;textual", package = "rbibutils"),
                 "Boshnakov (2020)")

    ## more than one key
    expect_equal(insert_citeOnly(
        "@see also @Rpackage:rbibutils and @parseRd;textual", package = "Rdpack"),
        "see also Boshnakov and Putman (2020) and Murdoch (2010)")
    
    ## commenting out since not sure if the ')' is on purpose after  "among others" (:TODO:)
    ##
    ## expect_equal(insert_citeOnly("@see also @Rpackage:rbibutils and @parseRd, among others;textual", package = "Rdpack"),
    ##              "see also Boshnakov and Putman (2020) and Murdoch (2010, among others)")

    expect_equal(insert_citeOnly(
        "@see also @Rpackage:rbibutils and @parseRd", package = "Rdpack"),
        "(see also Boshnakov and Putman 2020 and Murdoch 2010)")
    expect_equal(insert_citeOnly(
        "@see also @Rpackage:rbibutils and @parseRd;textual", package = "Rdpack"),
        "see also Boshnakov and Putman (2020) and Murdoch (2010)")

    insert_citeOnly(
        "@see also @Rpackage:rbibutils and @parseRd;textual", package = "Rdpack",
                                                              bibpunct = c("[", "]"))
        
    ## TODO: bug here:
    ##
    ## expect_equal(insert_citeOnly(
    ##     "@see also @Rpackage:rbibutils and @parseRd;textual", package = "Rdpack",
    ##                                                           bibpunct = c("[", "]")),
    ##     "see also Boshnakov and Putman [2020] and Murdoch [2010]")
    ##
    ## produces:
    ##   "see also Boshnakov and Putman [2020) and Murdoch [2010)"
    ## (note the closing parentheses)
    ## Uncomment the print comments in insertCite() to see more details.


    expect_equal(insert_citeOnly(
        "@see also @Rpackage:rbibutils and @parseRd;nobrackets", package = "Rdpack"),
        "see also Boshnakov and Putman 2020 and Murdoch 2010")
    
    expect_equal(insert_citeOnly(
        "@see also @Rpackage:rbibutils and @parseRd;nobrackets", package = "Rdpack"),
        "see also Boshnakov and Putman 2020 and Murdoch 2010")

    ## use brackets instead of parentheses
    expect_equal(insert_citeOnly("Rpackage:Rdpack;textual", package = "rbibutils",
                                 bibpunct = c("[", "]")),
                 "Boshnakov [2020]")
    expect_equal(insert_citeOnly("Rpackage:Rdpack", package = "rbibutils",
                                 bibpunct = c("[", "]")),
                 "[Boshnakov 2020]")

    expect_equal(insert_citeOnly("Rpackage:Rdpack", package = "rbibutils",
                                 bibpunct = c("[", "]"), dont_cite = TRUE),
                 character(0))


    expect_error(insert_citeOnly("Rpackage:Rdpack;textual", bibpunct = c("[", "]")),
                 "argument 'package' must be provided")
    
    expect_error(insert_citeOnly(c("Rpackage:Rdpack;textual", "xxxxx"), 
                 "`keys' must be a character string"))
    
    insert_ref("Rpackage:Rdpack", package = "rbibutils")

    ## missing keys
    expect_warning(insert_ref("xxx", package = "rbibutils"))
    expect_warning(insert_citeOnly(
       "@see also @Rpackage:rbibutils and @parseRd;nobrackets @kikiriki", package = "Rdpack"))
        ## "possibly non-existing or duplicated key(s) in bib file from package ..."

    ## TODO: this tries to load package "xxx" and gives error but finishes ok and returns a 
    ##       dummy reference, as expected.
    ##  
    ##     Why and which instruction tries to load package "yyy"? Maybe in .Rd_styled?
    ##    It is sufficient that the package is installed, it doesn't need to be loadable.
    ## expect_warning(insert_ref("xxx", package = "yyy")) # missing package
    expect_warning(insert_ref("xxx", package = "yyy"))

    insert_all_ref(matrix(c("parseRd,Rpack:bibtex", "Rdpack"), ncol = 2))
    insert_all_ref(matrix(c("parseRd,Rpack:bibtex", "Rdpack"), ncol = 2), empty_cited = TRUE)

    
    class(bibs_rb) <- c("bibentryRd", class(bibs_rb))
    expect_output(print(bibs_rb))

    ## after the fix of issue #25:
    ##    (Diaz and López-Ibá{ñ}ez 2021) and Diaz and López-Ibá{ñ}ez (2021)
    ## (before the fix the braces were escaped and appeared in the rendered citation)
    expect_false(grepl("\\\\", insert_citeOnly("DiaLop2020ejor", "Rdpack")))
    expect_false(grepl("\\\\", insert_citeOnly("DiaLop2020ejor;textual", "Rdpack")))


    ## after fix of issue #26
    ##     before the fix it was necessary to manually remove the backslash from \&, \_, etc.
    ##     in the bib file. Now the backslashes are removed by Rdpack
    expect_known_value(insert_all_ref(matrix(c("dummyArticle", "Rdpack"), ncol = 2)),
                       "dummyArticle.rds", update = FALSE)
    
    ## makeVignetteReference("Rdpack", 1)

})

