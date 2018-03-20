     SSTACK     SEGMENT PARA STACK  'STACK'
                DB   64 DUP('СТЕК____')
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
               MOV  AX,DSEG ; получаем адресок секции datasec в ds
               MOV  DS,AX

     M1:       MOV   K,2 ; записываем в к 2
               MOV SI,0; в si 0
               MOV CX,8; 
               MOV AL,B; в - это переменная а не цифра
     M2:       TEST X[SI],AL; побитовое и для адреса х со смещением si и al
               JNZ  M3; если флаг ZF не равен 0 перемещение по метке м3
               DEC  K; уменьшение на 1
               JZ   M4; если ZF == 1 переход по м4 
     M3:       INC  SI; увеличиваем si
               LOOP M2; перемещение по метке м2 если cx != 0 и cx-- а если cx == 0 не перемещаться по м2 
     M4:       ADD  SI,'0'; добавить код символа 0 в si
               MOV  AH,2; функция для дос - вывод 1 askii символа помещенного в dl
               MOV  DX,x[SI]; помещаем в dx код символа (получится, что в dh лежит 0, а в dl лежит код)
     M5:       INT  21H; передача управления дос
     M6:       MOV  AL,0; освобождаем al
	       MOV  AH,4Ch; команда для дос - завершить программу
               INT 21H; передача управления дос
     START     ENDP
               
     CSEG      ENDS
               END  START
