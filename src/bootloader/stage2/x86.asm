bits 16

section _TEXT class=CODE

;
; void _cdecl x86_div64_32(uint64_t dividend, uint32_t divisor, uint64_t* quotientOut, uint32_t* remainderOut);
;
global _x86_div64_32
_x86_div64_32:

    ; Make new caller frame
    push bp
    mov bp, sp

    push bx

    mov eax, [bp+8]; Get upper bits
    mov ecx, [bp+12]; Get divisor
    xor edx, edx
    div ecx ; eax = quot, edx = remainder

    mov bx, [bp+16]
    mov [bx+4], eax; Store upper 32 bits of quotient in quotient out higher bits

    mov eax, [bp+4]; Get lower bits of dividend
    div ecx ;   edx has last remainder, eax = quot, edx = remainer.


    ; Store the results;
    mov [bx], eax

    mov bx, [bp + 18] ; Get remainder pointer
    mov [bx], edx ; Store remainder

    pop bx
    mov sp, bp; Restore stack,
    pop bp
    ret

;
; int 10h ah=0Eh
; args: character, page
;
global _x86_Video_WriteCharTeletype
_x86_Video_WriteCharTeletype:
    
    ; make new call frame
    push bp             ; save old call frame
    mov bp, sp          ; initialize new call frame

    ; save bx
    push bx

    ; [bp + 0] - old call frame
    ; [bp + 2] - return address (small memory model => 2 bytes)
    ; [bp + 4] - first argument (character)
    ; [bp + 6] - second argument (page)
    ; note: bytes are converted to words (you can't push a single byte on the stack)
    mov ah, 0Eh
    mov al, [bp + 4]
    mov bh, [bp + 6]

    int 10h

    ; restore bx
    pop bx

    ; restore old call frame
    mov sp, bp
    pop bp
    ret