#rnd_lib.R
# data and functions for calculating random variables
rnd.env <- new.env()
rnd.env$vs.com <- NULL

rnd.env$priceID <- c('H','L','O','C','M')
rnd.env$prcorder <- c(1,2,2,2,3,11,12,12,12,13,111)
names(rnd.env$prcorder) <- c('C','M','L','H','O','YC','YM','YL','YH','YO','Y2C') #c('YO','YL','YH','YM','YC','O','L','H','M','C')

rnd.env$fun_id <- c(1:5)  #any undefined function will be mapped to zero
names(rnd.env$fun_id) <- c('calc_cap','calc_z','calc_res','calc_decay','calc_vlty')

get_id <- function(math_str) {
  math <- strsplit(math_str,split=",")[[1]] #get element to first comma (function call)
  id <- which(math==names(rnd.env$fun_id))
  if (length(id)==0) id <- 0
  parms <- gsub("^[^,]*,","",math_str) #get everything after first comma (parameters)
  parms <- gsub("[^0-9]","",parms)     #remove all non-numeric characters
  id <- paste(id,parms,sep="")
  return(id)
}

