# r0, r1 = i
# r2, r3, r4 = {nlen, n}
# r5 = c
# r6, r7 = n
# r8 = 3
# arg for printf("%lld", n) goes in r2 and r3.
        .global main
main:
        push    {lr}

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

        mov     r1, r3
        mov     r2, r4
        ldr     r0, .Print64
        bl      printf
        mov     r0, #0
        pop     {pc}
.Print32:
        .word   .LC0
.Print64:
        .word   .LC1
.PrintCollatzLenArgs:
        .word   .LC2
.PrintEven:
        .word   .LC3
.PrintOdd:
        .word   .LC4
.arg:
        .word   1000000
.LC0:
        .ascii  "%d\012\000"
.LC1:
        .ascii  "lld = %lld\012\000"
.LC2:
        .ascii  "collatzLen(1, %lld) = %d\012\000"
.LC3:
        .ascii  "even\012\000"
.LC4:
        .ascii  "odd\012\000"
