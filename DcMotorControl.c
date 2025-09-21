sbit LCD_RS at RB0_bit;
sbit LCD_EN at RB1_bit;
sbit LCD_D4 at RB2_bit;
sbit LCD_D5 at RB3_bit;
sbit LCD_D6 at RB4_bit;
sbit LCD_D7 at RB5_bit;

sbit LCD_RS_Direction at TRISB0_bit;
sbit LCD_EN_Direction at TRISB1_bit;
sbit LCD_D4_Direction at TRISB2_bit;
sbit LCD_D5_Direction at TRISB3_bit;
sbit LCD_D6_Direction at TRISB4_bit;
sbit LCD_D7_Direction at TRISB5_bit;

char display[16] = "";
void main() {
             unsigned int result;
             unsigned short duty;
             float volt, temp;
             trisb = 0;
             trisa = 1;
             trisc.f2 = 0;
             lcd_init();
             lcd_cmd(_lcd_clear);
             lcd_cmd(_lcd_cursor_off);

             //run the motor
             duty = 0;
             portb.f6 = 1;
             portb.f7 = 0;

             PWM1_Init(1000);
             PWM1_Start();
             PWM1_Set_Duty(duty);
             while(1)
             {
              result = adc_read(0);
              volt = result*4.88;
              temp = volt/10;

              lcd_out(1,1,"Temp = ");
              floattostr(temp,display);
              lcd_out_cp(display);
              lcd_chr(1,16,223);  //223 = degree sign
              lcd_out_cp(" C");

              if(temp > 20 && duty <=240){
                 Delay_ms(3000);
                 if(temp > 20 && duty <=240){
                    duty += 10;
                    PWM1_Set_Duty(duty);
                 }
              }
              if(temp < 20 && duty >= 10){
                 Delay_ms(3000);
                 if(temp < 20 && duty >= 10){
                    duty -= 10;
                    PWM1_Set_Duty(duty);
                 }
              }

             }
}