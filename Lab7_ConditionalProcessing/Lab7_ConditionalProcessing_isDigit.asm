;   Program: Lab 7 - Conditional Processing - isAlpha
;   Author: Noreen Chrysilla
;   Class: CSCI 150
;   Date: Due on 4/20/2015
;   Description: Implement isAlpha to count the letter within an array and output the total number of the alphabets

;   I certify that the code below is my own work.
;	
;	Exception(s): N/A

INCLUDE Irvine32.inc

.data
authorString BYTE "Author: Noreen Chrysilla", 0dh, 0ah, 0
partAString BYTE "Lab 7 Part 1", 0dh, 0ah, 0
numLetterString BYTE "Total number of alphabet in the string is", 0dh, 0ah, 0

charArray BYTE 'This is a TEST: 1, 2, 3. This is a test!'		; total 22 letters 
len DWORD ?
numLetter DWORD ?
.code

main PROC
	mov edx, OFFSET authorString
	call WriteString

	;Part1
	mov edx, OFFSET partAString
	call WriteString
	
	mov ecx, LENGTHOF charArray			; loop count
	mov esi, 0							; starting index
	mov numLetter, 0					; initialize numLetter to 0

	Check:
		mov al, charArray[esi]			; store char from charArray to al
		;call WriteChar
		call isAlpha					; call isAlpha proc
		inc esi							; increment array index
		loop Check

	mov edx, OFFSET numLetterString
	call WriteString

	mov eax, numLetter			
	call WriteDec

	exit
main ENDP

isAlpha PROC	

		cmp al, 65						; compare the char with 'A'
		jb Done							; if the char has lower ASCII code than 'A', go to Done
	
		mov bl, 122						; bl = 122
		cmp al, bl						; compare the char with 'z'
		ja Done							; if the char has higher ASCII code than 'z', go to Done
		inc numLetter					; else, increment numLetter
		test al, 0						; set ZF = 1
		
		Done:
			ret
			
isAlpha ENDP
END main
