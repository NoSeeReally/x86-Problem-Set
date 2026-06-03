.model small
.stack 64
.data 
sum dw 0 
    
ParaList Label Byte
max_len db 5                   
act_len db ?
kb_data db 4 dup(' ') 



.code
main proc near
    mov ax, @data
    mov es, ax
    mov ds, ax  
    
    call reqStringInput 
    call processInput
    
    mov ax, 4c00h
    int 21h   
main endp

reqStringInput proc near
    mov ah, 0ah
    lea dx, ParaList
    int 21h  
    ret
reqStringInput endp 

processInput proc near
    
    lea si, kb_data  
    
    mov ch, 0
    mov cl, act_len  
    
    process:
        mov al, [si]
        sub al, 30h 
        mov ah, 00
       
        add sum, ax
        inc si
    loop process   
    ret
processInput endp

