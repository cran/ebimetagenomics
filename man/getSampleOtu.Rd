\name{getSampleOtu}
\alias{getSampleOtu}
\title{Downloads and merges all of the OTU count data associated with a EMG sample}

\description{
This function downloads the OTU count data files from all runs associated with a particular sample from the EMG portal, and merges it using \code{mergeOtu}. The merged OTU data is returned as a data frame.
}

\usage{
getSampleOtu(summ,sampleID,verb=TRUE,plot.preston=FALSE)
}

\arguments{
  \item{summ}{An EMG project summary file, as returned by \code{getProjectSummary}.}
  \item{sampleID}{A string representing a valid EMG sample ID within the project \code{summ}.}
  \item{verb}{If true, outputs each \code{runID} to console.}
  \item{plot.preston}{If true, produces a Preston plot for the taxa abundance distribution of each run as it is downloaded.}
}

\value{
An R data frame containing OTU count data. The first column is the OTU ID, the second is the count, and the third contains a taxonomic classification.
}

\seealso{\code{\link{getRunOtu}}, \code{\link{mergeOtu}}, \code{\link{projectSamples}}, \code{\link{convertOtuTad}}, \code{\link{plotOtu}}}

\examples{
ps=getProjectSummary("SRP047083")
samp=projectSamples(ps)
runs=runsBySample(ps,samp[2])
getRunOtu(ps,runs[1])
}

\keyword{EMG}
