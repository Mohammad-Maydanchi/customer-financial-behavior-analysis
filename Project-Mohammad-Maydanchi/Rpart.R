# Libraries
install.packages("caTools")
library(caret)
library(FNN)
library (e1071)
library(MASS)
library(caTools)
#library(CRAN)

train <- read.csv("C://Project//santander-customer-transaction-prediction//train.csv")

#drop first column
train2<-train[,2:202]

####First Model
#split data in two parts(train and validation)
split_log<-sample.split(train2$target,SplitRatio=0.7)
train3<-subset(train2,split_log==T)
valid<-subset(train2,split_log==F)

#First Model:Multiple logestic Regression and use all variables
train3.model<-glm(target~.,family=binomial(link="logit"),data=train3)
summary(train3.model)




# Inference on parameters
# G
with(train3.model, null.deviance - deviance)
# dof
with(train3.model, df.null - df.residual)
# p-value
with(train3.model, pchisq(null.deviance-deviance, 
                    df.null-df.residual,
                     lower.tail=FALSE))

### I can get conclusion that my model is significant now I have to check it on validation
### and get measures of evaluation. For this goal I switch to python file, 


#model on validation
train3.response1<-predict(train3.model,valid,type="response")
train3.response1
#View(train3.response1)

#create contingency table by spliting the data at 0.5
C.Table<-table(valid$target,train3.response1>=0.5)
C.Table
TN<-C.Table[1,1]
FN<-C.Table[2,1]
TPN<-TN+FN
FP<-C.Table[1,2]
TP<-C.Table[2,2]
TAN<-TN+FP
TAP<-FN+TP
N<-TAN+TAP
Accuracy<-round((TN+TP)/N,4)
Accuracy
Overal_Error_Rate<-round((FN+FP)/N,4)
Overal_Error_Rate
Sensitivity<-round(TP/(TP+FN),4)
Sensitivity
specificity<-round(TN/(FP+TN),4)
specificity
False_Positive_Rate<-1-specificity
False_Positive_Rate
False_Negative_Rate<-1-Sensitivity
False_Negative_Rate
Proportion_of_True_Posetive<-round(TP/(FP+TP),4)
Proportion_of_True_Posetive
Proportion_of_True_Negative<-round(TN/(FN+TN),4)
Proportion_of_True_Negative
Proportion_of_False_Posetive<-round(FP/(FP+TP),4)
Proportion_of_False_Posetive
Proportion_of_False_Negative<-round(FN/(FN+TN),4)
Proportion_of_False_Negative


###Second Model using K-fold Cross Validation
set.seed(100000)
#classify target as a factor
train4<-train2
train4
train4$target<-as.factor(train4$target)
#train4$target

#split data to t
split_log<-sample.split(train2$target,SplitRatio=0.6)
train5<-subset(train4,split_log==T)
valid5<-subset(train4,split_log==F)

#model
train5.model<-train(target~.,train4, method="glm", trControl=
                       trainControl(method="cv",number=10,verboseIter=TRUE))
summary(train5.model)

#check the second model on validation data set (prediction)
train5.response2<-predict(train5.model,valid5,type="prob")
#create contingency table by spliting the data at 0.5
train5.response22<-train5.response2[,2]
C2.Table<-table(valid5$target,train5.response22>=0.5)
C2.Table
TN2<-C2.Table[1,1]
FN2<-C2.Table[2,1]
TPN2<-TN2+FN2
FP2<-C2.Table[1,2]
TP2<-C2.Table[2,2]
TAN2<-TN2+FP2
TAP2<-FN2+TP2
N2<-TAN2+TAP2
Accuracy2<-round((TN2+TP2)/N2,4)
Accuracy2
Overal_Error_Rate2<-round((FN2+FP2)/N2,4)
Overal_Error_Rate2
Sensitivity2<-round(TP2/(TP2+FN2),4)
Sensitivity2
specificity2<-round(TN2/(FP2+TN2),4)
specificity2
False_Positive_Rate2<-1-specificity2
False_Positive_Rate2
False_Negative_Rate2<-1-Sensitivity2
False_Negative_Rate2
Proportion_of_True_Posetive2<-round(TP2/(FP2+TP2),4)
Proportion_of_True_Posetive2
Proportion_of_True_Negative2<-round(TN2/(FN2+TN2),4)
Proportion_of_True_Negative2
Proportion_of_False_Posetive2<-round(FP2/(FP2+TP2),4)
Proportion_of_False_Posetive2
Proportion_of_False_Negative2<-round(FN2/(FN2+TN2),4)
Proportion_of_False_Negative2

