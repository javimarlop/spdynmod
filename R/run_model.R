#' Run the model.
#' 
#' Model solving function using ode.2D from the 'deSolve' package.
#'
#' @param pgr_rb potential growth rate of reed beds
#' @param pgr_sm potential growth rate of salt marsh
#' @param method integration method: "lsodes", "euler", "rk4", "ode23", "ode45", "adams", "iteration"
#' @param TS time step
#' @return the function outputs a matrix named "out" which contains the model simulated values for every pixel, time step and state variable.
#'
#' @keywords keywords
#'
#' @export
#' 
#' @examples
#' R code here showing how your function works

run_model<-function(pgr_rb = 0.005, pgr_sm = 0.2, method = 'euler', TS = 0.25){

### initial random maps generation

#rr <- r
#rr[]<-abs(round(rnorm(13000,mean=2,sd=0.5)))
#rr2<-mask(rr,r)

# sacar 0 y 1 como SS, 2 como SM, 3 como RB y 4 como BS
# poner a todos 20 inicialmente o 0 segun presencia ausencia

###

#rm(list=ls())
# SPATIAL PARAMETERS #
#require(raster)

rpath = system.file("extdata",package="spdynmod")
#rpath = '/net/netapp2/H05_Homes/majavie/spdynmod/inst/extdata'

r<<- raster(paste(rpath,'/mc84_1_reclass.asc',sep=''))

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
parms <<- c(tprb = pgr_rb, tpsm = pgr_sm)# tpsm = 0.01

### model specs and execution ###
##source('mc_dynmodv2_7_functions.R')
DT <<- TS
time <- seq(0.001,24,DT)

out <<- deSolve::ode.2D(func=spdynmod,y=st,times=time,parms=parms,method=method,nspec = 4, dimens = c(nr, nc),nr=nr,nc=nc,names=c('Salt marsh','Salt steppe','Reed beds','Bare soil'))
}
