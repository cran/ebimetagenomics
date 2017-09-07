\name{read.project.csv}
\alias{read.project.csv}
\title{Read an EMG project summary into a data frame}

\description{
This reads an EMG project summary file into an R data frame for subsequent analysis.
}

\usage{
read.project.csv(fileName,projectID,...)
}

\arguments{
  \item{fileName}{Filename (or URL) corresponding to a EMG project summary CSV file.}
  \item{projectID}{String corresponding to the EMG project ID (sometimes known as study ID) associated with the file.}
  \item{...}{Extra parameters to be passed on to \code{read.csv}.}
}

\value{
An R data frame containing a list of all samples and runs associated
with the project, one row per run. The \code{projectID} is associated
with the data frame via the attribute \code{project.id}.
}

\seealso{\code{\link{getProjectSummary}}, \code{\link{projectSamples}}, \code{\link{projectRuns}},
  \code{\link{runsBySample}}}



\keyword{EMG}
