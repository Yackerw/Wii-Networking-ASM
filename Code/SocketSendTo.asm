; r3 is socket
; r4 is IP
; r5 is port
; r6 is ptr to data
; r7 is data length
SOCKET_SENDTO:
mflr r8
subi sp, sp, 0x4
stw r8, 0 (sp)
; vector data
subi sp, sp, 0x20
mr r8, sp
subi sp, sp, 0x10
; set up vector ptrs
; IP address vector
stw r8, 0x8 (sp)
li r8, 0x14
stw r8, 0xC (sp)
; data vector
stw r6, 0 (sp)
stw r7, 0x4 (sp)
; set up IP vector
addi r8, sp, 0x10
; socket
stw r3, 0 (r8)
; flags: none
li r7, 0
stw r7, 0x4 (r8)
; has destination: always true
li r7, 1
stw r7, 0x8 (r8)
; IP length
li r7, 4
stb r7, 0xC (r8)
; family: ipv4
li r7, 2
stb r7, 0xD (r8)
; port
sth r5, 0xE (r8)
; address
stw r4, 0x10 (r8)

; rest of initialization 

; attempt to send some data
lis r3, 0x8000
lwz r3, 0x10 (r3)
; IOCTLV_SO_SENDTO
li r4, 0xD
; in vector count
li r5, 2
; io vector count
li r6, 0
; ok, now just ptr to vectors
mr r7, sp
; now we just execute the func
; change this to IOS_Ioctlv
lis r8, 0x8009
ori r8, r8, 0xC24C
mtctr r8
; stack insurance
subi sp, sp, 0x40
bctrl
; stack
addi sp, sp, 0x70
; return
lwz r4, 0 (sp)
addi sp, sp, 0x4
mtlr r4
blr

