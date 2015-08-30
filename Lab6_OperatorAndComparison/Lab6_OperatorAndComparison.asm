;   Program: Lab 6 - Logical Operator and Comparison
;   Author: Noreen Chrysilla
;   Class: CSCI 150
;   Date: Due on 4/13/2015
;   Description: Part A: Properly set flags for signed and unsigned comparison
;				 Part B: Use logical operator AND, OR, NOT and comparison to perform XOR operator
;   I certify that the code below is my own work.
;	
;	Exception(s): N/A

INCLUDE Irvine32.inc

.data
authorString BYTE "Author: Noreen Chrysilla", 0dh, 0ah, 0
partAString BYTE "Part A", 0dh, 0ah, 0
partBString BYTE "Part B", 0dh, 0ah, 0
one_one_zeroString BYTE "1 XOR 1 = 0", 0dh, 0ah, 0
one_zero_oneString BYTE "1 XOR 0 = 1", 0dh, 0ah, 0
zero_one_oneString BYTE "0 XOR 1 = 1", 0dh, 0ah, 0
zero_zero_zeroString BYTE "0 XOR 0 = 0", 0dh, 0ah, 0

value BYTE 8
value1 BYTE 8
value2 BYTE 10
value3 SBYTE 10 
value4 SBYTE -120

one BYTE 1
zero BYTE 0
dummy BYTE ?

.code

main PROC
	mov edx, OFFSET authorString
	call WriteString

	mov edx, OFFSET partAString
	call WriteString

	;unsigned
	mov al, value			; al = 8		
	cmp al, value1			; compare al and value1, if(al == value1), ZF = 1
	call DumpRegs
	
	mov al, value			; al = 8	
	cmp al, value2			; compare al and value2, 8 - 10 = -2, CF = 1, SF = 1
	call DumpRegs				

	;signed
	mov al, value			; al = 8
	cmp al, value3			; compare al and value3, 8 - 10 = -2, SF = 1, CF = 1
	call DumpRegs			

	mov al, value			; al = 8
	cmp al, value4			; compare al and value4, 8 - (-120) = 128, OF = 1, CF = 1, SF = 1
	call DumpRegs	
		
	call Crlf
	mov edx, OFFSET partBString
	call WriteString

	; 1 XOR 1 = 0
	mov al, one				; al = 1
	mov bl, one				; bl = 1
	NOT al
	AND al, bl
	jz OneOneZero

	OneOneZero:
		mov cl, 0
		mov edx, OFFSET one_one_zeroString
		call WriteString

	; 1 XOR 0 = 1
	mov al, one
	mov bl, zero
	OR al, bl
	jnz OneZeroOne

	OneZeroOne:
		mov cl, 1
		mov edx, OFFSET one_zero_oneString
		call WriteString

	; 0 XOR 1 = 1
	mov al, zero
	mov bl, one
	OR al, bl
	jnz ZeroOneOne

	ZeroOneOne:
		mov cl, 1
		mov edx, OFFSET zero_one_oneString
		call WriteString

	; 0 XOR 0 = 0
	mov al, zero
	mov bl, one
	AND al, bl
	jz ZeroZeroZero

	ZeroZeroZero:
		mov cl, 1
		mov edx, OFFSET zero_zero_zeroString
		call WriteString

	exit
main ENDP
END main
