;   Program: Project 3 - PrimeNumbers
;   Author: Noreen Chrysilla
;   Class: CSCI 150
;   Date: Due on 
;   Description: Generate prime numbers based on user input of largest value and option

;   I certify that the code below is my own work.
;	
;	Exception(s): N/A

INCLUDE Irvine32.inc

.data
authorString BYTE "Author: Noreen Chrysilla", 0dh, 0ah, 0
menuString1 BYTE "This program can find all prime numbers from 2 to the input value and display results according to an option as specified.", 0dh, 0ah, 0
menuString2 BYTE "Output option (1 - last value, 2 - all values, 3 - last 5 values)", 0dh, 0ah, 0
menuString3 BYTE "Enter -1 to terminate the program", 0dh, 0ah, 0
largestString BYTE "Enter the largest value: ", 0dh, 0ah, 0
optionString BYTE "Enter output option: ", 0dh, 0ah, 0
outputString BYTE "Count: ", 0
output1String BYTE "The largest prime number is: ", 0
output2String BYTE "All prime number: ", 0
output3String BYTE "The last 5 prime number: ", 0
comma BYTE ", ", 0
lBracket BYTE " {", 0
rBracket BYTE    "}", 0
primeString BYTE " is a prime number", 0
notPrimeString BYTE " is not a prime number", 0



arrayPrime DWORD 1000000 DUP(?)			; array of prime numbers
divisor DWORD 2						
testValue DWORD 2
divisorCount DWORD 0				; to check if the testValue has been tested with all possible divisor
limit DWORD ?
numOfElem DWORD 0
countOuter DWORD ?
sentinel DWORD 0
opt DWORD 0
pointerStack DWORD 0

.code

main PROC

	mov edx, OFFSET authorString		; edx = address of authorString
    call WriteString					 

	mov edx, OFFSET menuString1			; edx = address of menuString1
    call WriteString					

	mov edx, OFFSET menuString2			; edx = address of menuString2
    call WriteString					
	
	mov edx, OFFSET menuString3			; edx = address of menuString2
    call WriteString

	MainLoop:
		mov edx, OFFSET largestString		; edx = address of largestString
		call WriteString					
		call ReadInt						; read larget value
		cmp eax, -1							; compare eax to -1
		jz Terminate						; if user inputs -1, go to Terminate
		cmp eax, -1							
		jnz GoOn							; else, go to GoOn
		
		GoOn:
			mov sentinel, eax				; store largest value to sentinel
			mov edx, OFFSET optionString	; edx = address of optString
			call WriteString					
			call ReadInt					; read option (1, 2, or 3)
			mov opt, eax					; save opt for PrintArray PROC

			call Crlf
			mov ecx, sentinel				; outer loop count

			TestValues:
				mov countOuter, ecx			; save outer loop count
				mov eax, testValue			; store each test value to eax
				push eax					; push eax to the stack	
				call isPrime				; call isPrime PROC
				loop TestValues	

			call PrintArray					; call PrintArray PROC
			mov numOfElem, 0				; reset number of element
			mov testValue, 2				; reset test value
			call Crlf
		
		jmp MainLoop

		Terminate:							; exit the program

	exit
main ENDP 

isPrime PROC
	
	push ebp
	mov ebp, esp
	mov ebx, pointerStack

	;-----------------------------------
	; To determine if it's first value
	; or next value.
	;-----------------------------------
	cmp esi, 0															; compare esi with 0
	jz First															; if elem in array == 0, go to First
	cmp esi, 0															; compare esi with 0
	jnz NextElem														; else go to NextElem


	;----------------------------------
	; First value
	;----------------------------------

	First:
		mov ebx, [ebp + 8]
		mov arrayPrime[esi * TYPE arrayPrime], ebx						; store the first elem to the array
		mov eax, 1														; 1 indicates prime
		inc esi															; increment array index
		inc numOfElem													; count element within the array
		jmp Increment													; go to Increment


	;----------------------------------
	; Next elements
	;----------------------------------
	NextElem:
			mov ecx, [ebp + 8]											; store test value to ecx
			sub ecx, divisor												; inner loop starts from 2 - (testValue - 1)
			mov limit, ecx													; set inner loop count
			mov ebx, limit													; for comparing to the # of divisor used
			
			mov divisorCount, 0												; no divisor has been used yet
			mov divisor, 2													; start divisor from 2
			InnerLoop:
				mov edx, 0													; reset remainder to 0
				mov eax, testValue											; store testValue to eax
				div divisor													; edx:eax = eax / divisor
				cmp edx, 0													; compare the remainder with 0
				jz Done														; if remainder == 0, go to Done
				cmp edx, 0													; compare the remainder with 0
				jnz	Next													; else go to Next

				;----------------------------------------------
				; If it's divisible by other number, then it's
				; not a prime
				;----------------------------------------------

				Done:
					mov eax, 0												; 0 indicates not a prime number
					jmp Increment											; go to Increment
					

				;----------------------------------------------
				; Keep dividing the test value with incremented
				; divisor
				;----------------------------------------------

				Next:
					inc divisor												; increment divisor	
					inc divisorCount										; increment the # of divisor has been used
					cmp ebx, divisorCount									; compare inner loop limit with the # of divisor used
					jz StorePrime											; if testValue has been divided with all possible divisors, go to StorePrime
					cmp ebx, divisorCount									; compare inner loop limit with the # of divisor used
					jnz LoopAgain											; else go to LoopAgain

						LoopAgain: 
							jmp InnerLoop									; jump to InnerLoop

						StorePrime:
							mov eax, [ebp + 8]								; store the current testValue to eax
							mov arrayPrime[esi * TYPE arrayPrime], eax		; store prime # to arrayPrime array
							mov eax, 1										; 1 indicate prime number
							inc esi											; increment array index
							inc numOfElem									; increment the # of element inside arrayPrime array
							jmp Increment

			loop InnerLoop
			
	
	Increment:
		inc testValue						; increment testValue		
		mov ecx, countOuter					; restore outer loop count

	pop ebp									; return eax (1 or 0)
	ret 4
	
