#' Make an animation of the model output.
#' 
#' It requires ImageMagic installed in the system to work.
#'
#' @param inputParameter1 A description of the input parameter \code{inputParameter1}
#' @param inputParameter2 A description of the input parameter \code{inputParameter2}
#'
#' @return output A description of the object the function outputs 
#'
#' @keywords animation
#'
#' @export
#' 
#' @examples
#' R code here showing how your function works

animate_model<-function(){

brks <- seq(0, 30, by=1) 
nb <- length(brks)-1 

#require(animation)

saveGIF({
for (i in seq(1, dim(out)[1], by = 1)){
 i2<-seq(1984.25,2008,0.25)
 par(mfrow=c(3,2))
 par(mar=c(2,1,2,0.8))
 plot(raster(matrix(nr = nr, nc = nc, out[i, (3*NN+2):(4*NN+1)])),breaks=brks, col=rev(topo.colors(nb)), lab.breaks=brks, zlim=c(0,30),main="Bare Soil")
 plot(raster(matrix(nr = nr, nc = nc, out[i, (NN+2):(2*NN+1)])),breaks=brks, col=rev(topo.colors(nb)), lab.breaks=brks, zlim=c(0,30),main="Salt Steppe")
 plot(raster(matrix(nr = nr, nc = nc, out[i, 2:(NN+1)])),breaks=brks, col=rev(topo.colors(nb)), lab.breaks=brks, zlim=c(0,30),main="Salt marsh")
 plot(raster(matrix(nr = nr, nc = nc, out[i, (2*NN+2):(3*NN+1)])),breaks=brks, col=rev(topo.colors(nb)), lab.breaks=brks, zlim=c(0,30),main="Reed beds")
 par(mar=c(13,1,3,1.5))
 print(barplot(i2[i],col="black",horiz=T,xlim=c(1984,2008),axes=F,cex.sub=1.4, main="Time",cex.main=1.5))
 par(las=2)
 axis(1,at=c(1984,1992,1995,1997,2001,2008))
 }},movie.name='movie.gif')

}
