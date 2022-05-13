                           
data segment		 

NOTE  db 0Dh, 0Ah,"Your counting is finished ",0Dh, 0Ah, '$'

	
data ends 

code segment
assume cs:code, ds:data
START: 	
        mov ax, @data 
        mov ds, ax 		
         
        xor cx,cx 
        mov cx,10
        xor dx,dx
        
ChangeNumber:
        call Print_Number
        call Waiting
        inc dl
        call Carriage_Return
        loop ChangeNumber
               
        call Print_Mess
 
Exit:
        mov     ax,     4C00h
        int     21h	 



Print_Number proc near 
    pusha                   ;saving the data from AX,BX,CX,DX
    
    mov ah,2
    add dl,'0'
    int 21h                 ;printing a number 
    
    popa                    ;getting the data from the stack
    ret   
Print_Number endp
 
 
Carriage_Return proc near       ;returning the carriage to the
    push dx                     ;beginning
    
    mov ah,2
    mov dl,0dh                  ;0dh - it is the carriage
    int 21h 
    
    pop dx
    ret  
    
Carriage_Return endp
 
 
Waiting proc near   
  push cx
  mov cx, 180
Next:  
  nop
  loop  Next
  pop  cx
  ret  

Waiting endp 


Print_Mess proc near         ;Print Note
    lea dx,NOTE            
    mov ah,09h
    int 21h
    ret   
    
Print_Mess endp
    	               
 	               
code ends
end start
