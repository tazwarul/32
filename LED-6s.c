void main() {
    TRISB = 0x00;
    PORTB = 0x00;
    while(1) {
    int i;
        for(i = 1000; i < 6000; i+=1000) {
            // LED ON
            PORTB.F0 = 1;  
            vdelay_ms(i);           // Turn ON LED at RB0
            // LED OFF
            PORTB.F0 = 0;             // Turn OFF LED
            vdelay_ms(6000- i);
        }
    }
}
