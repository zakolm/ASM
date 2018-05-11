.386
.model flat, c

comment *
1246
      96764
-------------
      12464
      
12347
    74563
-------------
    12347
*

public CopyStr

.code
CopyStr proc
    push    ebp
    mov     ebp, esp
    push    esi
    push    edi
    
    mov     ecx, [ebp + 16] ; Длина (L)
    mov     edi, [ebp + 12] ; Приёмник (s2)
    mov     esi, [ebp + 8]  ; Источник (s1)

    mov     eax, edi
    cld                     ; df := 0

    cmp     edi, esi        ; приёмник, источник (s2, s1)
    je      exit            ; приёмник == источник (s2 == s1)
    jb      norev           ; приёмник < источник (s2 < s1)

    ; приёмник > источник (s2 > s1)
    std                     ; df := 1
    add     edi, ecx
    dec     edi
    add     esi, ecx
    dec     esi

    norev:
    rep     movsb			; из esi в edi длина ecx DF направление (!!!)

    exit:
    pop  edi
    pop  esi
    pop  ebp

    ret
CopyStr endp
end
