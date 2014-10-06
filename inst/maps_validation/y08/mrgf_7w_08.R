mrgf7b<-function(i){

 val0<-getValues(mc08_reclass)[unique(neigh_cell(neigh_cell(neigh_cell(i))))]
 
 val<-val0[!is.na(val0)]
 length(val)->wdata

 valr0<-getValues(mc_res08)[unique(neigh_cell(neigh_cell(neigh_cell(i))))]
 
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
mc08_reclass<-raster('mc08_reclass.asc')
mc_res08<-raster('mc_res08.asc')
mc08_reclass@nrows->nr
mc08_reclass@ncols->nc

getValues(mc08_reclass)->val_index
getValues(mc_res08)->val_indexr

which(!is.na(getValues(mc08_reclass)))->val_index2
length(val_index2)->lc
results7<-NULL
fitw7_08<<-NULL

mrgf7<-function(){
ltw<-seq(1,lc)
results7<-mclapply(ltw,mrgf7b)
fitw7_08<<-sum(unlist(results7),na.rm=T)/length(unlist(results7))
return(fitw7_08)
}

