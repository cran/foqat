% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/tuv.R
\name{tuv}
\alias{tuv}
\title{Calculate TUV in batch}
\usage{
tuv(pathtuv, df, colid = 1)
}
\arguments{
\item{pathtuv}{path for parent folder of TUV executable for Windows, such as "c:/tuv5.3.1.exe".}

\item{df}{dataframe of the time series for the parameters to be entered, such as 'date', 'o3col'. It must includes date column.}

\item{colid}{column index of date. The default value is 1.}
}
\value{
a dataframe.The first column is datetime. The second column is the solar altitude Angle. The rates of photolysis for each reaction(Unit: s-1)
start from third column: 1 = O3 -> O2 + O1D
}
\description{
This function runs TUV in batch by reading the time series for the
parameters to be entered, and summarizes the results to the new dataframe. \cr
}
\details{
There are online and offline versions of the TUV model, but both need to run on
a daily basis (that means manually reset parameters for each day's simulation). \cr
This function runs TUV in batch by reading the time series for the
parameters to be entered, and summarizes the results to the new dataframe. \cr
Currently only mode 2 (mode that outputs the photolysis rates) is supported. \cr
Logical variables are not supported currently!!! \cr
Please download \href{https://www2.acom.ucar.edu/modeling/tropospheric-ultraviolet-and-visible-tuv-radiation-model}{TUV executable for Windows} before you use this function.

Columns of photolysis rate coefficients (s-1): \cr
1 = O3 -> O2 + O(1D) \cr
2 = H2O2 -> 2 OH \cr
3 = NO2 -> NO + O(3P) \cr
4 = NO3 -> NO + O2 \cr
5 = NO3 -> NO2 + O(3P) \cr
6 = CH2O -> H + HCO \cr
7 = CH2O -> H2 + CO \cr
}
