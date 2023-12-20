#import data
BurgundySip <- read.csv("C:\\Users\\sajee\\Desktop\\Data handling & Decision making\\Final project\\BurgundySip.csv",na.string = c("","N.V.","NA"));
BurgundySip;

#structure
str(BurgundySip);

#transform variable type
BurgundySip [c(1:6)] = lapply(BurgundySip [c(1:6)],FUN=factor)

BurgundySip [c(10:14)] = lapply(BurgundySip [c(10:14)],as.numeric)

#Identify dependent and independent variables

#SN 
#Name - IND
#WINE - IND
#YR - IND
#REG - IND
#TP - IND
#RT - IND/DEP
#NUMR - IND
#PR - DEP
#BD - IND/DEP
#ACD - IND/DEP
#RSG - IND/DEP
#AL - IND/DEP
#DN - IND/DEP

#Duplicate removal approaches
#top down
BurgundySip_td <- BurgundySip[!duplicated(BurgundySip$SN),]; BurgundySip_td;
sum(is.na(BurgundySip_td))#1327 / 10 variables

summary(BurgundySip_td)

#bottom up
BurgundySip_bu <- BurgundySip[!duplicated(BurgundySip$SN,fromLast=TRUE), ]; BurgundySip_bu;
sum(is.na(BurgundySip_bu))#1319 / 11 variables 

summary(BurgundySip_bu)

#therefore top down approach is used

#Duplicate Treatment

#Duplicate % by SN
BurgundySip_sn <- BurgundySip[duplicated(BurgundySip$SN),]; #51%
length(BurgundySip_sn$SN)/length(BurgundySip$SN)

#Duplicate % by NAME, WINE, YR, REG,TP
BurgundySip_5v <- BurgundySip[duplicated(BurgundySip[2:6]),]; #72%
length(BurgundySip_5v$SN)/length(BurgundySip$SN)

#Therefore, duplicates removed by SN
BurgundySip <- BurgundySip[!duplicated(BurgundySip$SN),];BurgundySip;

#Remove columns SN,Name, Wine
BurgundySip<-BurgundySip[-c(1,2,3)];BurgundySip;

#recategorization of categorical variables

#REG
sort(summary(BurgundySip$REG))
levels(BurgundySip$REG)
levels(BurgundySip$REG)[levels(BurgundySip$REG) %in% levels(BurgundySip$REG)[-c(60,58,54,9,70)]] <- "other";

#TP
sort(summary(BurgundySip$TP))
levels(BurgundySip$TP)
levels(BurgundySip$TP)[levels(BurgundySip$TP) %in% levels(BurgundySip$TP)[-c(13,12,10,11,6,20)]] <- "other";

#Outlier treatment
#RSG
sumr_rsg <- summary(BurgundySip$RSG);sumr_rsg;
IQR_rsg <- sumr_rsg[5] - sumr_rsg[2];IQR_rsg;

outPercent_rsg <- sum(BurgundySip$RSG < sumr_rsg[2]-1.5*IQR_rsg | BurgundySip$RSG > sumr_rsg[5]+1.5*IQR_rsg,na.rm = T)/length(BurgundySip$RSG);
outPercent_rsg;

rsg_trimed_mean <- mean(BurgundySip$RSG, trim = outPercent_rsg,na.rm = T); rsg_trimed_mean;
BurgundySip$RSG[BurgundySip$RSG < sumr_rsg[2]-1.5*IQR_rsg | BurgundySip$RSG > sumr_rsg[5]+1.5*IQR_rsg] <- rsg_trimed_mean

#AL
sumr_al <- summary(BurgundySip$AL);sumr_al;
IQR_al <- sumr_al[5] - sumr_al[2];IQR_al;

outPercent_al <- sum(BurgundySip$AL < sumr_al[2]-1.5*IQR_al | BurgundySip$AL > sumr_al[5]+1.5*IQR_al,na.rm = T)/length(BurgundySip$AL);
outPercent_al;

al_trimed_mean <- mean(BurgundySip$AL, trim = outPercent_al,na.rm = T);al_trimed_mean;
BurgundySip$AL[BurgundySip$AL < sumr_al[2]-1.5*IQR_al | BurgundySip$AL > sumr_al[5]+1.5*IQR_al] <- al_trimed_mean

