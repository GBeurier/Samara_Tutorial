if (!require("ggplot2")) {
  install.packages("ggplot2")
}
library(ggplot2)

library(samara)

setwd("D:/Workspace/PAM/Samara_Tutorial/demo")

# load parameters
weather <- read.csv("weather.csv", sep=";")
param <- read.csv("param.csv", sep=";")

head(weather)
head(param[,1:10])

# instanciate simulation
samara::init_sim_idx_simple(1, param, weather)

# run simulation (idx 1, version 4)
res <- samara::run_sim_idx_version(1, 4)
head(res[,1:5])

# plot function
plot_graph <- function(column, num_values) {
  df <- data.frame(x = 1:num_values, y = res[[column]][1:num_values])
  
  ggplot(df, aes(x = x, y = y)) +
    geom_line() +
    labs(title = paste("Graph of", column))
}

# plot variables
plot_graph("CumIrrig", 170)
plot_graph("StockRac", 170)
plot_graph("FTSW", 170)
plot_graph("GrainYieldPop", 170)


# modify parameters
samara::update_sim_idx(1, 1, c("FtswIrrig"))
res <- samara::run_sim_idx_version(1, 4)
plot_graph("CumIrrig", 170)

