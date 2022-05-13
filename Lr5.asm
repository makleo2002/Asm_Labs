data segment	
    
NOTE1  db 0Dh, 0Ah,"Enter your main string: ",0Dh, 0Ah, '$' 
NOTE2  db 0Dh, 0Ah,"Enter your substring: ",0Dh, 0Ah, '$'
NOTE3  db 0Dh, 0Ah,"The word is found ",0Dh, 0Ah, '$'
NOTE4  db 0Dh, 0Ah,"The word is not found ",0Dh, 0Ah, '$'   	 
IN_MAINSTR db 80, ?, 82 dup (?)
IN_SUBSTR db 80, ?, 82 dup (?) 
Start_letter db 1
count db 0		
	
data ends 

code segment
assume cs:code, ds:data
START: 	
        mov ax, @data 
        mov ds, ax 		
         
        
        call FindStr
        
     	      	   
 
Exit:                                  
        mov     ax,     4C00h          
        int     21h	 

;//////////////////////////////////////////////////////////        
FindStr proc near  
            
        lea dx,NOTE1            ;Print Note1
        mov ah,09h
        int 21h
        
        
        lea dx, IN_MAINSTR  
        mov ah, 0ah             ;enter the main string
        int 21h 
                    
        lea dx,NOTE2            ;Print Note2
        mov ah,09h
        int 21h
        
        
        lea dx, IN_SUBSTR  
        mov ah, 0ah             ;enter the substring
        int 21h    
        
        xor dx,dx 
        xor cx,cx
        mov dl,IN_MAINSTR+1
        mov cl,IN_SUBSTR+1
        sub dl,cl
        inc dl                    ;get the number of tries      
         
         cld                     ;clear the direction flag (DF)
         
    lea     si, IN_MAINSTR + 2       ;getting the addresses of strings 
    lea     di, IN_SUBSTR + 2  
    
Comparing:
    mov     al, [si]            ;Next character from the string
    cmp     al, [di]            ;Compare the first character from the substring(it doesn't change)
    je      Checking               ; with a character of the string 
    jne   Going_to_the_next_letter
    
Going_to_the_next_letter: 
    inc Start_letter 
    inc     si                  ;DI remains at start of the word
    dec     dl
    jnz     Comparing            ;More tries to do
    jmp     Not_Found  
    
Checking: 
    
    push di
    push si
    
    repe cmpsb  
    pop si
    pop di
    jne Comparing        ;if ZF=0 (letters aren't the same) go to the next letter 
                         ;in the main string                     
    jmp Found            ;if ZF=1-> Found

Found:  
    lea dx,NOTE3            ;Print Note3
    mov ah,09h
    int 21h
    jmp Exit  
    
Not_Found:
    lea dx,NOTE4            ;Print Note4
    mov ah,09h
    int 21h
    jmp Exit                            
    ret 8
              
FindStr endp  
 

     
                                                   
code ends
end start
