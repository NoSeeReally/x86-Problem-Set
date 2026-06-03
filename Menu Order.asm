.model small
.stack 64
.data
menu db 'Milk..','Coffee','Tea...','Juice.' ;0,6,12,18 

input db ' ' 
off_Set db 0


.code

main proc near
    mov ax, @data
    mov es, ax
    mov ds, ax 
    
    call display_Menu  
    call charInput
    cmp input, 0
    jl terminate
    cmp input, 3
    ja terminate
     
    call processInput 
    call displayOrder 
    jmp exit
    
    terminate:
    
    mov al,'X'
    call displayChar
    
    exit:
    mov ax, 4c00h
    int 21h
main endp 

setVideoMode proc near
    mov ah, 00h
    mov al, 03h
    int 10h   
    ret
setVideoMode endp

setCursorPos proc near
    mov ah, 02h
    mov bh, 00h 
    int 10h  
    ret
setCursorPos endp

displayChar proc near
    mov ah, 09h
    mov bh, 00h
    mov bl, 04eH  
    mov cx, 1 
    int 10h
    ret
displayChar endp    

display_Menu proc near
    call setVideoMode
    lea si, menu
    mov dx, 00
    
    mov cx, 4   
    Outer:
        push cx
        mov cx, 6
        inner:
            push cx
            call setCursorPos
            mov al,[si] 
            call displayChar
            inc si
            inc dl
            pop cx
        loop inner
        inc dh
        mov dl, 0
        pop cx
   loop Outer
            
    
       
    ret
display_Menu endp

charInput proc near
    ;inc dh
    ;mov dl, 0
    call setCursorPos
    
    mov ah, 01h
    int 21h 
    
    mov input, al
    sub input, 30h 
    sub input, 1
       
    ret
charInput endp 

processInput proc near
   
    mov al, 6
    mov bl, input
    mul bl
    mov off_Set, al    
    
    
    ret
processInput endp 

displayOrder proc near 
    ;cmp input, 1
    ;jb invalid
    ;cmp input, 4
    ;ja invalid
    
    
    lea si, menu
    mov ch, 00
    mov cl, off_Set
    add si, cx
    
    inc dh
    mov dl, 0
    mov cx, 6
    displayItem:
        push cx 
        call setCursorPos
        mov al, [si]  
        call displayChar
        inc si
        inc dl
        pop cx        
    loop displayItem   
    ;jmp exit
            
            
    ;invalid: 
        ;mov al, 'X'
        ;call displayChar        
    
    ;exit:   
    ret
displayOrder endp    