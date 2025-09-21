char arrayca[] = { 0x40, 0x79, 0x24, 0x30, 0x19, 0x12, 0x02, 0x78, 0x00, 0x10 }; // 0-9 segment codes
int tens,ones;
void main() {
    int number = 0;  // 0-99 number

    // Set port directions
    TrisB = 0x00;   // PortB as output (data for 7-segment)
    TrisC = 0x00;   // PortC as output (digit select)
    TrisD = 0x03;   // PortD D0,D1 as input (buttons)

    // Initialize ports
    PortB = 0x00;
    PortC = 0x00;

    while (1) {
        // ---- Button 1 pressed ? increment number ----
        if (PortD.F0 == 1) {
            Delay_ms(150);   // Debounce
            if (PortD.F0 == 1) {
                number++;
                if (number > 99) number = 0;  // Wrap 0-99
            }
        }

        // ---- Button 2 pressed ? decrement number ----
        if (PortD.F1 == 1) {
            Delay_ms(150);   // Debounce
            if (PortD.F1 == 1) {
                number--;
                if (number < 0) number = 99; // Wrap 0-99
            }
        }

        // ---- Separate digits ----
        tens = number / 10;
        ones = number % 10;

        // ---- Display tens digit ----
        PortC.F0 = 1;         // Enable first 7-segment
        PortB = arrayca[tens];
        Delay_ms(5);
        PortC.F0 = 0;         // Disable first 7-segment

        // ---- Display ones digit ----
        PortC.F1 = 1;         // Enable second 7-segment
        PortB = arrayca[ones];
        Delay_ms(5);
        PortC.F1 = 0;         // Disable second 7-segment
    }
}
