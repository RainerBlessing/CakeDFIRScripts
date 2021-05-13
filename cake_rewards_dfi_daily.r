library(dplyr)
library(lubridate, warn.conflicts = FALSE)
library(ggplot2)

csv_file="cake.csv"
plot_file="rewards_dfi_daily.png"
start_day="2021-01-01"

cake=read.csv(file=csv_file)
date_dfi=select(filter(cake, grepl("reward|bonus",Operation),grepl("DFI",Coin.Asset)),Date,Amount) 
daily_summary = date_dfi %>% group_by(day=floor_date(as.POSIXct(Date),"day")) %>% summarize(amount=sum(Amount))
daily_summary_starting_from_day = daily_summary %>% filter(day >=start_day)

ggsave(plot_file,ggplot(head(daily_summary_starting_from_day ,-1) , aes(x=day, y=amount)) + geom_bar(stat = "identity") + ylab("Zinsen (DFI)") + xlab("Tag"))
