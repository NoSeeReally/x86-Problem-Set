.model small
.stack 64
.data 
input db ?
.code


main proc near
    mov ax, @data
    mov es, ax
    mov ds, ax  
    
    call reqInp
    call setVideoMode 
    call writePrecCharacters
    
    mov ax, 4c00h
    int 21h    
main endp  

setVideoMode proc near
    mov ah, 00h
    mov al, 03h
    int 10h
      
    ret
setVideoMode endp    

reqInp proc near
    mov ah, 01h
    int 21h
    
     
    inc al
    mov input, al
    
    ret
reqInp endp  
setCursorPos proc near
    mov ah, 02
    mov bh, 00
    int 10h
    
    ret
setCursorPos endp

dispChar proc near
    mov ah, 0Ah
    mov cx, 1
    int 10h
       
    ret   
dispChar endp    
             
WritePrecCharacters proc near
    
    mov dh,0
    mov dl, 0
    
    Display: 
        call setCursorPos
        mov al, input
        call dispChar
        
        inc input 
        cmp input, 255
        je exit
        
        inc dl
        
        
        cmp dl, 80
        jne Display
        
        inc dh
        mov dl, 0
        jmp Display
        
        
    
    exit:
    ret
WritePrecCharacters endp    