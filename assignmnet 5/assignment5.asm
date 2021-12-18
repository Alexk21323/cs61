;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: alex kuang	
; Email: akuan004@ucr.edu
; 
; Assignment name: Assignment 5
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
;-------------------------------
;INSERT CODE STARTING FROM HERE
;--------------------------------
Main_Loop
	LD R6, MENU
	JSRR R6
	
	ADD R3, R1, #0
	ADD R3, R3, #-1
	BRz CHECK_ALL_MACHINES_BUSY
	
	ADD R3, R1, #0
	ADD R3, R3, #-2
	BRz CHECK_ALL_MACHINES_FREE
	
	ADD R3, R1, #0
	ADD R3, R3, #-3
	BRz CHECK_REPORT_BUSY_MACHINES
	
	ADD R3, R1, #0
	ADD R3, R3, #-4
	BRz CHECK_REPORT_FREE_MACHINES
	
	ADD R3, R1, #0
	ADD R3, R3, #-5
	BRz CHECK_REPORT_STATUS_MACHINE
	
	ADD R3, R1, #0
	ADD R3, R3, #-6
	BRz CHECK_REPORT_FIRST_MACHINE
	
	ADD R3, R1, #0
	ADD R3, R3, #-7
	BRz QUIT 
	
CHECK_ALL_MACHINES_BUSY
	LD R6, ALL_MACHINES_BUSY
	JSRR R6
	
	ADD R2, R2, #-1
	BRz ALL_busy 
	LD R0, newline
	OUT
	LEA R0, allnotbusy
	PUTS 
	BR Main_Loop
	
	ALL_busy
	LD R0, newline
	OUT
	LEA R0, allbusy
	PUTS 
	BR Main_Loop
	
CHECK_ALL_MACHINES_FREE
	LD R6, ALL_MACHINES_FREE
	JSRR R6
	
	ADD R2, R2, #-1
	BRz ALL_free 
	LD R0, newline
	OUT
	LEA R0, allnotfree
	PUTS 
	BR Main_Loop
	
	ALL_free
	LD R0, newline
	OUT
	LEA R0, allfree
	PUTS 
	BR Main_Loop

CHECK_REPORT_BUSY_MACHINES
	LD R6, REPORT_BUSY_MACHINES
	JSRR R6
	
	LD R0, newline
	OUT
	
	LEA R0, busymachine1
	PUTS
	
	LD R6, print_num
	JSRR R6
	
	LEA R0, busymachine2
	PUTS 
	BR Main_Loop
	
CHECK_REPORT_FREE_MACHINES
	LD R6, REPORT_FREE_MACHINES
	JSRR R6
	
	LD R0, newline
	OUT
	
	LEA R0, freemachine1
	PUTS 
	
	LD R6, print_num
	JSRR R6
	
	LEA R0, freemachine2
	PUTS
	BR Main_Loop
	
CHECK_REPORT_STATUS_MACHINE
	LD R6, REPORT_STATUS_MACHINE
	JSRR R6
	
	LD R0, newline
	OUT
	
	LEA R0, status1
	PUTS
	
	LD R6, print_num
	JSRR R6
	
	ADD R2, R2, #0 
	BRp print_free
	LEA R0, status2
	PUTS 
	BR Main_Loop

	print_free
	LEA R0, status3
	PUTS 
	BR Main_Loop
	
CHECK_REPORT_FIRST_MACHINE
	LD R6, REPORT_FIRST_MACHINE
	JSRR R6
	
	LD R2, DEC_15_main
	ADD R2, R1, R2
	BRz NOT_Available 
	
	LD R0, newline
	OUT
	
	LEA R0, firstfree1
	PUTS
	
	LD R6, print_num
	JSRR R6
	
	LD R0, newline
	OUT
	
	BR Main_Loop
	NOT_Available
		LD R0, newline
		OUT
		
		LEA R0,firstfree2
		PUTS
	
		BR Main_Loop

