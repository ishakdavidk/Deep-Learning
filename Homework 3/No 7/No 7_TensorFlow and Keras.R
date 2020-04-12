library(knitr) #html table
library(magrittr)
library(tensorflow)
library(keras)

concrete <- read.csv(file = "/cloud/project/No 7/Concrete_Data.csv")
knitr::kable(head(concrete), caption = "Partial Table Preview")

normalize <- function(x){
  return ((x - min(x))/(max(x) - min(x) ))
}

concrete_norm <- as.data.frame(lapply(concrete, normalize))

kable(round(head(concrete_norm), digits = 3), caption = "Normalized Data Preview")

#training set
concrete_train <- concrete_norm[1:773, ]

#test set
concrete_test <- concrete_norm[774:1030, ]

X <- as.matrix(concrete_train[,1:8])
head(X)

Y <- as.matrix(concrete_train["strength"])
head(Y)

model <- keras_model_sequential() 

n_units = 5
model %>% 
  layer_dense(units = n_units, 
              activation = 'relu', 
              input_shape = dim(X)[2]) %>% 
  layer_dense(units = n_units, activation = 'relu') %>%
  layer_dense(units = n_units, activation = 'relu') %>%
  layer_dense(units = 1)

summary(model)

model %>% compile(
  loss = 'mean_squared_error',
  optimizer = optimizer_adam()
)

model %>% fit(
  X, Y, 
  epochs = 50, batch_size = 32, verbose = 1, 
  validation_split = 0.1
)

