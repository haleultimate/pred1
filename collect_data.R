#collect_data.R
# Run through xts objects in var.env extracting data frame for each ticker and then bind them into one data frame for regression

allmodelvar <- NULL

for (i in 1:length(v.com)) {
  allmodelvar[i] <- v.com[[i]]$model_var
}
allmodelvar <- which(allmodelvar)

reg_data.df <- NULL
for (i in 1:stx) {
  ticker <- stx.symbols[i]
  subset_string <- paste("var.env$",ticker,"[reg_date_range,allmodelvar]",sep="")
  cmd_string <- paste("reg_data.df <- bind_rows(reg_data.df,as.data.frame(",subset_string,"))",sep="")
  if (verbose) print(cmd_string)
  eval(parse(text=cmd_string))
}

str(reg_data.df)