############################################################
############################################################
######                 classification                 ######
############################################################
load("label20.RData")
library(randomForest)
music_rf<-randomForest(music_feature_train[,-1],music_label_train_f,importance=T,proximity=T)
music_rf_pre<-predict(music_rf,music_feature_test[,-1],type="vote",norm.votes=T)
############################################################