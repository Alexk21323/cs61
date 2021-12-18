;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Alex Kuang	
; Email: akuan004@ucr.edu
; 
; Assignment name: Assignment 2
; Lab section: 
; TA: Diphan Shaw
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team
; (apart from what was provided in the starter file).
;
;=========================================================================

.ORIG x3000			; Program begins here
;-------------
;Instructions
;-------------

;----------------------------------------------
;output prompt
;----------------------------------------------	
LEA R0, intro			; get starting address of prompt string
PUTS			   		; Invokes BIOS routine to output string

;-------------------------------
;INSERT YOUR CODE here
;--------------------------------

;---------------------------------
;Input
;--------------------------------- 

GETC
OUT 
ADD R1, R0, #0

LD R0, newline
OUT 

GETC 
OUT 
ADD R2, R0, #0

;----------------------------------
;Output 
;----------------------------------
LD R0, newline 
OUT 

ADD R0, R1, #0
OUT

LEA R0, minus
PUTS

ADD R0, R2, #0
OUT 

LEA R0, equal
PUTS
;-------------------------------------
;Convert second number 
;-------------------------------------
ADD R3, R2, #0
NOT R3, R3 
ADD R3, R3, 1

ADD R4, R1, R3
BRn CHECK_NEGATIVE 
	
ADD R4, R4, #12
ADD R4, R4, #12
ADD R4, R4, #12
ADD R4, R4, #12
ADD R0, R4, #0
OUT

LD R0, newline 
OUT 

HALT 

CHECK_NEGATIVE
	NOT R4, R4
	ADD R4, R4, #1
	ADD R4, R4, #12
	ADD R4, R4, #12
	ADD R4, R4, #12
	ADD R4, R4, #12	
	
	LEA R0, negative
	PUTS 
	
	ADD R0, R4, #0
	OUT	
	
	LD R0, newline
	OUT

HALT				; Stop execution of program
;------	
;Data
;------
; String to prompt user. Note: already includes terminating newline!
intro 	.STRINGZ	"ENTER two numbers (i.e '0'....'9')\n" 		; prompt string - use with LEA, followed by PUTS.
newline .FILL '\n'	; newline character - use with LD followed by OUT
minus	.STRINGZ " - "
equal	.STRINGZ	" = "
negative.STRINGZ	"-"



;---------------	
;END of PROGRAM
;---------------	
.END

