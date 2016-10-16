\name{projectSamples}
\alias{projectSamples}
\title{Find samples associated with an EMG project}

\description{
This function queries an already-downloaded project summary file for vector of EMG sample IDs associated with the project.
}

\usage{
projectSamples(summ)
}

\arguments{
  \item{summ}{An EMG project summary file, as returned by \code{getProjectSummary}.}
}

\value{
An R vector containing a list of strings representing EMG sample IDs.
}

\seealso{\code{\link{getProjectSummary}}, \code{\link{projectRuns}},
  \code{\link{runsBySample}}}

\examples{
ps=getProjectSummary("SRP047083")
projectSamples(ps)
}

\keyword{EMG}
