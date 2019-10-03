#define F_CPU 16000000UL

#include <avr/io.h>
#include <util/delay.h>
#include "uart.h"
#include "pwm.h"

void move(char x)
{
	if(x=='F')
	{
		PORTA=0x0A; //forward move
		
	}
	else if(x=='B')
	{
		PORTA=0x05; //backward movement
		
	}
	else if(x=='R')
	{
		PORTA=0x06; //left
		
	}
	else if(x=='L')
	{
		PORTA=0x09; //right
		
	}
	else if(x=='S')
	{
		PORTA=0x00; //stop
	}
}

int main(){
	sei();
	pwm_init();
	DDRA=0xff;
	PORTA=0x00;
	DDRD = (1 << PD4)|(1 << PD5);
	uart0_init(UART_BAUD_SELECT(9600, F_CPU));
	
	move('S');

	while(1){
		unsigned char x = uart0_getc();
		
		
		if(x == 'F')
		{
			move(x);
			pwm_writeA(1800);
		}
		else if(x=='B')
		{
			move(x);
			pwm_writeA(1800);
		}
		else if(x=='L')
		{
			move(x);
			pwm_writeA(2000);
		}
		else if(x=='R')
		{
			move(x);
			pwm_writeA(2000);
		}
		else if(x=='S')
		{
			move(x);
			pwm_writeA(0);
		}

	}
}

