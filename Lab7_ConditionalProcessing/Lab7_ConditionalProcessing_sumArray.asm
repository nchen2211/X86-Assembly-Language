;   Program: Lab 7 - Conditional Processing - sumArray
;   Author: Noreen Chrysilla
;   Class: CSCI 150
;   Date: Due on 4/20/2015
;   Description: return sum of 2 array elements within lower and upper bond separately

;   I certify that the code below is my own work.
;	
;	Exception(s): N/A

INCLUDE Irvine32.inc

.data
authorString BYTE "Author: Noreen Chrysilla", 0dh, 0ah, 0
partBString BYTE "Lab7 Part 2", 0dh, 0ah, 0
array1Sum BYTE "The sum of array1 within the range is", 0dh, 0ah, 0
array2Sum BYTE "The sum of array2 within the range is", 0dh, 0ah, 0

lower DWORD 20
upper DWORD 40
array1 SDWORD 10, 17, 19, 25, 30, 40, 41, 43, 55			; sum = 95
count DWORD ?
count1 DWORD ?
array2 SDWORD 10, -30, 25, 15, -17, 55, 40, 41, 43			; sum = 65
count2 DWORD ?
summation DWORD 0 

.code

main PROC
	mov edx, OFFSET authorString
	call WriteString

	;Part2
	mov edx, OFFSET partBString
	call WriteString

	mov ecx, 2											; outer loop count
	
	Sum:
		cmp ecx, 2										; compare ecx with 2. ecx - 2
		jz SumArray1									; if ZF = 1 (ecx == 2), go to SumArray1
		cmp ecx, 2										; compare ecx with 2. ecx - 2
		jnz SumArray2									; if ZF = 0 (ecx != 2), go to SumArray2
			
	SumArray1:
			mov count, ecx								; save outer loop count
			mov count1, LENGTHOF array1					; count1 = length of array1 
			mov ecx, count1								; inner loop count
			mov esi, 0									; starting index
			array1Loop:		
				mov eax, array1[esi * TYPE array1]		; store the int to edx
				call sumArray							; call sumArray proc
				inc esi 								; increment index
				loop array1Loop
			
			mov ecx, count								; restore outer loop count
			mov edx, OFFSET array1Sum
			call WriteString
			mov eax, summation							; eax = summation
			call WriteDec								; output eax
		
	SumArray2:
			call Crlf
			call Crlf
			mov summation, 0							; reset summation to 0
			mov count, ecx								; save outer loop count
			mov count2, LENGTHOF array2					; count2 = length of array2
			mov ecx, count2								; inner loop count
			mov esi, 0									; starting index
			loopArray2:		
				mov eax, array2[esi * TYPE array2]		; store the int to edx
				call sumArray							; call sumArray proc
				inc esi									; increment index
				loop loopArray2	
		
		mov ecx, count									; restore outer loop count
		mov edx, OFFSET array2Sum
		call WriteString
		mov eax, summation								; eax = summation
		call WriteDec									; output eax
		call Crlf
	exit
main ENDP

sumArray PROC 

	cmp eax, lower				; compare edx with lower
	jb Done						; if (edx < lower), got to Done
	cmp eax, upper				; compare edx with upper
	ja Done						; if (edx > upper), go to Done
	add summation, eax			; else summation += eax
	Done:
		ret
sumArray ENDP
END main
