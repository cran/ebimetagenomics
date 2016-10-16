\name{runsBySample}
\alias{runsBySample}
\title{Find runs associated with a particular sample ID within an EMG project}

\description{
This function queries an already-downloaded project summary file for vector of EMG run IDs associated with a particular sample ID within the project.
}

\usage{
runsBySample(summ,sampleID)
}

\arguments{
  \item{summ}{An EMG project summary file, as returned by \code{getProjectSummary}.}
  \item{sampleID}{A string representing a valid EMG sample ID within the project \code{summ}.}
}

\value{
An R vector containing a list of strings representing EMG run IDs.
}

\seealso{\code{\link{getProjectSummary}}, \code{\link{projectSamples}},
  \code{\link{projectRuns}}}

\examples{
ps=getProjectSummary("SRP047083")
samp=projectSamples(ps)
runsBySample(ps,samp[2])
}

\keyword{EMG}
