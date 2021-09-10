SOCKET_DEINIT:
subi sp, sp, 0x40
mflr r3
stw r3, 0x3C (sp)
; just close that thing
lis r3, 0x8000
lwz r3, 0x10 (r3)
; ios_close
lis r4, 0x8009
ori r4, r4, 0xB744
mtctr r4
bctrl
lwz r3, 0x3C (sp)
mtlr r3
addi sp, sp, 0x40
blr