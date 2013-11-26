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

run_model<-function(){

# SPATIAL PARAMETERS #
#require(raster)

rpath = system.file("extdata",package="spdynmod")
#rpath = '/net/netapp2/H05_Homes/majavie/spdynmod/inst/extdata'

r<- raster(paste(rpath,'/mc84_1_reclass.asc',sep=''))

fak<<- raster(paste(rpath,'/log_cr10_acum_rm_t1_aver.asc',sep=''))

dr1<<- raster(paste(rpath,'/rambla11_cr10_dist_t1.asc',sep='')) 
dr2<<- raster(paste(rpath,'/rambla22_cr10_dist_t1.asc',sep='')) 

avd<<- raster(paste(rpath,'/ramblas_cr10_dist_t1_ave.asc',sep=''))

fa_avd<<-fak+(1-avd)

es_init<<-raster(paste(rpath,'/mc84_1_reclass3.asc',sep=''))

sm_init<<-raster(paste(rpath,'/mc84_2_reclass3.asc',sep=''))

rb_init<<-raster(paste(rpath,'/mc84_34.asc',sep=''))

baresoil_init<<-raster(paste(rpath,'/mc84_4_reclass3.asc',sep=''))

nr<<-dim(r)[1]
nc<<-dim(r)[2]
NN<<-nr*nc

### state variables ###
st <<- c(raster::as.vector(raster::as.matrix(sm_init)), raster::as.vector(raster::as.matrix(es_init)),raster::as.vector(raster::as.matrix(rb_init)),raster::as.vector(raster::as.matrix(baresoil_init)))

### parameters ###
parms <<- c(tprb = 0.005, tpsm = 0.2)# tpsm = 0.01

### model specs and execution ###
##source('mc_dynmodv2_7_functions.R')
DT <<- 0.25
time <- seq(0.001,24,DT)

out <<- deSolve::ode.2D(func=spdynmod,y=st,times=time,parms=parms,method='euler',nspec = 4, dimens = c(nr, nc),nr=nr,nc=nc,names=c('Salt marsh','Salt steppe','Reed beds','Bare soil'))
}
