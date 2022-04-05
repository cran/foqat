## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(foqat)
library(ggplot2)
#pre-process the aqi data
aqids=trs(aqi, bkip="10 min")
aqids$NO[aqids$NO>7]=NA
aqids$NO2=aqids$NO2*0.3
cols <- names(aqids)[2:6]
aqids[, 2:6]=round(aqids[, 2:6], 2)
#pre-process the met data
metds=trs(met, bkip="15 mins")

## ---- echo=FALSE, layout="l-body-outset", paged.print=FALSE-------------------
library(rmarkdown)
paged_table(aqids, options = list(max.print=10000, rows.print = 10, cols.print = 6))

## ----fig.width = 7, fig.height = 3, message=FALSE, warning=FALSE, exercise=TRUE, tidy=FALSE----
geom_ts(
  df=aqids,   
  yl=c(3,2), yr=6,   
  alist=c(3,2), llist=6,   
  yllab=bquote(NO[x]~" "~(ppbv)), yrlab=bquote(O[3]~" "~(ppbv)), xlab="Datetime",  
  alab=list(bquote(NO[2]~" "), bquote(NO~" ")), llab=list(bquote(O[3]~" ")),  
  lcc="#ff4d4f", aff=c("#096dd9","#69c0ff"),
  ana=FALSE
)

## ----fig.width = 7, fig.height = 3, message=FALSE, warning=FALSE, exercise=TRUE, tidy=FALSE----
geom_ts(
  df=aqids,   
  yl=c(3,2), yr=6,   
  alist=c(3,2), llist=6,   
  yllab=bquote(NO[x]~" "~(ppbv)), yrlab=bquote(O[3]~" "~(ppbv)), xlab="Datetime",  
  alab=list(bquote(NO[2]~" "), bquote(NO~" ")), llab=list(bquote(O[3]~" ")),  
  lcc="#ff4d4f", aff=c("#096dd9","#69c0ff"),
  ana=FALSE,
  yl_limit=c(0,5), 
  yr_limit=c(0,120), 
  yl_breaks= seq(0,5,1), 
  yr_breaks=  seq(0,120,30)
)

## ----fig.width = 7, fig.height = 5, message=FALSE, warning=FALSE, exercise=TRUE, tidy=FALSE----
p1=geom_ts(
  df=aqids,   
  yl=c(3,2), 
  alist=c(3,2),   
  yllab=bquote(NO[x]~" "~(ppbv)), xlab="Datetime",  
  alab=list(bquote(NO[2]~" "), bquote(NO~" ")),  
  aff=c("#096dd9","#69c0ff"),
  ana=FALSE,
  apos="identity"
)
p2=geom_ts(
  df=aqids,   
  yl=c(2,3), 
  alist=c(2,3),   
  yllab=bquote(NO[x]~" "~(ppbv)), xlab="Datetime",  
  alab=list(bquote(NO~" "), bquote(NO[2]~" ")),  
  aff=c("#69c0ff", "#096dd9"),
  ana=FALSE,
  apos="identity"
)
library(patchwork)
p1/p2

## ----fig.width = 7, fig.height = 5, message=FALSE, warning=FALSE, exercise=TRUE, tidy=FALSE----
p1=geom_ts(
  df=aqids,   
  yl=c(3,2), yr=6,   
  alist=c(3,2), llist=6,   
  yllab=bquote(NO[x]~" "~(ppbv)), yrlab=bquote(O[3]~" "~(ppbv)), xlab="Datetime",  
  alab=list(bquote(NO[2]~" "), bquote(NO~" ")), llab=list(bquote(O[3]~" ")),  
  lcc="#ff4d4f", aff=c("#096dd9","#69c0ff"),
  ana=FALSE
)
p2=p1
p2$layers[c(1,2)]=p2$layers[c(2,1)]
library(patchwork)
p1/p2

## ----fig.width = 7, fig.height = 5,  message=FALSE, warning=FALSE, exercise=TRUE, tidy=FALSE----
p1=geom_ts(
  df=aqids,   
  yl=c(3,2), 
  llist=c(3,2),   
  yllab=bquote(NO[x]~" "~(ppbv)), xlab="Datetime",  
  llab=list(bquote(NO[2]~" "), bquote(NO~" ")),  
  lcc=c("#096dd9","#69c0ff")
)
p2=geom_ts(
  df=aqids,   
  yl=6, 
  llist=6,   
  yllab=bquote(O[3]~" "~(ppbv)), xlab="Datetime",  
  llab=list(bquote(O[3]~" ")),  
  lcc="#ff4d4f"
)
library(patchwork)
p1/p2

