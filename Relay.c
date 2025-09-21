void main() {
    ADCON1 = 0x06;        // Make all pins digital
    TRISD = 0xFF;         // PORTD all inputs (switches)
    TRISB = 0x00;         // PORTB all outputs (relay/LED)

    PORTD = 0x00;         // Clear PORTD
    PORTB = 0x00;         // Clear PORTB

    while(1) {
        // Button on RD0 = ON
        if(PORTD.F0 == 1) {
            Delay_ms(20);        // debounce
            if(PORTD.F0 == 1)    // confirm pressed
                PORTB.F0 = 1;    // Relay ON
        }

        // Button on RD1 = OFF
        if(PORTD.F1 == 1) {
            Delay_ms(20);        // debounce
            if(PORTD.F1 == 1)    // confirm pressed
                PORTB.F0 = 0;    // Relay OFF
        }
    }
}