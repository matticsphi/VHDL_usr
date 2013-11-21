wave refill.wfm clk reset get_diet give_diet get_cola give_cola refill_bins
clock clk 0 1
h reset
l get_diet
l get_cola
cycle
l reset
cycle
h get_diet
cycle 4
l get_diet
h get_cola
cycle 4
l get_cola
h reset
cycle
l reset
