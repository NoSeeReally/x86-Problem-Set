.model small
.stack 64
.data
str db 'Assembly Language$'
.code
main proc near
    mov ax, @data
    mov es, ax
    mov ds, ax
    
    call input    
           
    mov ax, 4c00h
    int 21h   
main endp       

input proc near
    mov ah, 00h
    int 16h
    
    mov dh, al 
    
    mov ah, 00h
    int 16h
    
    mov dl, al
    
    lea bx, str
    mov cx, 18
    
    start:
        mov ah, [bx]
        mov al, [bx+1]
        
        cmp dx, ax
        je C1
        
        add bx, 1
    loop start
    
    jmp exit
    
    C1:
        mov [bx], '*'
        mov [bx+1], '#'
        add bx, 2
        dec cx
    jmp start
    
    exit:                  
    ret
input endp    