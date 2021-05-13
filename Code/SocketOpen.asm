; r3 is TCP or UDP:
; 1 for TCP, 2 for UDP
; returns socket identifier
SOCKET_OPEN:
subi sp, sp, 0x4
mflr r4
stw r4, 0 (sp)
; protocol
mr r5, r3
; okay, let's theoretically
; set up a socket
; get our handle
lis r3, 0x8000
lwz r3, 0x10 (r3)
; ensure valid
cmpwi 0, r3, 0
beq RETURN
; this time we need to set up
; a buffer
subi sp, sp, 0x10
; AF_INET
li r4, 0x2
stw r4, 0 (sp)
; this is set up for UDP
; change to 1 to TCP
stw r5, 0x4 (sp)
; protocol; this differs from
; windows in that it HAS to be
; 0, rather than specifying
; TCP/UDP
li r4, 0
stw r4, 0x8 (sp)
; okay, specify type
; IOCTL_SO_SOCKET
li r4, 0xF
; buffer in
mr r5, sp
; buffer in size
li r6, 0x10
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
; return
lwz r4, 0 (sp)
mtlr r4
addi sp, sp, 0x4
blr

