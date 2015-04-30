
_Map:

;RotateMotorWithPWMDependingOnDS18b20TempSens.c,29 :: 		int Map(int Value, int FromLow, int FromHigh, int ToLow, int ToHigh ){
;RotateMotorWithPWMDependingOnDS18b20TempSens.c,30 :: 		if(Value<FromLow){
	MOVLW      128
	XORWF      FARG_Map_Value+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORWF      FARG_Map_FromLow+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Map13
	MOVF       FARG_Map_FromLow+0, 0
	SUBWF      FARG_Map_Value+0, 0
L__Map13:
	BTFSC      STATUS+0, 0
	GOTO       L_Map0
;RotateMotorWithPWMDependingOnDS18b20TempSens.c,31 :: 		Value = FromLow;
	MOVF       FARG_Map_FromLow+0, 0
	MOVWF      FARG_Map_Value+0
	MOVF       FARG_Map_FromLow+1, 0
	MOVWF      FARG_Map_Value+1
;RotateMotorWithPWMDependingOnDS18b20TempSens.c,32 :: 		}
L_Map0:
;RotateMotorWithPWMDependingOnDS18b20TempSens.c,33 :: 		if(Value>FromHigh){
	MOVLW      128
	XORWF      FARG_Map_FromHigh+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORWF      FARG_Map_Value+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Map14
	MOVF       FARG_Map_Value+0, 0
	SUBWF      FARG_Map_FromHigh+0, 0
L__Map14:
	BTFSC      STATUS+0, 0
	GOTO       L_Map1
;RotateMotorWithPWMDependingOnDS18b20TempSens.c,34 :: 		Value = FromHigh;
	MOVF       FARG_Map_FromHigh+0, 0
	MOVWF      FARG_Map_Value+0
	MOVF       FARG_Map_FromHigh+1, 0
	MOVWF      FARG_Map_Value+1
;RotateMotorWithPWMDependingOnDS18b20TempSens.c,35 :: 		}
L_Map1:
;RotateMotorWithPWMDependingOnDS18b20TempSens.c,36 :: 		return  (int)(((Value - FromLow) * (ToHigh - ToLow)) / (FromHigh - FromLow)) + ToLow;
	MOVF       FARG_Map_FromLow+0, 0
	SUBWF      FARG_Map_Value+0, 0
	MOVWF      R4+0
	MOVF       FARG_Map_FromLow+1, 0
	BTFSS      STATUS+0, 0
	ADDLW      1
	SUBWF      FARG_Map_Value+1, 0
	MOVWF      R4+1
	MOVF       FARG_Map_ToLow+0, 0
	SUBWF      FARG_Map_ToHigh+0, 0
	MOVWF      R0+0
	MOVF       FARG_Map_ToLow+1, 0
	BTFSS      STATUS+0, 0
	ADDLW      1
	SUBWF      FARG_Map_ToHigh+1, 0
	MOVWF      R0+1
	CALL       _Mul_16x16_U+0
	MOVF       FARG_Map_FromLow+0, 0
	SUBWF      FARG_Map_FromHigh+0, 0
	MOVWF      R4+0
	MOVF       FARG_Map_FromLow+1, 0
	BTFSS      STATUS+0, 0
	ADDLW      1
	SUBWF      FARG_Map_FromHigh+1, 0
	MOVWF      R4+1
	CALL       _Div_16x16_S+0
	MOVF       FARG_Map_ToLow+0, 0
	ADDWF      R0+0, 1
	MOVF       FARG_Map_ToLow+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 1
;RotateMotorWithPWMDependingOnDS18b20TempSens.c,37 :: 		}
L_end_Map:
	RETURN
; end of _Map

_Display_Temperature:

