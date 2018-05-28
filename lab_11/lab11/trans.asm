.386
.model FLAT,C
PUBLIC trans

.CODE
trans PROC

PUSH EBP
MOV EBP, ESP
PUSH EBX
PUSH ESI
PUSH EDI
MOV EBX, [EBP+8]

;Транспонирование матрицы - цикл в цикле
MOV ECX, 4 ; Задаём размер треугольной области (т.е. сторона - 1)
MOV EDX, 2 ; на сколько нужно сместиться, чтобы перейти на строку ниже
MOV ESI,23 ; стартовый индекс строки (право низ без диагонали)
MOV EDI,19 ; стартовый индекс столбца (право низ без диагонали)

M1:
	;MOV EBX, ECX ; Запоминаем счётчик первого цикла
    PUSH ECX
	M2:
        ; Обмен ячеек матрицы
        MOV AL, [EBX][ESI]
        MOV AH, [EBX][EDI]

        MOV [EBX][ESI], AH
        MOV [EBX][EDI], AL
        DEC ESI ; Просматриваем строку
        SUB EDI, 5 ; Просматриваем столбец
    loop M2
    SUB ESI, EDX ; Переходим на строку выше
    MOV EDI, ESI ; Переходим на столбец левее 
    SUB EDI, 4
    ;MOV ECX, EBX ; Восстанавливаем счётчик цикла
    POP ECX
	INC EDX ; Увеличиваем отступ для перехода между строками
loop M1

POP EDI
POP ESI
POP EBX
POP EBP
RET

trans ENDP
END