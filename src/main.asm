org 0x7C00
bits 16

start:
    jmp main
;
; Print a string to screen
; Params
; ds:si points to the string

puts:
    ; save registers
    push si
    push ax
.loop:
    loadsb  ;loads next character in si to al and increments si
    or al, al
    jz .done
    jmp .loop

.done:
    pop ax
    pop si
    ret

main:
    ; setup data
    mov ax, 0
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7C00
    
    hlt

.halt:
    jmp .halt


times 510-($-$$) db 0
dw 0AA55h