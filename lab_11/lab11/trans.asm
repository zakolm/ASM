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

;���������������� ������� - ���� � �����
MOV ECX, 4 ; ����� ������ ����������� ������� (�.�. ������� - 1)
MOV EDX, 2 ; �� ������� ����� ����������, ����� ������� �� ������ ����
MOV ESI,23 ; ��������� ������ ������ (����� ��� ��� ���������)
MOV EDI,19 ; ��������� ������ ������� (����� ��� ��� ���������)

M1:
	;MOV EBX, ECX ; ���������� ������� ������� �����
    PUSH ECX
	M2:
        ; ����� ����� �������
        MOV AL, [EBX][ESI]
        MOV AH, [EBX][EDI]

        MOV [EBX][ESI], AH
        MOV [EBX][EDI], AL
        DEC ESI ; ������������� ������
        SUB EDI, 5 ; ������������� �������
    loop M2
    SUB ESI, EDX ; ��������� �� ������ ����
    MOV EDI, ESI ; ��������� �� ������� ����� 
    SUB EDI, 4
    ;MOV ECX, EBX ; ��������������� ������� �����
    POP ECX
	INC EDX ; ����������� ������ ��� �������� ����� ��������
loop M1

POP EDI
POP ESI
POP EBX
POP EBP
RET

trans ENDP
END