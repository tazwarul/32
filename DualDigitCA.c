char arr[] = {0x3F,0x06,0x5B,0x4F,0x66,0x6D,0x7D,0x07,0x7F,0x6F};  // 0-9 patterns

void main() {
    int i, start = 25, end = 70;   // user assigned range
    int right, left, j;

    TRISB = 0x00;   // PORTB as output (7-seg data lines)
    TRISC = 0x00;   // PORTC as output (digit select)

    PORTB = 0x00;
    PORTC = 0x00;

    for(i = start; i <= end; i++)   // loop from start to end
    {
        left = i / 10;    // tens digit
        right = i % 10;   // units digit

        // show current number for some time
        for(j = 0; j < 20; j++)    // multiplexing loop
        {
            // show left digit
            PORTB = arr[left];
            PORTC.F0 = 0;
            Delay_ms(10);
            PORTC.F0 = 1;

            // show right digit
            PORTB = arr[right];
            PORTC.F1 = 0;
            Delay_ms(10);
            PORTC.F1 = 1;
        }

        Delay_ms(500);  // <-- time interval between each number (0.5s)
    }

    while(1);  // stop after reaching 'end'
}
