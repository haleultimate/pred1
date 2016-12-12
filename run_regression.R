#run_regression.R

#remove all colinear dependent variable 
keep.dat <- vif_func(reg_data.df[,-1],thresh=10,trace=FALSE) #don't include predict.ret
keep.dat <- append(colnames(reg_data.df)[1],keep.dat)
if (verbose) print(keep.dat)
reg_data.df <- reg_data.df[,keep.dat]
if (verbose) str(reg_data.df)

#run_regression
form1 <- as.formula(paste(colnames(reg_data.df)[1],"~ ."))
reg.model = lm(form1,data=reg_data.df)
#print("model.select")
model.stepwise <- model.select(reg.model,sig=0.001,verbose=FALSE)
print(paste("stepwise model completed",Sys.time()))
print(summary(model.stepwise))
#print("r2cor")
#r2cor <- oos.r2(model.stepwise,oos)
