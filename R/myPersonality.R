install.packages('RDRPOSTagger')
install.packages('NLP')

install.packages('tokenizers')
library(RDRPOSTagger)
library("tokenizers")

#importing the dataset

fbdataset = read.csv('mypersonality_final.csv')

#Slicing the dataset to retaining personality score and network features  
dataset = fbdataset[,c(1,3,4,5,6,7,14,15,16,17,18,19,20)]

#dataset$cEXT = factor(dataset$cEXT, levels = c("n", "y"),labels = c(0, 1))
#dataset$cAGR = factor(dataset$cAGR, levels = c("n", "y"),labels = c(0, 1))
#dataset$cNEU = factor(dataset$cNEU, levels = c("n", "y"),labels = c(0, 1))
#dataset$cCON = factor(dataset$cCON, levels = c("n", "y"),labels = c(0, 1))
#dataset$sOPN = factor(dataset$cOPN, levels = c("n", "y"),labels = c(0, 1))

#doing this gave better accuracy.# shrinking upto only 250 records i.e. users/records
dataset = aggregate(.~ dataset$X.AUTHID, dataset, mean)
dataset = dataset[,-1:-2]

dataset = scale(dataset)

library(caTools)
set.seed(123)

split = sample.split(dataset[,1], SplitRatio = 0.8)
dataset[,1] = factor(dataset[,1], level = c(0,1))

trdataset = subset(dataset, split == TRUE)
tsdataset = subset(dataset, split == FALSE)

#first take the mean and then do the rest.
ext = dataset$sEXT
neu = dataset$sNEU
agr = dataset$sAGR
con = dataset$sCON
opn = dataset$sOPN

network = dataset$NETWORKSIZE
betweenness = dataset$BETWEENNESS
nbetweenness = dataset$NBETWEENNESS
nbrokerage = dataset$NBROKERAGE
brokerage = dataset$BROKERAGE
density = dataset$DENSITY
transitivity = dataset$TRANSITIVITY

#cor(ext,brokerage)
print("Correlation among Extraversion and Social Network Feature")
cor(ext,dataset[,6:12])
print("Correlation among Neuroticism and Social Network Feature")
cor(neu,dataset[,6:12])
print("Correlation among Agreeableness and Social Network Feature")
cor(agr,dataset[,6:12])
print("Correlation among Conscientiousness and Social Network Feature")
cor(con,dataset[,6:12])
print("Correlation among Openness and Social Network Feature")
cor(opn,dataset[,6:12])

plot(network,ext)
plot(neu,network)

library(e1071)
nbclassifier = naiveBayes(x = trdataset[,6:12], y = trdataset[,1])
nbpred = predict(nbclassifier, newdata = tsdataset[,6:12])
cm1 = table(tsdataset[,1], nbpred)
plot(nbclassifier)

rawdata = fbdataset[,14:20]
rawdata1 = fbdataset[,3:7]
personality = scale(rawdata1)
netfeatures = scale(rawdata)
cor(ext, netfeatures, method = "pearson")

install.packages('Hmisc')
library(Hmisc)
cor.test(ext,fbdataset[,18])
cor(personality, fbdataset[,14])
rcorr(personality, netfeatures)

cor(fbdataset[,14], netfeatures)

lmodel = lm(ext ~ fbdataset$NETWORKSIZE+ fbdataset$BETWEENNESS+ fbdataset$NBETWEENNESS + fbdataset$NBROKERAGE+ fbdataset$BROKERAGE + fbdataset$DENSITY)
cor(ext,fbdataset$BROKERAGE)

lmodel

plot(fbdataset)

#gives better information.
cor(cbind(ext,fbdataset$NETWORKSIZE,fbdataset$BETWEENNESS,fbdataset$NBETWEENNESS,fbdataset$NBROKERAGE,fbdataset$BROKERAGE,fbdataset$DENSITY))
cor(cbind(ext,network, betweenness, nbetweenness, nbrokerage, brokerage, density,transitivity))
cor(cbind(neu,network, betweenness, nbetweenness, nbrokerage, brokerage, density,transitivity))


cov(cbind(neu,network, betweenness, nbetweenness, nbrokerage, brokerage, density,transitivity))

plot(ext,fbdataset[,15])
plot(neu,fbdataset[,15])

fbdataset$cEXT = factor(fbdataset$cEXT, levels = c("n", "y"),labels = c(0, 1))

LogR = glm(fbdataset$cEXT ~ fbdataset$NETWORKSIZE+ fbdataset$BETWEENNESS+ fbdataset$NBETWEENNESS +
             fbdataset$NBROKERAGE+ fbdataset$BROKERAGE + fbdataset$DENSITY, data = fbdataset , family = binomial())
summary(LogR)

plot(fbdataset$BROKERAGE,fbdataset$cEXT)

cor(fbdataset$sEXT, fbdataset[,16:20])

fbstatus= fbdataset[,1:2]

setRepositories()




