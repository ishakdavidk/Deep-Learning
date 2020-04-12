library(knitr) #html table
library(tensorflow)
library(kerasR)

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

X <- as.numeric(as.matrix(concrete_train[,1:8]))
X = matrix(as.numeric(X),ncol=8)
head(X)

Y <- as.matrix(concrete_train["strength"])
head(Y)

n_units = 5 

mod <- Sequential()
mod$add(Dense(units = n_units, input_shape = dim(X)[2]))
mod$add(LeakyReLU())

mod$add(Dense(units = n_units))
mod$add(LeakyReLU())

mod$add(Dense(units = n_units))
mod$add(LeakyReLU())

mod$add(Dense(1))

summary(model)

keras_compile(mod, loss = 'mean_squared_error', optimizer = adam())

keras_fit(mod, X, Y, batch_size = 32, epochs = 5, verbose = 2, validation_split = 0.1)