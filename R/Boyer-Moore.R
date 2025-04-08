
bad_character_heuristic <- function(pattern) {
  m <- nchar(pattern)
  badChar <- rep(-1, 256)
  pat_vec <- strsplit(pattern, "")[[1]]
  
  for (i in seq_len(m)) {
    badChar[as.integer(charToRaw(pat_vec[i])) + 1] <- i - 1
  }
  
  badChar
}

# Fonction pour la good suffix heuristic (corrigée)
good_suffix_heuristic <- function(pattern) {
  m <- nchar(pattern)
  goodSuffix <- rep(m, m)
  suffix <- rep(0, m)
  pat_vec <- strsplit(pattern, "")[[1]]
  
  # Calcul des suffixes
  suffix[m] <- m
  g <- m
  for (i in (m-1):1) {
    if (i > g && suffix[i + m - g] < i - g) {
      suffix[i] <- suffix[i + m - g]
    } else {
      g <- min(g, i)
      f <- i
      while (g >= 1 && pat_vec[g] == pat_vec[g + m - f]) {
        g <- g - 1
      }
      suffix[i] <- f - g
    }
  }
  
  # Calcul du good suffix shift
  for (i in 1:m) {
    goodSuffix[i] <- m
  }
  
  j <- 0
  for (i in m:1) {
    if (i == 1 || suffix[i-1] == i-1) {
      while (j < m - (i - 1)) {
        if (goodSuffix[j + 1] == m) {
          goodSuffix[j + 1] <- m - (i - 1)
        }
        j <- j + 1
      }
    }
  }
  
  for (i in 1:(m-1)) {
    goodSuffix[m - suffix[i] + 1] <- m - i
  }
  
  list(goodSuffix = goodSuffix)
}

#' Boyer-Moore pattern matching algorithm using R
#'
#' @description Searches for all occurrences of the pattern in a given text using the Boyer-Moore algorithm.
#' @param text A character string representing the main text.
#' @param pattern A character vector containing a single patterns to search for.
#' @return A list of integers indicating the starting positions of each match (1-based index).

boyer_moore_search_R <- function(text, pattern) {
  n <- nchar(text)
  m <- nchar(pattern)
  if (m == 0 || n < m) return(integer(0))
  
  text_vec <- strsplit(text, "")[[1]]
  pat_vec <- strsplit(pattern, "")[[1]]
  
  badChar <- bad_character_heuristic(pattern)
  gs_data <- good_suffix_heuristic(pattern)
  goodSuffix <- gs_data$goodSuffix
  
  result <- integer(0)
  s <- 0
  
  while (s <= n - m) {
    j <- m
    while (j >= 1 && pat_vec[j] == text_vec[s + j]) {
      j <- j - 1
    }
    
    if (j == 0) {
      result <- c(result, s + 1) # Match trouvé
      s <- s + goodSuffix[1]     # ici [1], pas [0]
    } else {
      bc_shift <- j - 1 - badChar[as.integer(charToRaw(text_vec[s + j])) + 1]
      gs_shift <- goodSuffix[j]
      s <- s + max(1, max(bc_shift, gs_shift))
    }
  }
  
  result
}
