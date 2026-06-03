.model small
.stack 64
.data  
total db 0 
PARA_LIST LABEL BYTE
max_len db 4
act_len db ?
kb_data db 4 dup(' ') 


.code
main proc near
    mov ax, @data
    mov es, ax
    mov ds, ax
        
     call stringInp  
     call processStringInp 
           
    mov ax, 4c00h
    int 21h          
main endp 

stringInp proc near 
    lea dx, PARA_LIST
    mov ah, 0ah
    int 21h
       
    ret
stringInp endp  

processStringInp proc near
    lea si, kb_data
    
    mov cx, 3 ;input is limited to 1 byte only
    Process:
        sub [si], 30h
        
        mov al, total
        mov bl, 10
        mul bl
        mov total, al
        mov al, [si]
        add total, al
        
        inc si
              
    loop Process    
    ret
processStringInp endp    