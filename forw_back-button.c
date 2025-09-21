char state=0;

void main(){
    trisB = 0x00;   // PORTB output
    trisD = 0xff;   // PORTD input
    portB = 0x00;   // Initialize

    while(1)
    {
        // Button 1 ? State 1
        if(portD.f0==1) {
            delay_ms(50);
            if(portD.f0==1) {
                state=1;
            }
            while(portD.f0==1); // wait for release
        }

        // Button 2 ? State 2
        if(portD.f1==1) {
            delay_ms(50);
            if(portD.f1==1) {
                state=2;
            }
            while(portD.f1==1);
        }

        // Button 3 (Stop) ? Reset state
        if(portD.f2==1) {
            delay_ms(50);
            if(portD.f2==1) {
                state=0;   // stop
            }
            while(portD.f2==1);
        }

        // Motor control
        if(state==1) {
            portB.f0=1;
            portB.f1=0;
            portB.f2=1;
        }
        else if(state==2) {
            portB.f0=0;
            portB.f1=1;
            portB.f2=1;
        }
        else {   // state == 0 (Stop)
            portB.f0=0;
            portB.f1=0;
            portB.f2=0;
        }
    }
}
