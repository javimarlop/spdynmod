spdynmod
========

[![DOI](https://zenodo.org/badge/4755/javimarlop/spdynmod.png)](http://dx.doi.org/10.5281/zenodo.10624)

<a rel="license" href="http://creativecommons.org/licenses/by-sa/3.0/deed.en_US"><img alt="Creative Commons License" style="border-width:0" src="http://i.creativecommons.org/l/by-sa/3.0/88x31.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-sa/3.0/deed.en_US">Creative Commons Attribution-ShareAlike 3.0 Unported License</a>.

Development version of the R library Spdynmod: Spatio-dynamic wetland plant communities model

The stable version can be found on [CRAN](http://cran.r-project.org/web/packages/spdynmod/index.html)

## How to install the spdynmod R library

```
install.packages('spdynmod')
```

## How to install the development version of the library

```
library(devtools)
install_github('spdynmod',username='javimarlop')
```

## Animation of model results

Animation of model results based on default parameters.

![Animation of model results](movie.gif)

## How to run the model

Please type `help(run_model)` for model execution options and `library(help=spdynmod)` to see all available functions in the library.

```
run_model()
```

## How to cite this model library

```
citation('spdynmod')
```

## Supplementary material

### Online wetland and watershed maps

You can see the location map of the study wetland and its watershed area by clicking on the [wetland.geojson](https://github.com/javimarlop/spdynmod/blob/master/inst/extdata/wetland.geojson) and [watershed.geojson](https://github.com/javimarlop/spdynmod/blob/master/inst/extdata/watershed.geojson) files on the `/inst/extdata` folder.

### Slides about the model

[Martínez-López J.](http://webs.um.es/javier.martinez/miwiki/lib/exe/fetch.php?id=inicio&cache=cache&media=isem2013_jml.pdf), Martínez-Fernández J. , Naimi B., Carreño M. F., Esteve M. A. 2013. Spatio-temporal dynamic modeling of plant communities responses to hydrological pressures in a semiarid Mediterranean wetland. Ecological Modelling for Ecosystem Sustainability in the context of Global Change - ISEM 2013. Toulouse, France.

## Model validation

A mutiple resolution goodness of fit assessment has been performed for each validation year after Costanza 1989 and Kuhnert et al. 2005. We implemented the version modified by Kuhnert et al. in order to exclude NA values from the analysis. The maps and R scripts needed to perform this assessment are prepared for parallel computing and can be found under `inst/maps_validation`.

@article{,
title = "{Model goodness of fit: A multiple resolution procedure}",
journal = "Ecological Modelling ",
volume = "47",
number = "3--4",
pages = "199 - 215",
year = "1989",
author = "Robert Costanza"
}

@Article{,
Title = {Comparing Raster Map Comparison Algorithms for Spatial Modeling and Analysis},
Author = {Kuhnert, Matthias and Voinov, Alexey and Seppelt, Ralf},
Journal = {Photogrammetric Engineering \& Remote Sensing},
Year = {2005},
Month = aug,
Number = {8},
Pages = {975--984},
Volume = {71}
}

