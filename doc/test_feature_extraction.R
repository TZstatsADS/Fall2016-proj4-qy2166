############################################################
######                    features                    ######
############################################################
# loudness
average_max_loudness_test<-vector()
dynamic_range_test<-vector()
max_loudness_test<-vector()
average_segment_rate_test<-vector()
# 8: segment_loudness_max
# 10: segment_loudness_start
# 12: segment_start
for(i in 1:ncol(sound_test)){
  average_max_loudness_test[i]<-mean(sound_test[8,i][[1]])
  dynamic_range_test[i]<-max(sound_test[8,i][[1]])-min(sound_test[10,i][[1]])
  max_loudness_test[i]<-max(sound_test[8,i][[1]])
  average_segment_rate_test[i]<-mean(diff(sound_test[12,i][[1]]))
}
load("fit_loudness.RData")
loudness_test<-cbind(1,average_max_loudness_test,dynamic_range_test,max_loudness_test,average_segment_rate_test)%*%fit_loudness$coefficients
loudness_test<-as.vector(loudness_test)
# tempo
tempo_test<-vector()
# 4: beats_start
for(i in 1:ncol(sound_test)){
  tempo_test[i]<-length(sound_test[4,i][[1]])/(max(sound_test[4,i][[1]])/60)
}
# duration
duration_test<-vector()
for(i in 1:ncol(sound_test)){
  duration_test[i]<-max(sound_test[4,i][[1]])
}
# bar duration
average_bar_duration_test<-vector()
# 2: bars_start
for(i in 1:ncol(sound_test)){
  average_bar_duration_test[i]<-mean(diff(sound_test[2,i][[1]]))
}
# tatum duration
average_tatum_duration_test<-vector()
# 16: tatums_start
for(i in 1:ncol(sound_test)){
  average_tatum_duration_test[i]<-mean(diff(sound_test[16,i][[1]]))
}
# pitch
all_pitch_test<-vector()
# 11: segments_pitches
for(i in 1:ncol(sound_test)){
  all_pitch_test<-cbind(all_pitch_test,sound_test[11,i][[1]])
}
all_pitch_test<-t(all_pitch_test)
load("pitch_cluster.RData")
dist_vec<-matrix(0,nrow(all_pitch_test),500)
for(j in 1:nrow(all_pitch_test)){
  for(i in 1:500){
    dist_vec[j,i]<-dist(rbind(all_pitch_test[j,],pitch_cluster$centers[i,]))
  }
}
cluster_vec<-vector()
for(i in 1:nrow(all_pitch_test)){
  cluster_vec[i]<-which.min(dist_vec[i,])
}
pitch_cluster_list_test<-list()
pitch_cluster_list_test[[1]]<-cluster_vec[1:(lengthcount_test[11,1]/12)]
for(i in 1:(ncol(sound_test)-1)){
  pitch_cluster_list_test[[i+1]]<-cluster_vec[(sum(lengthcount_test[11,1:i]/12)+1):sum(lengthcount_test[11,1:(i+1)]/12)]
}
pitch_matrix_test<-matrix(0,100,500)
for(i in 1:100){
  for(j in 1:500){
    pitch_matrix_test[i,j]<-sum(pitch_cluster_list_test[[i]]==j)
  }
}
colnames(pitch_matrix_test)<-c(paste0("pitch_test_",1:500))

music_feature_test<-cbind(id=c(1:100),loudness_test,tempo_test,duration_test,average_bar_duration_test,average_tatum_duration_test,pitch_matrix_test)
############################################################