mrgf13b<-function(i){

 val0<-getValues(mc92_reclass)[unique(neigh_cell(neigh_cell(neigh_cell(neigh_cell(neigh_cell(neigh_cell(i)))))))]

 val<-val0[!is.na(val0)]
 length(val)->wdata

 valr0<-getValues(mc_res92)[unique(neigh_cell(neigh_cell(neigh_cell(neigh_cell(neigh_cell(neigh_cell(i)))))))]
 
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
mc92_reclass<-raster('mc92_reclass.asc')
mc_res92<-raster('mc_res92.asc')
mc92_reclass@nrows->nr
mc92_reclass@ncols->nc

getValues(mc92_reclass)->val_index
getValues(mc_res92)->val_indexr

which(!is.na(getValues(mc92_reclass)))->val_index2
length(val_index2)->lc
results13<-NULL
fitw13_92<<-NULL

mrgf13<-function(){
ltw<-seq(1,lc)
results13<-mclapply(ltw,mrgf13b)
fitw13_92<<-sum(unlist(results13),na.rm=T)/length(unlist(results13))
return(fitw13_92)
}

