;   Program: Lab 5 - Stack
;   Author: Noreen Chrysilla
;   Class: CSCI 150
;   Date: Due on 3/23/2015
;   Description: print a given string in reverse order by using stack
;
;   I certify that the code below is my own work.
;	
;	Exception(s): N/A

INCLUDE Irvine32.inc


.data
	string1 BYTE "Author: Noreen Chrysilla", 0dh, 0ah, 0
	string2 BYTE "Reverse string using stack", 0dh, 0ah, 0
	source BYTE "This is the source string", 0 

.code
main proc
	
	mov edx, OFFSET string1
	call WriteString 
	call Crlf

	mov edx, OFFSET source
	call WriteString 
	call Crlf

	mov edx, OFFSET string2
	call WriteString
	call Crlf

	;Push process
	mov ecx, SIZEOF source
	dec ecx
	mov esi, 0

	L2: movzx eax, source[esi]	;get char
		push eax				;push it on the stack
		inc esi
		Loop L2

	;Pop process
	mov ecx, SIZEOF source
	dec ecx
	mov esi, 0

	L3: pop eax					;get char
		mov source[esi], al		;store in string
		inc esi
		Loop L3

	;Print out the reverse string
	mov edx, OFFSET source
	call Writestring
	call Crlf

    invoke ExitProcess,0
main endp

END main


