#------------------------------------------------
#	8-bit pseudo-random number generator(LSFR)
#	-------------------------
#
#	@ Polynomial
#	P(x) = x^6 + x^5 + 1
#   taps: 6 5 1
#	
#	@ Seed
#   second lastname: VARGAS
#	=> V : 0x56 / b01000001
#	Memory position -> 0x100
#   
#   @ Byte positions
#   (MSB)          (LSB)
#   -> [1|2|3|4|5|6|7|8] ->
# 
#   by @estalvgs1999 v 20201-08-17
#------------------------------------------------

start:
    li a1,0x41          # [a1] <- 0x56 : lsfr_value 
    li a2,0x100         # [a2] <- 0x100 : mem_pos
    sw a1,0(a2)         # 0x56 -> M[0x100] 
    li a3,0x0           # [a3] <- 0x0 : counter
    li a4,0x64          # [a4] <- 0x64 : stop_count(100)


lsfr:
    srli t0,a1,0x2      # [t0] <- [lsfr_value] >> 2 (pos 6)
    srli t1,a1,0x3      # [t1] <- [lsfr_value] >> 3 (pos 5)
    xor t2,t1,t0        # [t2] <- [t1] ^ [t0] : [b6] xor [b5]
    andi t4,t2,0x1      # [t4] <- [t2] & 00000001 : just the xor resulting bit
    slli t4,t4,0x7      # [t4] <- [t4] << 7 : put in MSB position
    srli t5,a1,0x1      # [t5] <- [lsfr_value] >> 1 : descart LSB
    add a1,t5,t4        # [a1] <- [t5] + r_bit


check:
    addi a3,a3,0x1      # counter = counter + 1
    addi a2,a2,0x4      # mem_pos = mem_pos + 4
    sw a1,0(a2)         # [lsfr_value] -> M[mem_pos]
    blt a3,a4,lsfr      # counter < stop_count? -> lsfr
    j end               # else: go to end


end:
    nop                  # end algorithm