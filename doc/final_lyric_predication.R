############################################################
######               lyric prediction                 ######
############################################################
load("rf_classification.RData")
library(randomForest)
colnames(music_feature_test)<-c("id","loudness","tempo","duration","average_bar_duration","average_tatum_duration",paste0("pitch_",1:500))
music_rf_pre<-predict(music_rf,music_feature_test[,-1],type="vote",norm.votes=T)
load("prob20.RData")
pred_word<-prob_num%*%t(music_rf_pre)
result<-list()
for(i in 1:100){
  result[[i]]<-rank(1-pred_word[,i])
}
lyric_pred<-vector()
for(i in 1:100){
  lyric_pred<-rbind(lyric_pred,result[[i]])
}
lyric_pred_new<-cbind(4987,4987,lyric_pred[,1:2],4987,4987,4987,4987,4987,
                      4987,4987,4987,4987,4987,4987,4987,4987,4987,4987,4987,4987,4987,4987,
                      4987,4987,4987,4987,4987,4987,lyric_pred[,3:4973])
colnames(lyric_pred_new)[1:30]<-colnames(lyr)[2:31]
############################################################