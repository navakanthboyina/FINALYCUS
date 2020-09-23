train <-read.csv("train.csv",na.strings = c(""," ",NA))
test <-read.csv("test.csv",na.strings = c(""," ",NA))
library(mlr)
summarizeColumns(train)
summarizeColumns(test)
barplot(table(train$Loan_Status))
prop.table(table(train$Loan_Status))
par(mfrow=c(1,2))
barplot(table(train$Gender),main="train set")
barplot(table(test$Gender),main="test set")
prop.table(table(train$Gender))
prop.table(table(test$Gender))
par(mfrow=c(1,2))
barplot(table(train$Married),main="train set")
barplot(table(test$Married),main="test set")
prop.table(table(train$Married))
prop.table(table(test$Married))
par(mfrow=c(1,2))
levels(train$Dependents)
barplot(table(train$Dependents),main="train set")
barplot(table(test$Dependents),main="test set")
prop.table(table(train$Dependents))
prop.table(table(test$Dependents))
par(mfrow=c(1,2))
levels(train$Education)
barplot(table(train$Education),main="train set")
barplot(table(test$Education),main="test set")
prop.table(table(train$Education))
prop.table(table(test$Education))
par(mfrow=c(1,2))
levels(train$Self_Employed)
barplot(table(train$Self_Employed),main="train set")
barplot(table(test$Self_Employed),main="test set")
prop.table(table(train$Self_Employed))
prop.table(table(test$Self_Employed))
par(mfrow=c(1,2))
boxplot(train$ApplicantIncome,train$CoapplicantIncome,names=c("App Income","Coapp Income"),main="train set")
boxplot(test$ApplicantIncome,test$CoapplicantIncome,names=c("App Income","Coapp Income"),main="test set")
par(mfrow=c(1,2))
boxplot(train$LoanAmount,main="train set")
boxplot(test$LoanAmount,main="test set")
par(mfrow=c(1,2))
hist(train$Loan_Amount_Term,breaks=500,main="train set")
hist(test$Loan_Amount_Term,breaks=500,main="test set")
summary(train$Loan_Amount_Term)
summary(test$Loan_Amount_Term)
par(mfrow=c(1,2))
train$Credit_History <-as.factor(train$Credit_History)
test$Credit_History <- as.factor(test$Credit_History)
barplot(table(train$Credit_History),main="train set")
barplot(table(test$Credit_History),main="test set")
prop.table(table(train$Credit_History))
prop.table(table(test$Credit_History)) 
par(mfrow=c(1,2))
barplot(table(train$Property_Area),main="train set")
barplot(table(test$Property_Area),main="test set")
prop.table(table(train$Property_Area))

prop.table(table(test$Property_Area))
print(ggplot(train, aes(x=Loan_Status))+geom_bar()+facet_grid(.~Gender)+ggtitle("Loan Status by Gender of Applicant"))
print(ggplot(train, aes(x=Loan_Status))+geom_bar()+facet_grid(.~Married)+ggtitle("Loan Status by Marital Status of Applicant"))
print(ggplot(train, aes(x=Loan_Status))+geom_bar()+facet_grid(.~Dependents)+ggtitle("Loan Status by number of Dependents of Applicant"))
print(ggplot(train, aes(x=Loan_Status))+geom_bar()+facet_grid(.~Education)+ggtitle("Loan Status by Education of Applicant"))
print(ggplot(train, aes(x=Loan_Status))+geom_bar()+facet_grid(.~Self_Employed)+ggtitle("Loan Status by Employment status of Applicant"))
print(ggplot(train, aes(x=Loan_Status))+geom_bar()+facet_grid(.~Loan_Amount_Term)+ggtitle("Loan Status by terms  of loan"))
print(ggplot(train, aes(x=Loan_Status))+geom_bar()+facet_grid(.~Credit_History)+ggtitle("Loan Status by credit history of Applicant"))
library(ggplot2)
print(ggplot(data=alldata[alldata$ApplicantIncome<20000,],aes(ApplicantIncome,fill=Married))+geom_bar(position="dodge")+facet_grid(Gender~.))
print(ggplot(data=alldata[alldata$ApplicantIncome<20000,],aes(CoapplicantIncome,fill=Married))+geom_bar(position="dodge")+facet_grid(Gender~.))
alldata2$Married[is.na(alldata2$Married) & alldata2$CoapplicantIncome==0]<-"No"
alldata2$Married[is.na(alldata2$Married)]<- "Yes"
alldata2[is.na(alldata2$Gender) & is.na(alldata2$Dependents),]
alldata2$Gender[is.na(alldata2$Gender) & is.na(alldata2$Dependents)] <- "Male"
print(ggplot(alldata2,aes(x=Dependents, fill=Gender)) + geom_bar() + facet_grid(.~Married)) 
alldata2$Dependents[is.na(alldata2$Dependents) & alldata2$Married=="No"]<- "0"

mm <- alldata2[(alldata2$Gender=="Male" & alldata2$Married=="Yes"),c(3,6:9,11)]
mmtrain<-mm[!is.na(mm$Dependents),]
mmtest<- mm[is.na(mm$Dependents),]
library(rpart)
library(rattle)
depFit <- rpart(data=mmtrain,Dependents~.,xval=3)
fancyRpartPlot(depFit)

p<-predict(depFit,mmtrain,type="class")
acc=sum(p==mmtrain[,1])/length(p)
acc

alldata2$Dependents[is.na(alldata2$Dependents) & alldata2$Gender=="Male" & alldata2$Married == "Yes"]<- predict(depFit,newdata=mmtest,type="class")

gtrain<-alldata2[!is.na(alldata2$Gender),1:7]
gtest<-alldata2[is.na(alldata2$Gender),1:7]
genFit<-rpart(data=gtrain,Gender~.,xval=3)
fancyRpartPlot(genFit)

#accuracy
p<-predict(genFit,gtrain,type="class")
acc<-sum(p==gtrain[,1])/length(p)
acc

alldata2$Gender[is.na(alldata2$Gender)]<-predict(genFit,gtest,type="class")
alldata2$Self_Employed[is.na(alldata$Self_Employed)] <- "No"

