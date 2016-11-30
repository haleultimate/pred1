#make_vars.R
source("define_vars.R")  #setup v.com

data_str <- NULL
for (stk in 1:stx) {
  ticker <- stx.symbols[stk]
  if (verbose) print(paste("Getting data for:",ticker))
  for (v in 1:length(v.com)) {
    vd <- v.com[[v]]
    for (m in 1:length(vd$math)) {
      math <- strsplit(vd$math[m],split=",")[[1]]
      parms <- gsub("^[^,]*,","",vd$math[m])
      fun_call <- paste(math[1],"('",ticker,"',",parms,")",sep="")
      if (verbose) print(fun_call)
      eval(parse(text=fun_call))
    }
    name.var(ticker,vd$name)
  }
}
