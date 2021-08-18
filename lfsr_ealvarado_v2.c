# include <stdint.h>
# include <stdio.h>

void lfsr_fibonacci(void) {
    
    uint8_t seed_value = 0x56;  
    uint8_t lfsr_value = seed_value;
    uint8_t bit;  //Must be 8-bit to allow bit<<7 later in the code
    int counter = 0;

    do
    {   // taps: 6 4; feedback polynomial: x^6 + x^5 + 1 
        bit = ((lfsr_value >> 2) ^ (lfsr_value >> 3)) & 1;
        lfsr_value = (lfsr_value >> 1) | (bit << 7);
        counter++;
    }
    while (counter < 100);
    
    printf("result -> %d\n",lfsr_value);
}

int main()
{
    lfsr_fibonacci();
    return 0;
}