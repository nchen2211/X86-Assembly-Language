;   Program: Project 4_ Integer Square Root Estimate
;   Author: Noreen Chrysilla & Lynne Tien
;   Class: CSCI 150
;   Date: Due on 6/3/2015
;   Description: Implement Newton-Raphson method to estimate unsigned int root based on 
;				 a list of integer entered by the user. Implement a macro that resembles setw c++ instruction.
;				 Print the int and root list as a two column table.

;   I certify that the code below is my own work.
;	
;	Exception(s): N/A

INCLUDE Irvine32.inc
INCLUDE Macros.inc	
TAB = 9							; ASCII code for Tab

mSetw MACRO TAB
	push eax
	push edx
	mov eax, TAB
	call WriteChar
	call WriteChar
	pop eax
	pop edx
ENDM


.data
authorStr BYTE "Author: Noreen Chrysilla & Lynne Tien", 0dh, 0ah, 0
inputStr BYTE "Input a list of integer. Press -1 to end the list of integer.", 0dh, 0ah, 0
listStr BYTE "The following table is the integer list and its corresponding root estimation", 0dh, 0ah, 0


inputArray DWORD 20 DUP(0)
rootArray DWORD 20 DUP(?)
count DWORD 0
occurence DWORD 0
DivByTwo DWORD 2
constDivident DWORD ?
val1 DWORD ?
val2 DWORD ?
storeEax DWORD ? 
storeVal1 DWORD ?


.code

sqrtEstimation PROC C
	
	push ebp
	mov ebp, esp

	;--------------------------------------
	; To determine if it's first recursion
	;--------------------------------------
	cmp occurence, 0
	jz First
	cmp occurence, 0
	jnz RecursiveRoot

	
	;-----------------------
	; First recursion
	;-----------------------
	
	First:
		mov eax, [ebp + 8]			; grab from userInput PROC and push
		mov constDivident, eax		; store the value as constant divident
		mov ebx, eax				; store eax to ebx
		mov edx, 0					; prepare division
		div DivByTwo				; edx:eax = eax / 2. eax is (y)

	RecursiveRoot:
		cmp occurence, 0
		jnz N_recur
		cmp occurence, 0
		jz FirstRecur

		N_recur:
			mov eax, [ebp + 8]			; push curr root to the stack

		FirstRecur:
			cmp ebx, eax				; if(x - y == 0)
			jz Root
			cmp ebx, eax	
			jnz Continue
		
		Continue:
			mov val1, eax			; store prev potential root to a dummy var to be subtracted 
			sub ebx, val1			 	
			cmp ebx, 1				; if(x - y == 1)
			jz Root
			
			Recursion:
				mov ebx, eax			; store curr root to ebx to be a prev root
				mov edx, 0				; prepare Newton-Raphson division
				mov eax, constDivident	; store constant divident to eax
				div ebx					; edx:eax = eax / ebx
				add eax, ebx			; eax + ebx
				mov edx, 0
				div DivByTwo			; edx:eax = eax / 2
				push eax				; push curr root
				inc occurence
				call sqrtEstimation
	
	Root:
		mov occurence, 0				; reset occurence to 0
		pop ebp							; pop base pointer
	
	ret 4

sqrtEstimation ENDP

userInput PROC C
	mov edx, OFFSET inputStr
	call WriteString

	mov esi, 0						; start from index 0
	
	userInt:
		call ReadInt
		cmp eax, -1					; compare eax with -1
		jz Stop						; if 0, go to Stop
		mov inputArray[esi], eax	; else, continue entering an int
		push eax					; push user input
		call sqrtEstimation			; process the root estimation
		mov rootArray[esi], eax
		inc count
		add esi, TYPE inputArray	; increment index
		jmp userInt

	Stop:
		call Print

	ret
userInput ENDP

Print PROC C
	call Crlf
	mov edx, OFFSET listStr
	call WriteString
	call Crlf

	mov esi, 0						; index starts from 0
	mov ecx, count					; # of element in inputArray
		
	PrintList:
		mov eax, inputArray[esi]	; mov element of inputArray to eax 
		call WriteDec
		mSetw TAB					; use macro to determine the # of space between each elem
		mov eax, rootArray[esi]		; mov element of rootArray to eax 
		call WriteDec
		call Crlf
		add esi, TYPE inputArray	; increment index
		loop PrintList

	call Crlf
	ret
Print ENDP

END 
