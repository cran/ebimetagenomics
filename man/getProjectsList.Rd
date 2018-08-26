\name{getProjectsList}
\alias{getProjectsList}
\title{Download the EMG projects list into a data frame}

\description{
This downloads an EMG projects list (detailed info) into an R data frame for subsequent analysis.
}

\usage{
getProjectsList()
}

\value{
An R data frame containing a list of all public EMG projects, one row
per project. The row names correspond to the accession ID.
}

\seealso{\code{\link{getProjectSummary}}, \code{\link{projectSamples}}}

\examples{\donttest{
pl = getProjectsList()
str(pl)

# Find big projects
biggies = pl$accession[pl$samples_count >= 100]
ps = getProjectSummary(biggies[3])

# Find some 16S projects
pl$accession[agrep("16S",pl$study_name)]

# Look up primary accession using secondary accession
pl$accession[pl$secondary_accession=="SRP047083"]
}}

\keyword{EMG}
