# symbolic link of extdata when documenting
# sudo add-apt-repository ppa:anton+/photo-video-apps
R CMD build --compact-vignettes='gs+qpdf' spdynmod
R CMD check --as-cran spdynmod_1.1.3.tar.gz
