data    segment
min     db     ?
mass    db     -10, 24, 76, -79, -128, 127, -24, 15, 124, 97
data    ends
 
 
code segment
        assume cs: code, ds: data
start:  mov    ax, data
        mov    ds, ax      
        lea    bx, mass    
        mov    cx, 10      
        mov    dx, 8080h   
 
beg:    mov    al, [bx]    
        cbw                
 
        xor    al, ah      
        sub    al, ah      
                           
 
        cmp    dl, al      
        jbe    no          
        mov    dl, al      
        mov    dh, [bx]    
 
no:     inc    bx          
        loop   beg
 
        mov    min, dh
quit:   mov    ax, 4C00h   
        int    21h         
code ends
end start