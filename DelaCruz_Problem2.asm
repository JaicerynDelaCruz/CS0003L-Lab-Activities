section .data
 title db 10, "=== SIMPLE CALCULATOR ===", 10
 db "1. Addition", 10, "2. Subtraction", 10
 db "3. Multiplication", 10, "4. Division", 10
 db "5. Exit", 10, "Choose operation: "
 titleLen equ $ - title
 firstMsg db "Enter first number (0-9): "
 firstMsgLen equ $ - firstMsg
 secondMsg db "Enter second number (0-9): "
 secondMsgLen equ $ - secondMsg
 resultMsg db "Result: "
 resultMsgLen equ $ - resultMsg
 againMsg db "Do another calculation? (Y/N): "
 againMsgLen equ $ - againMsg
 invalidMsg db "Invalid choice!", 10
 invalidMsgLen equ $ - invalidMsg
 zeroMsg db "Cannot divide by zero!", 10
 zeroMsgLen equ $ - zeroMsg
 newline db 10
 
section .bss
 choice resb 2
 num1 resb 2
 num2 resb 2
 again resb 2
 result resb 1
 
section .text
 global _start
 
_start:
calculator_loop:
 mov eax, 4
 mov ebx, 1
 mov ecx, title
 mov edx, titleLen
 int 0x80
 
 mov eax, 3
 mov ebx, 0
 mov ecx, choice
 mov edx, 2
 int 0x80
 
 cmp byte [choice], '5'
 je exit_program
 
 mov eax, 4
 mov ebx, 1
 mov ecx, firstMsg
 mov edx, firstMsgLen
 int 0x80
 
 mov eax, 3
 mov ebx, 0
 mov ecx, num1
 mov edx, 2
 int 0x80
 
 mov eax, 4
 mov ebx, 1
 mov ecx, secondMsg
 mov edx, secondMsgLen
 int 0x80
 
 mov eax, 3
 mov ebx, 0
 mov ecx, num2
 mov edx, 2
 int 0x80
 
 mov al, [num1]
 sub al, '0'
 mov bl, [num2]
 sub bl, '0'
 mov cl, [choice]
 cmp cl, '1'
 je addition
 cmp cl, '2'
 je subtraction
 cmp cl, '3'
 je multiplication
 cmp cl, '4'
 je division
 jmp invalid_choice
 
addition:
 add al, bl
 jmp display_result
 
subtraction:
 sub al, bl
 jmp display_result
 
multiplication:
 mul bl
 jmp display_result
 
division:
 cmp bl, 0
 je divide_by_zero
 mov ah, 0
 div bl
 jmp display_result
 
display_result:
 add al, '0'
 mov [result], al
 
 mov eax, 4
 mov ebx, 1
 mov ecx, resultMsg
 mov edx, resultMsgLen
 int 0x80
 
 mov eax, 4
 mov ebx, 1
 mov ecx, result
 mov edx, 1
 int 0x80
 
 mov eax, 4
 mov ebx, 1
 mov ecx, newline
 mov edx, 1
 int 0x80
 jmp ask_again
 
invalid_choice:
 mov eax, 4
 mov ebx, 1
 mov ecx, invalidMsg
 mov edx, invalidMsgLen
 int 0x80
 jmp ask_again
 
divide_by_zero:
 mov eax, 4
 mov ebx, 1
 mov ecx, zeroMsg
 mov edx, zeroMsgLen
 int 0x80
 
ask_again:
 mov eax, 4
 mov ebx, 1
 mov ecx, againMsg
 mov edx, againMsgLen
 int 0x80
 
 mov eax, 3
 mov ebx, 0
 mov ecx, again
 mov edx, 2
 int 0x80
 
 cmp byte [again], 'Y'
 je calculator_loop
 cmp byte [again], 'y'
 je calculator_loop
 jmp exit_program
 
exit_program:
 mov eax, 1
 mov ebx, 0
 int 0x80
