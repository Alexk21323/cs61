;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Alex Kuang 
; Email: akuan004@ucr.edu
; 
; Assignment name: Assignment 4
; Lab section: 21
; TA: Dipan Shaw 
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team
; (apart from what was provided in the starter file).
;
;=================================================================================
;THE BINARY REPRESENTATION OF THE USER-ENTERED DECIMAL NUMBER MUST BE STORED IN R5
;=================================================================================

.ORIG x3000		
;-------------
;Instructions
;-------------
START 

LD R0, introPromptPtr	; output intro prompt
PUTS 

LD R1, New_Line_offset	; Set up flags, counters, accumulators as needed
LD R3, counter
LD R4, counter_multiply
ADD R2, R2, #0			; if statement variable 

GETC					; Get first character, test for '\n', '+', '-', digit/non-digit 	
OUT 
			
ADD R1, R1, R0			; is very first character = '\n'? if so, just quit (no message)!
BRz END_LOOP

LD R1, plus
ADD R1, R1, R0 			; is it = '+'? if so, ignore it, go get digits
BRz st_positive

LD R1, minus 
ADD R1, R1, R0			; is it = '-'? if so, set neg flag, go get digits
BRz st_negative

BR check_num			; if none of the above, first character is first numeric digit - convert it to number & store in target register!
check_done_first_digit 

LD R1, zero_offset
ADD R0, R0, R1 
ADD R5, R5, R0
ADD R3, R3, #-1

st_positive 			; Now get remaining digits from user in a loop (max 5), testing each to see if it is a digit, and build up number in accumulator
	GETC
	OUT
	
	LD R1, New_Line_offset
	ADD R1, R0, R1
	BRz END_LOOP
	
	ADD R2, R2, #1 
	BR check_num
	check_done_positive  
	
	ADD R1, R5, #0			; Load base value
	multiply
		ADD R5, R5, R1
		ADD R4, R4, #-1
		BRp multiply
	
	LD R1, zero_offset
	ADD R0, R0, R1
	ADD R5, R5, R0
	
	LD R4, counter_multiply	; Reset multiply counter
	ADD R3, R3, #-1
	BRp st_positive
	
	BR END_LOOP_MAX_DIGIT
	
st_negative
	GETC 
	OUT
	
	LD R1, New_Line_offset
	ADD R1, R0, R1
	BRz END_LOOP_NEGATIVE
	
	ADD R2, R2, #-1
	BR check_num
	check_done_negative
	
	ADD R1, R5, #0			; Load base value
	multiply_negative
		ADD R5, R5, R1
		ADD R4, R4, #-1
		BRp multiply_negative
		
	LD R1, zero_offset
	ADD R0, R0, R1
	ADD R5, R5, R0 
	LD R4, counter_multiply	; reset multiply counter
	
	ADD R3, R3, #-1
	BRp st_negative
	
	NOT R5, R5
	ADD R5, R5, #1
	
	BR END_LOOP_MAX_DIGIT

check_num 
	ADD R6, R0, #0
	LD R1, zero_offset
	
	ADD R6, R1, R6
	BRn print_error 
	
	ADD R6, R0, #0
	LD R1, nine_offset
	
	ADD R6, R1, R6
	BRp print_error 
	
	ADD R2, R2, #0
	BRz check_done_first_digit 
	BRn check_done_negative
	BRp check_done_positive				
	
print_error 
	LD R0, new_line
	OUT
	LD R0, errorMessagePtr
	PUTS 
	AND R5, R5, #0			; reset
	AND R2, R2, #0
	BR START 
		
END_LOOP
HALT

END_LOOP_NEGATIVE
	NOT R5, R5
	ADD R5, R5, #1
	HALT

END_LOOP_MAX_DIGIT
	LD R0, new_line
	OUT 
	HALT 

;---------------	
; Program Data
;---------------

introPromptPtr		.FILL xB000
errorMessagePtr		.FILL xB200
plus 	.FILL #-43
minus	.FILL #-45
zero_offset	.FILL #-48
nine_offset	.FILL #-57
New_Line_offset	.FILL #-10
counter	.FILL #5
counter_multiply	.FILL #9
new_line	.FILL '\n'
;------------
; Remote data
;------------
.ORIG xB000			; intro prompt
.STRINGZ	"Input a positive or negative decimal number (max 5 digits), followed by ENTER\n"			
.ORIG xB200			; error message
.STRINGZ	"ERROR: invalid input\n"

;---------------
; END of PROGRAM
;---------------
.END
;-------------------
; PURPOSE of PROGRAM
;-------------------
; Convert a sequence of up to 5 user-entered ascii numeric digits into a 16-bit two's complement binary representation of the number.
; if the input sequence is less than 5 digits, it will be user-terminated with a newline (ENTER).
; Otherwise, the program will emit its own newline after 5 input digits.
; The program must end with a *single* newline, entered either by the user (< 5 digits), or by the program (5 digits)
; Input validation is performed on the individual characters as they are input, but not on the magnitude of the number.
