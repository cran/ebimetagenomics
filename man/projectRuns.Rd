\name{projectRuns}
\alias{projectRuns}
\title{Find runs associated with an EMG project}

\description{
This function queries an already-downloaded project summary file for vector of EMG run IDs associated with the project.
}

\usage{
projectRuns(summ)
}

\arguments{
  \item{summ}{An EMG project summary file, as returned by \code{getProjectSummary}.}
}

\value{
An R vector containing a list of strings representing EMG run IDs.
}

\seealso{\code{\link{getProjectSummary}}, \code{\link{projectSamples}},
  \code{\link{runsBySample}}}

\examples{
\donttest{
ps=getProjectSummary("SRP047083")
projectRuns(ps)
}}

\keyword{EMG}