#DN
sumr_dn <- summary(BurgundySip$DN);sumr_dn;
IQR_dn <- sumr_dn[5] - sumr_dn[2];IQR_dn;

outPercent_dn <- sum(BurgundySip$DN < sumr_dn[2]-1.5*IQR_dn | BurgundySip$DN > sumr_dn[5]+1.5*IQR_dn,na.rm = T)/length(BurgundySip$DN);
outPercent_dn;

dn_trimed_mean <- mean(BurgundySip$DN, trim = outPercent_dn,na.rm = T);dn_trimed_mean;
BurgundySip$DN[BurgundySip$DN < sumr_dn[2]-1.5*IQR_dn | BurgundySip$DN > sumr_dn[5]+1.5*IQR_dn] <- dn_trimed_mean

#RT
sumr_rt <- summary(BurgundySip$RT);sumr_rt;
IQR_rt <- sumr_rt[5] - sumr_rt[2];IQR_rt;

outPercent_rt <- sum(BurgundySip$RT < sumr_rt[2]-1.5*IQR_rt | BurgundySip$RT > sumr_rt[5]+1.5*IQR_rt,na.rm = T)/length(BurgundySip$RT);
outPercent_rt;

rt_trimed_mean <- mean(BurgundySip$RT, trim = outPercent_rt,na.rm = T);rt_trimed_mean;
BurgundySip$RT[BurgundySip$RT < sumr_rt[2]-1.5*IQR_rt | BurgundySip$RT > sumr_rt[5]+1.5*IQR_rt] <- rt_trimed_mean

#Missing value treatment
#independent variables/Hot desk approach
YR_wo_Nas <- BurgundySip$YR[!is.na(BurgundySip$YR)];
BurgundySip$YR[is.na(BurgundySip$YR)] <- YR_wo_Nas[sample(1:length(YR_wo_Nas), sum(is.na(BurgundySip$YR)))];

TP_wo_Nas <- BurgundySip$TP[!is.na(BurgundySip$TP)];
BurgundySip$TP[is.na(BurgundySip$TP)] <- TP_wo_Nas[sample(1:length(TP_wo_Nas), sum(is.na(BurgundySip$TP)))];

mean_BD<-mean(BurgundySip$BD, na.rm = T); mean_BD;
BurgundySip$BD[is.na(BurgundySip$BD)]<-mean_BD;

mean_ACD<-mean(BurgundySip$ACD, na.rm = T); mean_ACD;
BurgundySip$ACD[is.na(BurgundySip$ACD)]<-mean_ACD;

summary(BurgundySip);

#dependent numeric variables/ categorical imputation
mean_depend <- aggregate(cbind(RSG,AL,DN) ~YR+REG+TP, data=BurgundySip, FUN=mean,na.rm=T);
mean_depend;

names(mean_depend)<-c("YR","REG","TP","RSG_mean","AL_mean","DN_mean")
mean_depend;

BurgundySip<-merge(BurgundySip,mean_depend,by=c("YR","REG","TP"))

#replacing missing values with categorical mean
BurgundySip$RSG[is.na(BurgundySip$RSG)]<-BurgundySip$RSG_mean[is.na(BurgundySip$RSG)];
BurgundySip$AL[is.na(BurgundySip$AL)]<-BurgundySip$AL_mean[is.na(BurgundySip$AL)];
BurgundySip$DN[is.na(BurgundySip$DN)]<-BurgundySip$DN_mean[is.na(BurgundySip$DN)];

#removing mean columns
BurgundySip<-BurgundySip[1:11];

#added a new column for weighted rating
BurgundySip$weightedRT<-BurgundySip$RT*BurgundySip$NUMR;
BurgundySip;

summary(BurgundySip);

write.csv(BurgundySip,"C:\\Users\\sajee\\Desktop\\Data handling & Decision making\\Final project\\test\\burgandysip.csv")

