// lab11.cpp: определяет точку входа для консольного приложения.
//

#include "stdafx.h"
#include <cstdlib>

void trans_asm(unsigned __int8 arr[][5]);
void trans_c(unsigned __int8 arr[][5]);
void print_matrix(unsigned __int8 arr[][5]);

int _tmain(int argc, _TCHAR* argv[])
{
    unsigned __int8 arr1[5][5] = {{1,2,3,4,5}, {6,7,8,9,10}, {11,12,13,14,15}, {16,17,18,19,20}, {21,22,23,24,25}};
    unsigned __int8 arr2[5][5] = {{0,0,0,0,0}, {1,1,1,1,1}, {2,2,2,2,2}, {3,3,3,3,3}, {4,4,4,4,4}};
    
	printf("Transp ASM:\nOriginal matrix:\n");
    print_matrix(arr1);
    trans_asm(arr1);
	printf("Res matrix\n");
    print_matrix(arr1);

	printf("Transp C:\nOriginal matrix:\n");
    print_matrix(arr1);
	trans_c(arr1);
	printf("Res matrix\n");
    print_matrix(arr1);

    system("pause");
	return 0;
}

//
// Печать матрицы
//
void print_matrix(unsigned __int8 arr[][5])
{
    for (int i = 0; i < 5; i++)
    {
        for (int j = 0; j < 5; j++)
        {
            printf("%2hhu ", arr[i][j]);
        }
        printf("\n");
    }
    printf("\n");
}

//
// Транспонирование матрицы на ассемблере
//
void trans_asm(unsigned __int8 arr[][5])
{
	__asm
    {
		PUSH EBP
		MOV EBP, arr
        ;Транспонирование матрицы - цикл в цикле
        MOV ECX, 4 ; Задаём размер треугольной области (т.е. сторона - 1)
        MOV EDX, 2 ; на сколько нужно сместиться, чтобы перейти на строку ниже
        MOV ESI,23 ; стартовый индекс строки (право низ без диагонали)
        MOV EDI,19 ; стартовый индекс столбца (право низ без диагонали)

        M1:
	        MOV EBX, ECX ; Запоминаем счётчик первого цикла
            M2:
                ; Обмен ячеек матрицы
                MOV AL, [EBP][ESI]
                MOV AH, [EBP][EDI]

                MOV [EBP][ESI], AH
                MOV [EBP][EDI], AL
                DEC ESI ; Просматриваем строку
                SUB EDI, 5 ; Просматриваем столбец
            loop M2
            SUB ESI, EDX ; Переходим на строку выше
            MOV EDI, ESI ; Переходим на столбец левее 
            SUB EDI, 4
            MOV ECX, EBX ; Восстанавливаем счётчик цикла
	        INC EDX ; Увеличиваем отступ для перехода между строками
        loop M1
		POP EBP
    }
}

//
// Транспонирование матрицы на Си
//
void trans_c(unsigned __int8 arr[][5])
{
	unsigned __int8 temp = 0;
	for (int i = 0; i < 5; ++i)
		for (int j = 0; j < 5; ++j)
		{
			temp = arr[i][j];
			arr[i][j] = arr[j][i];
			arr[j][i] = temp;
		}
}