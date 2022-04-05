## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(foqat)
#Read built-in files
dn_table = read.delim(system.file("extdata", "smps.txt", package = "foqat"), check.names = FALSE)
dn1_table=dn_table[,c(1,5:148)]
#Set time format
dn1_table[,1]=as.POSIXct(dn1_table[,1], format="%m/%d/%Y %H:%M:%S", tz="GMT")
head(dn1_table[,1:5])

## ---- fig.width = 7, fig.height = 3-------------------------------------------
geom_psd(dn1_table,fsz=10)

## -----------------------------------------------------------------------------
dn2_table=nsvp(dn1_table,dlogdp=FALSE)
head(dn2_table[["df_channels"]])
head(dn2_table[["df_total"]])

## -----------------------------------------------------------------------------
dndlogdp_list=dn2_table[["df_channels"]][,c(1,2,4)]
head(dndlogdp_list)

## -----------------------------------------------------------------------------
dndlogdp_table=transp(dndlogdp_list)
head(dndlogdp_table[,1:5])

## -----------------------------------------------------------------------------
dndlogdp_table=transp(dndlogdp_list)
head(dndlogdp_table[,1:5])

## -----------------------------------------------------------------------------
x=avri(dndlogdp_table, st="2021-06-07 00:00:00", bkip="5 mins", mode="ncycle", value=288)
head(x[,1:5])

## -----------------------------------------------------------------------------
#Extract the time series of the required parameters from the results of the nsvp calculation, here the surface area is used as an example
dsdlogdp_list=dn2_table[["df_channels"]][,c(2,5)]
#Calculate the average distribution of surface area particle size spectra
ds_avri=avri(dsdlogdp_list,mode="custom",value=1)
head(ds_avri)

## ---- fig.width = 7-----------------------------------------------------------
par(mar=c(5,5,2,2))
plot(x=ds_avri[,1],y=ds_avri[,2], pch=16, xlab="Midrange (nm)", ylab=expression("dS (cm"^2*"/cm"^3*")"), col="#597ef7")

