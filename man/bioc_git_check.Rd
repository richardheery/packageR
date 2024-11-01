% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/package_tests.R
\name{bioc_git_check}
\alias{bioc_git_check}
\title{Run BiocCheckGitClone on a package}
\usage{
bioc_git_check(package_dir = getwd())
}
\arguments{
\item{package}{Path to a package source directory. Default is the current working directory.}
}
\value{
An object of class BiocCheck which consists of three lists: error, warning and note.
}
\description{
Run BiocCheckGitClone on a package
}
