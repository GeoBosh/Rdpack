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
\value{
\code{NULL}, invisibly.
}
\author{
Duncan Murdoch
}
\seealso{
\code{\link{reprompt}}, \code{\link{prompt}}
}
