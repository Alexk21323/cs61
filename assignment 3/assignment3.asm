;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Alex Kuang
; Email: akuan004@ucr.edu
; 
; Assignment name: Assignment 3
; Lab section: 21
; TA: Dipan Shaw 
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
LD R6, Value_ptr		; R6 <-- pointer to value to be displayed as binary
LDR R1, R6, #0			; R1 <-- value to be displayed as binary 
;-------------------------------
;INSERT CODE STARTING FROM HERE
;--------------------------------

LD R2, DEC_16	;Number of integer intotal 
LD R3, DEC_4	;Number of character per space interval

MAIN_LOOP 
	
	ADD R3, R3, #0
	BRp Print_Num	;Check if need to print space (R3<=0)
	
	;--------------------------
	;Print Space
	;--------------------------
	LEA R0, space 
	PUTS
	LD R3, DEC_4
	
	;--------------------------
	;Check if need to end loop 
	;--------------------------
	ADD R2, R2, #0 
	BRp MAIN_LOOP
	
	;--------------------------
	;Print number
	;--------------------------
	Print_Num
		ADD R1, R1, #0
		BRn Print_One	;if the number is negative print 1
		
		LEA R0, zero	;else print 0
		PUTS 
		
		BR Left_Shift
	
	Print_One 
		LEA R0, one
		PUTS
		
		BR Left_Shift 
	;--------------------------
	;Shifting
	;--------------------------
	Left_Shift 
		ADD R1, R1, R1	;Shifting Left by multiplying 2 
		ADD R3, R3, #-1	;Circle through loop if less than 16 outputs
		ADD R2, R2, #-1
		
		BRp MAIN_LOOP
		
LEA R0, New_Line
PUTS

HALT
;---------------	
;Data
;---------------

DEC_16	.FILL #16
DEC_4	.FILL #4
one	.STRINGZ "1"
zero	.STRINGZ "0"
New_Line	.STRINGZ "\n"
space	.STRINGZ " "

Value_ptr	.FILL xCA00	; The address where value to be displayed is stored
.ORIG xCA00					; Remote data
Value .FILL xABCD		; <----!!!NUMBER TO BE DISPLAYED AS BINARY!!! Note: label is redundant.
;---------------	
;END of PROGRAM
;---------------	
.END
