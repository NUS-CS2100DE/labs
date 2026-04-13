.section .text
.globl _start

# Simple LED chaser for the teaching RISC-V CPU in this repo.
# MMIO:
#   0x2400 -> 16 LEDs
#
# Important CPU quirk:
# - No data hazard forwarding/stalls, so dependent instructions need spacing.
# - No control hazard flush, so taken branches/jumps have two delay slots.

_start:
    lui   x1, 0x2          # x1 = 0x00002000
    addi  x2, x0, 1        # x2 = current LED pattern
    lui   x3, 0x10         # x3 = 0x00010000, wrap threshold
    addi  x1, x1, 0x400    # x1 = 0x00002400 (LED MMIO)
    addi  x0, x0, 0        # hazard padding before first LED write

main:
    lui   x4, 0x80         # delay counter = 0x00080000
    sw    x2, 0(x1)        # drive LEDs
    addi  x0, x0, 0        # hazard padding before delay loop uses x4

delay:
    addi  x4, x4, -1
    addi  x0, x0, 0
    addi  x0, x0, 0
    bne   x4, x0, delay
    addi  x0, x0, 0        # branch delay slot 1
    addi  x0, x0, 0        # branch delay slot 2

    slli  x2, x2, 1
    addi  x0, x0, 0
    addi  x0, x0, 0
    bne   x2, x3, main
    addi  x0, x0, 0        # branch delay slot 1
    addi  x0, x0, 0        # branch delay slot 2

    addi  x2, x0, 1        # wrap back to LED0 after LED15
    jal   x0, main
    addi  x0, x0, 0        # jump delay slot 1
    addi  x0, x0, 0        # jump delay slot 2
