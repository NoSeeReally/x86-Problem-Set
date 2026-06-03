.model small
.stack 64
.data
Alphabet_Table db 'ABCD', 'EFGH', 'IJKL', 'MNOP', 'QRST', 'UVWX', 'YZ..'

Para_List Label Byte
max_len db 5
act_len db ?
kb_data db 4 dup(' ')

match db 0 

positiveMessage db 'Input is present in table'
negativeMessage db 'Input is not present in table'
.code
main proc near
    mov ax, @data
    mov es, ax
    mov ds, ax  
    
     call stringInput
     call authenticate_String
     call setVideoMode       
     call displayMessage
    
    
    mov ax, 4c00h
    int 21h
main endp 
authenticate_String proc near 
    CLD
    lea si, Alphabet_Table 
    
    mov cx, 7
    AuthenticateString: 
        lea di, kb_data
        push cx 
        push si
        mov cx, 4
        
        inner:
            repe cmpsb
            
        cmp cx, 0
        je found
        
        pop si 
        pop cx
        add si, 4
        
    
    loop AuthenticateString
    jmp exit
    found:
        mov match, 1 
        pop si
        pop cx
    
    exit:
        
    ret
authenticate_String endp

stringInput proc near
    mov ah, 0ah
    lea dx, Para_List  
    int 21h
    
    ret
stringInput endp 

setVideoMode proc near  
    mov ah, 00h
    mov al, 03h
    int 10h
    ret
setVideoMode endp

setCursorPos proc near
    mov ah, 02h
    mov bh, 00 
    int 10h
    
    ret
setCursorPos endp 

displayChar proc near 
    mov ah, 09h
    mov bh, 00h
    mov bl, 0B0H
    mov cx, 1 
    int 10h
    
    ret
displayChar endp

displayMessage proc near  
    
    cmp match, 1
    je positive
    
    negative: 
        lea si, negativeMessage 
        mov dx, 00
        
        mov cx, 29 
        writeNegMessage:  
            push cx
            call setCursorPos
            mov al, [si]
            call displayChar
            inc si
            inc dl 
            pop cx
        loop writeNegMessage
        
    jmp end
    
    positive:
        lea si, positiveMessage
        mov dx, 00 
        
        mov cx, 25
        writePosMessage:
            push cx
            call setCursorPos
            mov al,[si]
            call displayChar
            inc si
            inc dl 
            pop cx
        loop writePosMessage
        
    end:
    
    ret
displayMessage endp    