QUIT 
	LD R0, newline
	OUT
	LEA R0, goodbye
	PUTS
	
HALT
;---------------	
;Data
;---------------
;Subroutine pointers
MENU	.FILL x3200
ALL_MACHINES_BUSY	.FILL x3400
ALL_MACHINES_FREE 	.FILL x3600
REPORT_BUSY_MACHINES	.FILL x3800
REPORT_FREE_MACHINES 	.FILL x4000
REPORT_STATUS_MACHINE	.FILL x4200
REPORT_FIRST_MACHINE	.FILL x4400
print_num	.FILL x4800

;Other data 
newline 		.fill '\n'
DEC_15_main		.FILL #-16

; Strings for reports from menu subroutines:
goodbye         .stringz "Goodbye!\n"
allbusy         .stringz "All machines are busy\n"
allnotbusy      .stringz "Not all machines are busy\n"
allfree         .stringz "All machines are free\n"
allnotfree		.stringz "Not all machines are free\n"
busymachine1    .stringz "There are "
busymachine2    .stringz " busy machines\n"
freemachine1    .stringz "There are "
freemachine2    .stringz " free machines\n"
status1         .stringz "Machine "
status2		    .stringz " is busy\n"
status3		    .stringz " is free\n"
firstfree1      .stringz "The first available machine is number "
firstfree2      .stringz "No machines are free\n"

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: MENU
; Inputs: None
; Postcondition: The subroutine has printed out a menu with numerical options, invited the
;                user to select an option, and returned the selected option.
; Return Value (R1): The option selected:  #1, #2, #3, #4, #5, #6 or #7 (as a number, not a character)
;                    no other return value is possible
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine MENU
;--------------------------------
;HINT back up 
.orig x3200
ST R0, bu_r0_3200
ST R2, bu_r2_3200
ST R3, bu_r3_3200
ST R4, bu_r4_3200
ST R5, bu_r5_3200
ST R6, bu_r6_3200
ST R7, bu_r7_3200

Menu_LOOP
	LD R0, Menu_string_addr
	PUTS 

	AND R1, R1, #0

	GETC 
	OUT 
	LD R2, offset_menu
	ADD R2, R2, R0
	BRn Error_menu
	LD R2, offset_positive
	ADD R2, R2, R0
	BRp Error_menu
	
	LD R2, offset_menu
	ADD R1, R1, R2
	ADD R1, R1, R0
	
	;HINT Restore
	LD R0, bu_r0_3200
	LD R2, bu_r2_3200
	LD R3, bu_r3_3200
	LD R4, bu_r4_3200
	LD R5, bu_r5_3200
	LD R6, bu_r6_3200
	LD R7, bu_r7_3200
	ret

Error_menu
	LD R0, new_line_menu
	OUT
	LEA R0, Error_msg_1
	PUTS 
	BR Menu_LOOP
;--------------------------------
;Data for subroutine MENU
;--------------------------------
Error_msg_1	      .STRINGZ "INVALID INPUT\n"
Menu_string_addr  .FILL x5000
offset_positive .FILL #-55
offset_menu	.FILL #-48
new_line_menu	.FILL '\n'

