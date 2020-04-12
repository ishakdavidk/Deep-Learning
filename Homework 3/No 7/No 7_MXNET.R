cran <- getOption("repos")
cran["dmlc"] <- "https://apache-mxnet.s3-accelerate.dualstack.amazonaws.com/R/CRAN/"
options(repos = cran)
install.packages("mxnet")
library(mxnet)

concrete <- read.csv(file = "/cloud/project/No 7/Concrete_Data.csv")

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

train.x = x
train.y = y
test.x = x
test.y = y

mx.set.seed(0)
model <- mx.mlp(train.x, train.y, hidden_node=c(5,5), out_node=2, out_activation="softmax", num.round=20, array.batch.size=32, learning.rate=0.07, momentum=0.9, eval.metric=mx.metric.accuracy)

preds = predict(model, test.x)
## Auto detect layout of input matrix, use rowmajor..
pred.label = max.col(t(preds))-1
table(pred.label, test.y)