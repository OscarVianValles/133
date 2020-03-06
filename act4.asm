.model small
.stack 100
.data
enterMsg db 10,13,"Enter a Hex Digit: ",'$'
decMsg db 10,13,"In Decimal, it is: ",'$'
againMsg db 10,13,"Do you want to do it again (Y/N): ",'$'
illegalMsg db 10,13,"Illegal Character - only (0-9) or (A-F): ",'$'


.code
  mov ax, @data
  mov ds, ax

printEnter:
  ; Print enter message
  lea dx, enterMsg
  mov ah, 09h
  int 21h

  jmp getHex

printIllegal:
  lea dx, illegalMsg
  mov ah, 09h
  int 21h

getHex:
  ; Read Character
  mov ah, 01h
  int 21h

checkIfNum:
  ; Check if less than 0
  cmp al, 48
  jl printIllegal

  ; Check if greater than 9. If greater check if it is a  letter
  cmp al, 57
  jg checkIfLetter
  mov bl, 48
  jmp printOutput

checkIfLetter:
  ; Check if greater than F
  cmp al, 70
  jg printIllegal

  ; Check if less than A
  cmp al, 65
  jl printIllegal

  ; Normalize number for computation. Make A to be 10
  mov bl, 49
  sub al, 17
  jmp printOutput


printOutput:
  lea dx, decMsg
  mov ah, 09h
  int 21h

  mov cl, al

  mov dl, bl
  mov ah, 02h
  int 21h

  mov dl, cl
  mov ah, 02h
  int 21h

again:
  lea dx, againMsg
  mov ah, 09h
  int 21h

  mov ah, 01h
  int 21h

  cmp al, 89
  je printEnter

  cmp al, 78
  je exit
  jmp again

exit:
  mov ah, 4Ch
  int 21h
end
