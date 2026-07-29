args <- commandArgs(trailingOnly = FALSE)
file_arg <- sub("^--file=", "", args[grepl("^--file=", args)])
test_dir <- if (length(file_arg)) dirname(normalizePath(file_arg)) else getwd()
project_dir <- normalizePath(file.path(test_dir, ".."))

source(file.path(project_dir, "R", "simulate_processes.R"))

ar1_a <- simulate_ar1(n = 150, phi = 0.9, seed = 12)
ar1_b <- simulate_ar1(n = 150, phi = 0.9, seed = 12)
stopifnot(length(ar1_a$values) == 150)
stopifnot(identical(ar1_a$values, ar1_b$values))
stopifnot(ar1_a$values[1] == 0)

ma1_a <- simulate_ma1(n = 100, theta = 0.5, seed = 123)
ma1_b <- simulate_ma1(n = 100, theta = 0.5, seed = 123)
stopifnot(length(ma1_a$values) == 100)
stopifnot(identical(ma1_a$values, ma1_b$values))

message("All simulation checks passed.")