#overall rating
BurgundySip$Ratecat <- cut(BurgundySip$RT,c(3,3.5,4,4.5,5),labels = c("3-3.5","3.5-4","4-4.5","4.5-5"), include.lowest = T);
BurgundySip;
Ratenumbr <- aggregate(NUMR ~Ratecat,data=BurgundySip,FUN = sum);Ratenumbr;

#pie chart
pct<-round((Ratenumbr$NUMR/sum(Ratenumbr$NUMR))*100); pct;
lbls<-paste(Ratenumbr$Ratecat,pct)
lbls<-paste(lbls, "%", sep="")
lbls;
z<-pie(Ratenumbr$NUMR, labels = lbls,col=rainbow(length(Ratenumbr$Ratecat)));

plot(BurgundySip$RT,ylab ="Average rating", col=516)

#simple mean
round(mean(BurgundySip$RT),2)

install.packages("plotrix");
library(plotrix);

#Region wise analysis
#Region vs price-bar plot analysis
priceregion <- aggregate(PR ~ REG,data=BurgundySip,FUN = mean,na.rm=T);
priceregion;
x<-barplot(PR~ REG ,data =priceregion, col=11,xlab = "Region", ylab = "Average Price");
barlabels(x,round(priceregion$PR,0))

#Region vs rating-bar plot analysis
ratingregion <- aggregate(cbind(NUMR,weightedRT) ~ REG,data=BurgundySip,FUN = sum);
ratingregion;
ratingregion<-transform(ratingregion,WAvgRating=weightedRT/NUMR)

y<-barplot(WAvgRating~ REG ,data =ratingregion, col=11,xlab = "Region", ylab = "Weighted Average Rating");
barlabels(x,round(ratingregion$WAvgRating,2))

#Piechart
pct<-round((ratingregion$NUMR/sum(ratingregion$NUMR))*100); pct;
lbls<-paste(ratingregion$REG,pct)
lbls<-paste(lbls, "%", sep="")
lbls;
z<-pie(ratingregion$NUMR, labels = lbls,col=rainbow(length(ratingregion$REG)));

#wine age analysis
#age vs RSG
rsg_yr <- aggregate(RSG ~ YR,data=BurgundySip,FUN = mean,na.rm=T);
rsg_yr;
x<-barplot(RSG~ YR ,data =rsg_yr, col=11,xlab = "Harvest Year", ylab = "Residualsugarlevel");

#age vs AL
al_yr <- aggregate(AL ~ YR,data=BurgundySip,FUN = mean,na.rm=T);
al_yr;
x<-barplot(AL~ YR ,data =al_yr, col=11,xlab = "Harvest Year", ylab = "Alcohol level");

#age vs DN
dn_yr <- aggregate(DN ~ YR,data=BurgundySip,FUN = mean,na.rm=T);
dn_yr;
x<-barplot(DN~YR ,data =dn_yr, col=11,xlab = "Harvest Year", ylab = "Density of wine");

#Corelation with rating
#Average rating  vs.Residual sugar level
plot(RT ~ RSG, data=BurgundySip, main="Average rating  vs.Residual sugar level", xlab="Residual sugar level", 
     ylab="Average rating ", pch=18, col=429);

abline(lm(BurgundySip$RT~BurgundySip$RSG),col="red")

#Average rating  vs.Alcohol level
plot(RT ~ AL, data=BurgundySip, main="Average rating  vs.Alcohol level", xlab="Alcohol level", 
     ylab="Average rating ", pch=18, col=429);

abline(lm(BurgundySip$RT~BurgundySip$AL),col="red")

library(PerformanceAnalytics)

#corelation (Price)
#ANOVA-vs categorical
BurgundySip_noNA <- na.omit(BurgundySip);
summary(BurgundySip_noNA)
anovaModel1 <- aov(PR ~ REG+TP,BurgundySip_noNA);
summary(anovaModel1)

BurgundySip_noNA$TP_INT <- as.integer(BurgundySip_noNA$TP)
BurgundySip_noNA$REG_INT <- as.integer(BurgundySip_noNA$REG)
BurgundySip_noNA ;
summary(BurgundySip_noNA)

library(PerformanceAnalytics);

chart.Correlation(BurgundySip_noNA [-c(1,2,3,5,12,13)],method = "spearman");

