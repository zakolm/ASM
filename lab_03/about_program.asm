     SSTACK     SEGMENT PARA STACK  'STACK'
                DB   64 DUP('����____')
     SSTACK     ENDS

     DSEG          SEGMENT  PARA PUBLIC 'DATA'
     X         DB      2, 3, 4, 5, 6, 7, 8
     B         DB      1B
     K         DB      ?
     DSEG          ENDS
PAGE
     CSEG      SEGMENT PARA PUBLIC 'CODE'
               ASSUME CS:CSEG,DS:DSEG,SS:SSTACK

     START     PROC FAR
               MOV  AX,DSEG ; �������� ������� ������ datasec � ds
               MOV  DS,AX

     M1:       MOV   K,2 ; ���������� � � 2
               MOV SI,0; � si 0
               MOV CX,8; 
               MOV AL,B; � - ��� ���������� � �� �����
     M2:       TEST X[SI],AL; ��������� � ��� ������ � �� ��������� si � al
               JNZ  M3; ���� ���� ZF �� ����� 0 ����������� �� ����� �3
               DEC  K; ���������� �� 1
               JZ   M4; ���� ZF == 1 ������� �� �4 
     M3:       INC  SI; ����������� si
               LOOP M2; ����������� �� ����� �2 ���� cx != 0 � cx-- � ���� cx == 0 �� ������������ �� �2 
     M4:       ADD  SI,'0'; �������� ��� ������� 0 � si
               MOV  AH,2; ������� ��� ��� - ����� 1 askii ������� ����������� � dl
               MOV  DX,x[SI]; �������� � dx ��� ������� (���������, ��� � dh ����� 0, � � dl ����� ���)
     M5:       INT  21H; �������� ���������� ���
     M6:       MOV  AL,0; ����������� al
	       MOV  AH,4Ch; ������� ��� ��� - ��������� ���������
               INT 21H; �������� ���������� ���
     START     ENDP
               
     CSEG      ENDS
               END  START
