\name{plotOtu}
\alias{plotOtu}
\title{Plots OTU count data}

\description{
This function takes as input a data frame representing OTU counts, such as returned by \code{getRunOtu}, plots it on the graphics device.
}

\usage{
plotOtu(otu)
}

\arguments{
  \item{otu}{An OTU data frame.}
}

\value{
The function returns silently, and is called purely for its side-effect of rendering plots on the graphics device.
}

\seealso{\code{\link{getSampleOtu}}, \code{\link{getRunOtu}}, \code{\link{convertOtuTad}}}

\examples{
ps=getProjectSummary("SRP047083")
samp=projectSamples(ps)
runs=runsBySample(ps,samp[2])
otu=getRunOtu(ps,runs[1])
tad=plotOtu(otu)
}

\keyword{EMG}
