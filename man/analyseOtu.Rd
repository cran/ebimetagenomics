\name{analyseOtu}
\alias{analyseOtu}
\title{Analysis of OTU count data}

\description{
This function takes as input a data frame representing OTU counts, such
as returned by \code{getRunOtu}, and conducts a range of analyses
relating to taxa diversity and coverage estimation.
}

\usage{
analyseOtu(otu, plot = TRUE)
}

\arguments{
  \item{otu}{An OTU data frame.}
  \item{plot}{If TRUE, calls \code{\link{plotOtu}} to generate a plot.}
}

\value{
The function returns a numeric vector with named elements representing
the results of various analyses.

TODO: Explain output properly...
}

\seealso{\code{\link{getSampleOtu}}, \code{\link{getRunOtu}}, \code{\link{plotOtu}}}

\examples{
ps=getProjectSummary("SRP047083")
samp=projectSamples(ps)
runs=runsBySample(ps,samp[2])
otu=getRunOtu(ps,runs[1])
analyseOtu(otu,plot=FALSE)
}

\keyword{EMG}
