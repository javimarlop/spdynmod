mrgf_focal<-function(a='',b='',w1,w2){
require(raster)
af<-raster(paste(a,'.asc',sep=''))
bf<-raster(paste(b,'.asc',sep=''))
fits<-NULL
fitw<-NULL
fitsw<<-NULL
ads<-NULL
g<-0
for(k in seq(w1,w2,2)){
g<-g+1
h<-0
getValuesFocal(af,ngb=k)->valss1
getValuesFocal(bf,ngb=k)->valss2
print(dim(valss1)[2])
for(j in 1:dim(valss1)[1]){
valsx1<-valss1[j,]
valsx2<-valss2[j,]
vals1<-valsx1[!is.na(valsx1)]
vals2<-valsx2[!is.na(valsx2)]
lvals1<-length(vals1)
cats<-unique(vals1)
lcats<-length(cats)
if(lcats>0){
 h<-h+1
 for(i in 1:lcats){
  length(vals1[vals1==cats[i]])->a1
  length(vals2[vals2==cats[i]])->a2
  ad<-abs(a1-a2)
  ads[i]<-ad
 }
 fit<-1-(sum(ads,na.rm=T)/(2*lvals1))
 fits[h]<-fit
}
}
fitw<-sum(fits,na.rm=T)/length(fits)
fitsw[g]<<-fitw
}
plot(seq(w1,w2,2),fitsw,xlab='window size',ylab='Fw',ty='o')
}
