# AR(1) and MA(1) simulations in R

A small base-R project for simulating two foundational stationary time-series
models and examining their autocorrelation functions.

## Models

The AR(1) process is

```text
y[t] = phi * y[t - 1] + epsilon[t]
```

The MA(1) process is

```text
y[t] = epsilon[t] + theta * epsilon[t - 1]
```

The defaults reproduce the parameters and random seeds from the two original
scripts:

- AR(1): `n = 150`, `phi = 0.9`, `seed = 12`
- MA(1): `n = 100`, `theta = 0.5`, `seed = 123`

## Project structure

```text
time-series-processes/
├── R/
│   └── simulate_processes.R
├── scripts/
│   └── run_demo.R
├── tests/
│   └── test_simulations.R
├── output/
└── README.md
```

## Run the demo

From the project directory:

```bash
Rscript scripts/run_demo.R
```

This creates a plot and CSV dataset for each process under `output/`.

## Run the checks

```bash
Rscript tests/test_simulations.R
```

## Try other parameters

Open R from the project directory and run:

```r
source("R/simulate_processes.R")

ar1 <- simulate_ar1(n = 300, phi = 0.6, seed = 42)
ma1 <- simulate_ma1(n = 300, theta = -0.4, seed = 42)

plot(ar1$values, type = "l")
acf(ma1$values)
```

For a stationary AR(1) model, use `abs(phi) < 1`. Values near `1` produce
highly persistent series. For an invertible MA(1) model, the conventional
parameter range is `abs(theta) < 1`.
