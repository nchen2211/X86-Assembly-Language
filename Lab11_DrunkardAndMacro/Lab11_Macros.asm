;   Program: Lab 11 - Macro
;   Author: Noreen Chrysilla
;   Class: CSCI 150
;   Date: Due on 5/20/2015
;   Description: Using a macro to implement mathematical expressions

;   I certify that the code below is my own work.
;	
;	Exception(s): N/A

INCLUDE Irvine32.inc
INCLUDE Macros.inc	; macro definitions

mAdd3 MACRO destination, source1, source2
	push eax
	mov eax, source1
	add eax, source2
	mov destination, eax
	pop eax
ENDM

mMul3 MACRO destination, source1, source2
	push eax
	mov eax, source1
	mul source2				; eax = eax * val2
	mov destination, eax
	pop eax
ENDM

mSub3 MACRO destination, source1, source2
	push eax
	mov eax, source1
	sub eax, source2
	mov destination, eax
	pop eax
ENDM

mDiv3 MACRO destination, source1, source2
	push eax
	mov edx, 0
	mov eax, source1
	div source2
	mov destination, eax
	pop eax
ENDM

.data
authorString BYTE "Author: Noreen Chrysilla", 0dh, 0ah, 0
addStr BYTE "Addition macro", 0dh, 0ah, 0
subtStr BYTE "Subtraction macro", 0dh, 0ah, 0
mulStr BYTE "Multiple macro", 0dh, 0ah, 0
divStr BYTE "Division macro", 0dh, 0ah, 0
extraStr BYTE "Extra credit", 0dh, 0ah, 0
temp DWORD ?
x DWORD ?
y DWORD ?
n DWORD 2
z DWORD 6

.code

main PROC
	mov edx, OFFSET authorString
	call WriteString
	call Crlf

	mov edx, OFFSET addStr
	call WriteString
	mAdd3 temp, 4, 3 ; temp = 4 + 3 = 7
	mov eax, temp 
	call WriteDec
	call Crlf
	call Crlf

	mov edx, OFFSET mulStr
	call WriteString
	mMul3 x, temp, n	; x = temp * 2 = 7 * 2 = 14
	mov eax, x 
	call WriteDec
	call Crlf
	call Crlf

	mov edx, OFFSET extraStr
	call WriteString
	mov edx, OFFSET subtStr
	call WriteString
	mSub3 temp, x, 2	; temp = 14 - 2 = 12
	mov eax, temp 
	call WriteDec
	call Crlf
	call Crlf

	mov edx, OFFSET divStr
	call WriteString
	mDiv3 x, temp, z ; x = temp / 6 = 12 / 6 = 2 
	mov eax, x 
	call WriteDec
	call Crlf
	call Crlf

	exit
main ENDP
END main
