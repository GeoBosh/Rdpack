\name{RStudio_reprompt}
\alias{RStudio_reprompt}
\title{Call reprompt based on RStudio editor contents}
\description{This function uses the RStudio api to get the
current function name in the editor, and call reprompt on it.}
\usage{
RStudio_reprompt(verbose = TRUE)
}
\arguments{  
\item{verbose}{
If \code{TRUE} print progress to console.
}
}
\value{
The name of the file that was modified.
}
\author{
Duncan Murdoch
}
\seealso{
\code{\link{reprompt}}, \code{\link{prompt}}
}
