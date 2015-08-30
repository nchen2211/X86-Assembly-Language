
;   Program: Project 1 Part 2 - AL
;   Author: Noreen Chrysilla
;   Class: CSCI 150
;   Date: Due on 3/16/2015
;   Description:
;
;   I certify that the code below is my own work.
;	
;	Exception(s): N/A

INCLUDE Irvine32.inc

.data
	val1 SDWORD 8;
	val2 SDWORD -15;
	val3 SDWORD 20h
	val4 WORD 10h

.code

main proc
	
	string1 BYTE "Author: Noreen Chrysilla", 0
	call WriteString

	mov eax,0 
	call DumpRegs
	mov ebx,0
	call DumpRegs

	;first arithmetic expression
	sub eax,val3; eax = 20h --> decValue = -(-32) = 32
	call DumpRegs
	sub eax,val1; eax = 18h --> decValue = 32-8 = 24
	call DumpRegs
	sub eax,val2; eax = 27h --> decValue = -(-15) + 24 = 39
	call DumpRegs
	add eax,5; eax = 2C --> decValue = 39 + 5 = 44
	call DumpRegs

	;second arithmetic expression
	add bx, val4; bx = 10h --> decValue = 16
	call DumpRegs
	add bx, ax; bx = 3C --> decValue = 16 + 44 = 60
	call DumpRegs

	call DumpRegs
    exit
main endp

END main+