        .global main
main:
        push    {r4, r5, r6, r7, r8, r9, lr}
        ldr     r0, .arg
        mov     r1, #0
        mvn     r2, #0
        mvn     r3, #0
        mvn     r4, #0
        b       loopstart
loopend:
        mov     r5, #1
        mov     r6, r0
        mov     r7, r1
        b       collatzLenStart
collatzLenLoop:
        add     r5, r5, #1
        tst     r6, #1
        bne     odd
        movs    r7, r7, lsr #1
        rrx     r6, r6
        cmp     r6, #1
        cmpeq   r7, #0
        bne     collatzLenLoop
        b       collatzLenReturn
odd:
        movs    r8, r6, asl #1
        adc     r9, r7, r7
        adds    r6, r6, r8
        adc     r7, r7, r9
        adds    r6, r6, #1
        adc     r7, r7, #0
collatzLenStart:
        cmp     r6, #1
        cmpeq   r7, #0
        bne     collatzLenLoop
collatzLenReturn:
        cmp     r5, r2
        movgt   r2, r5
        movgt   r3, r0
        movgt   r4, r1
        subs    r0, r0, #1
        sbc     r1, r1, #0
loopstart:
        cmp     r0, #1
        cmpeq   r1, #0
        bne     loopend
        ldr     r0, .Print
#        ldr     r1, .arg
        mov     r1, r3
        mov     r2, r4
        bl      printf
        mov     r0, #0
        pop     {r4, r5, r6, r7, r8, r9, pc}
.arg:
        .word   1000000
.Print:
        .word   .LC0
.LC0:
        .ascii  "hailstone(d) = %lld\012\000"
