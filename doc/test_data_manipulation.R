############################################################
######                  load data                     ######
############################################################
setwd("G:/Columbia/STAT GR5243/project04/test data")
library(rhdf5)
filenames_test<-vector()
for(i in 1:100){
  filenames_test[i]<-paste0("testsong",i,".h5")
}
filenumber_test<-length(filenames_test)
sound_test<-vector()
for(i in 1:filenumber_test){
  sound_test<-cbind(sound_test,h5read(filenames_test[i],"/analysis"))
  H5close()
}
columnnames_test<-vector()
for(i in 1:filenumber_test){
  columnnames_test[i]<-filenames_test[i]
}
colnames(sound_test)<-columnnames_test
############################################################
############################################################
######               length of each cell              ######
############################################################
lengthcount_test<-matrix(0,nrow(sound_test),ncol(sound_test))
for(i in 1:nrow(sound_test)){
  for(j in 1:ncol(sound_test)){
    lengthcount_test[i,j]<-length(sound_test[i,j][[1]])
  }
}
rownames(lengthcount_test)<-rownames(sound_test)
colnames(lengthcount_test)<-colnames(sound_test)
############################################################
############################################################
######                  invalid songs                 ######
############################################################
invalidsongs_test<-list()
for(i in 1:nrow(sound_test)){
  invalidsongs_test[[i]]<-which(lengthcount_test[i,]==0)
}
# 
############################################################