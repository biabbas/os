org 0x7C00
bits 16

%define ENDL 0x0D, 0x0A

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
    lodsb  ;loads next character in si to al and increments si
    or al, al
    jz .done

    mov ah, 0x0e; Bios interrupt for tty mode screen
    mov bh, 0 ; page number to zero
    int 0x10
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

    mov si, msg_hello
    call puts

    hlt

.halt:
    jmp .halt

msg_hello: db 'Welcome to the den',ENDL, 0

times 510-($-$$) db 0
dw 0AA55h