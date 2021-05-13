SOCKET_INIT:
mflr r3
subi sp, sp, 0x4
subi sp, sp, 0x40
stw r3, 0 (sp)
; Open ios for sockets
; replace this with ios_open
; for your game
; Dolphin can find it
; through symbols!
lis r3, 0x8009
ori r3, r3, 0xB564
mtctr r3
; which ios to open
bl STRING
mflr r3
; ?
li r4, 0
; don't think r5 is used
bctrl
; this is a safe place to store
; things, game-independant
lis r4, 0x8000
stw r3, 0x10 (r4)
; ensure sockets valid
cmpwi 0, r3, 0
beq RETURN
; it IS valid, let's set up
; our initialization of it
li r4, 0x1F
; replace this with IOS_Ioctl
; again, dolphin can find it
lis r5, 0x8009
ori r5, r5, 0xBEFC
mtctr r5
; i am completely guessing
; all these args, lmk if these
; are wrong
; buffer in loc
li r5, 0
; buffer in size
li r6, 0
; buffer out
li r7, 0
; buffer out size
li r8, 0
; execute!
bctrl
; return
addi sp, sp, 0x40
lwz r4, 0 (sp)
mtlr r4
addi sp, sp, 0x4
blr

STRING:
blrl
; /dev/net/ip/top
.int 0x2F646576
.int 0x2F6E6574
.int 0x2F69702F
.int 0x746F7000


