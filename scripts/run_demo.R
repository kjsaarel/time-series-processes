args <- commandArgs(trailingOnly = FALSE)
file_arg <- sub("^--file=", "", args[grepl("^--file=", args)])
script_dir <- if (length(file_arg)) dirname(normalizePath(file_arg)) else getwd()
project_dir <- normalizePath(file.path(script_dir, ".."))

source(file.path(project_dir, "R", "simulate_processes.R"))

output_dir <- file.path(project_dir, "output")
dir.create(output_dir, showWarnings = FALSE, recursive = TRUE)

ar1 <- simulate_ar1(n = 150, phi = 0.9, seed = 12)
ma1 <- simulate_ma1(n = 100, theta = 0.5, seed = 123)

plot_process_and_acf(
  ar1$values,
  "AR(1)",
  file.path(output_dir, "ar1_simulation.png")
)

plot_process_and_acf(
  ma1$values,
  "MA(1)",
  file.path(output_dir, "ma1_simulation.png")
)

write.csv(
  data.frame(time = seq_along(ar1$values), value = ar1$values),
  file.path(output_dir, "ar1_data.csv"),
  row.names = FALSE
)

write.csv(
  data.frame(time = seq_along(ma1$values), value = ma1$values),
  file.path(output_dir, "ma1_data.csv"),
  row.names = FALSE
)

message("Created plots and data files in: ", output_dir)
