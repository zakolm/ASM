EXTRN	SCAN : NEAR
EXTRN	F1 : NEAR	; unsigned	bin
EXTRN	F2 : NEAR	; signed	bin
EXTRN	F3 : NEAR	; unsigned	dec
EXTRN	F4 : NEAR	; signed	dec
EXTRN	F5 : NEAR	; unsigned	hex
EXTRN	F6 : NEAR	; signed	hex

SSTACK	SEGMENT PARA STACK 'STACK'
		DB		64 DUP('STACK___')
SSTACK	ENDS

DSEG	SEGMENT PARA PUBLIC 'DATA'
		F		DW	F1, F2, F3, F4, F5, F6
		X		DW	5
		
		MENU	DB	'	MENU', 10, 13
				DB	'0. Print menu', 10, 13
				DB	'1. Input number', 10, 13
				DB	'2. Num as unsigned bin', 10, 13
				DB	'3. Num as signed bin', 10, 13
				DB	'4. Num as unsigned dec', 10, 13
				DB	'5. Num as signed dec', 10, 13
				DB	'6. Num as unsigned hex', 10, 13
				DB	'7. Num as signed hex', 10, 13
				DB	'8. Exit', 10, 13, '$'
		
		ENT		DB	'> $'
		NLINE	DB	10, 13, '$'
DSEG	ENDS

CSEG	SEGMENT PARA PUBLIC 'CODE'
		ASSUME CS:CSEG, DS:DSEG, SS:SSTACK
BEGIN:
		MOV  AX, DSEG
		MOV  DS, AX
PMENU:
		MOV  AH, 9
		MOV  DX, OFFSET MENU
		INT  21H
		
PRINT_ENT:
		MOV  AH, 9
		MOV  DX, OFFSET ENT
		INT  21H
SCAN_CHOICE:
		MOV  AH, 8
		INT  21H
		
		CMP  AL, '0'
		JB   SCAN_CHOICE
		CMP  AL, '9'
		JA   SCAN_CHOICE
		
		MOV  BL, AL
		XOR  BH, BH
		
		MOV  AH, 2
		MOV  DL, AL
		INT  21H
		
		MOV  AH, 9
		MOV  DX, OFFSET NLINE
		INT  21H
		
PROCESS:
		SUB  BX, '0'
		
		CMP  BX, 8
		JAE  EXIT
		
		CMP  BX, 0
		JE   PMENU
		
		CMP  BX, 1
		JE   INPUT_NUMBER
		
		SUB  BX, 2
		SHL  BX, 1
		
		PUSH X
		PUSH SI
		CALL F[BX]
		
		JMP  PRINT_ENT
		
INPUT_NUMBER:
		CALL SCAN
		
		MOV  X, AX
		MOV  SI, DX
		
		JMP  PRINT_ENT
		
EXIT:
		MOV  AH, 4CH
		XOR  AL, AL
		INT  21H
		
CSEG	ENDS
END BEGIN