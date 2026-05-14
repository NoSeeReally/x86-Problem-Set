.model small
.stack 64
.data
prime db 'Prime'
notPrime db 'Not Prime'
isPrime db 0
input db 'Input:'
userInput db ?
.code
main proc near
 mov ax,@data
 mov es, ax
 mov ds, ax

    call setVideoMode
    call takeUserInput  
    call displayResult
        
  
 mov ax, 4c00h
 int 21h   
main endp   

setVideoMode proc near
    mov ah, 00
    mov al, 03
    int 10h
    
    ret   
setVideoMode endp 

setCursorPos proc near
    mov ah, 02
    mov bh, 00
    
    int 10h
    
    ret   
setCursorPos endp
displayChar proc near
    mov ah, 0Ah
    mov cx, 1
    int 10h
    
    ret   
displayChar endp

reqInp proc near
    mov ah, 01h
    int 21h
    
    ret   
reqInp endp

displayResult proc near
    
    mov dh, 02
    mov dl, 00
    call setCursorPos
    
    cmp isPrime, 0
    jne PrintPrime
    
    PrintNotPrime:
        lea si, notPrime
        
        mov cx, 9 
        WriteNP:
            push cx
            mov al, [si]
            call displayChar
            inc dl
            call setCursorPos
            inc si 
            pop cx
        loop WriteNP
        
        jmp exit   
    
    PrintPrime:
        lea si, prime
        
        mov cx, 5
        WriteP:
            push cx
            mov al, [si]
            call displayChar
            inc dl
            call setCursorPos
            inc si
            pop cx
        loop WriteP              
       
    exit:   
    ret    
displayResult endp 

takeUserInput proc near
    mov dx, 00
    call setCursorPos
    
    Inp:
        lea si, input
        
        mov cx,6 
        WriteInp:
            push cx
            mov al,[si]
            call displayChar
            inc dl
            call setCursorPos
            inc si 
            pop cx
        loop WriteInp
        
        call reqInp 
        mov userInput, al
        
    inpExit:        
    ret
takeuserInput endp

processInput proc near
    
    ret
processInput endp