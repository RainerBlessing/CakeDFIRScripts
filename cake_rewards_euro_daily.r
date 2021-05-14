library(dplyr)
library(lubridate, warn.conflicts = FALSE)
library(ggplot2)

source("common.r")

csv_file_name="cake.csv"
plot_file_name="rewards_euro_daily.png"
start_day="2021-01-01"
x_label="Tag"
y_label="Zinsen (Euro)"

cake_csv=read.csv(file=csv_file_name)

date_fiat=select(filter(cake_csv, grepl("reward|bonus",Operation),grepl("DFI",Coin.Asset)),Date,FIAT.value) 
daily_summary = date_fiat %>% group_by(day=floor_date(as.POSIXct(Date),"day")) %>% summarize(amount=sum(FIAT.value))
daily_summary_starting_from_day = daily_summary %>% filter(day >=start_day)

plot(plot_file_name,head(daily_summary_starting_from_day ,-1),"day","amount",x_label,y_label)
