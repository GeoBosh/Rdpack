\name{reprompt}
\alias{reprompt}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Update the documentation of a topic}
\description{Examine the documentation of functions, methods or classes and
  update it with additional arguments, methods or slots, as
  appropriate. This is an extention of the promptXXX() family of functions.
}
\usage{
reprompt(object, infile = NULL, Rdtext = NULL, final = TRUE,
         type = NULL, package = NULL, methods = NULL, verbose = TRUE,
         filename = NULL, sec_copy = TRUE, \dots)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{object}{the object whose documentation is to be updated, such as
    a string, a function, a help topic, a parsed Rd object, see
    `Details'.}
  \item{infile}{a file name containing Rd documentation, see `Details'.}
  \item{Rdtext}{a character string with Rd formatted text, see `Details'.}
  \item{final}{logical, see `Details'.}
  \item{type}{type of topic, e.g. "methods", see `Details'.}
  \item{package}{package name; document only objects defined in this package.}
  \item{methods}{used for documentation of S4 methods only, syntax is as
    the corresponding argument in \code{promptMethods}, see Details.}
  \item{verbose}{if \code{TRUE} print messages on the screen.}
  \item{filename}{name of the file for the generated Rd content.}
  \item{\dots}{currently not used}
  \item{sec_copy}{if \code{TRUE} copy Rd contents of unchanged sections
    in the result, see Details.}
}
\details{
  The typical use of \code{reprompt} is with one argument, as in
  \preformatted{
    reprompt(infile = "./Rdpack/man/reprompt.Rd")
    reprompt(reprompt)
    reprompt("reprompt")
  }
  \code{reprompt} updates the requested documentation and writes the new
  Rd file in the current working directory. When argument \code{infile}
  is used, the descriptions of all objects described in the input file
  are updated. When an object or its name is given, \code{reprompt}
  looks first for installed documentation and processes it in the same
  way as in the case of \code{infile}. If there is no documentation for
  the object, \code{reprompt} creates a skeleton Rd file similar to the
  one produced by the base R functions of the \code{prompt} family.

  For S4 methods and classes the argument "package" is often needed to
  restrict the output to methods defined in the package of interest.
  \preformatted{
    reprompt("myfun-methods")

    reprompt("[<--methods", package = "mypackage")             # or
    reprompt("[<-", type = "methods", package = "mypackage")

    reprompt("myclass", type = "class", package = "mypackage") # or
    reprompt("myclass-class", package = "mypackage")
  }
  For "myfun" above the "package" argument may not matter but for the
  replacement method it almost certainly will.

  Below are the details.

  Typically, only one of \code{object}, \code{infile}, and \code{Rdtext}
  is supplied. Warning messages are issued if this is not the case.

  The object must have been made available by the time when
  \code{reprompt()} is issued. If the object is in a package this is
  typically achieved by a \code{library()} command.

  \code{object} may be a function or a name, as accepted by the \code{?}
  operator. If it has the form "name-class" and "name-methods" a
  documentation shell for class "name" or the methods for generic function
  "name" will be examined/created. Alternatively, argument \code{type}
  may be set to "class" or "methods" to achieve the same effect.

  \code{infile} specifies a documentation file to be updated. If it
  contains the documentation for one or more functions, \code{reprompt}
  examines their usage statements and updates them if they have
  changed. It also adds arguments to the "arguments" section if not all
  arguments in the usage statements have entries there. If \code{infile}
  describes the methods of a function or a class, the checks made are as
  appropriate for them. For example, new methods and/or slots are added
  to the corresponding sections.

  \code{Rdtext} is similar to \code{infile} but the Rd content is taken
  from a character vector.

  If Rd content is supplied by \code{infile} or \code{Rdtext},
  \code{reprompt} uses it as a basis for comparison. Otherwise it tries
  to find installed documentation for the object or topic requested.
  If that fails, it resorts to one of the \code{promptXXX} functions to
  generate a documentation shell. If that also fails, the requested
  object or topic does not exist.

  If the above succeeds, the function examines the current definition of
  the requested object(s), methods, or class and amends the
  documentation with any additional items it finds.

  For Rd objects describing one or more functions, the usage expressions
  are checked and replaced, if changed. Arguments appearing in one or
  more usage expressions and missing from section "Arguments" are
  amended to it with content "Describe ..."  and a message is
  printed. Arguments no longer in the usage statements are NOT removed
  but a message is issued to alert the user. Alias sections are inserted
  for any functions with "usage" but without "alias" section.

  Currently \code{reprompt} functionality is not implemented for topic
  "package" but if \code{object} has the form "name-package" (or the
  equivalent with argument \code{topic}) and there is no documentation
  for \code{package?name}, \code{reprompt} calls
  \code{\link{promptPackageSexpr}} to create the required shell.
  Note that the shell produced by \code{promptPackageSexpr} does not
  need `reprompting' since the automatically generated information is
  included by \verb{\Sexpr}, not literal strings.

  If argument \code{sec_copy} is \code{TRUE}, \code{reprompt} will,
  effectively, copy the contents of (some) unchanged sections, thus
  ensuring that they are exactly the same as in the original.

  In general, if an Rd object is obtained by parsing an Rd file, then
  converting the object back to the Rd format may not reproduce the
  original file exactly (some escape sequences may change). Even though
  the new version should be functionally equivalent to the original,
  this may not be desirable. For example, if such changes creep into
  the Details section (which \code{reprompt} never changes) the user may
  be annoyed or worried. Notice that this is not really a cause of
  concern. Moreover, once you replace the old file with the one
  one produced by \code{reprompt}, it will not change again.
}
\value{
  if \code{filename} is a character string or \code{NULL}, the name of
  the file to which the updated shell was written.

  Otherwise, the text is returned as a character vector.
}

\author{Georgi N. Boshnakov}
\note{

  The arguments of \code{reprompt} are similar to prompt, with some
  additions. As in \code{prompt}, \code{filename} specifies the output
  file. In \code{reprompt} a new argument, \code{infile}, specifies the
  input file containing the Rd source.

  When \code{reprompt} is used to update sources of Rd documentation for
  a package, it is best to supply the original Rd file in argument
  \code{infile}. Otherwise, if the original Rd file contains
  \verb{\Sexpr} commands, \code{reprompt} may not be able to recover the
  original Rd content from the installed documentation. Also, the fields
  (e.g. the keywords) in the installed documentation may not be were you
  expect them to be. (This may be addressed in a future revision.)

  A common error when supplying a file name for \code{reprompt} is to
  forget to name the argument,
  e.g. \code{reprompt(infile="./Rdpack/man/reprompt.Rd")}. Otherwise the
  argument is taken to be the name of a function.
  Currently a convenience convention is that if \code{infile} is missing
  and \code{object} is a character string ending in ".Rd" and containing
  a forward slash (i.e. it looks like Rd file in a directory), then it
  is taken to be \code{infile}. However, this feature should not be
  relied upon as it may be withdrawn since it is dubious and only
  partially solves the problem with forgetting the name of the argument.

  While \code{reprompt} adds new items to the documentation, it never
  removes existing content. It only issues a suggestion to remove an
  item, if it does not seem necessary any more (e.g. a removed argument
  from a function definition).

  \code{reprompt} handles usage statements for S3 and S4  methods
  introduced with any of the macros \verb{\method}, \verb{\S3method} and
  \verb{\S4method}, as in \verb{\method{fun}{class}(args...)}.

  Usage statements for functions are split over two or more lines if
  necessary. The user may edit them afterwards if the automatic
  splitting is not appropriate, see below.

  The usage section of Rd objects describing functions is left intact if
  the usage has not changed. To force \code{reprompt} to recreate the
  usage section (e.g. to reformat long lines), invalidate the usage of
  one of the described functions by removing an argument from its usage
  expression.  Currently the usage section is recreated completely if
  the usage of any of the described functions has changed. Manual
  formatting may be lost in such cases.

  Todo: add an S3class argument (or equivalent) to allow specification
  of S3 methods for \code{reprompt}. Note that S3 methods present in
  usage statements are already processed. Also, giving the full name of
  an S3 method as \code{fun.class} works, as well
  (e.g. \code{reprompt(predict.lm)}).

}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\examples{
# note: usage of reprompt() is simple.
#       the examples below are bulky because they
#       simulate various usage scenarios.
#
# change to a temporary directory to avoid clogging up user's
cur_wd <- getwd()
setwd(tempdir())

# as for prompt() the default to save in current dir as "seq.Rd".
# the argument here is a function, reprompt finds its doc. and
# updates all objects described along with `seq'.
# (In this case there is nothing to update, we have not changed `seq'.)

fnseq <- reprompt(seq)

# let's parse the saved Rd file
rdoseq <- tools::parse_Rd(fnseq)

# replace usage statements with wrong ones for illustration.
dummy_usage <- char2Rdpiece(paste("seq()", "\\\\method{seq}{default}()",
                   "seq.int()", "seq_along()", "seq_len()", sep="\n"),
                   "usage")
rdoseq_dummy <- Rdo_replace_section(rdoseq, dummy_usage)
Rdo_show(rdoseq_dummy)  # wrong usage

reprompt(rdoseq_dummy, file = "seqA.Rd")
Rdo_show(tools::parse_Rd("seqA.Rd"))  # usage ok now

myseq <- function(from, to, x){
        if(to < 0) seq(from=from, to=length(x)+to) else seq(from, to)}

# add a description of  sequence()
rdo2 <- Rdo_modify_simple(rdoseq, "myseq()", "usage")

reprompt(rdo2, file = "seqB.Rd")  # updates usage of myseq
Rdo_show(tools::parse_Rd("seqB.Rd"))     # and add an entry for 'x' in 'arguments'




# as for prompt() the default is to save in current dir as "seq.Rd".
fnseq <- reprompt(seq)
rdoseq <- tools::parse_Rd(fnseq)   # parse fnseq to see the result.
Rdo_show(rdoseq)

reprompt(infile = "seq.Rd", filename = "seq2.Rd")
reprompt(infile = "seq2.Rd", filename = "seq3.Rd")

# Rd objects for installed help may need some tidying for human editing.
hseq_inst <- help("seq")
rdo <- utils:::.getHelpFile(hseq_inst)
rdo
rdo <- Rdpack:::.Rd_tidy(rdo)          # tidy up (e.g. insert new lines
                                       #          for human readers)

reprompt(rdo) # same as rdoseq;



unlink("seq.Rd")         # remove temporary files
unlink("seq2.Rd")
unlink("seq3.Rd")
unlink("seqA.Rd")
unlink("seqB.Rd")

setwd(cur_wd)            # restore user's working directory
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{Rd}
