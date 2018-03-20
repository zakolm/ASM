; ФАЙЛ lr05-3-1.asm
SSTACK SEGMENT PARA STACK 'STACK'
    DB 64 DUP (?)
SSTACK ENDS

SD1 SEGMENT PARA PUBLIC 'DATA'
    S1 DB 'Y'
    DB 65535 - 2 DUP (0)
SD1 ENDS

SD2 SEGMENT PARA PUBLIC 'DATA'
    S2 DB 'E'
    DB 65535 - 2 DUP (0)
SD2 ENDS

SD3 SEGMENT PARA PUBLIC 'DATA'
    S3 DB 'S'
    DB 65535 - 2 DUP (0)
SD3 ENDS

CSEG SEGMENT PARA PUBLIC 'CODE'
    ASSUME CS: CSEG, DS: SD1, SS: SSTACK
    OUTPUT:
        MOV AH,2
        INT 21h
        MOV DL,13
        INT 21h
        MOV DL,10
        INT 21h
        RET

    MAIN:
        mov AX,SD1
        mov DS,AX
        mov DL,S1
        CALL OUTPUT

    ASSUME DS: SD2
        MOV AX,SD2
        MOV DS,AX
        MOV DL,S2
        CALL OUTPUT

    ASSUME DS: SD3
        MOV AX,SD3
        MOV DS,AX
        MOV DL,S3
        CALL OUTPUT

    EXIT:
        MOV AX, 4c00h
        INT 21h
CSEG ENDS
END MAIN