mrgf11b<-function(i){

 val0<-getValues(mc95_reclass)[unique(neigh_cell(neigh_cell(neigh_cell(neigh_cell(neigh_cell(i))))))]
 
 val<-val0[!is.na(val0)]
 length(val)->wdata

 valr0<-getValues(mc_res95)[unique(neigh_cell(neigh_cell(neigh_cell(neigh_cell(neigh_cell(i))))))]
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
mc95_reclass<-raster('mc95_reclass.asc')
mc_res95<-raster('mc_res95.asc')
mc95_reclass@nrows->nr
mc95_reclass@ncols->nc

getValues(mc95_reclass)->val_index
getValues(mc_res95)->val_indexr

which(!is.na(getValues(mc95_reclass)))->val_index2
length(val_index2)->lc
results11<-NULL
fitw11_95<<-NULL

mrgf11<-function(){
ltw<-seq(1,lc)
results11<-mclapply(ltw,mrgf11b)
fitw11_95<<-sum(unlist(results11),na.rm=T)/length(unlist(results11))
return(fitw11_95)
}

