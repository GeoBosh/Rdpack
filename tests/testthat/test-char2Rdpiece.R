context("char2Rdpiece")

test_that("char2Rdpiece works fine", {
    ## these two should be identical:
    expect_equal_to_reference(char2Rdpiece("graphics", "keyword")
                            , "char2Rdpiece_a.RDS")
    expect_equal_to_reference(char2Rdpiece("graphics", "keyword", force.sec = TRUE)
                            , "char2Rdpiece_a.RDS")

    expect_equal_to_reference(char2Rdpiece("log(x, base = exp(1))", "usage"), "char2Rdpiece_b.RDS")
    expect_equal_to_reference(char2Rdpiece("Give more examples.", "Todo", force.sec = TRUE), "char2Rdpiece_c.RDS")

})

test_that("c_Rd works fine", {
    a1 <- char2Rdpiece("Dummyname", "name")
    a2 <- char2Rdpiece("Dummyallias1", "alias")
    a3 <- char2Rdpiece("Dummy title", "title")
    a4 <- char2Rdpiece("Dummy description", "description")

    b1 <- c_Rd(gbRd::Rdo_empty(), list(a1), list(a2), list(a3), list(a4))
    b1a <- c_Rd(list(a1), gbRd::Rdo_empty(), list(a2), list(a3), list(a4))
    expect_identical(class(b1), "Rd")
    expect_identical(class(b1a), "Rd")

    b2 <- c_Rd(list(a1), list(a2), list(a3), list(a4))
    expect_identical(class(b2), "list")
})

test_that("get_sig_text works fine", {
    setClass("aRdpack")
    setClass("bRdpack")

    fn <- tempfile()
    on.exit(unlink(fn))

    ## TODO: the following passes devtools::test() but not 'R CMD check'
    ##       Why the difference?

    ## only default method defined
    #f1 <- function(x, y){NULL}
    #setGeneric("f1")
    #setGeneric("f1", function(x, y){NULL})
    #
    #reprompt("f1", filename = fn)
    #rdo <- tools::parse_Rd(fn)
    #txt1 <- get_sig_text(rdo)
    #expect_equal(class(txt1), "character")
    #expect_equal_to_reference(txt1, "get_sig_text_f1.RDS")

    ## several methods defined
    #setGeneric("f4", function(x, y){NULL})
    #setMethod("f4", c("numeric", "numeric"), function(x, y){NULL})
    #setMethod("f4", c("aRdpack", "numeric"), function(x, y){NULL})
    #setMethod("f4", c("bRdpack", "numeric"), function(x, y){NULL})
    #setMethod("f4", c("aRdpack", "bRdpack"), function(x, y){NULL})
    #
    #reprompt("f4", filename = fn)
    #rdo <- tools::parse_Rd(fn)
    #txt4 <- get_sig_text(rdo)
    #expect_equal(class(txt4), "character")
    #expect_equal_to_reference(txt4, "get_sig_text_f4.RDS")

})

test_that("Rdo_fetch works fine", {
    somenames <- c("reprompt", "Rdpack-package")
    someRdnames <- paste0(somenames, ".Rd")

    ## The no-argument call is mostly for interactive use.
    ##    (a test here would be artificial)
    ## db <- Rdo_fetch()

    db1 <- Rdo_fetch(package = "Rdpack")
    expect_equal(class(db1), "list")
    expect_true(all(someRdnames %in% names(db1)))

    db2 <- Rdo_fetch(package = "Rdpack", installed = FALSE)
    expect_equal(class(db2), "list")
    expect_true(all(someRdnames %in% names(db2)))

    db3 <- Rdo_fetch("Rdo_macro", "Rdpack")
    expect_equal(class(db3), "Rd")

    db4 <- Rdo_fetch(somenames, "Rdpack", installed = FALSE)
    expect_equal(class(db4), "list")
    expect_true(setequal(names(db4), someRdnames))

})

