.section 
.text
.globl _start
.text
.globl main

# Simple LED chaser for the teaching RISC-V CPU in this repo.
# MMIO:
# - No data hazard forwarding/stalls, so dependent instructions need spacing.
# - No control hazard flush, so taken branches/jumps have two delay slots.

_start:
main:
    lui   x1, 0x2          # x1 = 0x00002000
    addi  x2, x0, 1        # x2 = current LED pattern
    lui   x3, 0x10         # x3 = 0x00010000, wrap threshold
    addi  x1, x1, 0x400    # x1 = 0x00002400 (LED MMIO)
    addi  x0, x0, 0        # hazard padding before first LED write
loop:
    lui   x4, 0x80         # delay counter = 0x00080000
    j delay

start_of_actual_loop:
    sw    x2, 0(x1)        # drive LEDs
    addi  x0, x0, 0        # hazard padding before delay loop uses x4
    slli  x2, x2, 1
    bne   x2, x3, loop
    addi  x2, x0, 1        # wrap back to LED0 after LED15
    j main
    
delay:
     addi x4, x4, -1
     bne x4,x0, delay
     j start_of_actual_loop
