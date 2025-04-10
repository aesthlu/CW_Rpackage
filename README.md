# Academic project 

### Luc YAO, Léos COUTROT, Richard CHEAM

#### Evry Paris-Saclay University

### April 10, 2025

> [Package Presentation](#pp)

> [Quick Start](#qs)

> [Examples](#ex)

------------------------------------------------------------------------

<a id="pp"></a>

## Package Presentation

The `CW_Rpackage` R/Rcpp package is our own R/Rcpp packages as part of the **M2
Algorithmic courses in the Data Science master’s program at Université
d’Évry Paris-Saclay**.

This package provides implementations of various algorithmic strategies
in both R and Rcpp, including:

- **Naive pattern matching algorithm**
- **Aho-Corasick algorithm**: Multi-pattern matching algorithm 
- **Boyer-Moore**: Pattern matching algorithm induced with the bad character rule and the good suffixe rule

------------------------------------------------------------------------

<a id="qs"></a>

## Quick Start

### Prerequisites for Package Development

To develop and use the package, install the necessary dependencies:

``` r
install.packages(c("Rcpp", "RcppArmadillo", "devtools", "roxygen2", "testthat", "stringr"))
```

### Installing the Package from GitHub

To install the CW_Rpackage package, use:

``` r
devtools::install_github("aesthlu/CW_Rpackage")
```

Then, load the package:

``` r
library(CWRpackage)
```

------------------------------------------------------------------------

<a id="ex"></a>

## Examples

### Naive pattern matching algorithm 

``` r
n <- 1000
num_replacements <- 25
dictionary <- c("cats", "dogs", "car", "distance")
text <- create_long_string(n, num_replacements, dictionary)
naive_pattern_matching(text, "cats")
```

    ##  [1] 367 489 551


### Aho-Corasick algorithm

``` r
n <- 1000
num_replacements <- 25
dictionary <- c("cats", "dogs", "car", "distance")
text <- create_long_string(n, num_replacements, dictionary)

res <- aho_corasick(text, dictionary)
for (i in 1:length(res)) {
  cat("Pattern :", (res[[i]]$pattern), 
      "| Positions :", (res[[i]]$positions),"\n")
}
```

    ##  Pattern : cats | Positions : 79 171 404 482 707 796 946 
    ##  Pattern : car | Positions : 129 207 268 323 441 452 565 
    ##  Pattern : distance | Positions : 220 929 956 
    ##  Pattern : dogs | Positions : 260 277 506 585 609 658 715 964 


### Boyyer-Moore algorithm 

``` r
n <- 1000
num_replacements <- 25
dictionary <- c("cats", "dogs", "car", "distance")
text <- create_long_string(n, num_replacements, dictionary)

boyer_moore_search_Rcpp(text, "cat")
```

    ##  [1] 159 279 374 544 699 755 765 823 846 967