isPrime ENDP


PrintArray PROC

	cmp opt, 2				; compare user option with 2
	js Option1				; if the user input 1, go to Option1
	cmp opt, 2
	jz Option2				; else if the user input 2, go to Option2
	cmp opt, 2
	jnz Option3				; else if the user input 3, go to Option3

	;--------------------------------------------------------
	; Print the total number of prime numbers in the array
	; Print the largest prime number in the array
	;--------------------------------------------------------


	Option1:
		mov edx, OFFSET outputString						; edx = adress of outputString
		call WriteString	
		mov eax, numOfElem									; store number of element in the array to eax
		call WriteDec
		call Crlf
		mov edx, OFFSET output1String						; edx = adress of output1String
		call WriteString
		mov esi, numOfElem									; store the number of element inside the arrayPrime to ecx
		dec esi												; esi-- because index 0 doesn't need to be counted in byte
		mov eax, arrayPrime[esi * TYPE arrayPrime]			; store the last element to eax
		call WriteDec
		call Crlf
		jmp EndPrintArray

	;--------------------------------------------------------
	; Print the total number of prime numbers in the array
	; Print all prime number in the array
	;--------------------------------------------------------

	Option2:

		cmp opt, 2												; if the option is 2
		jz Option2Inner					
		cmp opt, 2												; if the option is 3, but the number of array element less than 5 
		jnz Option3Inner
		
		Option2Inner:
			mov edx, OFFSET outputString						; edx = adress of outputString
			call WriteString	
			mov eax, numOfElem
			call WriteDec
			call Crlf
			mov edx, OFFSET output2String						; edx = adress of output1String
			call WriteString
		
		Option3Inner:
			mov eax, 0											; reset eax to 0
			mov esi, 0											; start from the first index
			mov ecx, numOfElem									; loop counter

			mov edx, OFFSET lBracket							; edx = adress of leftBracket
			call WriteString									; "{"
	
			Print:
				mov eax, arrayPrime[esi * TYPE arrayPrime]		; store array element to eax
				call WriteDec		
		
				mov sentinel, ecx								; sentinel = total number of element
				sub sentinel, 1									; sentinel =  sentinel - 1
				jz Done											; if ZF = 1, jump to Done		
				mov edx, OFFSET comma							; edx = adress of comma
				call WriteString
		
				Done:
		
				inc esi											; increment index
				loop Print			

			mov edx, OFFSET rBracket							; edx = adress of rBracket
			call WriteString									; "}"
			call Crlf
			jmp EndPrintArray

	;--------------------------------------------------------
	; Print the total number of prime numbers in the array
	; Print the last 5 prime number in the array or print all
	; if the array element is less than 5.
	;--------------------------------------------------------

	Option3:
		mov edx, OFFSET outputString						; edx = adress of outputString
		call WriteString	
		mov eax, numOfElem
		call WriteDec
		call Crlf
		mov edx, OFFSET output3String						; edx = adress of output2String
		call WriteString
		
		cmp numOfElem, 5
		jbe PrintAll
		jmp PrintFive
		
		PrintAll:
				jmp Option2

		PrintFive:
			
			mov ecx, 5												; only 5 last prime number to be printed
			mov eax, numOfElem										; store number of array elements in eax
			sub eax, 5												; subtract 5 to start index from the 1st element of the last 5 elements
			mov esi, eax											; store eax to esi for starting index

			mov edx, OFFSET lBracket								; edx = adress of leftBracket
			call WriteString										; "{"

			
			PrintLoop:
				mov eax, arrayPrime[esi * TYPE arrayPrime]
				call WriteDec		
		
				mov sentinel, ecx									; sentinel = total number of element
				sub sentinel, 1										; sentinel =  sentinel - 1
				jz Finish											; if ZF = 1, jump to Done		
				mov edx, OFFSET comma								; edx = adress of comma
				call WriteString
		
				Finish:
		
				inc esi												; increment index
				loop PrintLoop	

				mov edx, OFFSET rBracket							; edx = adress of rBracket
				call WriteString									; "}"
				call Crlf
					

			jmp EndPrintArray

			EndPrintArray:

	mov ecx, numOfElem
	mov esi, 0
	ResetArray:
		mov arrayPrime[esi * TYPE arrayPrime], 0
		loop ResetArray
		
ret
PrintArray ENDP

END main
