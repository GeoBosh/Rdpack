if(require("testthat")) {
    library(testthat)
    library(Rdpack)
    test_check("Rdpack")
} else
    warning("package 'testthat' required for 'Rdpack\'s' tests")
