void MSDelay(unsigned char Time)
{
    unsigned char y,z;
    for(y=0;y<Time;y++)
        for(z=0;z<20;z++);
}

void main()
{
    TRISB = 0b00000000;  // All PORTC pins as output
    TRISD = 0b00000000;  // All PORTD pins as output

    while(1)
    {       //portd=row ,portb=column
        PORTD = 0b10000000; PORTB = 0b00000000; MSDelay(10);
        PORTD = 0b01000000; PORTB = 0b11111111; MSDelay(10);
        PORTD = 0b00100000; PORTB = 0b11111111; MSDelay(10);
        PORTD = 0b00010000; PORTB = 0b11011000; MSDelay(10);
        PORTD = 0b00001000; PORTB = 0b11011000; MSDelay(10);
        PORTD = 0b00000100; PORTB = 0b11111111; MSDelay(10);
        PORTD = 0b00000010; PORTB = 0b11111111; MSDelay(10);
        PORTD = 0b00000001; PORTB = 0b00000000; MSDelay(10);
    }
}
