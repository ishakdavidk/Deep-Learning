lin_dataset<-read.table("/cloud/project/No 1/lsd.dat", header=FALSE, skip=0)
print(lin_dataset)
lin_model<-lm(V2 ~ V1, data=lin_dataset)
plot(lin_dataset, xlab="Tissue Concentration",
     ylab="Math Score", main="Math Scores and Drug Concentrations")
abline(lin_model)
print(lin_model)
summary(lin_model)
