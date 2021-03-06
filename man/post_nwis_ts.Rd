% Generated by roxygen2 (4.0.2): do not edit by hand
\name{post_nwis_ts}
\alias{post_nwis_ts}
\title{post timeseries data for all sites for a given variable}
\usage{
post_nwis_ts(variable, p_code, session, startDate = "2008-01-01")
}
\arguments{
\item{variable}{shortname for the variable}

\item{p_code}{a string for a valid NWIS parameter code}

\item{session}{a valid authenticated sciencebase session}

\item{startDate}{a string in the form of YYYY-MM-DD}
}
\description{
post timeseries data for all sites for a given variable.
Will create new item or skip if it already exists
}
\examples{
\dontrun{
post_nwis_ts(variable = 'wtr', p_code='00010', session, startDate = '2008-01-01')
}
}
\seealso{
\code{\link{post_ts}}
}

