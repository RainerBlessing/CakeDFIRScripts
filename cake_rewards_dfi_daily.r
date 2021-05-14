library(dplyr)
library(lubridate, warn.conflicts = FALSE)
library(ggplot2)

source("common.r")

csv_file_name="cake.csv"
plot_file_name="rewards_dfi_daily.png"
start_day="2021-01-01"
x_label="Tag"
y_label="Zinsen (DFI)"

cake_csv=read.csv(file=csv_file_name)

date_dfi=select(filter(cake_csv, grepl("reward|bonus",Operation),grepl("DFI",Coin.Asset)),Date,Amount) 
daily_summary = date_dfi %>% group_by(day=floor_date(as.POSIXct(Date),"day")) %>% summarize(amount=sum(Amount))
daily_summary_starting_from_day = daily_summary %>% filter(day >=start_day)

plot(plot_file_name,head(daily_summary_starting_from_day ,-1),"day","amount",x_label,y_label)
#ggsave(plot_file_name,ggplot(head(daily_summary_starting_from_day ,-1) , aes(x=day, y=amount)) + geom_bar(stat = "identity") + ylab(y_label) + xlab(x_label))