;RotateMotorWithPWMDependingOnDS18b20TempSens.c,39 :: 		void Display_Temperature(unsigned int temp2write) {
;RotateMotorWithPWMDependingOnDS18b20TempSens.c,45 :: 		if (temp2write & 0x8000) {
	BTFSS      FARG_Display_Temperature_temp2write+1, 7
	GOTO       L_Display_Temperature2
;RotateMotorWithPWMDependingOnDS18b20TempSens.c,46 :: 		text[0] = '-';
	MOVF       _text+0, 0
	MOVWF      FSR
	MOVLW      45
	MOVWF      INDF+0
;RotateMotorWithPWMDependingOnDS18b20TempSens.c,47 :: 		temp2write = ~temp2write + 1;
	COMF       FARG_Display_Temperature_temp2write+0, 1
	COMF       FARG_Display_Temperature_temp2write+1, 1
	INCF       FARG_Display_Temperature_temp2write+0, 1
	BTFSC      STATUS+0, 2
	INCF       FARG_Display_Temperature_temp2write+1, 1
;RotateMotorWithPWMDependingOnDS18b20TempSens.c,48 :: 		}
L_Display_Temperature2:
;RotateMotorWithPWMDependingOnDS18b20TempSens.c,51 :: 		temp_whole = temp2write >> 4 ;
	MOVF       FARG_Display_Temperature_temp2write+0, 0
	MOVWF      R0+0
	MOVF       FARG_Display_Temperature_temp2write+1, 0
	MOVWF      R0+1
	RRF        R0+1, 1
	RRF        R0+0, 1
	BCF        R0+1, 7
	RRF        R0+1, 1
	RRF        R0+0, 1
	BCF        R0+1, 7
	RRF        R0+1, 1
	RRF        R0+0, 1
	BCF        R0+1, 7
	RRF        R0+1, 1
	RRF        R0+0, 1
	BCF        R0+1, 7
	MOVF       R0+0, 0
	MOVWF      Display_Temperature_temp_whole_L0+0
;RotateMotorWithPWMDependingOnDS18b20TempSens.c,54 :: 		if (temp_whole/100)
	MOVLW      100
	MOVWF      R4+0
	CALL       _Div_8x8_U+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_Display_Temperature3
;RotateMotorWithPWMDependingOnDS18b20TempSens.c,55 :: 		text[0] = temp_whole/100  + 48;
	MOVF       _text+0, 0
	MOVWF      FLOC__Display_Temperature+0
	MOVLW      100
	MOVWF      R4+0
	MOVF       Display_Temperature_temp_whole_L0+0, 0
	MOVWF      R0+0
	CALL       _Div_8x8_U+0
	MOVLW      48
	ADDWF      R0+0, 1
	MOVF       FLOC__Display_Temperature+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
	GOTO       L_Display_Temperature4
L_Display_Temperature3:
;RotateMotorWithPWMDependingOnDS18b20TempSens.c,57 :: 		text[0] = '0';
	MOVF       _text+0, 0
	MOVWF      FSR
	MOVLW      48
	MOVWF      INDF+0
L_Display_Temperature4:
;RotateMotorWithPWMDependingOnDS18b20TempSens.c,59 :: 		text[1] = (temp_whole/10)%10 + 48;             // Extract tens digit
	INCF       _text+0, 0
	MOVWF      FLOC__Display_Temperature+0
	MOVLW      10
	MOVWF      R4+0
	MOVF       Display_Temperature_temp_whole_L0+0, 0
	MOVWF      R0+0
	CALL       _Div_8x8_U+0
	MOVLW      10
	MOVWF      R4+0
	CALL       _Div_8x8_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVLW      48
	ADDWF      R0+0, 1
	MOVF       FLOC__Display_Temperature+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;RotateMotorWithPWMDependingOnDS18b20TempSens.c,60 :: 		text[2] =  temp_whole%10     + 48;             // Extract ones digit
	MOVLW      2
	ADDWF      _text+0, 0
	MOVWF      FLOC__Display_Temperature+0
	MOVLW      10
	MOVWF      R4+0
	MOVF       Display_Temperature_temp_whole_L0+0, 0
	MOVWF      R0+0
	CALL       _Div_8x8_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVLW      48
	ADDWF      R0+0, 1
	MOVF       FLOC__Display_Temperature+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;RotateMotorWithPWMDependingOnDS18b20TempSens.c,63 :: 		temp_fraction  = temp2write;
	MOVF       FARG_Display_Temperature_temp2write+0, 0
	MOVWF      Display_Temperature_temp_fraction_L0+0
	MOVF       FARG_Display_Temperature_temp2write+1, 0
	MOVWF      Display_Temperature_temp_fraction_L0+1
;RotateMotorWithPWMDependingOnDS18b20TempSens.c,64 :: 		temp_fraction &= 0x000F;
	MOVLW      15
	ANDWF      FARG_Display_Temperature_temp2write+0, 0
	MOVWF      R0+0
	MOVF       FARG_Display_Temperature_temp2write+1, 0
	MOVWF      R0+1
	MOVLW      0
	ANDWF      R0+1, 1
	MOVF       R0+0, 0
	MOVWF      Display_Temperature_temp_fraction_L0+0
	MOVF       R0+1, 0
	MOVWF      Display_Temperature_temp_fraction_L0+1
;RotateMotorWithPWMDependingOnDS18b20TempSens.c,65 :: 		temp_fraction *= 625;
	MOVLW      113
	MOVWF      R4+0
	MOVLW      2
	MOVWF      R4+1
	CALL       _Mul_16x16_U+0
	MOVF       R0+0, 0
	MOVWF      Display_Temperature_temp_fraction_L0+0
	MOVF       R0+1, 0
	MOVWF      Display_Temperature_temp_fraction_L0+1
;RotateMotorWithPWMDependingOnDS18b20TempSens.c,68 :: 		text[4] =  temp_fraction/1000    + 48;         // Extract thousands digit
	MOVLW      4
	ADDWF      _text+0, 0
	MOVWF      FLOC__Display_Temperature+0
	MOVLW      232
	MOVWF      R4+0
	MOVLW      3
	MOVWF      R4+1
	CALL       _Div_16x16_U+0
	MOVLW      48
	ADDWF      R0+0, 1
	MOVF       FLOC__Display_Temperature+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;RotateMotorWithPWMDependingOnDS18b20TempSens.c,69 :: 		text[5] = (temp_fraction/100)%10 + 48;         // Extract hundreds digit
	MOVLW      5
	ADDWF      _text+0, 0
	MOVWF      FLOC__Display_Temperature+0
	MOVLW      100
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       Display_Temperature_temp_fraction_L0+0, 0
	MOVWF      R0+0
	MOVF       Display_Temperature_temp_fraction_L0+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_U+0
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16x16_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVLW      48
	ADDWF      R0+0, 1
	MOVF       FLOC__Display_Temperature+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;RotateMotorWithPWMDependingOnDS18b20TempSens.c,70 :: 		text[6] = (temp_fraction/10)%10  + 48;         // Extract tens digit
	MOVLW      6
	ADDWF      _text+0, 0
	MOVWF      FLOC__Display_Temperature+0
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       Display_Temperature_temp_fraction_L0+0, 0
	MOVWF      R0+0
	MOVF       Display_Temperature_temp_fraction_L0+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_U+0
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16x16_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVLW      48
	ADDWF      R0+0, 1
	MOVF       FLOC__Display_Temperature+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;RotateMotorWithPWMDependingOnDS18b20TempSens.c,71 :: 		text[7] =  temp_fraction%10      + 48;         // Extract ones digit
	MOVLW      7
	ADDWF      _text+0, 0
	MOVWF      FLOC__Display_Temperature+0
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       Display_Temperature_temp_fraction_L0+0, 0
	MOVWF      R0+0
	MOVF       Display_Temperature_temp_fraction_L0+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVLW      48
	ADDWF      R0+0, 1
	MOVF       FLOC__Display_Temperature+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;RotateMotorWithPWMDependingOnDS18b20TempSens.c,74 :: 		Lcd_Out(2, 5, text);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      5
	MOVWF      FARG_Lcd_Out_column+0
	MOVF       _text+0, 0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;RotateMotorWithPWMDependingOnDS18b20TempSens.c,76 :: 		pwm =    Map(temp_whole,0,150,0,255);
	MOVF       Display_Temperature_temp_whole_L0+0, 0
	MOVWF      FARG_Map_Value+0
	CLRF       FARG_Map_Value+1
	CLRF       FARG_Map_FromLow+0
	CLRF       FARG_Map_FromLow+1
	MOVLW      150
	MOVWF      FARG_Map_FromHigh+0
	CLRF       FARG_Map_FromHigh+1
	CLRF       FARG_Map_ToLow+0
	CLRF       FARG_Map_ToLow+1
	MOVLW      255
	MOVWF      FARG_Map_ToHigh+0
	CLRF       FARG_Map_ToHigh+1
	CALL       _Map+0
	MOVF       R0+0, 0
	MOVWF      _pwm+0
	MOVF       R0+1, 0
	MOVWF      _pwm+1
;RotateMotorWithPWMDependingOnDS18b20TempSens.c,77 :: 		PWM1_Set_Duty(pwm);
	MOVF       R0+0, 0
	MOVWF      FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;RotateMotorWithPWMDependingOnDS18b20TempSens.c,79 :: 		if(PORTD.F2 == 1){
	BTFSS      PORTD+0, 2
	GOTO       L_Display_Temperature5
;RotateMotorWithPWMDependingOnDS18b20TempSens.c,80 :: 		IntToStr(temp_whole,whole);
	MOVF       Display_Temperature_temp_whole_L0+0, 0
	MOVWF      FARG_IntToStr_input+0
	CLRF       FARG_IntToStr_input+1
	MOVF       _whole+0, 0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;RotateMotorWithPWMDependingOnDS18b20TempSens.c,81 :: 		IntToStr(temp_fraction,fr);
	MOVF       Display_Temperature_temp_fraction_L0+0, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       Display_Temperature_temp_fraction_L0+1, 0
	MOVWF      FARG_IntToStr_input+1
	MOVF       _fr+0, 0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;RotateMotorWithPWMDependingOnDS18b20TempSens.c,82 :: 		IntToStr(pwm,strPwm);
	MOVF       _pwm+0, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       _pwm+1, 0
	MOVWF      FARG_IntToStr_input+1
	MOVF       _strPwm+0, 0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;RotateMotorWithPWMDependingOnDS18b20TempSens.c,83 :: 		UART1_Write_Text("{\"temp\":\"");
	MOVLW      ?lstr5_RotateMotorWithPWMDependingOnDS18b20TempSens+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;RotateMotorWithPWMDependingOnDS18b20TempSens.c,84 :: 		UART1_Write_Text(whole);
	MOVF       _whole+0, 0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;RotateMotorWithPWMDependingOnDS18b20TempSens.c,85 :: 		UART1_Write_Text(".");
	MOVLW      ?lstr6_RotateMotorWithPWMDependingOnDS18b20TempSens+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;RotateMotorWithPWMDependingOnDS18b20TempSens.c,86 :: 		UART1_Write_Text(fr);
	MOVF       _fr+0, 0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;RotateMotorWithPWMDependingOnDS18b20TempSens.c,87 :: 		UART1_Write_Text("\",\"pwm\":\"");
	MOVLW      ?lstr7_RotateMotorWithPWMDependingOnDS18b20TempSens+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;RotateMotorWithPWMDependingOnDS18b20TempSens.c,88 :: 		UART1_Write_Text(strPwm);
	MOVF       _strPwm+0, 0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;RotateMotorWithPWMDependingOnDS18b20TempSens.c,89 :: 		UART1_Write_Text("\"}");
	MOVLW      ?lstr8_RotateMotorWithPWMDependingOnDS18b20TempSens+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;RotateMotorWithPWMDependingOnDS18b20TempSens.c,90 :: 		UART1_Write(10);
	MOVLW      10
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;RotateMotorWithPWMDependingOnDS18b20TempSens.c,91 :: 		UART1_Write(13);
	MOVLW      13
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;RotateMotorWithPWMDependingOnDS18b20TempSens.c,93 :: 		}
L_Display_Temperature5:
;RotateMotorWithPWMDependingOnDS18b20TempSens.c,94 :: 		}
L_end_Display_Temperature:
	RETURN
