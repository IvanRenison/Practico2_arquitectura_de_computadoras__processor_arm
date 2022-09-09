// N = 29

	ADD x10, xzr, xzr // x10 = 0
loop2: // while x0 != 30
	SUB x11, x0, x30
	CBZ x11, end
	STUR x0, [x10, #0]
	ADD x0, x1, x0
	ADD x10, x10, x8
	CBZ xzr, loop2
end:


// N = 29


	stur x12, [x0, #8]
	stur x18, [x0, #32]



	add x2, xzr, xzr
	add x4, xzr, xzr
loop: // do while x0 != 30
	ldur x3, [x2, #0]
	add x4, x4, x3
	add x2, x2, x8

	add x5, x5, x1
	// end loop
	sub x5, x30, x0
	cbz x5, loop

	stur x4, [x2, #0]


infloop:
	cbz xzr, infloop

