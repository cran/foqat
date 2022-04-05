## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(foqat)

## -----------------------------------------------------------------------------
#Examples.
#output molecular photolysis frequency (109 light reactions)
#Time range: March 1, 2021
#Resolution: hour
#Ground elevation 1 km
#Measured altitude 1.05 km
#Longitude 109.747144 °
#latitude 38.298267 °
#Ozone column concentration 306 DU

df=data.frame(
  time=seq(as.POSIXct("2021-03-01 00:00:00",tz="GMT"), as.POSIXct("2021-03-01 3:00:00",tz="GMT"), by="hour"), 
  gAltitude=rep(1, 4), 
  mAltitude=rep(1.05, 4),
  longitude=rep(109.747144, 4),
  latitude=rep(38.298267, 4),
  ozone=rep(306, 4)
)
tuv_df=tuv_batch(df, inputMode=0, outputMode=2, nStreams=-2)
#Show columns 1 to 3
head(tuv_df[,1:3])

