section .data
vowelMsg db "The character is a vowel.", 10
vowelLen equ $ - vowelMsg
notVowelMsg db "The character is not a vowel.", 10
notVowelLen equ $ - notVowelMsg
 
section .text
global _start
 
_start:
mov al, 'E'
cmp al, 'A'
je vowel
cmp al, 'E'
je vowel
cmp al, 'I'
je vowel
cmp al, 'O'
je vowel
cmp al, 'U'
je vowel
jmp not_vowel
 
vowel:
mov eax, 4
mov ebx, 1
mov ecx, vowelMsg
mov edx, vowelLen
int 0x80
jmp exit
 
not_vowel:
mov eax, 4
mov ebx, 1
mov ecx, notVowelMsg
mov edx, notVowelLen
int 0x80
 
exit:
mov eax, 1
mov ebx, 0
int 0x80
