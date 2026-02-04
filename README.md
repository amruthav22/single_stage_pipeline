# single_stage_pipeline
This module implements a 1-deep elastic buffer (single-entry FIFO) using a valid-ready handshake. Backpressure is handled by gating updates on in_ready, allowing lossless transfer and full throughput (one beat per cycle)
## Simulation

EDA Playground link to run the design and testbench:

👉 https://www.edaplayground.com/x/umMU
