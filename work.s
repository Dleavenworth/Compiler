//Build with
// as work.s -o work.o
// ld -s -o work work.o

//Disassemble with:
//objdumb -d --no-show-raw-insn work.o > work_dis.s
.text 
	.global _start 

_start:
	movl $2,%ebx
	movl $1,%eax
	int $0x80
