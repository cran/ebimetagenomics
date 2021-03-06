\name{getRunOtu}
\alias{getRunOtu}
\title{Downloads OTU count data associated with a EMG run}

\description{
This function downloads an OTU count data file associated with a particular run from the EMG portal. The OTU data is returned as a data frame.
}

\usage{
getRunOtu(runID,verb=FALSE,plot.preston=FALSE)
}

\arguments{
  \item{runID}{A string representing a valid run ID.}
  \item{verb}{If true, outputs \code{runID} to console.}
  \item{plot.preston}{If true, produces a Preston plot for the taxa abundance distribution of the run.}
}

\value{
An R data frame containing OTU count data. The first column is the OTU ID, the second is the count, and the third contains a taxonomic classification.
}

\seealso{\code{\link{getSampleOtu}}, \code{\link{mergeOtu}}, \code{\link{projectRuns}}, \code{\link{convertOtuTad}}, \code{\link{plotOtu}}, \code{\link{read.otu.tsv}}}

\examples{
\donttest{
ps=getProjectSummary("SRP047083")
samp=projectSamples(ps)
runs=runsBySample(ps,samp[2])
getRunOtu(runs[1])
}}

\keyword{EMG}
