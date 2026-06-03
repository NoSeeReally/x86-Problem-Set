.model small
.stack 64
.data
numbers db 1,2,3,4,5
present db 0
input db ' ' 
result db 0
.code
main proc near
    mov ax, @data
    mov es, ax
    mov ds, ax 
    
    call reqCharInp  
    call checkInput
    
    
    mov ax, 4c00h
    int 21h
main endp

reqCharInp proc near
    mov ah, 01h
    int 21h
    
    mov input, al
    sub input, 30h 
      
    ret
reqCharInp endp 

checkInput proc near
    
    cld 
    mov cx, 5
    lea di, numbers
    mov al, input
    repne scasb
    jne exit
    
    found:
        mov result, 1
    
    exit:
       
    ret
checkInput endp    