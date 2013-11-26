#' A one sentence description of what your function does
#' 
#' A more detailed description of what the function is and how
#' it works. It may be a paragraph that should not be separated
#' by any spaces. 
#'
#' @param inputParameter1 A description of the input parameter \code{inputParameter1}
#' @param inputParameter2 A description of the input parameter \code{inputParameter2}
#'
#' @return output A description of the object the function outputs 
#'
#' @keywords keywords
#'
#' @export
#' 
#' @examples
#' R code here showing how your function works

##if (require(deSolve) == F) {install.packages('deSolve',repos='http://cran.r-project.org');if (require(deSolve) == F) print ('Error: deSolve package is not installed on your machine')}

############# MODEL
spdynmod<-function(t,init,parameters,nr,nc) { 

	NN<-nr*nc
	sm <- matrix(nr=nr,nc=nc,init[1:NN])
	es <- matrix(nr=nr,nc=nc,init[(NN+1):(2*NN)])
	rb <- matrix(nr=nr,nc=nc,init[((2*NN)+1):(3*NN)])
	baresoil <- matrix(nr=nr,nc=nc,init[((3*NN)+1):(4*NN)])
	drambla1<-raster::as.matrix(dr1) 
	drambla2<-raster::as.matrix(dr2) 
	fa_avd2<-raster::as.matrix(fa_avd)

	Time <<- t
	tprb <- parameters['tprb']
	tpsm <- parameters['tpsm']

	IPRH <- inputData(t, 'IPRH')
	eframbla1 <- 1-drambla1
	eframbla2 <- 1-drambla2

	daguarb <- (eframbla1)^5 + (eframbla2)^5
	daguasm <- fa_avd2^4 

	edarb <- (1+IPRH)*daguarb 
	edasm <- (1+IPRH)*daguasm 

	tpss2sm <- IPRH/2
	tpbs2sm <- IPRH/0.2
	tpss2rb <- IPRH/0.4540899989
	tpbs2rb <- IPRH/0.1
	tpsm2rb <- IPRH/3

	tactsm2rb <- edarb*tpsm2rb*tprb
	tactss2rb <- edarb*tpss2rb*tprb
	tactbs2sm <- edasm*tpbs2sm*tpsm
	tactss2sm <- edasm*tpss2sm*tpsm
	tactbs2rb <- edarb*tpbs2rb*tprb

	ss2rb <-  rb * tactss2rb * es * ( 1 - ( rb / 25 ) )
	ss2sm <-  sm * tactss2sm * es * ( 1 - ( sm / 25 ) )
	sm2rb <-  rb * tactsm2rb * sm * ( 1 - ( rb / 25 ) )
	bs2sm <-  sm * tactbs2sm * baresoil * ( 1 - ( sm / 25 ) )
	bs2rb <-  rb * tactbs2rb * baresoil * ( 1 - ( rb / 25 ) )

	 dsm = ss2sm  + bs2sm  - sm2rb 
	 des = - ss2sm  - ss2rb 
	 drb = sm2rb  + ss2rb  + bs2rb 
	 dbaresoil =  - bs2sm  - bs2rb 

######### BEGIN DISPERSAL
#sm_disp<-0
		w22<-which(sm > 1)

		if (length(w22)>0) {
			wg22<-sapply(w22,neigh_cell)

				disp222bs<<-sapply(wg22,function(x) x[which(baresoil[x]>=1)]) 
				which(disp222bs>0)->ind
				as.numeric(disp222bs[ind])->xs

				if (length(ind)>0) {
						dbaresoil[xs]<-dbaresoil[xs]-0.25
						dsm[xs]<-dsm[xs]+0.25
						#sm_disp<-3


				} 

				disp222ss<<-sapply(wg22,function(x) x[which(es[x]>=1)]) 
				which(disp222ss>0)->ind
				as.numeric(disp222ss[ind])->xs

				if (length(ind)>0) {
						des[xs]<-des[xs]-0.25
						dsm[xs]<-dsm[xs]+0.25
						#sm_disp<-4

	} 
}
######### END DISPERSAL

	 list(c(dsm,des,drb,dbaresoil))
}

#system('aplay -t wav hangout_dingtone.wav')
