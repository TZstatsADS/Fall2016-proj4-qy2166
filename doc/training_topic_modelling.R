############################################################
######              topic modelling                   ######
############################################################
library(topicmodels)
library(NLP)
library(tm)

string_convert<-function(lyr) {
  result<-data.frame()
  for(row in 1:(nrow(lyr))){
    words<-NULL
    for(col in 2:(ncol(lyr)-1)){
      if(lyr[row,col]!=0){
        kw<-rep(colnames(lyr)[col],lyr[row,col])
        kw<-paste(kw,collapse=' ')
        words<-paste(words,kw)
      }
    }
    result[row,1]<-words
  }
  return(result)
}

adjust_prob<-function(lyr,label){
  new_lyr<-lyr[-237,]
  df<-cbind(label,new_lyr)
  result<-data.frame(matrix(seq(20),nrow=max(as.numeric(label)),ncol=5000))
  for(lb in 1:max(as.numeric(label))) {
    holder<-subset(df,df[,1]==lb)
    holder<-colSums(holder[,3:5002])
    tot<-sum(holder)
    prop<-holder/tot
    result[lb,]<-prop
  }
  result<-t(result)
  result<-cbind(colnames(new_lyr)[2:5001],result)
  result<-result[-c(1,2,5:29),]
  return(result)
}

lyrics<-string_convert(lyric)
Vlyrics<-c()
for(i in 1:2350){
  Vlyrics<-c(Vlyrics,lyrics[[1]][i])
}
Vlyrics<-Vlyrics[-237]
Vlyrics<-VCorpus(VectorSource(Vlyrics))
Vlyrics<-tm_map(Vlyrics,stripWhitespace)
Vlyrics<-tm_map(Vlyrics,removeWords,stopwords("english"))
dtm<-DocumentTermMatrix(Vlyrics,control=list(weight=weightTfIdf))

k3<-20
set.seed(123)
result20<-LDA(dtm,k=k3,method="VEM",control=list(seed=2010))
label20<-topics(result20,1)
rank20<-terms(result20,100)
write.csv(label20,file="label20.csv")
write.csv(rank20,file="termsrank20.csv")
adjustprob20<-adjust_prob(lyr,label20)
prob_new<-adjustprob20[,-c(1)]
prob_num<-matrix(0,4973,20)
for(i in 1:20){
  for(j in 1:4973){
    prob_num[j,i]<-as.numeric(prob_new[j,i])
  }
}
rownames(prob_num)<-adjustprob20[,1]
############################################################