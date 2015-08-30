;   Program: Lab 10 - Concatenate String
;   Author: Noreen Chrysilla
;   Class: CSCI 150
;   Date: Due on 5/10/2015
;   Description: Part 1 - concatenate string using rep movsb
;				 Part 2 - 

;   I certify that the code below is my own work.
;	
;	Exception(s): N/A

INCLUDE Irvine32.inc

.data
authorString BYTE "Author: Noreen Chrysilla", 0dh, 0ah, 0
part1 BYTE "Part 1 - Concatenate 2 string", 0dh, 0ah, 0
part2 BYTE "Part 2 - Count letter occurence", 0dh, 0ah, 0
occurenceStr BYTE "Occurence of each letter of string: ", 0
targetStr BYTE "ABCDE",10 DUP(0)
sourceStr BYTE "FGH",0


target BYTE "AAEBDCFBBC", 0
colon BYTE ": ",0
freqTable DWORD 26 DUP(?)
letterArr BYTE 26 DUP (?), 0


totalAlphabet DWORD 26
alphabet BYTE 65

count DWORD 0
storeLoop DWORD ?
targetLength DWORD ?



Str_concat PROTO, targetPtr: PTR BYTE , sourcePtr: PTR BYTE
Get_frequency PROTO

.code

main PROC
	mov edx, OFFSET authorString
	call WriteString

	mov edx, OFFSET part1
	call WriteString

	INVOKE Str_concat, ADDR targetStr, ADDR sourceStr
	call Crlf 
	call Crlf

	mov edx, OFFSET part2
	call WriteString

	mov edx, OFFSET occurenceStr
	call WriteString

	mov edx, OFFSET target
	call WriteString
	call Crlf

	call Get_frequency

	exit
main ENDP

Str_concat PROC, targetPtr: PTR BYTE ,sourcePtr: PTR BYTE

	mov ecx, LENGTHOF sourceStr
	add targetPtr, 5		; point to last element of targetStr
	mov esi, sourcePtr
	mov edi, targetPtr 
	rep movsb

	mov edx, OFFSET targetStr
	call WriteString
	
	ret
Str_concat ENDP

Get_frequency PROC

	;----------------------------------------
	; Check what letters are in the array
	;----------------------------------------
	mov ecx, totalAlphabet			; loop 26 time (A-Z) to check what letters are in the array
	mov storeLoop, ecx				; store outer loop count
	mov esi, 0
	
	L2:
		mov edi, OFFSET target		; point to target string
		mov al, alphabet
		mov ecx,LENGTHOF target
		cld
		repne scasb
		jnz noSuchLetter 			; if there is no letter as such, go to noSuchLetter
		mov letterArr[esi], al		; else, store the letter in a new array
		inc count
		inc esi
		cmp esi, 6
		jz Quit
		inc alphabet
		mov ecx, storeLoop
		jmp L2

		noSuchLetter:
			inc alphabet

		mov ecx, storeLoop
		loop L2

	Quit:
		
	
	;----------------------------------------
	; Store the occurence of each letter
	;----------------------------------------

	mov esi, 0
	mov ecx, count					; set outer loop count
	

	L3:
		mov storeLoop, ecx			; save outer loop count
		mov edi, 0
		mov al, letterArr[esi]		; store a letter to al
		mov ecx, LENGTHOF target 	; set inner loop
		mov count, 0				; reset count to 0

		L4:
			cmp al, target[edi]		; compare the letter with letters in target array
			jz Occurence			; if they are equal, go to Occurence
			cmp al, target[edi]		
			jnz Skip				; else, go to Skip
			
			Skip:
				inc edi				; increment inner index array
				jmp N

			Occurence:
				inc count			; increment occurence of the letter
				inc edi				; increment inner index array

			N:

			loop L4

		mov eax, count
		mov freqTable[esi], eax
		inc esi
		mov ecx, storeLoop
		loop L3


	;-------------------------------------
	; Print letter array and freq table
	;-------------------------------------
	mov ecx, LENGTHOF freqTable
	mov esi, 0
	Print:
		cmp freqTable[esi], 0
		jz StopPrint
		mov al, letterArr[esi]
		call WriteChar
		mov edx, OFFSET colon
		call WriteString
		mov al, BYTE PTR freqTable[esi]
		call WriteDec
		call Crlf
		inc esi
		loop Print

		StopPrint:

	ret
Get_frequency ENDP
END main
