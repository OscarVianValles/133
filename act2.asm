.model small
.stack 100
.data
; Creating strings
enterMsg db 10,13,"Enter Number > ",'$'
opMessage db 10,13,"Select Operation:",10,13,"0: Addition",10,13,"1: Subtraction",10,13,"> ",'$'
subMessage db 10,13,"Difference: ",'$'
addMessage db 10,13,"Sum: ",'$'

; Create num array
num db 0,0

.code
  ; Read from data
  mov ax, @data
  mov ds, ax
  mov cx, 0

getNum:
  ; Print enter number
  lea dx, enterMsg
  mov ah, 09h
  int 21h

  ; Read character
  mov ah, 01h
  int 21h

  ;Normalize character by subtracting 48
  sub al, 48

  ; Store number in array
  ; Move loop counter to base register as arrays
  ; only take iterators from base or index register
  mov bx, cx
  mov num[bx], al

  ; Increase loop counter
  inc cx

  ; If counter is 2, go to operation, else go to get num again
  cmp cx,2
  je getOutput
  jmp getNum

getOutput:
  ; Print select operator
  lea dx, opMessage
  mov ah, 09h
  int 21h

  ; Read character
  mov ah, 01h
  int 21h

  cmp al, 48
  je addition
  jg subtraction

addition:
  ; Print add message
  lea dx, addMessage
  mov ah, 09h
  int 21h

  ; Compute addition
  ; Set dl to 48 to make it 0 in ascii then add both numbers
  mov dl, 48
  add dl, num[0]
  add dl, num[1]
  jmp exit

subtraction:
  ; Print sub message
  lea dx, subMessage
  mov ah, 09h
  int 21h

  ; Compute subtraction
  ; Enter first number to the output
  mov dl, 48
  add dl, num[0]
  ; Subtract second number from first number
  sub dl, num[1]
  jmp exit

exit:
  ; Print Output
  mov ah, 02h
  int 21h

  ; End gracefully
  mov ah, 4Ch
  int 21h
end
