data segment
        mass db 00000001b, 11111111b, 01111010b, 01100000b,00100101b,10001000b,01110000b,01110000b,0
data ends
code segment
assume cs: code, ds: data
start: mov  ax, data
       mov  ds, ax  
       lea  bx, mass
       mov cx, 8
beg:   mov al,[bx]
       mov si, cx
       mov cx, 8
check: test ax, 0500h
       jnz no
       test ax, 0200h
       jz no
       inc di 
no:    shl ax, 1       
       loop check
       mov cx, si
       inc bx
       loop beg
quit:  mov ax,4C00h 
       int 21h      
code ends
end start
