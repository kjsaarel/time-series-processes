simulate_ar1 <- function(n = 150, phi = 0.9, seed = NULL, initial = 0) {
  stopifnot(length(n) == 1, n >= 2, n == as.integer(n))
  stopifnot(length(phi) == 1, is.finite(phi))
  stopifnot(length(initial) == 1, is.finite(initial))

  if (!is.null(seed)) {
    set.seed(seed)
  }

  innovations <- rnorm(n)
  values <- numeric(n)
  values[1] <- initial

  for (t in 2:n) {
    values[t] <- phi * values[t - 1] + innovations[t]
  }

  structure(
    list(values = values, innovations = innovations, phi = phi),
    class = "ar1_simulation"
  )
}

simulate_ma1 <- function(n = 100, theta = 0.5, seed = NULL) {
  stopifnot(length(n) == 1, n >= 1, n == as.integer(n))
  stopifnot(length(theta) == 1, is.finite(theta))

  if (!is.null(seed)) {
    set.seed(seed)
  }

  innovations <- rnorm(n + 1)
  values <- innovations[2:(n + 1)] + theta * innovations[1:n]

  structure(
    list(values = values, innovations = innovations, theta = theta),
    class = "ma1_simulation"
  )
}

plot_process_and_acf <- function(values, process_name, output_file) {
  png(output_file, width = 1200, height = 600, res = 120)
  on.exit(dev.off(), add = TRUE)

  old_par <- par(mfrow = c(1, 2), mar = c(4, 4, 3, 1))
  on.exit(par(old_par), add = TRUE)

  plot(
    values,
    type = "l",
    col = "#2563EB",
    lwd = 1.5,
    main = paste(process_name, "simulation"),
    xlab = "Time",
    ylab = "Value"
  )
  abline(h = 0, col = "grey70", lty = 2)

  acf(
    values,
    main = paste("ACF of", process_name),
    col = "#D97706"
  )
}
