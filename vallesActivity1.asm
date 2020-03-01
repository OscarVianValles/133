.model small
.stack 100
.DATA
MSG DB 10,13,"Enter Number:",'$'
NL DB 10,13,"Sum: ",'$'
NUM1 DB 48
TMP DB ?
COUNTER DB 0
.CODE
    MOV AX,@DATA
    MOV DS,AX
PRINT:
    LEA DX,MSG
    MOV AH,09H
    INT 21H
READ:
    ; Read Character
    MOV AH,01H
    INT 21H
    ; Normalize
    SUB AL, 48

    ; Add normalized number to num1
    ADD NUM1, AL

    ; Increase counter and compare. if 2 go to end else go to print
    INC COUNTER
    CMP COUNTER,2
    JE EXIT
    JMP PRINT
EXIT:
    ; Print sum
    LEA DX,NL
    MOV AH,09H
    INT 21H

    ; Print character
    MOV DL, NUM1
    MOV AH,02H
    INT 21H

    ; End gracefully
    MOV AH,4CH
    INT 21H
END
