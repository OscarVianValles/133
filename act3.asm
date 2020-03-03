.model small
.stack 100
.data
.code
start:
  mov dl, 65

printLetter:
  ; Print dl
  mov ah, 02h
  int 21h

  ; Check for interrupt
  mov ah, 01h
  int 16h
  cmp al, 13
  je exit

  ; Check if Z is reached
  inc dl
  cmp dl, 91
  je start
  jmp printLetter

exit:
  mov ah, 4Ch
  int 21h
end
