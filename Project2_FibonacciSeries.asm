;   Program: Project 2
;   Author: Noreen Chrysilla
;   Class: CSCI 150
;   Date: Due on 4/8/2015
;   Description: Generate Fibonacci number at the order determined by the user and the sum of the first n-th values
;
;   I certify that the code below is my own work.
;	
;	Exception(s): N/A

INCLUDE Irvine32.inc

.data
authorString BYTE "Author: Noreen Chrysilla", 0dh, 0ah, 0

promptString BYTE "Enter a value within a range 1 - 30. Enter -1 to terminate.", 0dh, 0ah, 0
lessRangeString BYTE "The value is less than the determined range.", 0dh, 0ah, 0
greaterRangeString BYTE "The value is greater than the determined range.", 0dh, 0ah, 0
outputString BYTE "Fibonacci sequence: ", 0dh, 0ah, 0
sumString BYTE "The sum of the above sequence is: ", 0dh, 0ah, 0
nthString BYTE " -th value is: ", 0dh, 0ah, 0

comma BYTE ", ", 0
lBracket BYTE "{", 0
rBracket BYTE    "}", 0

count DWORD ?
sentinel DWORD ?
nthVal DWORD ?
sum DWORD 0
fibArray DWORD 1, 1, 28 DUP(0)	 ; first and second value = 1, the remaining 28 are set to 0

.code

main PROC
    mov edx, OFFSET authorString		; edx = address of authorString
    call WriteString					; "Author: Noreen Chrysilla"

    MainLoop:
        mov edx, OFFSET promptString	; edx = address of promptString
        call WriteString				; "Enter a value within a range 1 - 30. Enter -1 to terminate"
        call ReadInt                    ; Read user input, automatically stored in eax
    
		; condition for sentinel (to exit MainLoop)
        mov sentinel, 1					
        add sentinel, eax				; if eax = -1, sentinel = 1 + (-1) = 0
        jz EndMain						; if ZF = 1, terminate 

		; if user input out of range
		; if eax < 1
		cmp eax, 1						; compare eax with 1
		js LessThanRange				; if eax < 1, go to LessThanRange
		; if eax > 30
		cmp eax, 30						; compare eax with 30
		ja GreaterThanRange				; if eax > 30, go to GreaterThanRange
								
        mov count, eax					; for count loop
		mov nthVal, eax					; for providing a single n-th value
        call Fibonacci					; call Fibonacci function
        
        mov edx, OFFSET outputString	; edx = address of outputString
        call WriteString				; "Fibonacci sequence: "
        call PrintArray					; call PrintArray function

        call SumFib						; call SumFib

        mov edx, OFFSET sumString		; edx = adress of sumString
        call WriteString				; "The sum of the sequence is: "

        mov eax, sum					; Print the sum
        call WriteDec

        call Crlf
        call Crlf

		jmp MainLoop					; repeat MainLoop

		LessThanRange:
			mov edx, OFFSET lessRangeString
			call WriteString
			call Crlf
			jmp MainLoop				; repeat MainLoop
		
		GreaterThanRange:
			mov edx, OFFSET greaterRangeString
			call WriteString
			call Crlf
			jmp MainLoop				; repeat MainLoop

        

    EndMain:
    exit
main ENDP

; Computes and generates n Fib value and store them to fibArray 
; Receive var count from main, return fibArray
Fibonacci PROC USES eax ecx esi
    mov ecx, count							; loop counter
    sub ecx, 2								; fibArr[0] & fibArr[1] don't count

	;if count before sub 2 == 2
	jz DoNothing							; count == 0, skip

	;if count before sub 2 == 1
    jc DoNothing							; count == -1, skip

	call Crlf								; new line
	add nthVal, 0							; add 0 to user input, so the value won't change
	call WriteDec
	

    mov esi, 2								; start from fibArray[2]
    FibLoop:
        mov eax, 0							; to count sum of Fib values

        ; f(n) = f(n-2) + f(n-1)
        add eax, fibArray[esi * 4 - 2 * 4]	; f(n - 2)
        add eax, fibArray[esi * 4 - 1 * 4]	; f(n - 1)
        mov fibArray[esi * 4], eax
        inc esi								; increment index
		
		cmp esi, count
		je NthValue
        loop FibLoop
		
    DoNothing:								; will jump to here if count == 1 || count == 2

	NthValue:								; return n-th value
		mov edx, OFFSET nthString			; edx = address of nthString
		call WriteString					; "-th value is: "
		mov ebx, fibArray[esi]				; ebx = the last element of fibArray
		call WriteDec					
		call Crlf  
		call Crlf

    ret
Fibonacci ENDP

; Computes the sum of the first n values of the Fibonacci Sequence
; Receive var count 
SumFib PROC USES eax ecx esi
	mov ecx, count							; loop counter
    mov esi, 0								; start from the first index
	mov sum, 0								; initialize sum to 0
    SumLoop:
        mov eax, fibArray[esi * 4]			; eax = fibArray[esi] 
        add sum, eax						; sum = sum + eax
        inc esi								; increment index
        loop SumLoop
    ret
SumFib ENDP

; Prints the first n values of an array
; Receives var count, fibArray
PrintArray PROC USES eax ecx edx esi
    mov edx, OFFSET lBracket				; edx = adress of leftBracket
    call WriteString						; "{"
    
    mov eax, 0								; reset eax to 0
    mov esi, 0								; start from the first index
    mov ecx, count							; loop counter
    PrintLoop:
        ; move the element to eax then print
        mov eax, fibArray[esi * TYPE fibArray]
        call WriteDec

        ; print the space in between, if needed
        mov sentinel, ecx					; sentinel = total number of element
        sub sentinel, 1						; sentinel =  sentinel - 1
        jz PrintComma						; if ZF = 1, jump tp PrintComma
        mov edx, OFFSET comma				; edx = address of comma
        call WriteString					; ", "

        PrintComma:							; if ecx = 1, no comma is needed
		inc esi								; increment index
        loop PrintLoop

    mov edx, OFFSET rBracket				; edx = address of right bracket
    call WriteString						; "}"
	call Crlf 
	call Crlf
    ret
PrintArray ENDP
END main