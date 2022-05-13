;x=2b-1+4(a-3c) 

org  100h 

data segment
a dw 6
b dw 3
c dw 1
x dw ?
data ends
 
code segment 
assume cs: code, ds: data
start: mov ax, data  
mov ds,ax
mov ax, a
mov bx, b 
mov cx, c
sal bx, 1  ;2b
dec bx     ;2b-1
sal cx, 1  ;2c
add cx,cx  ;3c
sub ax,cx  ;a-3c
sal ax, 2  ;4(a-3c)
add ax,bx ;2b-1+4(a-3c)
mov x,ax   ;x=2b-1+4(a-3c)
quit:
mov ax,4c00h
int 21h     
code ends
end start