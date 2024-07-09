#' Build and then optionally install a package
#' 
#' @param package_dir Path to the package source directory. Default is the current directory. 
#' @param output_directory Directory in which to save package tarball. Default is the parent directory of the package source directory.
#' @param install Logical value indicating if package should be installed after it is built. Default is TRUE. 
#' @param build_vignettes A logical value indicating whether or not to build PDF vignettes. Default is FALSE. 
#' @param increment_version If provided, bumps the package version using usethis::use_version(). 
#' Should be one of "major", "minor", "patch" or "dev". 
#' @return Path to the package tarball
#' @export
build_and_install_package = function(package_dir = getwd(), output_directory = NULL, 
  install = TRUE, build_vignettes = FALSE, increment_version = NULL){
  
  # Save path to current directory and then change into path for package
  current_dir = getwd()
  on.exit(setwd(current_dir))
  setwd(package_dir)
  
  # Check that allowed value provided for increment_version and that output_directory is the path to a directory
  match.arg(increment_version, choices = c("major", "minor", "patch", "dev"))
  if(!is.null(output_directory)){
    if(!dir.exists(output_directory)){stop("output_directory must be the path to a directory")}
  }
  
  # If increment_version is TRUE, increment version
  if(!is.null(increment_version)){usethis::use_version(which = increment_version)}
  
  # Build the package and save the path to its tarball
  package_tarball = devtools::build(pkg = package_dir, vignettes = build_vignettes, path = output_directory)
  
  # Install the package if specified and return the tarball
  if(install){devtools::install(package_tarball)}
  return(package_tarball)
  
}

#' Build vignettes for a package
#' 
#' @param package_dir Path to the package source directory. Default is the current directory. 
#' @export
build_vignettes = function(package_dir = getwd()){
  devtools::build_vignettes(package_dir)
}

#' Install a package from its tarball
#' 
#' @param package_tarball Path to a package tarball.
#' @export
install_package_tarball = function(package_tarball){
  system(paste("R CMD INSTALL", package_tarball))
}