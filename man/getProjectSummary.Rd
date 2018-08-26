\name{getProjectSummary}
\alias{getProjectSummary}
\title{Download an EMG project summary into a data frame}

\description{
This downloads an EMG project summary file into an R data frame for subsequent analysis.
}

\usage{
getProjectSummary(projectID)
}

\arguments{
  \item{projectID}{A character string representing an EMG accession ID
  (eg. MGYS00002669 or SRP047083).}
}

\value{
An R data frame containing a list of all samples and runs associated
with the project, one row per run. The \code{projectID} is associated
with the data frame via the attribute \code{project.id}.
}

\seealso{\code{\link{getProjectsList}}, \code{\link{projectSamples}}, \code{\link{projectRuns}},
  \code{\link{runsBySample}}, \code{\link{read.project.csv}}}

\examples{
\donttest{
ps = getProjectSummary("MGYS00000646")
# Tabulate number of runs by sample
table(ps$sample_id)
}}

\keyword{EMG}
