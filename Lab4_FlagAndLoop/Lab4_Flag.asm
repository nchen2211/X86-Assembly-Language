;   Program: Lab 4
;   Author: Noreen Chrysilla
;   Class: CSCI 150
;   Date: Due on 3/23/2015
;   Description: implement flags (ZF, SF, CF, OF)
;
;   I certify that the code below is my own work.
;	
;	Exception(s): N/A

INCLUDE Irvine32.inc


.data
	string1 BYTE "Author: Noreen Chrysilla", 0dh, 0ah, 0
	string2 BYTE "Zero Flag", 0dh, 0ah, 0
	string3 BYTE "Sign Flag", 0dh, 0ah, 0
	string4 BYTE "Carry Flag", 0dh, 0ah, 0
	string5 BYTE "Overflow Flag", 0dh, 0ah, 0

.code
main proc
	
	mov edx, OFFSET string1
	call WriteString 
	mov edx, OFFSET string2
	call WriteString
	mov eax, 1; eax = 1			ZF = 0
	sub eax, 1; eax	= 0			ZF = 1			ZF is set because eax = 0 after subtracting the initial value 1 with 1
	call DumpRegs

	mov edx, OFFSET string3
	call WriteString
	mov eax, 0; ax = 0			SF = 0
	sub eax, 1; ax = -1			SF = 1			SF is set because ax = -1 after subtracting the initial value 0 with 1
	call DumpRegs

	mov edx, OFFSET string4
	call WriteString
	mov al, 255; al = 255		CF = 0
	add al, 1; al = 0			CF = 1			CF is set because al = 0 after adding the initial value 255 with 1 which fell outside of the range
	call DumpRegs


	mov edx, OFFSET string5
	call WriteString
	mov bl, 0; bl = 0			OF = 0
	sub bl, 127; bl = -127		SF = 1			SF is set because bl = -127 after subtracting the initial value 0 with 128
	call DumpRegs
	sub bl, 2; bl = 0			OF = 1			OF is set because bl = 0 after subtracting the initial value -127 with 3 which fell outside of the range
	call DumpRegs

    exit
main endp

END main


