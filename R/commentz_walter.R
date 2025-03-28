commentz_walter <- function(text, patterns) {
  library(stringr)
  
  build_ac_trie <- function(patterns) {
    trie <- list()
    fail <- list()
    output <- list()
    
    root <- "root"
    trie[[root]] <- list()
    
    for (pattern in patterns) {
      current <- root
      for (char in unlist(strsplit(pattern, ""))) {
        if (!(char %in% names(trie[[current]]))) {
          new_state <- paste0(current, char)
          trie[[current]][[char]] <- new_state
          trie[[new_state]] <- list()
        }
        current <- trie[[current]][[char]]
      }
      output[[current]] <- pattern
    }
    
    queue <- c()
    for (char in names(trie[[root]])) {
      fail[[trie[[root]][[char]]]] <- root
      queue <- c(queue, trie[[root]][[char]])
    }
    
    while (length(queue) > 0) {
      state <- queue[1]
      queue <- queue[-1]
      
      for (char in names(trie[[state]])) {
        next_state <- trie[[state]][[char]]
        queue <- c(queue, next_state)
        
        fail_state <- fail[[state]]
        while (fail_state != root && !(char %in% names(trie[[fail_state]]))) {
          fail_state <- fail[[fail_state]]
        }
        
        fail[[next_state]] <- ifelse(char %in% names(trie[[fail_state]]), trie[[fail_state]][[char]], root)
      }
    }
    
    list(trie = trie, fail = fail, output = output)
  }
  
  search <- function(text, ac_trie) {
    matches <- list()
    state <- "root"
    
    for (i in seq_along(unlist(strsplit(text, "")))) {
      char <- substr(text, i, i)
      while (state != "root" && !(char %in% names(ac_trie$trie[[state]]))) {
        state <- ac_trie$fail[[state]]
      }
      state <- ifelse(char %in% names(ac_trie$trie[[state]]), ac_trie$trie[[state]][[char]], "root")
      
      if (state %in% names(ac_trie$output)) {
        matches[[length(matches) + 1]] <- list(pattern = ac_trie$output[[state]], position = i - nchar(ac_trie$output[[state]]) + 1)
      }
    }
    
    matches
  }
  
  ac_trie <- build_ac_trie(patterns)
  search(text, ac_trie)
}