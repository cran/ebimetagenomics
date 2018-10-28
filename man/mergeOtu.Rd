\name{mergeOtu}
\alias{mergeOtu}
\title{Merges two OTU count data data frames to produce a combined OTU count data data frame}

\description{
This function merges two or more OTU count data data frames, such as returned by \code{getRunOtu}. The merged OTU data is returned as a data frame. The ordering of the two data frames to be merged should not be significant. The operation of merging should also be associative.
}

\usage{
mergeOtu(...)
}

\arguments{
  \item{...}{A sequence of OTU data frames to be merged.}
}

\value{
An R data frame containing OTU count data. The first column is the OTU ID, the second is the count, and the third contains a taxonomic classification.
}

\seealso{\code{\link{getSampleOtu}}, \code{\link{getRunOtu}}, \code{\link{projectRuns}}}

\examples{
\donttest{
ps=getProjectSummary("SRP047083")
samp=projectSamples(ps)
runs=runsBySample(ps,samp[2])

# merge two:
otu1=getRunOtu(runs[1])
otu2=getRunOtu(runs[2])
mergeOtu(otu1,otu2)

# merge many:
otuList=lapply(as.list(runs[1:5]),function(rid){getRunOtu(rid)})
Reduce(mergeOtu,otuList)
}}

\keyword{EMG}
