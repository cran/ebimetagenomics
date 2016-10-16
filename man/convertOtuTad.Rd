\name{convertOtuTad}
\alias{convertOtuTad}
\title{Converts an OTU count data frame to a TAD data frame}

\description{
This function takes as input a data frame representing OTU counts, such as returned by \code{getRunOtu}, and tabulates it in the form of a taxa abundance distribution (TAD). 
}

\usage{
convertOtuTad(otu)
}

\arguments{
  \item{otu}{An OTU data frame.}
}

\value{
An R data frame representing a taxa abundance distribution (TAD). The first column is species abundance and the second column represents the number of species with that level of abundance in the sample.
}

\seealso{\code{\link{getSampleOtu}}, \code{\link{getRunOtu}}, \code{\link{mergeOtu}}}

\examples{
ps=getProjectSummary("SRP047083")
samp=projectSamples(ps)
runs=runsBySample(ps,samp[2])
otu=getRunOtu(ps,runs[1])
tad=convertOtuTad(otu)
head(tad)
}

\keyword{EMG}
