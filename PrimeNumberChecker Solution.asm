.model small
.stack 64
.data 
ctr db 2
sqrAprx db 0
prime db 'Prime'
notPrime db 'Not Prime'
isPrime db 0
input db 'Input:'
userInput dw 0 
;testing dw 1234

Para_List Label Byte
max_len db 5
act_len db ?
kb_data db 5 dup(' ')
.code
main proc near
 mov ax,@data
 mov es, ax
 mov ds, ax

    ;call setVideoMode
    ;call takeUserInput 
    call reqInp
    call processStringInput
    call checkPrime 
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
    lea dx, Para_List
    mov ah, 0ah
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
        
    inpExit:        
    ret
takeuserInput endp

processStringInput proc near 
    lea si, kb_data
    mov ch, 0
    mov cl, act_len
    Process:
        sub [si], 30h
         
        mov ax, userInput
        mov bl, 10
        mul bl
        mov userInput, ax 
        mov ah, 00
        mov al, [si]
        add userInput, ax
        
        inc si 
    loop Process       
    ret
processStringInput endp 

squareApproximate proc near 
    
    mov cx, 2
    Start:
         
         mov ax, cx
         mov bx, cx
         mul bx
         
         inc sqrAprx
         inc cx
         
         cmp ax, userInput
         jna Start
         ja Ext
        
        
    Ext: 
      
    ret    
squareApproximate endp    

checkPrime proc near
    call squareApproximate
    
    
    sub sqrAprx, 2
    mov ch, 00
    mov cl, sqrAprx
    Check:
        mov dx, 0
        mov ax, userInput
        mov bh, 00
        mov bl, ctr
        div bx
        inc ctr
        cmp dx, 0
        je notP
    loop Check
    mov isPrime, 1
    jmp finalExit
    
    notP:
        mov isPrime, 0 
        
    finalExit:    
    ret    
checkPrime endp    