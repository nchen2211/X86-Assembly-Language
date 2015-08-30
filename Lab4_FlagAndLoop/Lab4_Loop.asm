;   Program: Lab 4
;   Author: Noreen Chrysilla
;   Class: CSCI 150
;   Date: Due on 3/23/2015
;   Description: print a given string in reverse order by using loop
;
;   I certify that the code below is my own work.
;	
;	Exception(s): N/A

INCLUDE Irvine32.inc


.data
	string1 BYTE "Author: Noreen Chrysilla", 0dh, 0ah, 0
	source BYTE "This is the source string", 0 
	target BYTE SIZEOF source DUP(0),0

.code
main proc
	
	mov edx, OFFSET string1
	call WriteString 

	mov edx, OFFSET source
	call WriteString 

	mov esi, LENGTHOF source		; esi = 1Ch     decValue = 28
	sub esi, 2
	mov edi, 0						; set index starts from 0 for variable target 
	mov ecx, SIZEOF source			; loop counter
	dec ecx
	
	
	L1:
		mov al, source[esi]			; esi get the last char in variable source	
		mov target[edi], al			; store it to target in ascending index	
		dec esi						; move to the prev char in variable source	
		inc edi						; move to the next index in variable target
		loop L1						; repeat for the entire string

	mov edx, OFFSET target
	call WriteString 


    invoke ExitProcess,0
main endp

END main


