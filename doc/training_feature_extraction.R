############################################################
######                    features                    ######
############################################################
# loudness
general_loudness<-vector()
for(i in 1:ncol(sound)){
  general_loudness[i]<-sound[14,i][[1]]$loudness
}
average_max_loudness<-vector()
dynamic_range<-vector()
max_loudness<-vector()
average_segment_rate<-vector()
for(i in 1:ncol(sound)){
  average_max_loudness[i]<-mean(sound[8,i][[1]])
  dynamic_range[i]<-max(sound[8,i][[1]])-min(sound[10,i][[1]])
  max_loudness[i]<-max(sound[8,i][[1]])
  average_segment_rate[i]<-mean(diff(sound[12,i][[1]]))
}
fit_loudness<-lm(general_loudness~average_max_loudness+dynamic_range+max_loudness+average_segment_rate)
loudness<-cbind(1,average_max_loudness,dynamic_range,max_loudness,average_segment_rate)%*%fit_loudness$coefficients
loudness<-as.vector(loudness)
# tempo
tempo<-vector()
for(i in 1:ncol(sound)){
  tempo[i]<-length(sound[4,i][[1]])/(max(sound[4,i][[1]])/60)
}
# duration
duration<-vector()
for(i in 1:ncol(sound)){
  duration[i]<-max(sound[4,i][[1]])
}
# bar duration
average_bar_duration<-vector()
for(i in 1:ncol(sound)){
  average_bar_duration[i]<-mean(diff(sound[2,i][[1]]))
}
# tatum duration
average_tatum_duration<-vector()
for(i in 1:ncol(sound)){
  average_tatum_duration[i]<-mean(diff(sound[16,i][[1]]))
}
# pitch
all_pitch<-vector()
for(i in 1:ncol(sound)){
  all_pitch<-cbind(all_pitch,sound[11,i][[1]])
}
all_pitch<-t(all_pitch)
pitch_time<-proc.time()
set.seed(123)
pitch_cluster<-kmeans(all_pitch,500,iter.max=500,algorithm="MacQueen")
proc.time()-pitch_time
pitch_cluster_list<-list()
pitch_cluster_list[[1]]<-pitch_cluster$cluster[1:(lengthcount[11,1]/12)]
for(i in 1:(ncol(sound)-1)){
  pitch_cluster_list[[i+1]]<-pitch_cluster$cluster[(sum(lengthcount[11,1:i]/12)+1):sum(lengthcount[11,1:(i+1)]/12)]
}
pitch_matrix<-matrix(0,2350,500)
for(i in 1:2350){
  for(j in 1:500){
    pitch_matrix[i,j]<-sum(pitch_cluster_list[[i]]==j)
  }
}
pitch_weight_matrix<-matrix(0,2350,500)
for(i in 1:2350){
  for(j in 1:500){
    pitch_weight_matrix[i,j]<-(pitch_matrix[i,j]/sum(pitch_matrix[i,]!=0))*log(2350/sum(pitch_matrix[,j]!=0))
  }
}
colnames(pitch_matrix)<-c(paste0("pitch_",1:500))
# timbre
# this feature does not improve the result
# kmeans cluster does not converge within 500 iterations
#all_timbre<-vector()
#for(i in 1:ncol(sound)){
#  all_timbre<-cbind(all_timbre,sound[13,i][[1]])
#}
#all_timbre<-t(all_timbre)
#timbre_time<-proc.time()
#set.seed(123)
#timbre_cluster<-kmeans(all_timbre,500,iter.max=500,algorith="MacQueen")
#proc.time()-timbre_time
#timbre_cluster_list<-list()
#timbre_cluster_list[[1]]<-timbre_cluster$cluster[1:(lengthcount[11,1]/12)]
#for(i in 1:(ncol(sound)-1)){
#  timbre_cluster_list[[i+1]]<-timbre_cluster$cluster[(sum(lengthcount[11,1:i]/12)+1):sum(lengthcount[11,1:(i+1)]/12)]
#}
#timbre_matrix<-matrix(0,2350,500)
#for(i in 1:2350){
#  for(j in 1:500){
#    timbre_matrix[i,j]<-sum(timbre_cluster_list[[i]]==j)
#  }
#}
#colnames(timbre_matrix)<-c(paste0("timbre_",1:500))

music_feature_train<-cbind(id=c(1:2350),loudness,tempo,duration,average_bar_duration,average_tatum_duration,pitch_matrix)
music_feature_train<-music_feature_train[-c(237,715,950,991,1112,1325,1375,1658,1705,2284),]
############################################################