# Reproducibility repository for *A high-order fast direct solver for surface PDEs*

This repository contains the code and data required to reproduce all results from the paper:

- Daniel Fortunato, *A high-order fast direct solver for surface PDEs*, SIAM J. Sci. Comput. (2023).

Figures 5.1&ndash;5.10 in the paper contain numerical results and each figure has a corresponding folder in this repository.

## Requirements

- MATLAB R2021a or newer
- Gnuplot
- `epstopdf`

This repository uses git submodules. To initialize the submodules, either clone this repository with the `--recursive` flag or run `git submodule update --init --recursive` after cloning.

## Instructions

First, run the MATLAB script `setup.m` to add the required directories to your MATLAB path. To generate figure `X`, change to the `figureX` directory and run the MATLAB script `figureX.m`. The script may plot a figure in MATLAB and/or write data to a file `figureX.txt`. In the latter case, the data may be plotted by running `make` from the `figureX` directory in a terminal.
