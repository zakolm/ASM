;   ФАЙЛ lr05-4-2.asm
PUBLIC CHANGE
EXTRN X: byte

SD2 SEGMENT para 'DATA'

    Y db 'Y'
SD2 ENDS

SC2 SEGMENT para public 'CODE'
    ASSUME CS:SC2, DS:SD2
    CHANGE:
        ;MOV BX,DS
        MOV BL,X
        MOV AX,SD2
        MOV DS,AX
        MOV CL,Y
        ;XCHG SI,DI
        MOV X,CL
        MOV Y,BL
        MOV AH,2
        MOV DL,Y

        INT 21h

        EE:
            MOV AX, 4c00h
            INT 21h
SC2 ENDS
END