; end of _Display_Temperature

_main:

;RotateMotorWithPWMDependingOnDS18b20TempSens.c,96 :: 		void main() {
;RotateMotorWithPWMDependingOnDS18b20TempSens.c,97 :: 		ANSEL  = 0;                                    // Configure AN pins as digital I/O
	CLRF       ANSEL+0
;RotateMotorWithPWMDependingOnDS18b20TempSens.c,98 :: 		ANSELH = 0;
	CLRF       ANSELH+0
;RotateMotorWithPWMDependingOnDS18b20TempSens.c,99 :: 		C1ON_bit = 0;                                  // Disable comparators
	BCF        C1ON_bit+0, BitPos(C1ON_bit+0)
;RotateMotorWithPWMDependingOnDS18b20TempSens.c,100 :: 		C2ON_bit = 0;
	BCF        C2ON_bit+0, BitPos(C2ON_bit+0)
;RotateMotorWithPWMDependingOnDS18b20TempSens.c,101 :: 		TRISC = 0;
	CLRF       TRISC+0
;RotateMotorWithPWMDependingOnDS18b20TempSens.c,102 :: 		PORTC = 0;
	CLRF       PORTC+0
;RotateMotorWithPWMDependingOnDS18b20TempSens.c,103 :: 		TRISD = 0xFF;
	MOVLW      255
	MOVWF      TRISD+0
;RotateMotorWithPWMDependingOnDS18b20TempSens.c,104 :: 		PORTD = 0;
	CLRF       PORTD+0
;RotateMotorWithPWMDependingOnDS18b20TempSens.c,106 :: 		UART1_Init(9600);
	MOVLW      25
	MOVWF      SPBRG+0
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;RotateMotorWithPWMDependingOnDS18b20TempSens.c,107 :: 		Delay_ms(100);
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_main6:
	DECFSZ     R13+0, 1
	GOTO       L_main6
	DECFSZ     R12+0, 1
	GOTO       L_main6
	NOP
	NOP
;RotateMotorWithPWMDependingOnDS18b20TempSens.c,109 :: 		PWM1_Init(5000);
	BCF        T2CON+0, 0
	BCF        T2CON+0, 1
	MOVLW      199
	MOVWF      PR2+0
	CALL       _PWM1_Init+0
;RotateMotorWithPWMDependingOnDS18b20TempSens.c,110 :: 		PWM1_Start();
	CALL       _PWM1_Start+0
;RotateMotorWithPWMDependingOnDS18b20TempSens.c,111 :: 		PWM1_Set_Duty(0);
	CLRF       FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;RotateMotorWithPWMDependingOnDS18b20TempSens.c,113 :: 		Lcd_Init();                                    // Initialize LCD
	CALL       _Lcd_Init+0
;RotateMotorWithPWMDependingOnDS18b20TempSens.c,114 :: 		Lcd_Cmd(_LCD_CLEAR);                           // Clear LCD
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;RotateMotorWithPWMDependingOnDS18b20TempSens.c,115 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);                      // Turn cursor off
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;RotateMotorWithPWMDependingOnDS18b20TempSens.c,116 :: 		Lcd_Out(1, 1, " Temperature:   ");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr9_RotateMotorWithPWMDependingOnDS18b20TempSens+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;RotateMotorWithPWMDependingOnDS18b20TempSens.c,118 :: 		Lcd_Chr(2,13,223);                             // Different LCD displays have different char code for degree
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      13
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      223
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;RotateMotorWithPWMDependingOnDS18b20TempSens.c,121 :: 		Lcd_Chr(2,14,'C');
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      14
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      67
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;RotateMotorWithPWMDependingOnDS18b20TempSens.c,124 :: 		do {
L_main7:
;RotateMotorWithPWMDependingOnDS18b20TempSens.c,126 :: 		Ow_Reset(&PORTE, 2);                         // Onewire reset signal
	MOVLW      PORTE+0
	MOVWF      FARG_Ow_Reset_port+0
	MOVLW      2
	MOVWF      FARG_Ow_Reset_pin+0
	CALL       _Ow_Reset+0
;RotateMotorWithPWMDependingOnDS18b20TempSens.c,127 :: 		Ow_Write(&PORTE, 2, 0xCC);                   // Issue command SKIP_ROM
	MOVLW      PORTE+0
	MOVWF      FARG_Ow_Write_port+0
	MOVLW      2
	MOVWF      FARG_Ow_Write_pin+0
	MOVLW      204
	MOVWF      FARG_Ow_Write_data_+0
	CALL       _Ow_Write+0
;RotateMotorWithPWMDependingOnDS18b20TempSens.c,128 :: 		Ow_Write(&PORTE, 2, 0x44);                   // Issue command CONVERT_T
	MOVLW      PORTE+0
	MOVWF      FARG_Ow_Write_port+0
	MOVLW      2
	MOVWF      FARG_Ow_Write_pin+0
	MOVLW      68
	MOVWF      FARG_Ow_Write_data_+0
	CALL       _Ow_Write+0
;RotateMotorWithPWMDependingOnDS18b20TempSens.c,129 :: 		Delay_us(120);
	MOVLW      39
	MOVWF      R13+0
L_main10:
	DECFSZ     R13+0, 1
	GOTO       L_main10
	NOP
	NOP
;RotateMotorWithPWMDependingOnDS18b20TempSens.c,131 :: 		Ow_Reset(&PORTE, 2);
	MOVLW      PORTE+0
	MOVWF      FARG_Ow_Reset_port+0
	MOVLW      2
	MOVWF      FARG_Ow_Reset_pin+0
	CALL       _Ow_Reset+0
;RotateMotorWithPWMDependingOnDS18b20TempSens.c,132 :: 		Ow_Write(&PORTE, 2, 0xCC);                   // Issue command SKIP_ROM
	MOVLW      PORTE+0
	MOVWF      FARG_Ow_Write_port+0
	MOVLW      2
	MOVWF      FARG_Ow_Write_pin+0
	MOVLW      204
	MOVWF      FARG_Ow_Write_data_+0
	CALL       _Ow_Write+0
;RotateMotorWithPWMDependingOnDS18b20TempSens.c,133 :: 		Ow_Write(&PORTE, 2, 0xBE);                   // Issue command READ_SCRATCHPAD
	MOVLW      PORTE+0
	MOVWF      FARG_Ow_Write_port+0
	MOVLW      2
	MOVWF      FARG_Ow_Write_pin+0
	MOVLW      190
	MOVWF      FARG_Ow_Write_data_+0
	CALL       _Ow_Write+0
;RotateMotorWithPWMDependingOnDS18b20TempSens.c,135 :: 		temp =  Ow_Read(&PORTE, 2);
	MOVLW      PORTE+0
	MOVWF      FARG_Ow_Read_port+0
	MOVLW      2
	MOVWF      FARG_Ow_Read_pin+0
	CALL       _Ow_Read+0
	MOVF       R0+0, 0
	MOVWF      _temp+0
	CLRF       _temp+1
;RotateMotorWithPWMDependingOnDS18b20TempSens.c,136 :: 		temp = (Ow_Read(&PORTE, 2) << 8) + temp;
	MOVLW      PORTE+0
	MOVWF      FARG_Ow_Read_port+0
	MOVLW      2
	MOVWF      FARG_Ow_Read_pin+0
	CALL       _Ow_Read+0
	MOVF       R0+0, 0
	MOVWF      R2+1
	CLRF       R2+0
	MOVF       _temp+0, 0
	ADDWF      R2+0, 0
	MOVWF      R0+0
	MOVF       R2+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      _temp+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      _temp+0
	MOVF       R0+1, 0
	MOVWF      _temp+1
;RotateMotorWithPWMDependingOnDS18b20TempSens.c,139 :: 		Display_Temperature(temp);
	MOVF       R0+0, 0
	MOVWF      FARG_Display_Temperature_temp2write+0
	MOVF       R0+1, 0
	MOVWF      FARG_Display_Temperature_temp2write+1
	CALL       _Display_Temperature+0
;RotateMotorWithPWMDependingOnDS18b20TempSens.c,141 :: 		Delay_ms(500);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
	MOVWF      R13+0
L_main11:
	DECFSZ     R13+0, 1
	GOTO       L_main11
	DECFSZ     R12+0, 1
	GOTO       L_main11
	DECFSZ     R11+0, 1
	GOTO       L_main11
	NOP
	NOP
;RotateMotorWithPWMDependingOnDS18b20TempSens.c,142 :: 		} while (1);
	GOTO       L_main7
;RotateMotorWithPWMDependingOnDS18b20TempSens.c,143 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
