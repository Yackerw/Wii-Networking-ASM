; r3 is socket to close
SOCKET_CLOSE:
subi sp, sp, 0x4
mflr r4
stw r4, 0 (sp)
subi sp, sp, 0x10
; IOCTL_SO_SHUTDOWN
li r4, 0xE
; put socket into buffer
stw r3, 0x8 (sp)
; "how" into buffer
li r3, 0
stw r3, 0xC (sp)
; ios handle
lis r3, 0x8000
lwz r3, 0x10 (r3)
; buffer in
addi r5, sp, 8
; buffer in size
li r6, 8
; buffer out
li r7, 0
; buffer out size
li r8, 0
; replace this with IOS_Ioctl
lis r9, 0x8009
ori r9, r9, 0xBEFC
mtctr r9
; preserve stack
subi sp, sp, 0x40
bctrl
; stack reset
addi sp, sp, 0x50
lwz r3, 0 (sp)
mtlr r3
addi sp, sp, 0x4
blr