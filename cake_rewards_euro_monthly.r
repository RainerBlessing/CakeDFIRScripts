library(dplyr)
library(lubridate, warn.conflicts = FALSE)
library(ggplot2)

source("common.r")

csv_file_name="cake.csv"
plot_file_name="rewards_euro_monthly.png"
start_month="2021-01-01"
x_label="Monat"
y_label="Zinsen (Euro)"

cake_csv=read.csv(file=csv_file_name)

date_fiat=select(filter(cake_csv, grepl("reward|bonus",Operation)),Date,FIAT.value) 
month_summary = date_fiat %>% group_by(month=floor_date(as.POSIXct(Date),"month")) %>% summarize(amount=sum(FIAT.value))
month_summary_starting_from_month = month_summary %>% filter(month >=start_month)

plot(plot_file_name,month_summary_starting_from_month,"month","amount",x_label,y_label)
