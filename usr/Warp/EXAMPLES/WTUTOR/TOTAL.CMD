restart
vector total total_[4:0]
vector entered count1_[4:0]
vector exited count2_[4:0]
stepsize 100ns
wave total.wfm reset car_enter car_exit total entered exited lot_empty lot_full
 
h reset
cycle 

l reset car_exit car_enter 
cycle  

clock car_enter 1 0
cycle 33

h reset
l car_enter
cycle 
l reset car_enter
cycle 

h car_enter
cycle

l car_enter
cycle

l car_enter
h car_exit
cycle

l car_enter car_exit
cycle

l car_enter
cycle