## ----fig.width = 7, fig.height = 5, message=FALSE, warning=FALSE, exercise=TRUE, tidy=FALSE----
p1=geom_ts(
  df=aqids,   
  yl=c(3,2), 
  llist=c(3,2),   
  yllab=bquote(NO[x]~" "~(ppbv)), xlab="Datetime",  
  llab=list(bquote(NO[2]~" "), bquote(NO~" ")),  
  lcc=c("#096dd9","#69c0ff")
)+theme(axis.title.x=element_blank(),axis.text.x=element_blank(),axis.ticks.x=element_blank())
p2=geom_ts(
  df=aqids,   
  yl=6, 
  llist=6,   
  yllab=bquote(O[3]~" "~(ppbv)), xlab="Datetime",  
  llab=list(bquote(O[3]~" ")),  
  lcc="#ff4d4f"
)
library(patchwork)
p1/p2

## ----fig.width = 7, fig.height = 5, message=FALSE, warning=FALSE, exercise=TRUE, tidy=FALSE----
p1=geom_ts(
  df=aqids,   
  yl=c(3,2), 
  llist=c(3,2),   
  yllab=bquote(NO[x]~" "~(ppbv)), xlab="Datetime",  
  llab=list(bquote(NO[2]~" "), bquote(NO~" ")),  
  lcc=c("#096dd9","#69c0ff")
)+theme(axis.title.x=element_blank(),axis.text.x=element_blank(),axis.ticks.x=element_blank())
p2=geom_ts(
  df=aqids,   
  yl=6, 
  llist=6,   
  yllab=bquote(O[3]~" "~(ppbv)), xlab="Datetime",  
  llab=list(bquote(O[3]~" ")),  
  lcc="#ff4d4f"
)
library(patchwork)
p1/p2&theme(plot.margin = margin(b=1))

## ---- eval=FALSE, message=FALSE, warning=FALSE, exercise=TRUE, tidy=FALSE-----
#  geom_ts_batch(aqids)

## ---- eval=FALSE, fig.height=6, message=FALSE, warning=FALSE, exercise=TRUE, tidy=FALSE----
#  xlab=bquote(Time~"")
#  ylab=list(bquote(NO~" "~(ppbv)), bquote(NO[2]~" "~(ppbv)), bquote(CO~" "~(ppmv)), bquote(SO[2]~" "~(ppbv)), bquote(O[3]~" "~(ppbv)))
#  cclist=c("#eb2f96", "#1890ff", "#52c41a", "#faad14", "#f5222d")
#  geom_ts_batch(aqids, xlab=xlab, ylab=ylab, cclist=cclist, bquote=TRUE)

## ---- fig.width=7, fig.height=3, message=FALSE, warning=FALSE, exercise=TRUE, tidy=FALSE----
geom_tsw(metds, coliws=4, coliwd=5, mx = 0.7, my = 2.5)

## ---- message=FALSE, warning=FALSE, exercise=TRUE, tidy=FALSE-----------------
dn_table = read.delim(system.file("extdata", "smps.txt", package = "foqat"),
check.names = FALSE)
dn1_table=dn_table[,c(1,5:148)]
dn1_table[,1]=as.POSIXct(dn1_table[,1], format="%m/%d/%Y %H:%M:%S", tz="GMT")
head(dn1_table[,1:5])

## ---- fig.width=7, fig.height=3, message=FALSE, warning=FALSE, exercise=TRUE, tidy=FALSE----
geom_psd(dn1_table,fsz=10)

## ---- fig.width=3.5, fig.height = 2.5, message=FALSE, warning=FALSE, exercise=TRUE, tidy=FALSE----
avri_aqi=avri(aqi, bkip = "1 hour", mode = "recipes", value = "day", st = "2017-05-01 00:00:00")
geom_avri(avri_aqi,cave=6,csd=11)

## ---- fig.width=3.5, fig.height = 2.5, message=FALSE, warning=FALSE, exercise=TRUE, tidy=FALSE----
geom_avri(avri_aqi,cave=6,csd=11,alpha=0.5,lcc="#0050b3",
rff="#40a9ff", xlab="Hour of day",ylab=bquote(O[3]~" "~(ppbv)))

## ---- fig.width=7, fig.height = 7.5, message=FALSE, warning=FALSE, exercise=TRUE, tidy=FALSE----
geom_avri_batch(avri_aqi)

## ---- fig.width=7, fig.height = 7.5, message=FALSE, warning=FALSE, exercise=TRUE, tidy=FALSE----
lcc=c("#f5222d","#fa8c16","#52c41a","#1890ff","#722ed1")
rff=c("#ff7875","#ffc069","#95de64","#69c0ff","#b37feb")
xlab1=list(bquote(Time~""),bquote(Time~""),bquote(Time~""), bquote(Time~""),bquote(Time~""))
ylab1=list(bquote(NO~" "~(ppbv)), bquote(NO[2]~" "~(ppbv)), bquote(CO~" "~(ppmv)), bquote(SO[2]~" "~(ppbv)), bquote(O[3]~" "~(ppbv)))
geom_avri_batch(avri_aqi, alpha=0.6, xlab=xlab1, ylab=ylab1, lcc=lcc, rff=rff, bquote=TRUE)

