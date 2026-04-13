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
    nop
    nop
    nop
    addi  x1, x1, 0x400    # x1 = 0x00002400 (LED MMIO)
    addi  x0, x0, 0        # hazard padding before first LED write
    nop
    nop
    nop

loop:
    lui   x4, 0x80         # delay counter = 0x00080000
    nop
    nop
    nop
    sw    x2, 0(x1)        # drive LEDs
    nop
    nop
    nop
    addi  x0, x0, 0        # hazard padding before delay loop uses x4
    nop
    nop
    nop
    slli  x2, x2, 1
    nop
    nop
    nop
    bne   x2, x3, loop
    nop
    nop
    nop
    nop
    addi  x2, x0, 1        # wrap back to LED0 after LED15
    nop
    nop
    nop
    j main
    nop
    nop
    nop