mrgf5b<-function(i){

 val0<-getValues(mc01_reclass)[unique(neigh_cell(neigh_cell(i)))]

 val<-val0[!is.na(val0)]
 length(val)->wdata

 valr0<-getValues(mc_res01)[unique(neigh_cell(neigh_cell(i)))]
 valr<-valr0[!is.na(valr0)]
 unique(val)->cval
 length(cval)->lca
 ads<-NULL
  if(lca>0){

	for(j in 1:lca){
	a1<-length(val[val==cval[j]])
	a2<-length(valr[valr==cval[j]])
	ad<-abs(a1-a2)
	ads[j]<-ad
	}

 fit<-1-(sum(ads,na.rm=T)/(2*wdata))

 return(fit)
}
}

require(raster)
#require(parallel)
require(multicore) # install.packages('multicore',,'http://www.rforge.net/')
source('neigh_cell.R')
mc01_reclass<-raster('mc01_reclass.asc')
mc_res01<-raster('mc_res01.asc')
mc01_reclass@nrows->nr
mc01_reclass@ncols->nc

getValues(mc01_reclass)->val_index
getValues(mc_res01)->val_indexr

which(!is.na(getValues(mc01_reclass)))->val_index2
length(val_index2)->lc
results5<-NULL
fitw5_01<<-NULL

mrgf5<-function(){
ltw<-seq(1,lc)
results5<-mclapply(ltw,mrgf5b)
fitw5_01<<-sum(unlist(results5),na.rm=T)/length(unlist(results5))
return(fitw5_01)
}

