COMMENT *
ZAKOLESNIK MAKSIM IU7-43
    int p(int N) - N!
*
StkSeg SEGMENT PARA STACK 'STACK'
    DB 64 DUP (?)
StkSeg ENDS

DSeg SEGMENT PARA PUBLIC 'DATA'
    M DW 5                                      ; NUMBER
    fakt1 DW ?                                  ; FACTORIAL
DSeg ENDS

CODESeg SEGMENT PARA PUBLIC 'CODE'
    ASSUME CS: CODESeg, DS: DSeg, SS: StkSeg
    BEGIN PROC FAR
        MOV AX,DSeg
        MOV DS,AX
        XOR AX,AX
        CALL p                                  ; FACTORIAL
        MOV fakt1,AX
        EXIT:
            MOV AX,4c00h
            INT 21h
    BEGIN ENDP
    MYPROC PROC                                 ; FACTORIAL(INT N)
        p:
            PUSH BP                             ; BP ~ N
            MOV BP,SP
            MOV CX,[BP+4]
            MOV BP,CX
            CMP BP,1                            ; BP > 1
            JG  L2                              ; IF (BP > 1)
            MOV AX, 1                           ; IF (N = 0 OR N = 1)
            JMP L3                              ; IF (N = 0 OR N = 1)
        L2:
            DEC CX
            push cx
            CALL p
            POP cx
            IMUL BP;
        L3:
            POP BP
            RET
    MYPROC ENDP
CODESeg ENDS
END BEGIN