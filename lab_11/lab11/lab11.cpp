// lab11.cpp: ���������� ����� ����� ��� ����������� ����������.
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
// ������ �������
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
// ���������������� ������� �� ����������
//
void trans_asm(unsigned __int8 arr[][5])
{
	__asm
    {
		PUSH EBP
		MOV EBP, arr
        ;���������������� ������� - ���� � �����
        MOV ECX, 4 ; ����� ������ ����������� ������� (�.�. ������� - 1)
        MOV EDX, 2 ; �� ������� ����� ����������, ����� ������� �� ������ ����
        MOV ESI,23 ; ��������� ������ ������ (����� ��� ��� ���������)
        MOV EDI,19 ; ��������� ������ ������� (����� ��� ��� ���������)

        M1:
	        MOV EBX, ECX ; ���������� ������� ������� �����
            M2:
                ; ����� ����� �������
                MOV AL, [EBP][ESI]
                MOV AH, [EBP][EDI]

                MOV [EBP][ESI], AH
                MOV [EBP][EDI], AL
                DEC ESI ; ������������� ������
                SUB EDI, 5 ; ������������� �������
            loop M2
            SUB ESI, EDX ; ��������� �� ������ ����
            MOV EDI, ESI ; ��������� �� ������� ����� 
            SUB EDI, 4
            MOV ECX, EBX ; ��������������� ������� �����
	        INC EDX ; ����������� ������ ��� �������� ����� ��������
        loop M1
		POP EBP
    }
}

//
// ���������������� ������� �� ��
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