bu_r0_3200	.BLKW #1
bu_r2_3200	.BLKW #1
bu_r3_3200	.BLKW #1
bu_r4_3200	.BLKW #1
bu_r5_3200	.BLKW #1
bu_r6_3200	.BLKW #1
bu_r7_3200	.BLKW #1
;-----------------------------------------------------------------------------------------------------------------
; Subroutine: ALL_MACHINES_BUSY (#1)
; Inputs: None
; Postcondition: The subroutine has returned a value indicating whether all machines are busy
; Return value (R2): 1 if all machines are busy, 0 otherwise
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine ALL_MACHINES_BUSY
;--------------------------------
;HINT back up 
.orig x3400
ST R0, bu_r0_3400
ST R1, bu_r1_3400
ST R3, bu_r3_3400
ST R4, bu_r4_3400
ST R5, bu_r5_3400
ST R6, bu_r6_3400
ST R7, bu_r7_3400

LD R0, BUSYNESS_ADDR_ALL_MACHINES_BUSY
LDR R0, R0, #0

BRz ALL_BUSSY

AND R2, R2, #0
ADD R2, R2, #0
;HINT Restore
LD R0, bu_r0_3400
LD R1, bu_r1_3400
LD R3, bu_r3_3400	
LD R4, bu_r4_3400
LD R5, bu_r5_3400	
LD R6, bu_r6_3400
LD R7, bu_r7_3400
Ret 

ALL_BUSSY 
	AND R2, R2, #1
	ADD R2, R2, #1
	;HINT Restore
	LD R0, bu_r0_3400
	LD R1, bu_r1_3400
	LD R3, bu_r3_3400
	LD R4, bu_r4_3400
	LD R5, bu_r5_3400
	LD R6, bu_r6_3400
	LD R7, bu_r7_3400
	Ret 
;--------------------------------
;Data for subroutine ALL_MACHINES_BUSY
;--------------------------------
BUSYNESS_ADDR_ALL_MACHINES_BUSY .Fill xB400

bu_r0_3400	.BLKW #1
bu_r1_3400	.BLKW #1
bu_r3_3400	.BLKW #1
bu_r4_3400	.BLKW #1
bu_r5_3400	.BLKW #1
bu_r6_3400	.BLKW #1
bu_r7_3400	.BLKW #1
;-----------------------------------------------------------------------------------------------------------------
; Subroutine: ALL_MACHINES_FREE (#2)
; Inputs: None
; Postcondition: The subroutine has returned a value indicating whether all machines are free
; Return value (R2): 1 if all machines are free, 0 otherwise
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine ALL_MACHINES_FREE
;--------------------------------
;HINT back up 
.orig x3600
ST R0, bu_r0_3600
ST R1, bu_r1_3600
ST R3, bu_r3_3600
ST R4, bu_r4_3600
ST R5, bu_r5_3600
ST R6, bu_r6_3600
ST R7, bu_r7_3600

LD R0, BUSYNESS_ADDR_ALL_MACHINES_FREE
LDR R0, R0, #0
LD R1, offset_all_free
NOT R1, R1
ADD R1, R1, #1
ADD R1, R1, R0
BRz ALL_FREE

AND R2, R2, #0
ADD R2, R2, #0
;HINT Restore
LD R0, bu_r0_3600
LD R1, bu_r1_3600
LD R3, bu_r3_3600	
LD R4, bu_r4_3600
LD R5, bu_r5_3600	
LD R6, bu_r6_3600
LD R7, bu_r7_3600
Ret 

ALL_FREE
	AND R2, R2, #1
	ADD R2, R2, #1
	;HINT Restore
	LD R0, bu_r0_3600
	LD R1, bu_r1_3600
	LD R3, bu_r3_3600
	LD R4, bu_r4_3600
	LD R5, bu_r5_3600
	LD R6, bu_r6_3600
	LD R7, bu_r7_3600
	Ret 
;--------------------------------
;Data for subroutine ALL_MACHINES_FREE
;--------------------------------
BUSYNESS_ADDR_ALL_MACHINES_FREE .Fill xB400
offset_all_free	.FILL xFFFF

bu_r0_3600	.BLKW #1
bu_r1_3600	.BLKW #1
bu_r3_3600	.BLKW #1
bu_r4_3600	.BLKW #1
bu_r5_3600	.BLKW #1
bu_r6_3600	.BLKW #1
bu_r7_3600	.BLKW #1
;----------------------------------------------------------------------------------------------------------------
; Subroutine: NUM_BUSY_MACHINES (#3)
; Inputs: None
; Postcondition: The subroutine has returned the number of busy machines.
; Return Value (R1): The number of machines that are busy (0)
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine NUM_BUSY_MACHINES
;--------------------------------
;HINT back up 
.orig x3800
ST R0, bu_r0_3800
ST R2, bu_r2_3800
ST R3, bu_r3_3800
ST R4, bu_r4_3800
ST R5, bu_r5_3800
ST R6, bu_r6_3800
ST R7, bu_r7_3800

LD R6, BUSYNESS_ADDR_NUM_BUSY_MACHINES 
LDR R1, R6, #0
AND R2, R2, #0
LD R2, DEC_16_busy	;Number of integer intotal 
AND R4, R4, #0
MAIN_LOOP_Print 
	Print_Num
		ADD R1, R1, #0
		BRn Print_One	;if the number is negative print 1
		ADD R4, R4, #1
		BR Left_Shift
	
	Print_One 
		ADD R5, R5, #1
		BR Left_Shift 
	;--------------------------
	;Shifting
	;--------------------------
	Left_Shift 
		ADD R1, R1, R1	;Shifting Left by multiplying 2 
		ADD R3, R3, #-1	;Circle through loop if less than 16 outputs
		ADD R2, R2, #-1
		BRp MAIN_LOOP_Print

ADD R1, R4, #0
;HINT Restore
LD R0, bu_r0_3800
LD R2, bu_r2_3800
LD R3, bu_r3_3800
LD R4, bu_r4_3800
LD R5, bu_r5_3800
LD R6, bu_r6_3800
LD R7, bu_r7_3800
Ret
;--------------------------------
;Data for subroutine NUM_BUSY_MACHINES
;--------------------------------
BUSYNESS_ADDR_NUM_BUSY_MACHINES .Fill xB400
DEC_16_busy	.FILL #16
bu_r0_3800	.BLKW #1
bu_r2_3800	.BLKW #1
bu_r3_3800	.BLKW #1
bu_r4_3800	.BLKW #1
bu_r5_3800	.BLKW #1
bu_r6_3800	.BLKW #1
bu_r7_3800	.BLKW #1
;-----------------------------------------------------------------------------------------------------------------
; Subroutine: NUM_FREE_MACHINES (#4)
; Inputs: None
; Postcondition: The subroutine has returned the number of free machines
; Return Value (R1): The number of machines that are free (1)
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine NUM_FREE_MACHINES
;--------------------------------
;HINT back up 
.orig x4000
ST R0, bu_r0_4000
ST R2, bu_r2_4000
ST R3, bu_r3_4000
ST R4, bu_r4_4000
ST R5, bu_r5_4000
ST R6, bu_r6_4000
ST R7, bu_r7_4000

LD R6, BUSYNESS_ADDR_NUM_FREE_MACHINES 
LDR R1, R6, #0
AND R2, R2, #0
LD R2, DEC_16_free	;Number of integer intotal 
AND R4, R4, #0
MAIN_LOOP_Print_free
	Print_Num_free
		ADD R1, R1, #0
		BRn Print_One_free	;if the number is negative print 1
		BR Left_Shift_free
	
	Print_One_free
		ADD R4, R4, #1
		ADD R5, R5, #1
		BR Left_Shift_free
	;--------------------------
	;Shifting
	;--------------------------
	Left_Shift_free
		ADD R1, R1, R1	;Shifting Left by multiplying 2 
		ADD R3, R3, #-1	;Circle through loop if less than 16 outputs
		ADD R2, R2, #-1
		BRp MAIN_LOOP_Print_free

ADD R1, R4, #0
;HINT Restore
LD R0, bu_r0_4000
LD R2, bu_r2_4000
LD R3, bu_r3_4000
LD R4, bu_r4_4000
LD R5, bu_r5_4000
LD R6, bu_r6_4000
LD R7, bu_r7_4000

Ret
;--------------------------------
;Data for subroutine NUM_FREE_MACHINES 
;--------------------------------
BUSYNESS_ADDR_NUM_FREE_MACHINES .Fill xB400
DEC_16_free	.FILL #16
bu_r0_4000	.BLKW #1
bu_r2_4000	.BLKW #1
bu_r3_4000	.BLKW #1
bu_r4_4000	.BLKW #1
bu_r5_4000	.BLKW #1
bu_r6_4000	.BLKW #1
bu_r7_4000	.BLKW #1

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: MACHINE_STATUS (#5)
; Input (R1): Which machine to check, guaranteed in range {0,15}
; Postcondition: The subroutine has returned a value indicating whether
;                the selected machine (R1) is busy or not.
; Return Value (R2): 0 if machine (R1) is busy, 1 if it is free
;              (R1) unchanged
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine MACHINE_STATUS
;--------------------------------
;HINT back up 
.orig x4200
ST R0, bu_r0_4200
ST R3, bu_r3_4200
ST R4, bu_r4_4200
ST R5, bu_r5_4200
ST R6, bu_r6_4200
ST R7, bu_r7_4200

LD R6, Get_Input 
JSRR R6

LD R6, BUSYNESS_ADDR_MACHINE_STATUS 
LDR R2, R6, #0
LD R3, offset_15
ADD R3, R1, R3

MACHINE_STATUS 
	ADD R3, R3, #0
	BRzp End_Loop_status
	Left_Shift_STATUS
		ADD R2, R2, R2
		ADD R3, R3, #1
		BRn MACHINE_STATUS

End_Loop_status
ADD R2, R2, #0
BRn return_free
AND R2, R2, #0
BR RETRUN_STATUS 

return_free
AND R2, R2, #0 
ADD R2, R2, #1 
BR RETRUN_STATUS

RETRUN_STATUS
;HINT Restore
LD R0, bu_r0_4200
LD R3, bu_r3_4200
LD R4, bu_r4_4200
LD R5, bu_r5_4200
LD R6, bu_r6_4200
LD R7, bu_r7_4200
ret
;--------------------------------
;Data for subroutine MACHINE_STATUS
;--------------------------------
BUSYNESS_ADDR_MACHINE_STATUS.Fill xB400
Get_Input	.FILL x4600
offset_15	.FILL #-15
bu_r0_4200	.BLKW #1
bu_r3_4200	.BLKW #1
bu_r4_4200	.BLKW #1
bu_r5_4200	.BLKW #1
bu_r6_4200	.BLKW #1
bu_r7_4200	.BLKW #1
;-----------------------------------------------------------------------------------------------------------------
; Subroutine: FIRST_FREE (#6)
; Inputs: None
; Postcondition: The subroutine has returned a value indicating the lowest numbered free machine
; Return Value (R1): the number of the free machine
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine FIRST_FREE
;--------------------------------
;HINT back up 
.orig x4400
ST R0, bu_r0_4400
ST R2, bu_r2_4400
ST R3, bu_r3_4400
ST R4, bu_r4_4400
ST R5, bu_r5_4400
ST R6, bu_r6_4400
ST R7, bu_r7_4400

LD R2, BUSYNESS_ADDR_FIRST_FREE
LDR R2, R2, #0

AND R1, R1, #0
LD R4, DEC_16_first_free
LD R5, bit_vector
LD R6, DEC_15

LOOP_first_Free
	AND R3, R3, #0
	AND R3, R2, R5
	BRp END_LOOP_first_free
	
	BR Right_shift
	finish_right_shift 
	LD R6, DEC_15
	ADD R1, R1, #1
	ADD R4, R4, #-1
	BRz END_LOOP_first_free
	BR LOOP_first_Free
	
Right_shift
	ADD R2, R2, #0
	BRn ADD_ONE
	ADD R2, R2, R2
	ADD R6, R6, #-1
	BRz finish_right_shift
	BR Right_shift

ADD_ONE 
	ADD R2, R2, R2
	ADD R2, R2, #1
 	ADD R6, R6, #-1
	BRz finish_right_shift
	BR Right_shift
	
END_LOOP_first_free
;HINT Restore
LD R0, bu_r0_4400
LD R2, bu_r2_4400
LD R3, bu_r3_4400
LD R4, bu_r4_4400
LD R5, bu_r5_4400
LD R6, bu_r6_4400
LD R7, bu_r7_4400
ret
;--------------------------------
;Data for subroutine FIRST_FREE
;--------------------------------
BUSYNESS_ADDR_FIRST_FREE .Fill xB400
bit_vector	.FILL x0001
DEC_16_first_free	.FILL #16
DEC_15	.FILL #15
bu_r0_4400	.BLKW #1
bu_r2_4400	.BLKW #1
bu_r3_4400	.BLKW #1
bu_r4_4400	.BLKW #1
bu_r5_4400	.BLKW #1
bu_r6_4400	.BLKW #1
bu_r7_4400	.BLKW #1
;-----------------------------------------------------------------------------------------------------------------
; Subroutine: GET_MACHINE_NUM
; Inputs: None
; Postcondition: The number entered by the user at the keyboard has been converted into binary,
;                and stored in R1. The number has been validated to be in the range {0,15}
; Return Value (R1): The binary equivalent of the numeric keyboard entry
; NOTE: You can use your code from assignment 4 for this subroutine, changing the prompt, 
;       and with the addition of validation to restrict acceptable values to the range {0,15}
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine 
;--------------------------------
.orig x4600
ST R0, bu_r0_4600
ST R2, bu_r2_4600
ST R3, bu_r3_4600
ST R4, bu_r4_4600
ST R5, bu_r5_4600
ST R6, bu_r6_4600
ST R7, bu_r7_4600

LD R0, new_line
OUT 

START 

LEA R0, prompt	
PUTS

LD R1, New_Line_offset	
LD R3, counter
LD R4, counter_multiply
ADD R2, R2, #0			

GETC 	
OUT 
			
ADD R1, R1, R0			
BRz print_error

LD R1, plus
ADD R1, R1, R0 			
BRz st_positive

BR check_num			
check_done_first_digit 

LD R1, zero_offset
ADD R0, R0, R1 
ADD R5, R5, R0
ADD R3, R3, #-1

st_positive 			
	GETC
	
	LD R1, New_Line_offset
	ADD R1, R0, R1
	BRz END_LOOP
	OUT
	ADD R2, R2, #1 
	BR check_num
	check_done_positive  
	
	ADD R1, R5, #0			
	multiply
		ADD R5, R5, R1
		ADD R4, R4, #-1
		BRp multiply
	
	LD R1, zero_offset
	ADD R0, R0, R1
	ADD R5, R5, R0
	
	LD R4, counter_multiply	
	ADD R3, R3, #-1
	BRp st_positive
	
	BR END_LOOP


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
	BRp check_done_positive				
	
print_error 
	LD R0, new_line
	OUT 
	LEA R0, Error_msg_2
	PUTS 
	AND R5, R5, #0			
	AND R2, R2, #0
	BR START

print_error_large
	LD R0, new_line
	OUT 
	LD R0, new_line
	OUT 
	LEA R0, Error_msg_2
	PUTS 
	AND R5, R5, #0			
	AND R2, R2, #0
	BR START
	
END_LOOP_NEGATIVE
	NOT R5, R5
	ADD R5, R5, #1
	BR END_LOOP

END_LOOP
	ADD R5, R5, #0
	BRn print_error
	LD R1, max_value
	ADD R1, R5, R1
	BRp print_error_large 
	ADD R1, R5, #0
	LD R0, bu_r0_4600
	LD R2, bu_r2_4600
	LD R3, bu_r3_4600
	LD R4, bu_r4_4600
	LD R5, bu_r5_4600
	LD R6, bu_r6_4600
	LD R7, bu_r7_4600
	ret

;--------------------------------
;Data for subroutine Get input
;--------------------------------
prompt .STRINGZ "Enter which machine you want the status of (0 - 15), followed by ENTER: "
Error_msg_2 .STRINGZ "ERROR INVALID INPUT\n"
plus 	.FILL #-43
minus	.FILL #-45
zero_offset	.FILL #-48
nine_offset	.FILL #-57
New_Line_offset	.FILL #-10
counter	.FILL #5
counter_multiply	.FILL #9
max_value	.FILL #-15
new_line	.FILL '\n'
bu_r0_4600	.BLKW #1
bu_r2_4600	.BLKW #1
bu_r3_4600	.BLKW #1
bu_r4_4600	.BLKW #1
bu_r5_4600	.BLKW #1
bu_r6_4600	.BLKW #1
bu_r7_4600	.BLKW #1
	
;-----------------------------------------------------------------------------------------------------------------
; Subroutine: PRINT_NUM
; Inputs: R1, which is guaranteed to be in range {0,16}
; Postcondition: The subroutine has output the number in R1 as a decimal ascii string, 
;                WITHOUT leading 0's, a leading sign, or a trailing newline.
; Return Value: None; the value in R1 is unchanged
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine 
;--------------------------------
.orig x4800
ST R0, bu_r0_4800
ST R1, bu_r1_4800
ST R2, bu_r2_4800
ST R3, bu_r3_4800
ST R4, bu_r4_4800
ST R5, bu_r5_4800
ST R6, bu_r6_4800
ST R7, bu_r7_4800

AND R3, R3, #0
ADD R3, R1, #0
AND R0, R0, #0

Loop_10
	LD R4, minus_10
	ADD R3, R3, R4
	BRn END_LOOP_10
	
	ADD R0, R0, #1
	BR Loop_10

END_LOOP_10
	ADD R0, R0, #0
	BRp print_1 
	finish_print
	LD R4, DEC_10
	ADD R3, R3, R4
	AND R0, R0, #0
		
Loop_1
	LD R4, minus_1
	ADD R3, R3, R4
	BRn END_LOOP_1
	ADD R0, R0, #1
	BR Loop_1

END_LOOP_1
	LD R4, offset_print
	ADD R0, R0, R4	
	OUT
	LD R4, DEC_1
	ADD R3, R3, R4
	AND R0, R0, #0

LD R0, bu_r0_4800
LD R1, bu_r1_4800
LD R2, bu_r2_4800
LD R3, bu_r3_4800
LD R4, bu_r4_4800
LD R5, bu_r5_4800
LD R6, bu_r6_4800
LD R7, bu_r7_4800 
ret

print_1
	LD R4, offset_print
	ADD R0, R0, R4
	OUT 
	BR finish_print
 
;--------------------------------
;Data for subroutine print number
;--------------------------------
value_ptr	.FILL xB400
offset_print	.FILL #48
minus_10	.FILL #-10
DEC_10		.FILL #10
minus_1		.FILL #-1
DEC_1 		.FILL #1
bu_r0_4800	.BLKW #1
bu_r1_4800	.BLKW #1
bu_r2_4800	.BLKW #1
bu_r3_4800	.BLKW #1
bu_r4_4800	.BLKW #1
bu_r5_4800	.BLKW #1
bu_r6_4800	.BLKW #1
bu_r7_4800	.BLKW #1

.ORIG x5000
MENUSTRING .STRINGZ "**********************\n* The Busyness Server *\n**********************\n1. Check to see whether all machines are busy\n2. Check to see whether all machines are free\n3. Report the number of busy machines\n4. Report the number of free machines\n5. Report the status of machine n\n6. Report the number of the first available machine\n7. Quit\n"

.ORIG xB400			; Remote data
BUSYNESS .FILL x0000		; <----!!!BUSYNESS VECTOR!!! Change this value to test your program.

;---------------	
;END of PROGRAM
;---------------	
.END
