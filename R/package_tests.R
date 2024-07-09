#' Check examples in a package
#' 
#' @param package Path to either a package source directory or a package tarball. Default is the current working directory.
#' @param start Which file to start running examples from. Default is to start from the first file in lexicographical order. 
#' @export
examples_check = function(package = getwd(), start = NULL){
  devtools::run_examples(package, start = start)
}

#' Run R CMD check on a package
#' 
#' @param package Path to either a package source directory or a package tarball. Default is the current working directory.
#' @return An object of class rcmdcheck.
#' @export
r_check = function(package){
  rcmdcheck::rcmdcheck(package)
}

#' Run BiocCheck on a package
#' 
#' @param package Path to either a package source directory or a package tarball. Default is the current working directory.
#' @return An object of class BiocCheck which consists of three lists: error, warning and note. 
#' @export
bioc_check = function(package = getwd(), checkDir){
  BiocCheck::BiocCheck(package = package)
}

#' Run BiocCheckGitClone on a package
#' 
#' @param package Path to a package source directory. Default is the current working directory.
#' @return An object of class BiocCheck which consists of three lists: error, warning and note. 
#' @export
bioc_git_check = function(package_dir = getwd()){
  BiocCheck::BiocCheckGitClone(package_dir)
}

#' Run package checks on a package
#' 
#' @param package_dir Path to a package source directory. Default is current working directory.
#' @param run_examples_check Logical value indicating whether to run devtools::examples_check(). Default is TRUE. 
#' @param run_r_check Logical value indicating whether to run R CMD check. Default is TRUE.
#' @param run_bioc_check Logical value indicating whether to run BiocCheck. Default is TRUE.
#' @param run_bioc_git_check Logical value indicating whether to run BiocCheckGitClone. Default is TRUE.
#' @return An list with the results from the specified checks. 
#' @export
package_check_pipeline = function(package_dir = getwd(), run_examples_check = TRUE, run_r_check = TRUE, 
  run_bioc_check = TRUE, run_bioc_git_check = TRUE){
  
  # Check that a path to a directory provided by package_dir
  if(!dir.exists(package_dir)){"package_dir should be the path to a package source directory"}
  
  # Initialize a list to store results of checks
  check_results = list()
  
  # Perform specified checks
  if(run_examples_check){check_results$examples_check = examples_check(package = package_dir)}
  if(run_r_check){check_results$r_check = r_check(package = package_dir)}
  if(run_bioc_check){check_results$bioc_check = bioc_check(package = package_dir)}
  if(run_bioc_git_check){check_results$bioc_git_check = bioc_git_check(package = package_dir)}
  
  # Return list with check results
  return(check_results)
  
}