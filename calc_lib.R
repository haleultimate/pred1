#calc_lib

name.var <- function(ticker,new_name) { #always name last column
  ve.xls <- paste("var.env$",ticker,sep="")
  cmd_string <- paste("col <- ncol(",ve.xls,")",sep="")
  eval(parse(text=cmd_string))
  cmd_string <- paste("colnames(",ve.xls,")[",col,"] <- '",new_name,"'",sep="")
  eval(parse(text=cmd_string))
} 

from.data.env <- function(ticker,field) {
  #if (verbose) print(paste("from.data.env:","ticker=",ticker,"field=",field))
  de.xls <- paste("data.env$",ticker,"$",ticker,field,sep="")
  ve.xls <- paste("var.env$",ticker,sep="")
  if (exists(ve.xls)) {
    cmd_string <- paste(ve.xls," <- cbind(",ve.xls,",",de.xls,")",sep="")
  } else {
    cmd_string <- paste(ve.xls," <- ",de.xls,sep="")
  }
  eval(parse(text=cmd_string))
}

from.var.env <- function(ticker,field) {
  #if (verbose) print(paste("from.var.env:","ticker=",ticker,"field=",field))
  ve.xls <- paste("var.env$",ticker,sep="")
  ve.field <- paste(ve.xls,"$",field,sep="")
  cmd_string <- paste(ve.xls," <- cbind(",ve.xls,",",ve.field,")",sep="")
  #if (verbose) print(cmd_string)
  eval(parse(text=cmd_string))
}

calc_lag <- function(ticker,lag=1) {  #always lag last column
  #if (verbose) print(paste("calc_lag:","ticker=",ticker,"lag=",lag))
  ve.xls <- paste("var.env$",ticker,sep="")
  cmd_string <- paste("col <- ncol(",ve.xls,")",sep="")
  eval(parse(text=cmd_string))
  cmd_string <- paste(ve.xls,"[,",col,"] <- stats::lag(",ve.xls,"[,",col,"],",lag,")",sep="")
  #if (verbose) print(cmd_string)
  eval(parse(text=cmd_string))
}

calc_ret <- function(ticker,start_price,end_price) {
  #if (verbose) print(paste("calc_ret:","ticker=",ticker,"start_price=",start_price,"end_price=",end_price))
  ve.xls <- paste("var.env$",ticker,sep="")
  start_field <- paste(ve.xls,"$",start_price,sep="")
  end_field <- paste(ve.xls,"$",end_price,sep="")
  cmd_string <- paste(ve.xls," <- cbind(",ve.xls,",log(",end_field,"/",start_field,"))",sep="")
  #if (verbose) print(cmd_string)
  eval(parse(text=cmd_string))
}

calc_cap <- function(ticker,abscap=NULL) {  #always cap last column
  #if (verbose) print(paste("calc_cp:","ticker=",ticker,"abscap=",abscap))
  ve.xls <- paste("var.env$",ticker,sep="")
  cmd_string <- paste("col <- ncol(",ve.xls,")",sep="")
  eval(parse(text=cmd_string))
  data_string <- paste(ve.xls,"[,",col,"]",sep="")
  cmd_string <- paste(data_string,"[",data_string," < ",-abscap,"] <- ",-abscap,sep="")
  #if (verbose) print(cmd_string)
  eval(parse(text=cmd_string))
  cmd_string <- paste(data_string,"[",data_string," > ",abscap,"] <- ",abscap,sep="")
  #if (verbose) print(cmd_string)
  eval(parse(text=cmd_string))
}

#replace place holders XX0,XX1,..XXn with vars 
# XX0 represents last column, XX0N represents new column (can only be on right side)
# XX1..XXn existing vars
# math_str in the form 'XX0 <- f(XX0,XX1..XXn)' 
calc_math <- function(ticker,XX_list=NULL,math_str) { #always apply math to last column
  if (verbose) print(paste("ticker=",ticker,"XX_list=",XX_list,"math_str=",math_str))
  if (verbose) print(XX_list)
  ve.xls <- paste("var.env$",ticker,sep="")
  if (grepl("XX0N",math_str)) {
    place_holder_str <- "XX0N"
    data_string <- 'tmp.xls'
    new_var <- TRUE
  } else {
    place_holder_str <- "XX0"
    cmd_string <- paste("col <- ncol(",ve.xls,")",sep="")
    eval(parse(text=cmd_string))
    data_string <- paste(ve.xls,"[,",col,"]",sep="")
    new_var <- FALSE
  }
  print (math_str)
  print (data_string)
  math_str <- gsub(place_holder_str,data_string,math_str)
  print (math_str)
  if (verbose) print(math_str)
  if (!is.na(XX_list)) {
    for (n in 1:length(XX_list)) {
      data_string <- paste(ve.xls,"[,'",XX_list[n],"']",sep="")
      place_holder_str <- paste("XX",n,sep="")
      print(data_string)
      print(place_holder_str)
      print(math_str)
      math_str <- gsub(place_holder_str,data_string,math_str)
      if (verbose) print(math_str)
    }
  }
  eval(parse(text=math_str))
  if (new_var) {
    cmd_str <- paste(ve.xls," <- cbind(",ve.xls,",tmp.xls)",sep="")
    if (verbose) print(cmd_str)
    eval(parse(text=cmd_str))
  }
}


