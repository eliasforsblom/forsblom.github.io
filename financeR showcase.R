library(financeR)
library(ggplot2)
library(lubridate)
library(tidyverse)
library(tidyr)
library(dplyr)



install_github("oliealex/Stock-analysis", subdir = "financeR")


api <- "7a9b4f83bf8183ccd6f27602ca7d06b7"

GME <- historic_price("GME", "full")
PLTR <- historic_price("PLTR", "full")

GME$date <- as.Date(GME$date)
PLTR$date <- as.Date(PLTR$date)

price <- matrix(nrow = 79, ncol = 3)
price <- as.data.frame(price)
price[,1] <- PLTR$date[1:79]
price[,2] <- GME$close[1:79]
price[,3] <- PLTR$close[1:79]

colnames(price) <- c("date", "GME", "PLTR")

df <- price %>%
  select(date, GME, PLTR) %>%
  gather(key = "variable", value = "value", -date)


p <- ggplot(df, aes(x = date, y = value)) +
  geom_line(aes(color = variable, linetype = variable)) +
  scale_color_manual(values = c("darkred", "steelblue")) +
  theme_bw()
p

companyprofile <- company_profile(c("AAPL", "MSFT", "PLTR"))
companyprofile

mostgainer <- most_gainer()
head(mostgainer)
