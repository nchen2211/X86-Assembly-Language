TITLE ASM Template					(template.asm)

;   Program: Lab 3 Programming in AL
;   Author: Noreen Chrysilla
;   Class: CSCI 150
;   Date: Due on 3/11/2015
;   Description:
;
;   I certify that the code below is my own work.
;	
;	Exception(s): N/A

INCLUDE Irvine32.inc

.data
	a WORD 20
	b SWORD 15
	d WORD 40
	aa WORD 10

.code

main proc
	
	mov eax,0 
	sub ax, b ;ax = ax - 15
	add ax, d ;ax = ax + 40
	add ax, a ;ax = ax + 20
	add ax, aa

	call DumpRegs
    exit
main endp

END main