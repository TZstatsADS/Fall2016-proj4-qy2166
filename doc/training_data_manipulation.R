############################################################
######                  load data                     ######
############################################################
setwd("G:/Columbia/STAT GR5243/project04")
load("lyr.RData")
lyric<-lyr[,-c(2,3,6:30)]
setwd("G:/Columbia/STAT GR5243/project04/data")
library(rhdf5)
filenames<-list.files(recursive=T)
filenumber<-length(filenames)
sound<-vector()
for(i in 1:filenumber){
  sound<-cbind(sound,h5read(filenames[i],"/analysis"))
  H5close()
}
columnnames<-vector()
for(i in 1:filenumber){
  columnnames[i]<-sound[,i]$songs$track_id
}
colnames(sound)<-columnnames
############################################################
############################################################
######               length of each cell              ######
############################################################
lengthcount<-matrix(0,nrow(sound),ncol(sound))
for(i in 1:nrow(sound)){
  for(j in 1:ncol(sound)){
    lengthcount[i,j]<-length(sound[i,j][[1]])
  }
}
rownames(lengthcount)<-rownames(sound)
colnames(lengthcount)<-colnames(sound)
############################################################
############################################################
######                  invalid songs                 ######
############################################################
invalidsongs<-list()
for(i in 1:nrow(sound)){
  invalidsongs[[i]]<-which(lengthcount[i,]==0)
}
# 715,950,991,1112,1325,1375,1658,1705,2284
############################################################