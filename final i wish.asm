
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;final i wish.c,11 :: 		void interrupt()
;final i wish.c,13 :: 		if(intf_bit==1)
	BTFSS      INTF_bit+0, BitPos(INTF_bit+0)
	GOTO       L_interrupt0
;final i wish.c,15 :: 		intf_bit=0;
	BCF        INTF_bit+0, BitPos(INTF_bit+0)
;final i wish.c,16 :: 		cnt++;
	INCF       _cnt+0, 1
;final i wish.c,17 :: 		}
L_interrupt0:
;final i wish.c,18 :: 		}
L_end_interrupt:
L__interrupt41:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;final i wish.c,19 :: 		void main() {
;final i wish.c,20 :: 		trisc=0;trisd=0;trisa=0;trise=0;trisb.b0=1;trisb.b1=1;
	CLRF       TRISC+0
	CLRF       TRISD+0
	CLRF       TRISA+0
	CLRF       TRISE+0
	BSF        TRISB+0, 0
	BSF        TRISB+0, 1
;final i wish.c,21 :: 		adcon1=7;
	MOVLW      7
	MOVWF      ADCON1+0
;final i wish.c,22 :: 		gie_bit=1;
	BSF        GIE_bit+0, BitPos(GIE_bit+0)
;final i wish.c,23 :: 		inte_bit=1;
	BSF        INTE_bit+0, BitPos(INTE_bit+0)
;final i wish.c,24 :: 		intedg_bit=0;
	BCF        INTEDG_bit+0, BitPos(INTEDG_bit+0)
;final i wish.c,25 :: 		for(;;){
L_main1:
;final i wish.c,26 :: 		portc=0;portd=0;porta=0;portb=0;porte=0;
	CLRF       PORTC+0
	CLRF       PORTD+0
	CLRF       PORTA+0
	CLRF       PORTB+0
	CLRF       PORTE+0
;final i wish.c,27 :: 		while(portb.b1==0){
L_main4:
	BTFSC      PORTB+0, 1
	GOTO       L_main5
;final i wish.c,28 :: 		for(i=0;i<=23;i++){
	CLRF       _i+0
L_main6:
	MOVF       _i+0, 0
	SUBLW      23
	BTFSS      STATUS+0, 0
	GOTO       L_main7
;final i wish.c,29 :: 		if(portb.b1==1) break;
	BTFSS      PORTB+0, 1
	GOTO       L_main9
	GOTO       L_main7
L_main9:
;final i wish.c,30 :: 		portc=display1[i];
	MOVF       _i+0, 0
	ADDLW      _display1+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;final i wish.c,31 :: 		portd=display1[i+3];
	MOVLW      3
	ADDWF      _i+0, 0
	MOVWF      R0+0
	CLRF       R0+1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	MOVF       R0+0, 0
	ADDLW      _display1+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTD+0
;final i wish.c,32 :: 		porta=0b000001;
	MOVLW      1
	MOVWF      PORTA+0
;final i wish.c,33 :: 		porte=0b100;
	MOVLW      4
	MOVWF      PORTE+0
;final i wish.c,34 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main10:
	DECFSZ     R13+0, 1
	GOTO       L_main10
	DECFSZ     R12+0, 1
	GOTO       L_main10
	DECFSZ     R11+0, 1
	GOTO       L_main10
	NOP
	NOP
;final i wish.c,35 :: 		if(portd==0){
	MOVF       PORTD+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_main11
;final i wish.c,36 :: 		while(i<=23){
L_main12:
	MOVF       _i+0, 0
	SUBLW      23
	BTFSS      STATUS+0, 0
	GOTO       L_main13
;final i wish.c,37 :: 		portc=display1[i];
	MOVF       _i+0, 0
	ADDLW      _display1+0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;final i wish.c,38 :: 		portd=display1[i];
	MOVF       R0+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTD+0
;final i wish.c,39 :: 		porta=0b000001;
	MOVLW      1
	MOVWF      PORTA+0
;final i wish.c,40 :: 		porte=0b010;
	MOVLW      2
	MOVWF      PORTE+0
;final i wish.c,41 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main14:
	DECFSZ     R13+0, 1
	GOTO       L_main14
	DECFSZ     R12+0, 1
	GOTO       L_main14
	DECFSZ     R11+0, 1
	GOTO       L_main14
	NOP
	NOP
;final i wish.c,42 :: 		i++;
	INCF       _i+0, 1
;final i wish.c,43 :: 		}
	GOTO       L_main12
L_main13:
;final i wish.c,44 :: 		}
L_main11:
;final i wish.c,28 :: 		for(i=0;i<=23;i++){
	INCF       _i+0, 1
;final i wish.c,45 :: 		}
	GOTO       L_main6
L_main7:
;final i wish.c,46 :: 		for(j=0;j<=15;j++){
	CLRF       _j+0
L_main15:
	MOVF       _j+0, 0
	SUBLW      15
	BTFSS      STATUS+0, 0
	GOTO       L_main16
;final i wish.c,47 :: 		if(portb.b1==1)break;
	BTFSS      PORTB+0, 1
	GOTO       L_main18
	GOTO       L_main16
L_main18:
;final i wish.c,48 :: 		portc=display2[j+3];
	MOVLW      3
	ADDWF      _j+0, 0
	MOVWF      R0+0
	CLRF       R0+1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	MOVF       R0+0, 0
	ADDLW      _display2+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;final i wish.c,49 :: 		portd=display2[j];
	MOVF       _j+0, 0
	ADDLW      _display2+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTD+0
;final i wish.c,50 :: 		porta=0b000100;
	MOVLW      4
	MOVWF      PORTA+0
;final i wish.c,51 :: 		porte=0b001;
	MOVLW      1
	MOVWF      PORTE+0
;final i wish.c,52 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main19:
	DECFSZ     R13+0, 1
	GOTO       L_main19
	DECFSZ     R12+0, 1
	GOTO       L_main19
	DECFSZ     R11+0, 1
	GOTO       L_main19
	NOP
	NOP
;final i wish.c,53 :: 		if(portc==0){
	MOVF       PORTC+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_main20
;final i wish.c,54 :: 		while(j<=15){
L_main21:
	MOVF       _j+0, 0
	SUBLW      15
	BTFSS      STATUS+0, 0
	GOTO       L_main22
;final i wish.c,55 :: 		portc=display2[j];
	MOVF       _j+0, 0
	ADDLW      _display2+0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;final i wish.c,56 :: 		portd=display2[j];
	MOVF       R0+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTD+0
;final i wish.c,57 :: 		porta=0b000010;
	MOVLW      2
	MOVWF      PORTA+0
;final i wish.c,58 :: 		porte=0b001;
	MOVLW      1
	MOVWF      PORTE+0
;final i wish.c,59 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main23:
	DECFSZ     R13+0, 1
	GOTO       L_main23
	DECFSZ     R12+0, 1
	GOTO       L_main23
	DECFSZ     R11+0, 1
	GOTO       L_main23
	NOP
	NOP
;final i wish.c,60 :: 		j++;
	INCF       _j+0, 1
;final i wish.c,61 :: 		}
	GOTO       L_main21
L_main22:
;final i wish.c,62 :: 		}
L_main20:
;final i wish.c,46 :: 		for(j=0;j<=15;j++){
	INCF       _j+0, 1
;final i wish.c,63 :: 		}
	GOTO       L_main15
L_main16:
;final i wish.c,64 :: 		}
	GOTO       L_main4
L_main5:
;final i wish.c,65 :: 		while(portb.b1==1){
L_main24:
	BTFSS      PORTB+0, 1
	GOTO       L_main25
;final i wish.c,66 :: 		if(cnt==1){
	MOVF       _cnt+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main26
;final i wish.c,67 :: 		portd=0;
	CLRF       PORTD+0
;final i wish.c,68 :: 		portc=0;
	CLRF       PORTC+0
;final i wish.c,69 :: 		porta=0b000001;
	MOVLW      1
	MOVWF      PORTA+0
;final i wish.c,70 :: 		porte=0b100;
	MOVLW      4
	MOVWF      PORTE+0
;final i wish.c,72 :: 		}
L_main26:
;final i wish.c,73 :: 		if(cnt==2){
	MOVF       _cnt+0, 0
	XORLW      2
	BTFSS      STATUS+0, 2
	GOTO       L_main27
;final i wish.c,74 :: 		for(x=3;x>=0;x--){
	MOVLW      3
	MOVWF      _x+0
L_main28:
	MOVLW      0
	SUBWF      _x+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_main29
;final i wish.c,75 :: 		if(x==0){x=3;cnt=3;break;}
	MOVF       _x+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_main31
	MOVLW      3
	MOVWF      _x+0
	MOVLW      3
	MOVWF      _cnt+0
	GOTO       L_main29
L_main31:
;final i wish.c,76 :: 		porta=0b000001;
	MOVLW      1
	MOVWF      PORTA+0
;final i wish.c,77 :: 		porte=0b010;
	MOVLW      2
	MOVWF      PORTE+0
;final i wish.c,78 :: 		portd=x;
	MOVF       _x+0, 0
	MOVWF      PORTD+0
;final i wish.c,79 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main32:
	DECFSZ     R13+0, 1
	GOTO       L_main32
	DECFSZ     R12+0, 1
	GOTO       L_main32
	DECFSZ     R11+0, 1
	GOTO       L_main32
	NOP
	NOP
;final i wish.c,74 :: 		for(x=3;x>=0;x--){
	DECF       _x+0, 1
;final i wish.c,80 :: 		}
	GOTO       L_main28
L_main29:
;final i wish.c,81 :: 		}
L_main27:
;final i wish.c,82 :: 		if(cnt==3){
	MOVF       _cnt+0, 0
	XORLW      3
	BTFSS      STATUS+0, 2
	GOTO       L_main33
;final i wish.c,83 :: 		portd=0;
	CLRF       PORTD+0
;final i wish.c,84 :: 		portc=0;
	CLRF       PORTC+0
;final i wish.c,85 :: 		porta=0b000100;
	MOVLW      4
	MOVWF      PORTA+0
;final i wish.c,86 :: 		porte=0b001;
	MOVLW      1
	MOVWF      PORTE+0
;final i wish.c,87 :: 		}
L_main33:
;final i wish.c,88 :: 		if(cnt==4){
	MOVF       _cnt+0, 0
	XORLW      4
	BTFSS      STATUS+0, 2
	GOTO       L_main34
;final i wish.c,89 :: 		for(y=3;y>=0;y--){
	MOVLW      3
	MOVWF      _y+0
L_main35:
	MOVLW      0
	SUBWF      _y+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_main36
;final i wish.c,90 :: 		if(y==0){ y=3;break;}
	MOVF       _y+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_main38
	MOVLW      3
	MOVWF      _y+0
	GOTO       L_main36
L_main38:
;final i wish.c,91 :: 		porta=0b000010;
	MOVLW      2
	MOVWF      PORTA+0
;final i wish.c,92 :: 		porte=0b001;
	MOVLW      1
	MOVWF      PORTE+0
;final i wish.c,93 :: 		portc=y;
	MOVF       _y+0, 0
	MOVWF      PORTC+0
;final i wish.c,94 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main39:
	DECFSZ     R13+0, 1
	GOTO       L_main39
	DECFSZ     R12+0, 1
	GOTO       L_main39
	DECFSZ     R11+0, 1
	GOTO       L_main39
	NOP
	NOP
;final i wish.c,95 :: 		cnt=1;
	MOVLW      1
	MOVWF      _cnt+0
;final i wish.c,89 :: 		for(y=3;y>=0;y--){
	DECF       _y+0, 1
;final i wish.c,96 :: 		}
	GOTO       L_main35
L_main36:
;final i wish.c,97 :: 		}
L_main34:
;final i wish.c,98 :: 		}
	GOTO       L_main24
L_main25:
;final i wish.c,100 :: 		}
	GOTO       L_main1
;final i wish.c,101 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
