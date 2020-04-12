library(knitr) #html table
library(ggvis) #Data visulization
library(psych) #Scatterplot matrix
library(deepnet)

concrete <- read.csv(file = "/cloud/project/No 7/Concrete_Data.csv")
knitr::kable(head(concrete), caption = "Partial Table Preview")

str(concrete)

concrete %>% ggvis(x = ~strength, fill:= "#27bc9c") %>% layer_histograms() %>% layer_paths(y = ~strength, 35.82, stroke := "red")

pairs.panels(concrete[c("cement", "slag", "ash", "strength")])

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

nn <- nn.train(X, Y, activationfun = "sigm", output="linear", hidden = c(5))

X_test <- as.numeric(as.matrix(concrete_test[,1:8]))
X_test = matrix(as.numeric(X_test),ncol=8)

Y_test <- as.matrix(concrete_test["strength"])

y_pred = nn.predict(nn, X_test)
head(y_pred)

nn.test(nn, X_test, Y_test)
