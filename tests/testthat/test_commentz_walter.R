library(testthat)
library(CWRpackage)

### RETURNS ###

test_that("return is a list",
          {
            text <- "abbabbajjkshers"
            patterns <- c("abba", "bjj", "jjk", "she", "her")
            result <- commentz_walter_cpp(text, patterns)
            expect_equal(is.list(result), TRUE)
          })

test_that("return has correct structure",
          {
            text <- "abbabbajjkshers"
            patterns <- c("abba", "bjj", "jjk", "she", "her")
            result <- commentz_walter_cpp(text, patterns)
            expect_true(all(sapply(result, function(x) "pattern" %in% names(x))))
            expect_true(all(sapply(result, function(x) "positions" %in% names(x))))
          })

### ERRORS ###

test_that("error when input is not a character vector",
          {
            expect_error(commentz_walter_cpp(123, c("abba", "bjj")))
            expect_error(commentz_walter_cpp("abbabbajjkshers", 123))
          })

test_that("error when input is empty",
          {
            expect_error(commentz_walter_cpp("", c("abba", "bjj")))
            expect_error(commentz_walter_cpp("abbabbajjkshers", character(0)))
          })

### MATCHING ###

test_that("correct matching of patterns",
          {
            text <- "abbabbabjjkshers"
            patterns <- c("abba", "bjj", "jjk", "she", "her")
            result <- commentz_walter_cpp(text, patterns)
            print("1")
            print(result)
            # Checking the match for 'abba'
            abba_positions <- sapply(result, function(x) ifelse(x$pattern == "abba", x$positions, NA))
            print(abba_positions)
            abba_positions <- abba_positions[!is.na(abba_positions)]
            expect_equal(abba_positions, c(1, 4))
            print(abba_positions)
            # Checking the match for 'bjj'
            bjj_positions <- sapply(result, function(x) ifelse(x$pattern == "bjj", x$positions, NA))
            bjj_positions <- bjj_positions[!is.na(bjj_positions)]
            expect_equal(bjj_positions, 8)
            print(bjj_positions)
          })

test_that("empty result for non-matching pattern",
          {
            text <- "abbabbajjkshers"
            patterns <- c("xyz", "qwerty")
            result <- commentz_walter_cpp(text, patterns)
            expect_equal(length(result), 0)
          })

### MATCHING ACCURACY ###

test_that("matching all positions for 'abba'",
          {
            text <- "abbabbabjjkshers"
            patterns <- c("abba")
            result <- commentz_walter_cpp(text, patterns)
            print("2")
            print(result)
            abba_positions <- sapply(result, function(x) ifelse(x$pattern == "abba", x$positions, NA))
            print(abba_positions[1])
            abba_positions <- abba_positions[!is.na(abba_positions)]
            print(abba_positions)
            expect_equal(abba_positions, c(1, 4))
          })

test_that("matching multiple patterns returns all results",
          {
            text <- "abbabbabjjkshers"
            patterns <- c("abba", "bjj", "jjk", "she", "her")
            result <- commentz_walter_cpp(text, patterns)
            
            # Should contain 'abba', 'bjj', 'jjk', 'she', 'her'
            expect_equal(length(result), 5)
            expect_true("abba" %in% sapply(result, function(x) x$pattern))
            expect_true("bjj" %in% sapply(result, function(x) x$pattern))
            expect_true("jjk" %in% sapply(result, function(x) x$pattern))
            expect_true("she" %in% sapply(result, function(x) x$pattern))
            expect_true("her" %in% sapply(result, function(x) x$pattern))
          })
