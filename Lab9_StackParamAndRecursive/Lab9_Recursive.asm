;   Program: Lab 9_StackParameters&Recursion
;   Author: Noreen Chrysilla
;   Class: CSCI 150
;   Date: Due on 5/4/2015
;   Description: use recursive for generating GCD
;
;   I certify that the code below is my own work.
;	
;	Exception(s): N/A


;Write a recursive implementation of Euclid’s algorithm for finding the greatest common divisor
;(GCD) of two integers. Descriptions of this algorithm are available in algebra books and
;on the Web. Write a test program that calls your GCD procedure five times, 
;using the following pairs of integers: (5,20), (24,18), (11,7), (432,226), (26,13). 
;After each procedure call, display the GCD.

INCLUDE Irvine32.inc


.data
	string1 BYTE "Author: Noreen Chrysilla", 0dh, 0ah, 0
	GCDString BYTE "GCD is: ", 0
	result DWORD ?
	store DWORD 12


.code
main proc
	
	mov edx, OFFSET string1
	call WriteString 

	L1:
		push 5
		push 20
		call GCD

		mov edx, OFFSET GCDString
		call WriteString 
		call WriteDec
		call Crlf
		call Crlf

	L2:
		push 24
		push 18
		call GCD

		mov edx, OFFSET GCDString
		call WriteString 
		call WriteDec
		call Crlf
		call Crlf

	L3:
		push 11
		push 7
		call GCD

		mov edx, OFFSET GCDString
		call WriteString 
		call WriteDec
		call Crlf
		call Crlf

	L4:
		push 432
		push 226
		call GCD

		mov edx, OFFSET GCDString
		call WriteString 
		call WriteDec
		call Crlf
		call Crlf

	L5:
		push 26
		push 13
		call GCD

		mov edx, OFFSET GCDString
		call WriteString 
		call WriteDec
		call Crlf
		call Crlf

	exit
main endp

GCD PROC
	
	push ebp
	mov ebp, esp
	
	mov eax, [ebp + 12]			; store the first pushed value
	mov ebx, [ebp + 8]			; store the second pushed value
	cmp ebx, 0
	jz ReturnFirst
	cmp ebx, 0
	jnz RecursiveGCD

	RecursiveGCD:
		mov edx, 0				; reset edx
		div ebx					; edx:eax = eax / ebx
		mov eax, ebx			; store prev ebx to eax
		mov ebx, edx			; store the remainder to ebx
		push eax
		push ebx
		call GCD
		
	ReturnFirst:
		pop ebp

	ret 8
	GCD ENDP
END main


