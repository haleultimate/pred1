#define_vars.R

V1 <- NULL
V1$number <- 1
V1$name <- "C"
V1$tier <- 1
V1$ID <- 0.1
V1$type <- "Price"
V1$math[1] <- "from.data.env,'.Adjusted'"

v.com$C <- V1
rm(V1)

V2 <- NULL
V2$number <- 2
V2$name <- "YC"
V2$tier <- 2
V2$dependencies <- "C"
V2$ID <- 0.11
V2$type <- "Price"
V2$math[1] <- "from.var.env,'C'"
V2$math[2] <- "calc_lag,1"

v.com$YC <- V2
rm(V2)

V3 <- NULL
V3$number <- 3
V3$name <- "CCret_raw"
V3$tier <- 3
V3$dependencies <- c("C","YC")
V3$ID <- 0.1101
V3$type <- "Ret"
V3$math[1] <- "calc_ret,'YC','C'"

v.com$CCret_raw <- V3
rm(V3)

V4 <- NULL
V4$number <- 4
V4$name <- "CCret"
V4$tier <- 4
V4$dependencies <- c("C","YC","CCret_raw")
V4$ID <- 0.110101
V4$type <- "Ret"
V4$model_var <- TRUE
V4$math[1] <- "from.var.env,'CCret_raw'"
V4$math[2] <- "calc_cap,abscap=0.05"

v.com$CCret <- V4
rm(V4)

V5 <- NULL
V5$number <- 5
V5$name <- "YCCret"
V5$tier <- 5
V5$dependencies <- c("C","YC","CCret_raw","CCret")
V5$ID <- 0.1101011
V5$type <- "Ret"
V5$model_var <- TRUE
V5$math[1] <- "from.var.env,'CCret'"
V5$math[2] <- "calc_lag,1"

v.com$YCCret <- V5
rm(V5)

V6 <- NULL
V6$number <- 6
V6$name <- "CCret_raw2"
V6$tier <- 3
V6$dependencies <- c("C","YC")
V6$ID <- 0.1101
V6$type <- "Ret"
V6$model_var <- FALSE
V6$math[1] <- "calc_math,c('C','YC'),'XX0N <- log(XX1/XX2)'"

v.com$CCret_raw2 <- V6
rm(V6)