#Regression Model

#Train & Test data sets
train_data<-na.omit(BurgundySip); train_data;
test_data<-BurgundySip[is.na(BurgundySip$PR),];test_data;

#Non-linear

BurgundySipNLM1 <- loess(PR~RT+RSG, data=train_data, control = loess.control(surface="direct"));
summary(BurgundySipNLM1); 

BurgundySipNLM2 <- loess(PR~RT+RSG+AL+DN, data=train_data, control = loess.control(surface="direct"));
summary(BurgundySipNLM2); 

#prediction with model 1
BurgundySip_NLM1<-BurgundySip;

predPR_NLM1<-predict(BurgundySipNLM1, newdata = test_data);predPR_NLM1

BurgundySip_NLM1$PR[is.na(BurgundySip_NLM1$PR)]<-predPR_NLM1;
summary(BurgundySip_NLM1);

#plot
#actual price
plot(PR~RT, data = train_data, xlab="Average Rating",ylab="Price",main="Price vs Average Rating") 

#predicted price
predPRALL_NLM1<-predict(BurgundySipNLM1, newdata = train_data)

plot(predPRALL_NLM1~train_data$RT, xlab="Average Rating",ylab="Predected Price_model1",main="Predicted Price vs Average Rating with Model 1") 

#prediction with model 2
BurgundySip_NLM2<-BurgundySip;

predPR_NLM2<-predict(BurgundySipNLM2, newdata = test_data);predPR_NLM2

BurgundySip_NLM2$PR[is.na(BurgundySip_NLM2$PR)]<-predPR_NLM2;
summary(BurgundySip_NLM2);

#plot
#actual price
plot(PR~RT, data = train_data, xlab="Average Rating",ylab="Price",main="Price vs Average Rating") 

#predicted price
predPRALL_NLM2<-predict(BurgundySipNLM2, newdata = train_data)

plot(predPRALL_NLM2~train_data$RT, xlab="Average Rating",ylab="Predected Price_model2",main="Predicted Price vs Average Rating with Model 2") 

#prediction with model 2
BurgundySip$PR[is.na(BurgundySip$PR)]<-predPR_NLM2;
summary(BurgundySip);

plot(PR~RT, data = BurgundySip, xlab="Average Rating",ylab="Price",main="Price (predicted for NA) vs Average Rating") 

#cluster
#univariate - PR

Kcluster <- kmeans(BurgundySip$PR,3);Kcluster;

plot(BurgundySip$PR, pch=21, bg=Kcluster$cluster * 1 + 3, ylab = "Price" );

BurgundySip$newClass <- Kcluster$cluster;
BurgundySip$newClass[BurgundySip$newClass==1] <- "Low";
BurgundySip$newClass[BurgundySip$newClass==2] <- "Medium";
BurgundySip$newClass[BurgundySip$newClass==3] <- "High";
BurgundySip$newClassF<-factor(BurgundySip$newClass)

table(BurgundySip$newClassF, BurgundySip$REG)
summary(table(BurgundySip$newClassF, BurgundySip$REG))

#Multivariate - 

Kclustermulti <- kmeans(BurgundySip$PR+BurgundySip$RT,3);Kclustermulti;
plot(BurgundySip$PR~BurgundySip$RT, pch=21, bg=Kclustermulti$cluster * 1 + 3, ylab = "Price", xlab="Average rating");

BurgundySip$newClass2 <- Kclustermulti$cluster;
BurgundySip$newClass2[BurgundySip$newClass2==1] <- "Low";
BurgundySip$newClass2[BurgundySip$newClass2==2] <- "Medium";
BurgundySip$newClass2[BurgundySip$newClass2==3] <- "High";
BurgundySip$newClass2F<-factor(BurgundySip$newClass2)

table(BurgundySip$newClass2F, BurgundySip$REG)
summary(table(BurgundySip$newClassF, BurgundySip$REG))

#3D plot
library(plotly)
plot_ly(data=BurgundySip,y=~PR, x=~RT,z=~AL,type = "scatter3d", mode="markers",
        color=Kclustermulti$cluster * 2 + 17 );



