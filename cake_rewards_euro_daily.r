library(dplyr)
library(lubridate, warn.conflicts = FALSE)
library(ggplot2)

csv_file="cake.csv"
plot_file="rewards_euro_daily.png"
start_day="2021-01-01"

cake=read.csv(file=csv_file)

date_fiat=select(filter(cake, grepl("reward|bonus",Operation),grepl("DFI",Coin.Asset)),Date,FIAT.value) 
daily_summary = date_fiat %>% group_by(day=floor_date(as.POSIXct(Date),"day")) %>% summarize(amount=sum(FIAT.value))
daily_summary_starting_from_day = daily_summary %>% filter(day >=start_day)

ggsave(plot_file,ggplot(head(daily_summary_starting_from_day ,-1) , aes(x=day, y=amount)) + geom_bar(stat = "identity") + ylab("Zinsen (Euro)") + xlab("Tag"))
