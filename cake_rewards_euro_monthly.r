library(dplyr)
library(lubridate, warn.conflicts = FALSE)
library(ggplot2)

csv_file="cake.csv"
plot_file="rewards_euro_monthly.png"
start_month="2021-01-01"

cake=read.csv(file=csv_file)

date_fiat=select(filter(cake, grepl("reward|bonus",Operation)),Date,FIAT.value) 
month_summary = date_fiat %>% group_by(month=floor_date(as.POSIXct(Date),"month")) %>% summarize(amount=sum(FIAT.value))
month_summary_starting_from_month = month_summary %>% filter(month >=start_month)

ggsave(plot_file,ggplot(month_summary_starting_from_month , aes(x=month, y=amount)) + geom_bar(stat = "identity") + ylab("Zinsen (Euro)") + xlab("Monat"))
