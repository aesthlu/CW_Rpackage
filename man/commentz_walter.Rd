% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/commentz_walter.R
\name{commentz_walter}
\alias{commentz_walter}
\title{Commentz-Walter multiple pattern matching algorithm using R}
\usage{
commentz_walter(text, patterns)
}
\arguments{
\item{text}{A character string representing the main text.}

\item{patterns}{A character vector containing multiple patterns to search for.}
}
\value{
A list of integers indicating the starting positions of each match (1-based index).
}
\description{
Searches for all occurrences of multiple patterns in a given text using the Commentz-Walter algorithm, 
which combines Boyer-Moore-like heuristics for efficient searching.
}
