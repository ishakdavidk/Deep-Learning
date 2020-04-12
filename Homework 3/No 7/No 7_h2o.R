library(h2o)
localH2O = h2o.init(ip="localhost", port = 54321, 
                    startH2O = TRUE, nthreads=-1)

concrete_train <- h2o.importFile("/cloud/project/No 7/Concrete_Data.csv")
concrete_test <- h2o.importFile("/cloud/project/No 7/Concrete_Data.csv")

y = names(concrete_train)[9]
x = names(concrete_train)[1:8]

concrete_train[,y] = as.factor(concrete_train[,y])
concrete_test[,y] = as.factor(concrete_test[,y])

model = h2o.deeplearning(x=x, 
                         y=y, 
                         training_frame=concrete_train,
                         activation="Rectifier",
                         hidden = c(5,5),
                         l1 = 1e-5,
                         epochs = 50)

print(model)
