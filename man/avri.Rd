% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/avri.R
\name{avri}
\alias{avri}
\title{Calculate average of variation}
\usage{
avri(
  df,
  bkip = NULL,
  mode = "recipes",
  value = "day",
  st = NULL,
  et = NULL,
  na.rm = TRUE,
  digits = 2,
  wind = FALSE,
  coliws = 2,
  coliwd = 3,
  sn = FALSE
)
}
\arguments{
\item{df}{dataframe of time series.}

\item{bkip}{the basic time reslution for average variation, such as '1 hour'. If mode "custom" is selected, do not need to enter bkip.}

\item{mode}{for calculating cycles: "recipes", "ncycle", "custom".
"recipes" means using internal setting for calculation.
"ncycle" means setting number of items for per cycle.
"custom" means using 1 column in dataframe as a list of grouping elements for calculation.}

\item{value}{for detail setting of mode. Possible values for "recipes" are "day", "week", "month", year".
"day" equals to 24 (hours) values in 1 day.
"week" equals to 7 (days) values in 1 week.
"month" equals to 31 (days) values in 1 month.
"year" equals to 12 (months) values in 1 year.
values for "ncycle" is a number representing number of items in per cycle.
values for "custom" is a number representing column index in dataframe.}

\item{st}{start time of resampling. The default value is the fisrt value of datetime column.}

\item{et}{end time of resampling. The default value is the last value of datetime column.}

\item{na.rm}{logical value. Remove NA value or not?}

\item{digits}{numeric value, digits for result dataframe.}

\item{wind}{logical value. if TRUE, please set coliwd, coliws.}

\item{coliws}{numeric value, column index of wind speed in dataframe.}

\item{coliwd}{numeric value, column index of wind direction (degree) in dataframe.}

\item{sn}{logical value. if TRUE, the results will be presented by scientific notation (string).}
}
\value{
a data frame which contains both the average variations and the standard deviations.
Note that when the pattern USES
"ncycle" or "custom", the start time determines the start time of the first
element in the average variation. For example, if the first timestamp of data is
"2010-05-01 12:00:00", the resolution is 1 hour, the mode is "ncycle", and the
value is 24, then the result represents diurnal variation starting from 12 o'clock.
}
\description{
Calculates average of variation of time series. (contain but not limited to:
average daily variation, average monthly variation, average annual variation)
}
\details{
If you have wind data (wind speed, and wind direction in dgree), please set 'wind' as 'TRUE', and set values for 'coliwd' and 'coliws'.
}
\examples{
avri(met, bkip = "1 hour", mode = "recipes", value = "day",
st = "2017-05-01 00:00:00", wind = TRUE, coliws = 4, coliwd = 5)
}
