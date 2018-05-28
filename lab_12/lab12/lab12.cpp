// lab12.cpp: определяет точку входа для консольного приложения.
//

#include "stdafx.h"

extern "C" void ASM_MAIN();

int _tmain(int argc, _TCHAR* argv[])
{
    ASM_MAIN();

	return 0;
}

