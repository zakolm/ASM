; ФАЙЛ lr05-1-1.asm
EXTRN OUTPUT_X: NEAR

STK SEGMENT PARA STACK 'STACK'
    DB 64 DUP (?)
STK ENDS

DSEG SEGMENT PARA PUBLIC 'DATA'
    PUBLIC X
    X DB 'R'
DSEG ENDS

CSEG SEGMENT PARA PUBLIC 'CODE'
    ASSUME CS: CSEG, DS: DSEG, SS: STK
    MAIN:
        MOV AX,DSEG
        MOV DS,AX

        CALL OUTPUT_X

        MOV AX,4c00h
        INT 21h
CSEG ENDS
END MAIN