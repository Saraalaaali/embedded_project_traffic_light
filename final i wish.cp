#line 1 "C:/Users/DELL/OneDrive/Desktop/final i wish/code/final i wish.c"
char display1[]={0b00100011,0b00100010,0b00100001,0b00100000,0b00011001,0b00011000,0b00010111,0b00010110,0b00010101,0b00010100
,0b00010011,0b00010010,0b00010001,0b00010000,0b00001001,0b00001000,0b00000111,0b00000110,0b00000101,0b00000100,0b00000011
,0b00000010,0b00000001,0b00000000};
char display2[]={0b00010101,0b00010100,0b00010011,0b00010010,0b00010001,0b00010000,0b00001001,0b00001000,0b00000111,0b00000110,
0b00000101,0b00000100,0b00000011,0b00000010,0b00000001,0b00000000};
char i=0;
char j=0;
char x=3;
char y=3;
char cnt=0;
void interrupt()
{
if(intf_bit==1)
{
intf_bit=0;
cnt++;
}
}
void main() {
trisc=0;trisd=0;trisa=0;trise=0;trisb.b0=1;trisb.b1=1;
 adcon1=7;
 gie_bit=1;
 inte_bit=1;
 intedg_bit=0;
 for(;;){
 portc=0;portd=0;porta=0;portb=0;porte=0;
 while(portb.b1==0){
 for(i=0;i<=23;i++){
 if(portb.b1==1) break;
 portc=display1[i];
 portd=display1[i+3];
 porta=0b000001;
 porte=0b100;
 delay_ms(1000);
 if(portd==0){
 while(i<=23){
 portc=display1[i];
 portd=display1[i];
 porta=0b000001;
 porte=0b010;
 delay_ms(1000);
 i++;
 }
 }
 }
 for(j=0;j<=15;j++){
 if(portb.b1==1)break;
 portc=display2[j+3];
 portd=display2[j];
 porta=0b000100;
 porte=0b001;
 delay_ms(1000);
 if(portc==0){
 while(j<=15){
 portc=display2[j];
 portd=display2[j];
 porta=0b000010;
 porte=0b001;
 delay_ms(1000);
 j++;
 }
 }
 }
 }
 while(portb.b1==1){
 if(cnt==1){
 portd=0;
 portc=0;
 porta=0b000001;
 porte=0b100;

 }
 if(cnt==2){
 for(x=3;x>=0;x--){
 if(x==0){x=3;cnt=3;break;}
 porta=0b000001;
 porte=0b010;
 portd=x;
 delay_ms(1000);
 }
 }
 if(cnt==3){
 portd=0;
 portc=0;
 porta=0b000100;
 porte=0b001;
 }
 if(cnt==4){
 for(y=3;y>=0;y--){
 if(y==0){ y=3;break;}
 porta=0b000010;
 porte=0b001;
 portc=y;
 delay_ms(1000);
 cnt=1;
 }
 }
 }

 }
 }
