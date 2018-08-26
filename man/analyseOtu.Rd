\name{analyseOtu}
\alias{analyseOtu}
\title{Analysis of OTU count data}

\description{
This function takes as input a data frame representing OTU counts, such
as returned by \code{getRunOtu}, and conducts a range of analyses
relating to taxa diversity and coverage estimation.
}

\usage{
analyseOtu(otu, plot = TRUE)
}

\arguments{
  \item{otu}{An OTU data frame.}
  \item{plot}{If TRUE, calls \code{\link{plotOtu}} to generate a plot.}
}

\value{
The function returns a numeric vector with named elements representing
the results of various analyses. As well as computing various different estimates of the total number of taxa in the community that was sampled, it also computes estimates (assuming a Poisson-log-normal TAD) of the number of sequences required in order to observe a given fraction of the total species present. This can be useful for estimating required sequencing effort. Several of the fields should be familiar from the \code{vegan} function \code{estimateR}. The \code{breakaway} estimate has also been included. \code{S.vln} is Preston's veiled log-normal method and \code{S.pln} is an estimate from a Poisson-log-Normal SAD fit. Under the same assumption of an underlying Poisson-log-Normal species abundance distribution (and using the same fit), \code{N.75}, \code{N.90}, \code{N.95} and \code{N.99} are estimates of the \code{N.obs} required in order to obtain 75\%, 90\%, 95\% and 99\% species coverage in a future sample.
}

\seealso{\code{\link{getSampleOtu}}, \code{\link{getRunOtu}}, \code{\link{plotOtu}}}

\examples{
\donttest{
ps=getProjectSummary("SRP047083")
samp=projectSamples(ps)
runs=runsBySample(ps,samp[2])
otu=getRunOtu(ps,runs[1])
analyseOtu(otu,plot=FALSE)
}}

\keyword{EMG}
