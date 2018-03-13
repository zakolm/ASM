    StkSeg  SEGMENT PARA STACK 'STACK'
        DB      200h DUP (?)
    StkSeg  ENDS

    DSEG SEGMENT PARA PUBLIC 'DATA'
        N DW 6
        X DB '123456'
          DB '123456'
          DB '123456'
          DB '123456'
          DB '123456'
          DB '123456'
    DSEG ENDS

    CODE SEGMENT PARA PUBLIC 'CODE'
        ASSUME CS:CODE, DS:DSEG, SS:StkSeg
        START PROC FAR
            MOV AX,DSEG
            MOV DS,AX
            XOR AX,AX
            MOV SI,OFFSET X
            MOV BX,SI                       ; Заносим в регистры BX и SI базовые адреса начала матрицы
            MOV DX,N                        ; Размерность матрицы X
            MOV BP,N                        ; Размерность матрицы X
            MOV CX,DX                       ; В регистры CX и DX заносим размеры матрицы
            ADD BX,DX                       ; Переходим к второй строке матрицы
            DEC CX                          ; Пропускаем клетку, лежащую на главной диагонали, которая не изменяется
            M1:
                DEC BP                      ; Пропускаем уже измененные клетки
                MOV SP,BX                   ; Сохраняем размеры матрицы
            M2:
                INC SI                      ; Переходим к следующему столбцу
                MOV AL,[SI]
                XCHG AL,[BX]
                XCHG AL,[BX]
                XCHG AL,[BX]
                MOV [SI],AL                 ; Обмен значений столбцов и строк
                ADD BX,DX                   ; Переходим к следующей строке
            LOOP M2                         ; Обмениваем целиком строку и столбец
                MOV BX, SP
                MOV CX, BP
                ADD BX,DX
                INC BX                      ; Переходим к следующему столбцу, пропуская клетку, лежащую на главной диагонали
                MOV SI,BX
                SUB SI,DX                   ; И к следующей строке
            LOOP M1                         ; И опять производим обмен очередных пар строк и столбцов
            EXIT:                           ; Для break point
                ;LOOP M1
        START ENDP
    CODE ENDS
END  START