% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/geom_tsw.r
\name{geom_tsw}
\alias{geom_tsw}
\title{Plot time series}
\usage{
geom_tsw(
  df,
  coliws = 2,
  coliwd = 3,
  lsize = 0.8,
  psize = NA,
  msize = 8,
  mlabel = "West wind",
  mx = 0.05,
  my = -0.1,
  mwd = 270
)
}
\arguments{
\item{df}{dataframe contains time series.}

\item{coliws}{column index of wind speed. The default vaule is 2.}

\item{coliwd}{column index of wind direction. The default vaule is 3.}

\item{lsize}{size of line (wind speed). The default vaule is 0.8.}

\item{psize}{size of point (wind speed). The default vaule is NA.}

\item{msize}{size of mark (wind direction). The default vaule is 8.}

\item{mlabel}{label of mark (wind direction). The default vaule is "West wind".}

\item{mx}{adjust value for the x position of mark (wind direction). The default vaule is 0.05.}

\item{my}{adjust value for the y position of mark (wind direction). The default vaule is -0.1.}

\item{mwd}{direction of mark (wind direction). The default vaule is 270.}
}
\description{
Easy way to plot time series.
}
\examples{
\dontrun{
metds=trs(met, bkip="15 mins")
geom_tsw(metds, coliws=4, coliwd=5)
}
}
