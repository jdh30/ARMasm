	.global	main
main:
	push	{r4, r5, r6, lr}
	mov	r4, r1
	cmp	r0, #2
	beq	.L2
	ldr	r0, .L17
	bl	puts
	pop	{r4, r5, r6, pc}
.L2:
	mov	r2, #10
	mov	r1, #0
	ldr	r0, [r4, #4]
	bl	strtol
	mov	r4, r0
	bl	malloc
	mov	r5, r0
	cmp	r4, #0
	ble	.L3
	mov	r3, r0
	add	r1, r0, r4
	mov	r2, #1
.L4:
	strb	r2, [r3], #1
	cmp	r3, r1
	bne	.L4
.L3:
	cmp	r4, #2
	ble	.L5
	add	ip, r5, #1
	mov	r0, #4
	mov	r2, #2
	mov	r1, #0
	b	.L8
.L6:
	add	r2, r2, #1
	add	r0, r0, #2
	cmp	r2, r4
	beq	.L5
.L8:
	ldrb	r3, [ip, #1]!	@ zero_extendqisi2
	cmp	r3, #0
	beq	.L6
	mov	r3, r0
	cmp	r0, r4
	bge	.L6
.L11:
	strb	r1, [r5, r3]
	add	r3, r3, r2
	cmp	r3, r4
	blt	.L11
	b	.L6
.L5:
	sub	r1, r4, #1
	ldrb	r3, [r5, r1]	@ zero_extendqisi2
	cmp	r3, #0
	bne	.L9
	add	r4, r5, r1
.L10:
	sub	r1, r1, #1
	ldrb	r3, [r4, #-1]!	@ zero_extendqisi2
	cmp	r3, #0
	beq	.L10
.L9:
	ldr	r0, .L17+4
	bl	printf
	mov	r0, r5
	bl	free
	mov	r0, #0
	pop	{r4, r5, r6, pc}
.L17:
	.word	.LC0
	.word	.LC1
.LC0:
	.ascii	"Usage: sieve <n>\000"
.LC1:
	.ascii	"%d\012\000"
