## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(foqat)
head(aqi)
head(voc)
head(met)

## -----------------------------------------------------------------------------
statdf(aqi)

## -----------------------------------------------------------------------------
new_met=trs(met, bkip = "1 hour", st = "2017-05-01 01:00:00", wind = TRUE, coliws = 4, coliwd = 5)
head(new_met)

## -----------------------------------------------------------------------------
new_voc=svri(voc, bkip="1 hour", mode="recipes", value="day", fun="median")
head(new_voc)

## -----------------------------------------------------------------------------
new_voc=svri(voc, bkip="1 hour", st="2020-05-01 00:00:00", mode="ncycle", value=24, fun="median")
head(new_voc)

## -----------------------------------------------------------------------------
#add a new column stands for hour.
voc$hour=lubridate::hour(voc$Time)
#calculate according to the index of reference column.
new_voc=svri(voc, bkip = "1 hour", mode="custom", value=7, fun="median")
head(new_voc[,-2])
#rmove voc 
rm(voc)

## -----------------------------------------------------------------------------
new_voc=avri(voc, bkip = "1 hour", st = "2020-05-01 01:00:00")
head(new_voc)

## -----------------------------------------------------------------------------
prop_voc=prop(voc)
head(prop_voc)

## ---- eval = FALSE------------------------------------------------------------
#  df=data.frame(aqi,day=day(lubridate::aqi$Time))
#  lr_result=anylm(df, xd=c(2,3), yd=6, zd=4, td=7,dign=3)
#  View(lr_result)

