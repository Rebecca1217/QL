library(GCAMCPUB)
library(readxl)
library(magrittr) # for pipe function
library(data.table)

# data_prepare ------------------------------------------------------------

stock_universe <- read_excel("./para_data/HS300.xlsx") %>% setDT()
date_x <- as.Date("2018-02-28")
date_y_from <- as.Date("2018-03-01")
date_y_end <- as.Date("2018-03-28")

w_wss_data<-w.wss(stock_universe$Sec_Code,
                  'holder_sumpcttop5,pe_ttm,val_peindu,val_pbindu,val_lnmv,
                  val_lntotassets,val_ortoev_ttm,val_ortomv_ttm,risk_variance20,
                  risk_variance60,risk_beta20,risk_beta60,risk_treynorratio20,
                  risk_treynorratio60,risk_volatilityratio,risk_hisrelation,
                  west_netprofit_fy1_1m,west_netprofitmaxmin_fy1,fa_roewgt,
                  fa_roc_ttm,fa_roe_ttm,fa_pbttoor_ttm,fa_salescashtoor,
                  fa_salescashtoor_ttm,fa_debttoasset,fa_noncurassetsratio,
                  fa_curassetsratio,fa_orgr_ttm,fa_ncgr_ttm,fa_tpgr_ttm,
                  fa_oigr_ttm,fa_npgr_ttm',paste0("tradeDate=", date_x))
stopifnot(w_wss_data$ErrorCode == 0)
data1 <- w_wss_data$Data %>% setDT()
w_wss_data<-w.wss(stock_universe$Sec_Code,'pct_chg_per',
                  paste0('startDate=', date_y_from), paste0('endDate=', date_y_end))
stopifnot(w_wss_data$ErrorCode == 0)
data2 <- w_wss_data$Data %>% setDT()

data_complete <- data2[data1, on = "CODE"]

# dealing with NA and normalization
# describe data first


# regression and select variables -----------------------------------------







