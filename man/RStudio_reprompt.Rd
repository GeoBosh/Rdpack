\name{RStudio_reprompt}
\alias{RStudio_reprompt}
\title{Call reprompt based on RStudio editor contents}
\description{This function uses the RStudio API to call \code{\link{reprompt}} on either the current help file in the editor, or if a name
is highlighted in a \file{.R} file, on that object.}
\usage{
RStudio_reprompt(verbose = TRUE)
}
\arguments{  
\item{verbose}{
If \code{TRUE} print progress to console.
}
}
\details{
This function depends on being run in RStudio; it will generate
an error if run in other contexts.

It depends on code being in a package that has already been
built, installed, and attached.  In RStudio, this means you
should run \dQuote{Install and Restart} before running this
function.

It is automatically installed into RStudio as an add-in called 
\dQuote{Reprompt}.  Whether invoked directly or through the 
add-in, it looks at the file currently being edited in the 
code editor.  If it is an \file{.Rd} file, it will run 
\code{\link{reprompt}} on that file.  

If it is an \R source file, it will look for a selected object
name.  It queries the help system to find if there is already
a help page for that name, and if so, works on that.  If not,
it will try to create one.
}
\value{
\code{NULL}, invisibly.
}
\author{
Duncan Murdoch
}
\seealso{
\code{\link{reprompt}}, \code{\link{ereprompt}}, \code{\link{prompt}}
}
