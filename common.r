plot <- function(plot_file_name, data_frame, x_column, y_column, x_label, y_label){
	ggsave(plot_file_name,ggplot(data_frame, aes_string(x=x_column, y=y_column)) + geom_bar(stat = "identity") + ylab(y_label) + xlab(x_label))

}
