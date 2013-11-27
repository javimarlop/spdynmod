#' Plot abundance maps of plant communities.
#' 
#' A more detailed description of what the function is and how
#' it works. It may be a paragraph that should not be separated
#' by any spaces. 
#'
#' @param i time step to plot (from 1 to 96)
#' @param inputParameter2 A description of the input parameter \code{inputParameter2}
#'
#' @return by default plots the final plant communities map (i = 96). There are 4 maps per year from 1984 to 2008.
#'
#' @keywords keywords
#'
#' @export
#' 
#' @examples
#' R code here showing how your function works

plot_maps<-function(i = 96) { 

brks <- seq(0, 30, by=1) 
nb <- length(brks)-1 
#i<-96

par(mfrow=c(2,2))

plot(raster(matrix(nr = nr, nc = nc, out[i, 2:(NN+1)])),breaks=brks, col=rev(terrain.colors(nb)), lab.breaks=brks, zlim=c(0,30),main="Salt marsh")

plot(raster(matrix(nr = nr, nc = nc, out[i, (NN+2):(2*NN+1)])),breaks=brks, col=rev(terrain.colors(nb)), lab.breaks=brks, zlim=c(0,30),main="Salt steppe")

plot(raster(matrix(nr = nr, nc = nc, out[i, (2*NN+2):(3*NN+1)])),breaks=brks, col=rev(terrain.colors(nb)), lab.breaks=brks, zlim=c(0,30),main="Reed beds")


plot(raster(matrix(nr = nr, nc = nc, out[i, (3*NN+2):(4*NN+1)])),breaks=brks, col=rev(terrain.colors(nb)), lab.breaks=brks, zlim=c(0,30),main="Bare soil")
}

