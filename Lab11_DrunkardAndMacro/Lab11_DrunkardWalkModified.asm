;   Program: Lab 11 - Structure 
;   Author: Noreen Chrysilla
;   Class: CSCI 150
;   Date: Due on 5/20/2015
;   Description: Part 1 - Drunkard's Walk (limited to East and West direction only)		 

;   I certify that the code below is my own work.
;	
;	Exception(s): modified from Irvine Walk.asm

INCLUDE Irvine32.inc
WalkMax = 0
StartX = 0
StartY = 0

DrunkardWalk STRUCT
	path COORD WalkMax DUP(<0,0>)
	pathsUsed WORD 0
DrunkardWalk ENDS

DisplayPosition PROTO currX:WORD, currY:WORD

.data
authorString BYTE "Author: Noreen Chrysilla", 0dh, 0ah, 0
sumStr BYTE "The sum of all steps taken is: ", 0
avgStr BYTE "The average is: ", 0
countStr BYTE "The total step taken is: ", 0
spacecommaStr BYTE "  ", 0
aWalk DrunkardWalk <>
sum DWORD 0
avg DWORD ?
count DWORD 0
divisor DWORD 10
countPrint DWORD 0

.code
main PROC

	mov ecx, 10
	MainLoop:
		mov	esi,OFFSET aWalk
		call TakeDrunkenWalk
		call Crlf
		call Crlf
		loop MainLoop

	mov edx, OFFSET sumStr
	call WriteString
	mov eax, sum
	call WriteDec
	call Crlf

	mov edx, OFFSET avgStr
	call WriteString
	mov edx, 0
	div divisor
	call WriteDec
	call Crlf
	exit
main ENDP

;-------------------------------------------------------
TakeDrunkenWalk PROC
	LOCAL currX:WORD, currY:WORD
;
; Take a walk in random directions (north, south, east,
; west).
; Receives: ESI points to a DrunkardWalk structure
; Returns:  the structure is initialized with random values
;-------------------------------------------------------
	pushad

; Use the OFFSET operator to obtain the address of
; path, the array of COORD objects, and copy it to EDI.
	mov	edi,esi
	add	edi,OFFSET DrunkardWalk.path
	mov	currX,StartX		; current X-location
	mov	currY,StartY		; current Y-location
	mov count, 0
	mov countPrint, 0

Again:
	cmp currX, 6
	jz Finish
	; Insert current location in array.
	mov	ax,currX
	mov	(COORD PTR [edi]).X,ax
	mov	ax,currY
	mov	(COORD PTR [edi]).Y,ax

	INVOKE DisplayPosition, currX, currY
	inc count

	mov eax,2			; choose a direction (0-1)
	call RandomRange

	.IF eax == 0		; East
	  cmp currX, 0
	  jz StayZero
	  cmp currX, 0
	  jmp Decrement

	  StayZero:
		mov currX, 0
		jmp Again

	  Decrement:
		dec currX
		jmp Again

	.ELSEIF eax == 1	; West
	  inc currX
	.ENDIF

	add	edi,TYPE COORD		; point to next COORD
	jmp	Again

Finish:
	call Crlf
	mov edx, OFFSET countStr
	call WriteString
	mov eax, count
	;call WriteDec
	add sum, eax
	call WriteDec
	mov (DrunkardWalk PTR [esi]).pathsUsed, WalkMax
	popad
	ret
TakeDrunkenWalk ENDP

;-------------------------------------------------------
DisplayPosition PROC currX:WORD, currY:WORD
; Display the current X and Y positions.
;-------------------------------------------------------
.data
commaStr BYTE ",",0
.code
	pushad
	movzx eax,currX			; current X position
	call WriteDec
	mov	 edx,OFFSET commaStr	; "," string
	call WriteString
	movzx eax,currY			; current Y position
	call WriteDec
	inc countPrint
	cmp countPrint, 9
	jz NewLine
	mov edx,OFFSET spacecommaStr	; "," string
	call WriteString
	jmp Done

	NewLine:
		mov countPrint, 0
		call Crlf

	Done:

	popad
	ret
DisplayPosition ENDP
END main