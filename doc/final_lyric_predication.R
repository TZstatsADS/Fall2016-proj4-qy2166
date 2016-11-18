############################################################
######               lyric prediction                 ######
############################################################
pred_word<-prob_num%*%t(music_rf_pre)
result<-list()
for(i in 1:100){
  result[[i]]<-rank(1-pred_word[,i])
}