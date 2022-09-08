// N = 30

	ADD x2, xzr, xzr
loop:
	STUR x0, [x2, #0]
	ADD x0, x1, x0
	ADD x2, x2, x8
	SUB x3, x0, x30
	CBZ x3, end
	CBZ xzr, loop
end:

infloop:
	CBZ xzr, infloop



