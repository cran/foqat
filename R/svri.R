#' Compute the variation of summary statistics
#'
#' Compute the variation of summary statistics for time series.
#'
#' If you have wind data (wind speed, and wind direction in dgree), please set 'wind' as 'TRUE', and set values for 'coliwd' and 'coliws'.
#'
#' @param df dataframe of time series.
#' @param bkip the basic time reslution for variation, such as '1 hour'. If mode "custom" is selected, do not need to enter bkip.
#' @param mode for calculating cycles: "recipes", "ncycle", "custom".
#' "recipes" means using internal setting for calculation.
#' "ncycle" means setting number of items for per cycle.
#' "custom" means using 1 column in dataframe as a list of grouping elements for calculation.
#' @param value for detail setting of mode. Possible values for "recipes" are "day", "week", "month", year".
#' "day" equals to 24 (hours) values in 1 day.
#' "week" equals to 7 (days) values in 1 week.
#' "month" equals to 31 (days) values in 1 month.
#' "year" equals to 12 (months) values in 1 year.
#' values for "ncycle" is a number representing number of items in per cycle.
#' values for "custom" is a number representing column index in dataframe.
#' @param st start time of resampling. The default value is the fisrt value of datetime column.
#' @param et end time of resampling. The default value is the last value of datetime column.
#' @param fun  a function to compute the summary statistics which can be applied to all data subsets: 'sum', 'mean', 'median', 'min', 'max', 'sd' and 'quantile'.
#' @param probs numeric vector of probabilities with values in \([0,1]\).
#' @param na.rm logical value. Remove NA value or not?
#' @param digits numeric value, digits for result dataframe.
#' @param wind logical value. if TRUE, please set coliwd, coliws.
#' @param coliws numeric value, column index of wind speed in dataframe.
#' @param coliwd numeric value, column index of wind direction (degree) in dataframe.
#' @param sn logical value. if TRUE, the results will be presented by scientific notation (string).
#' @return the variation of summary statistics
#' Note that when the pattern USES
#' "ncycle" or "custom", the start time determines the start time of the first
#' element in the average variation. For example, if the first timestamp of data is
#' "2010-05-01 12:00:00", the resolution is 1 hour, the mode is "ncycle", and the
#' value is 24, then the result represents diurnal variation starting from 12 o'clock.
#'
#' @export
#' @examples
#' svri(met, bkip = "1 hour", mode = "recipes", value = "day", fun = 'quantile', probs=0.5,
#' st = "2017-05-01 00:00:00")
#' @importFrom dplyr full_join
#' @importFrom stats aggregate
#' @importFrom lubridate duration

svri<-function(df, bkip=NULL, mode = "recipes", value = "day", st = NULL, et = NULL, fun = 'mean', probs=0.5, na.rm = TRUE, digits = 2, wind = FALSE, coliws = 2, coliwd = 3, sn=FALSE){

  #time resampling
  if(mode!="custom"){
	rs_df <- trs(df, bkip, st = st, et = et, na.rm = na.rm, wind = wind, coliws = coliws, coliwd = coliwd)
  }else{
	rs_df=df
  }
  
  #move value column to first column
  if(mode=="custom"&value!=1){
	rs_df[,1:value] = rs_df[,c(value,1:(value-1))]
    colnames(rs_df)[1:value] = colnames(rs_df)[c(value,1:(value-1))]
  }
  
  #get colnames of rs_df
  cona_df <- colnames(rs_df)

  #generate u, v
  if(wind == TRUE){
    rs_df$u<-sin(pi/180*rs_df[,coliwd])*rs_df[,coliws]
    rs_df$v<-cos(pi/180*rs_df[,coliwd])*rs_df[,coliws]
  }

  #mode
  #mode recipes custom ncycle
  #value day week month year
  if(mode=="recipes"){
    if(value=="day"){
      #24 hour in 1 day
      mod_list=hour(rs_df[,1])
    }else if(value=="week"){
      #7 days in 1 week
      mod_list=weekdays(rs_df[,1])
    }else if(value=="month"){
      #31 days in 1 month
      mod_list=day(rs_df[,1])
    }else if(value=="year"){
      #12 month in 1 year
      mod_list=month(rs_df[,1])
    }
  }else if(mode=="ncycle"){
    mod_list=seq(0,nrow(rs_df)-1,1)%%value
  }else if(mode=="custom"){
    mod_list=rs_df[,1]
  }

  #stat 
  if(fun!="quantile"){
	eval(parse(text = paste(c("results <- aggregate(rs_df[,-1], by=list(cycle=mod_list), FUN=", fun, ", na.rm = na.rm)"),collapse = "")))
  }else{
	eval(parse(text = paste(c("results <- aggregate(rs_df[,-1], by=list(cycle=mod_list), FUN = 'quantile', probs=", probs, ", na.rm = na.rm)"),collapse = "")))
  }
  
  #calculate ws, wd
  if(wind == TRUE){
    datat=results
    datat$fake_degree<-(atan(datat$u/datat$v)/pi*180)
    datat$temp_ws<-sqrt((datat$u)^2+(datat$v)^2)
    datat <- within(datat, {
      true_degree = ifelse(datat$v<0,datat$fake_degree+180,ifelse(datat$u<0,datat$fake_degree+360,datat$fake_degree))
    })
    datat <- datat[ ,-which(names(datat) %in% c("u", "v", "fake_degree"))]
    datat[ ,c(coliws,coliwd)] <- datat[ ,c((length(datat)-1),length(datat))]
    datat <- datat[,-c((length(datat)-1),length(datat))]
    results=datat
  }

  #format average data (avoid NA)
  if(!all(is.na(results[, -1]))){
	if(ncol(results)==2){
		if(sn==TRUE){
			results[,-1]=do.call(rbind, lapply(results[,-1], formatC, format = "e", digits = digits))
		}else{
			results[,-1]=do.call(rbind, lapply(results[,-1], as.numeric))
		}
	}else{
		if(sn==TRUE){
			results[,-1]=lapply(results[,-1], formatC, format = "e", digits = digits)
		}else{
			results[,-1]=lapply(results[,-1], as.numeric)
		}
	}
  }

  #name for cycle
  if(mode=="recipes"){
    if(value=="day"){
      #24 hour in 1 day
      colnames(results)[1]="hour of day"
    }else if(value=="week"){
      #7 days in 1 week
      colnames(results)[1]="day of week"
    }else if(value=="month"){
      #31 days in 1 month
      colnames(results)[1]="day of month"
    }else if(value=="year"){
      #12 month in 1 year
      colnames(results)[1]="month of year"
    }
  }else if(mode=="ncycle"){
    colnames(results)[1]="cycle"
  }else if(mode=="custom"){
    colnames(results)[1]="custom cycle"
  }

  #rename average df
  colnames(results)[2:ncol(results)] <- cona_df[2:length(cona_df)]

  #output
  return(results)
}
