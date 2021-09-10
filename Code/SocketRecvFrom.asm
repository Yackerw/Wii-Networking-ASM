; r3 is socket
; r4 is output buffer
; r5 is output buffer size
; r6 is address info output
SOCKET_RECVFROM:
mflr r7
subi sp, sp, 0x4
stw r7, 0 (sp)
; set up io vectors
; in buffer 1 data
subi sp, sp, 0x8
stw r3, 0 (sp)
; flags...we just want it non
; blocking!
li r7, 0x4
stw r7, 0x4 (sp)

subi sp, sp, 0x8
; address info
; short family
; short port
; int address
stw r6, 0 (sp)
li r6, 16
stw r6, 0x4 (sp)
subi sp, sp, 0x8
stw r4, 0 (sp)
stw r5, 0x4 (sp)
; set up in buffer now
subi sp, sp, 0x8
addi r3, sp, 0x18
stw r3, 0 (sp)
; length is just 8
li r3, 8
stw r3, 0x4 (sp)
; ios
lis r3, 0x8000
lwz r3, 0x10 (r3)
; IOCTLV_SO_RECVFROM
li r4, 0xC
; in vector count
li r5, 1
; out vector count
li r6, 2
; out vector
mr r7, sp
; call the function
lis r8, 0x8009
ori r8, r8, 0xC24C
mtctr r8
subi sp, sp, 0x40
bctrl
; whew, done!
addi sp, sp, 0x60
lwz r4, 0 (sp)
addi sp, sp, 0x4
mtlr r4
blr