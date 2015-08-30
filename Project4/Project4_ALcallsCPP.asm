;   Program: Project 4_ Integer Square Root Estimate
;   Author: Noreen Chrysilla & Lynne Tien
;   Class: CSCI 150
;   Date: Due on 6/3/2015
;   Description: Implement Newton-Raphson method to estimate unsigned int root based on 
;				 a list of integer entered by the user. Implement a macro that resembles setw c++ instruction.
;				 Print the int and root list as a two column table.

;   I certify that the code below is my own work.
;	
;	Exception(s): N/A

INCLUDE Irvine32.inc


.data
authorStr BYTE "Author: Noreen Chrysilla & Lynne Tien", 0dh, 0ah, 0

userInput PROTO C

.code

main PROC
	mov edx, OFFSET authorStr
	call WriteString

	mov esi, 0
	INVOKE userInput

	exit
main ENDP
END main
