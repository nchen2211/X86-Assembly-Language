
;   Program: Lab 5 Part 2 - Random Number
;   Author: Noreen Chrysilla
;   Class: CSCI 150
;   Date: Due on 4/6/2015
;   Description: Generate a series of random number by using AL library
;
;   I certify that the code below is my own work.
;	
;	Exception(s): N/A

INCLUDE Irvine32.inc
TAB = 9			;ASCII code for Tab

.data
	string1 BYTE "Author: Noreen Chrysilla", 0ah, 0dh, 0
.code

main proc
	
	mov edx, OFFSET string1
	call WriteString
	
	mov ebx, -300
	mov eax, 100
	call Randomize

	mov ecx, 10
	L2:
		call BetterRandomRange
		loop L2
	
	invoke ExitProcess,0
main endp


BetterRandomRange PROC	;generate ten pseudo-random integers from -300 to +100

	push ecx
	mov ecx, 10

	L1: mov eax, 401
		call RandomRange
		sub eax, 300
		call WriteInt
		mov al, TAB
		call WriteChar
		loop L1

	call Crlf
	pop ecx
	ret

BetterRandomRange ENDP
END main