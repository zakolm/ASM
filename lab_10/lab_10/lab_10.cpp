// lab_10.cpp: определяет точку входа для консольного приложения.

#include "stdafx.h"

#include <stdio.h>

extern "C" int DlinaStroki(char *s);
extern "C" char *CopyStr(char *s1, char *s2, int L); // s1 - источник, s2 - приёмник

int _tmain(int argc, _TCHAR* argv[])
{
    char stroka1[80] = "1234567";
    char stroka2[80] = "\0";
    char *tempPtr;
    int lenStr1;
    int lenStr2;
    
    lenStr1 = DlinaStroki(stroka1);
    lenStr2 = DlinaStroki(stroka2);

    printf("Source : %s - %d\n", stroka1, lenStr1);
    printf("Destenition : %s - %d\n", stroka2, lenStr2);

	lenStr2 = lenStr1;
    tempPtr = CopyStr(stroka1, stroka2, lenStr2);

    lenStr1 = DlinaStroki(stroka1);
    lenStr2 = DlinaStroki(stroka2);

    printf("Source : %s - %d\n", stroka1, lenStr1);
    printf("Destenition : %s - %d\n", stroka2, lenStr2);

    printf("\nFor exit, press Enter");
    getchar();

    return 0;
}

