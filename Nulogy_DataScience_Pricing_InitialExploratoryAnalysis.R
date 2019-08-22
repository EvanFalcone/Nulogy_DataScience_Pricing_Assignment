library(tidyverse)
library(readr)

direc <- "~/Nulogy/Nulogy_DataScience_Pricing_Assignment"
setwd(direc)
set.seed(123)

data_base <- read.csv("product_data_schema.csv")
data <- read_csv("7004_1.csv")

dim(data)
str(data)
head(data)
View(data)

# clearly there is a splitting issue when reading in the data with base read.csv
# try with readr read_csv instead
# the latter has more rows, same cols (did base R read drop some?)

test <- data %>% filter(prices.amountMin != prices.amountMax)
View(test)

null_sums <- sapply(as.data.frame(is.na(data)),sum)
test2 <- null_sums[null_sums == nrow(data)]
colnames_to_drop <- names(test2)

data <- data %>% select(-colnames_to_drop)

data <- distinct(data)

test <- data %>% 
  filter(prices.sourceURLs != sourceURLs) %>% 
  mutate(
    prices.sourceURLs = str_replace(prices.sourceURLs,"https","http")
  )

# write_csv(data, "product_data_schema.csv")