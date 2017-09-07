\name{read.otu.tsv}
\alias{read.otu.tsv}
\title{Reads OTU count data associated with a EMG run}

\description{
This function reads an OTU count data file associated with a particular run from the EMG portal. The OTU data is returned as a data frame.
}

\usage{
read.otu.tsv(fileName,...)
}

\arguments{
  \item{fileName}{A string representing a filename (or URL) corresponding to a valid EMG OTU TSV file.}
  \item{...}{Extra arguments to be passed to \code{read.delim}.}
}

\value{
An R data frame containing OTU count data. The first column is the OTU ID, the second is the count, and the third contains a taxonomic classification.
}

\seealso{\code{\link{getSampleOtu}}, \code{\link{mergeOtu}}, \code{\link{getRunOtu}}}


\keyword{EMG}
