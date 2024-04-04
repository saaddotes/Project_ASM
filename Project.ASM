.model small
.stack 100h

.data

    input_password    db 'Please Enter Your Password$'
    inputChars        db 10 dup('$')
    password          db 'ubit$'
    correctPassPrompt db 'Correct Password$'
    menuPrompt        db 10,13, 'Choose an Option: $'
    groceryMenu       db 10,13, '1.Fruits', 10,13, '2.Vegetables', 10,13, '3.Cosmetics', 10,13, '4.Cart', '$'
    wrongInput        db 10,13, 'Wrong Input$'
    inputAgain        db 10,13, 'Please Press one of the above given keys$'
    fruitsNames       db 10,13,'Bananas', 10,13,'Oranges', 10,13,'Graphs', 10,13,'Mangoes', 10,13,'Pineapples','$'






.code


main proc
                         mov  ax, @data
                         mov  ds, ax
                         call inputPassword

                         call mainMenu

                     

                         mov  ah,4
                         int  21h
main endp


inputPassword PROC
                         mov  dx, offset input_password
                         call print

                         mov  si, offset inputChars

    inputPass:           

                         mov  ah,1
                         int  21h

                         cmp  al,13
                         je   checkPass

                         mov  [si],al
                         inc  si
                         jmp  inputPass
    
    checkPass:           
                         mov  si, offset inputChars
                         mov  di, offset password

    compareLoop:         
                         mov  al, [si]
                         mov  bl, [di]
                         cmp  al, bl
                         jne  wrongPassword
                         cmp  al, '$'
                         je   passwordVerified
                         inc  si
                         inc  di
                         jmp  compareLoop

    wrongPassword:       
                         jmp  inputPass

    passwordVerified:    
                         mov  dx, offset correctPassPrompt
                         mov  ah, 9
                         int  21h

                         ret
    
inputPassword ENDP


    ;description
mainMenu PROC
                         mov  dx,offset groceryMenu
                         call print

                         mov  dx, offset menuPrompt
                         call print

                         mov  ah, 1
                         int  21h

                         cmp  al, '1'
                         je   buyMedicines

                         cmp  al, '4'
                         je   exitProgram

                         jmp  invalidInput


    buyMedicines:        
                         call displayFruits
    ;  call selectMedicine
                         jmp  exitProgram

    ; see_medicines_stats:
    ;                        call display_medicine_stats
    ;                        jmp  main_menu

    ; show_amount_earned:
    ;                        mov  dx, offset total_earned
    ;                        call print_word
    ;                        jmp  main_menu

    exitProgram:         
                         mov  ax, 4
                         int  21h

    ; selectMedicine:
    ;                        mov  ah, 1
    ;                        int  21h

    ;                        sub  al, '1'
    ;                        cmp  al, 8
    ;                        ja   invalid_input

    ;                        xor  ah, ah                          ; Clear upper bits of AX
    ;                        mov  bl, al                          ; Move AL to BL

    ; ; Load the base address of medicine_prices into SI
    ;                        lea  si, [medicine_prices]
    ; ; Multiply the index by the size of each element (2 bytes for a word)
    ;                        shl  bx, 1
    ; ; Access the price of the selected medicine
    ;                        mov  ax, [si + bx]

    ; ; Add the price to total earned
    ;                        add  [total_earned], ax

    ; ; Load the base address of medicine_sold into DI
    ;                        lea  di, [medicine_sold]
    ; ; Increment the sold count of the selected medicine
    ;                        inc  word ptr [di + bx]


    displayFruits:
                         mov  dx, offset fruitsNames
                         call print

                         ret



    invalidInput:        
                         mov  dx, offset wrongInput
                         call print

                         mov  dx, offset inputAgain
                         call print

                         jmp  mainMenu

    
mainMenu ENDP


print PROC
                         mov  ah,9
                         int  21h

                         ret
print ENDP



end main