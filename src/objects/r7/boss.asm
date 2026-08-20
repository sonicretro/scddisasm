; ------------------------------------------------------------------------------

MetalSonicObject:
	lea	player_object,a1
	movea.w	obj.var_2e(a0),a2
	bsr.w	sub_20BFAC
	bsr.w	sub_20BF54
	moveq	#0,d0
	move.b	obj.routine(a0),d0
	move.w	off_20BE48(pc,d0.w),d0
	jsr	off_20BE48(pc,d0.w)
	lea	MetalSonicAnims,a1
	jsr	AnimateObject
	jmp	DrawObject

; ------------------------------------------------------------------------------

off_20BE48:
	dc.w	MetalSonicObject_0_Routine0-*
	dc.w	MetalSonicObject_0_Routine2-off_20BE48
	dc.w	MetalSonicObject_0_Routine4-off_20BE48
	dc.w	MetalSonicObject_0_Routine6-off_20BE48
	dc.w	MetalSonicObject_0_Routine6-off_20BE48
	dc.w	MetalSonicObject_0_RoutineA-off_20BE48
	dc.w	MetalSonicObject_0_RoutineC-off_20BE48
	dc.w	MetalSonicObject_0_RoutineE-off_20BE48
	dc.w	MetalSonicObject_0_Routine10-off_20BE48
	dc.w	MetalSonicObject_0_Routine12-off_20BE48

; ------------------------------------------------------------------------------

MetalSonicObject_0_Routine0:
	move.b	#4,obj.sprite_flags(a0)
	move.b	#5,obj.sprite_layer(a0)
	move.b	#$14,obj.width_2(a0)
	move.b	#$18,obj.height(a0)
	move.w	#$37C,obj.sprite_tile(a0)
	move.l	#MetalSonicSprites,obj.sprite_data(a0)
	addq.b	#2,obj.routine(a0)

MetalSonicObject_0_Routine2:
	cmpi.b	#1,obj.anim_id(a0)
	bne.s	loc_20BE9C
	cmpi.b	#7,obj.anim_index(a0)
	bne.s	locret_20BEC4
	move.b	#0,obj.anim_id(a0)

loc_20BE9C:
	btst	#1,obj.flags(a1)
	beq.s	loc_20BEC0
	btst	#2,obj.flags(a1)
	beq.s	loc_20BEC0
	tst.b	obj.var_2d(a0)
	bne.s	locret_20BEC4
	move.b	#1,obj.var_2d(a0)
	move.b	#1,obj.anim_id(a0)
	bra.s	locret_20BEC4

; ------------------------------------------------------------------------------

loc_20BEC0:
	clr.b	obj.var_2d(a0)

locret_20BEC4:
	rts

; ------------------------------------------------------------------------------

MetalSonicObject_0_Routine4:
	moveq	#0,d0
	move.b	obj.var_2d(a0),d0
	add.b	d0,d0
	move.w	off_20BED6(pc,d0.w),d0
	jmp	off_20BED6(pc,d0.w)

; ------------------------------------------------------------------------------

off_20BED6:
	dc.w	MetalSonicObject_1_Routine0-*
	dc.w	MetalSonicObject_1_Routine2-off_20BED6
	dc.w	EggmanObject_1_Routine4-off_20BED6
	dc.w	MetalSonicObject_1_Routine6-off_20BED6
	dc.w	EggmanObject_1_Routine4-off_20BED6
	dc.w	MetalSonicObject_1_RoutineA-off_20BED6
	dc.w	EggmanObject_1_Routine4-off_20BED6
	dc.w	MetalSonicObject_1_RoutineE-off_20BED6

; ------------------------------------------------------------------------------

MetalSonicObject_1_Routine0:
	move.b	#2,obj.anim_id(a0)
	addq.b	#1,obj.var_2d(a0)
	clr.b	obj.sprite_frame(a0)

MetalSonicObject_1_Routine2:
	cmpi.b	#6,obj.sprite_frame(a0)
	bne.s	locret_20BF0C
	move.b	#3,obj.anim_id(a0)
	addq.b	#1,obj.var_2d(a0)
	move.w	#$78,obj.var_2a(a0)

locret_20BF0C:
	rts

; ------------------------------------------------------------------------------

MetalSonicObject_1_Routine6:
	addq.b	#1,obj.var_2d(a0)
	move.b	#4,obj.anim_id(a0)
	move.w	#$96,obj.var_2a(a0)
	rts

; ------------------------------------------------------------------------------

MetalSonicObject_1_RoutineA:
	move.b	#$82,obj.var_38(a2)
	bset	#7,boss_flags
	addq.b	#1,obj.var_2d(a0)
	move.w	#$3C,obj.var_2a(a0)
	move.w	#$20,d0
	movem.l	a0-a2,-(sp)
	jsr	SubCpuCommand
	movem.l	(sp)+,a0-a2
	rts

; ------------------------------------------------------------------------------

MetalSonicObject_1_RoutineE:
	bset	#5,obj.var_2c(a0)
	bra.w	loc_20C1C8

; ------------------------------------------------------------------------------

sub_20BF54:
	btst	#5,obj.var_2c(a0)
	beq.w	locret_20BFAA
	move.w	obj.x(a0),d0
	sub.w	8(a2),d0
	cmpi.w	#$58,d0
	bgt.w	locret_20BFAA
	cmpi.w	#$3500,obj.x(a0)
	blt.s	loc_20BF8A
	move.w	$10(a2),obj.x_speed(a0)
	move.w	#8,obj.var_30(a0)
	move.w	#$600,obj.var_34(a0)
	bra.s	locret_20BFAA

; ------------------------------------------------------------------------------

loc_20BF8A:
	move.w	obj.x_speed(a0),d0
	cmp.w	obj.x_speed(a2),d0
	bge.s	loc_20BFA6
	move.w	obj.x_speed(a2),obj.x_speed(a0)
	move.w	#8,obj.var_30(a0)
	move.w	#$600,obj.var_34(a0)

loc_20BFA6:
	bra.w	loc_20C212

; ------------------------------------------------------------------------------

locret_20BFAA:
	rts

; ------------------------------------------------------------------------------

sub_20BFAC:
	tst.b	$39(a2)
	bmi.s	locret_20BFCA
	bne.s	loc_20BFCC
	move.w	#$3E90,d0
	cmp.w	obj.x(a0),d0
	ble.w	loc_20C032
	lea	player_object,a3
	cmp.w	obj.x(a3),d0
	ble.s	loc_20BFCC

locret_20BFCA:
	rts

; ------------------------------------------------------------------------------

loc_20BFCC:
	tst.b	$39(a2)
	bne.s	loc_20C002
	move.b	#1,$39(a2)
	bset	#7,boss_flags
	move.w	#$BB,d0
	movem.l	a0-a2,-(sp)
	jsr	PlayFmSound
	movem.l	(sp)+,a0-a2
	movea.l	a0,a3
	bsr.w	sub_20C072
	move.w	#$800,obj.var_34(a0)
	move.w	#$10,obj.var_30(a0)

loc_20C002:
	cmpi.w	#$3E48,obj.x(a0)
	blt.s	locret_20C030
	bset	#7,$39(a2)
	bclr	#5,obj.var_2c(a0)
	move.b	#$12,obj.routine(a0)
	movem.l	a1-a2,-(sp)
	bsr.w	sub_20CF14
	movem.l	(sp)+,a1-a2
	clr.w	obj.var_2a(a0)
	clr.b	obj.var_2d(a0)

locret_20C030:
	rts

; ------------------------------------------------------------------------------

loc_20C032:
	move.w	d0,obj.x(a0)
	move.b	#$82,$39(a2)
	bset	#7,boss_flags
	move.w	#$BB,d0
	movem.l	a0-a2,-(sp)
	jsr	PlayFmSound
	movem.l	(sp)+,a0-a2
	lea	player_object,a3
	bsr.w	sub_20C072
	bclr	#5,obj.var_2c(a0)
	move.b	#$10,obj.routine(a0)
	clr.w	obj.var_2a(a0)
	clr.b	obj.var_2d(a0)
	rts

; ------------------------------------------------------------------------------

sub_20C072:
	tst.b	(a3)
	beq.s	locret_20C084
	move.w	#$3E48,d1
	cmp.w	8(a3),d1
	bge.s	locret_20C084
	move.w	d1,8(a3)

locret_20C084:
	rts

; ------------------------------------------------------------------------------

MetalSonicObject_0_Routine6:
	bsr.w	sub_20CE68
	bsr.w	sub_20CA0E
	tst.b	$39(a2)
	beq.s	loc_20C096
	rts

; ------------------------------------------------------------------------------

loc_20C096:
	addq.w	#1,obj.var_38(a0)
	tst.b	obj.var_36(a0)
	bne.w	loc_20C13C
	move.w	8(a1),d5
	sub.w	obj.x(a0),d5
	move.w	d5,d4
	bmi.s	loc_20C0B6
	bset	#6,obj.var_2c(a0)
	bra.s	loc_20C0BE

; ------------------------------------------------------------------------------

loc_20C0B6:
	bclr	#6,obj.var_2c(a0)
	neg.w	d4

loc_20C0BE:
	cmpi.w	#$A0,d4
	bge.s	loc_20C0E4
	tst.w	obj.var_3a(a0)
	bge.s	loc_20C0CE
	clr.w	obj.var_3a(a0)

loc_20C0CE:
	addq.w	#1,obj.var_3a(a0)
	cmpi.w	#$10,d4
	bge.s	loc_20C0DE
	clr.w	obj.var_3c(a0)
	bra.s	loc_20C0F2

; ------------------------------------------------------------------------------

loc_20C0DE:
	addq.w	#1,obj.var_3c(a0)
	bra.s	loc_20C0F2

; ------------------------------------------------------------------------------

loc_20C0E4:
	tst.w	obj.var_3a(a0)
	bmi.s	loc_20C0EE
	clr.w	obj.var_3a(a0)

loc_20C0EE:
	subq.w	#1,obj.var_3a(a0)

loc_20C0F2:
	cmpi.w	#$32,obj.var_3c(a0)
	bge.s	loc_20C0FE
	bra.w	loc_20C14A

; ------------------------------------------------------------------------------

loc_20C0FE:
	cmpi.w	#$3500,obj.x(a0)
	bge.s	loc_20C10A
	bra.w	loc_20C208

; ------------------------------------------------------------------------------

loc_20C10A:
	btst	#6,obj.var_2c(a0)
	bne.w	loc_20C128
	bsr.w	sub_20C226
	move.b	#2,obj.var_36(a0)
	move.w	#$F0,obj.var_3e(a0)
	bra.w	loc_20C14A

; ------------------------------------------------------------------------------

loc_20C128:
	bsr.w	sub_20C226
	move.b	#1,obj.var_36(a0)
	move.w	#$F0,obj.var_3e(a0)
	bra.w	loc_20C14A

; ------------------------------------------------------------------------------

loc_20C13C:
	subq.w	#1,obj.var_3e(a0)
	bgt.s	loc_20C14A
	clr.b	obj.var_36(a0)
	clr.w	obj.var_3e(a0)

loc_20C14A:
	tst.w	obj.var_3e(a0)
	bne.s	loc_20C160
	cmpi.w	#$FF88,obj.var_3a(a0)
	bgt.s	loc_20C160
	tst.w	d5
	bmi.s	loc_20C17C
	bra.w	loc_20C0FE

; ------------------------------------------------------------------------------

loc_20C160:
	move.w	obj.var_38(a0),d0
	divu.w	#$3C,d0
	swap	d0
	cmpi.w	#$1E,d0
	bge.s	loc_20C17C
	cmpi.b	#8,obj.routine(a0)
	bne.w	loc_20C188
	rts

; ------------------------------------------------------------------------------

loc_20C17C:
	cmpi.b	#6,obj.routine(a0)
	bne.w	loc_20C1C8
	rts

; ------------------------------------------------------------------------------

loc_20C188:
	cmpi.b	#1,obj.var_36(a0)
	beq.s	loc_20C19E
	cmpi.b	#2,obj.var_36(a0)
	beq.s	loc_20C1A4
	move.w	#$400,d0
	bra.s	loc_20C1A8

; ------------------------------------------------------------------------------

loc_20C19E:
	move.w	#$800,d0
	bra.s	loc_20C1A8

; ------------------------------------------------------------------------------

loc_20C1A4:
	move.w	#$2AA,d0

loc_20C1A8:
	move.w	d0,obj.var_34(a0)
	cmp.w	obj.x_speed(a0),d0
	blt.s	loc_20C1B4
	neg.w	d0

loc_20C1B4:
	move.w	d0,obj.var_30(a0)
	move.b	#8,obj.routine(a0)
	move.b	#6,obj.anim_id(a0)
	bra.w	loc_20C22A

; ------------------------------------------------------------------------------

loc_20C1C8:
	cmpi.b	#1,obj.var_36(a0)
	beq.s	loc_20C1DE
	cmpi.b	#2,obj.var_36(a0)
	beq.s	loc_20C1E4
	move.w	#$280,d0
	bra.s	loc_20C1E8

; ------------------------------------------------------------------------------

loc_20C1DE:
	move.w	#$500,d0
	bra.s	loc_20C1E8

; ------------------------------------------------------------------------------

loc_20C1E4:
	move.w	#$1AA,d0

loc_20C1E8:
	move.w	d0,obj.var_34(a0)
	cmp.w	obj.x_speed(a0),d0
	blt.s	loc_20C1F4
	neg.w	d0

loc_20C1F4:
	move.w	d0,obj.var_30(a0)
	move.b	#6,obj.routine(a0)
	move.b	#5,obj.anim_id(a0)
	bra.w	loc_20C22A

; ------------------------------------------------------------------------------

loc_20C208:
	move.b	#$A,obj.routine(a0)
	bra.w	sub_20C226

; ------------------------------------------------------------------------------

loc_20C212:
	move.b	#$C,obj.routine(a0)
	bra.w	sub_20C226

; ------------------------------------------------------------------------------

loc_20C21C:
	move.b	#$E,$24(a0)
	bra.w	*+4

; ------------------------------------------------------------------------------

sub_20C226:
	clr.w	obj.var_3c(a0)

loc_20C22A:
	clr.b	obj.var_2d(a0)
	clr.w	obj.var_2a(a0)
	rts

; ------------------------------------------------------------------------------

MetalSonicObject_0_RoutineA:
	bsr.w	sub_20CE68
	bsr.w	sub_20CA0E
	lea	word_20C246,a3
	bra.w	sub_20CEE0

; ------------------------------------------------------------------------------

word_20C246:
	dc.w	0
	dc.w	loc_20C24E-word_20C246
	dc.w	60
	dc.w	sub_20C268-word_20C246

; ------------------------------------------------------------------------------

loc_20C24E:
	move.b	#4,obj.anim_id(a0)
	move.w	#$C9,d0
	movem.l	a0-a2,-(sp)
	jsr	PlayFmSound
	movem.l	(sp)+,a0-a2
	rts

; ------------------------------------------------------------------------------

sub_20C268:
	move.w	obj.x(a1),d5
	sub.w	obj.x(a0),d5
	bmi.s	loc_20C27A
	bset	#6,obj.var_2c(a0)
	bra.s	loc_20C212

; ------------------------------------------------------------------------------

loc_20C27A:
	bclr	#6,obj.var_2c(a0)
	bra.s	loc_20C21C

; ------------------------------------------------------------------------------

MetalSonicObject_0_RoutineC:
	bsr.w	sub_20CE68
	bsr.w	sub_20CA0E
	lea	word_20C294,a3
	bra.w	sub_20CEE0

; ------------------------------------------------------------------------------

word_20C294:
	dc.w	0
	dc.w	loc_20C2A4-word_20C294
	dc.w	30
	dc.w	sub_20C2CA-word_20C294
	dc.w	40
	dc.w	sub_20C2D2-word_20C294
	dc.w	180
	dc.w	sub_20C2E0-word_20C294

; ------------------------------------------------------------------------------

loc_20C2A4:
	move.w	#$CA,d0
	movem.l	a0-a2,-(sp)
	jsr	PlayFmSound
	movem.l	(sp)+,a0-a2
	move.w	#8,obj.var_30(a0)
	move.w	#$600,obj.var_34(a0)
	move.b	#8,obj.anim_id(a0)
	rts

; ------------------------------------------------------------------------------

sub_20C2CA:
	move.b	#9,obj.anim_id(a0)
	rts

; ------------------------------------------------------------------------------

sub_20C2D2:
	move.b	#$BC,obj.collide_type(a0)
	move.b	#2,obj.collide_status(a0)
	rts

; ------------------------------------------------------------------------------

sub_20C2E0:
	clr.b	obj.collide_type(a0)
	clr.b	obj.collide_status(a0)
	move.w	obj.x(a1),d0
	cmp.w	obj.x(a0),d0
	bgt.s	loc_20C2F6
	bra.w	loc_20C188

; ------------------------------------------------------------------------------

loc_20C2F6:
	bra.w	loc_20C1C8

; ------------------------------------------------------------------------------

MetalSonicObject_0_RoutineE:
	bsr.w	sub_20CE68
	bsr.w	sub_20CA0E
	lea	word_20C30E,a3
	bsr.w	sub_20CEE0
	rts

; ------------------------------------------------------------------------------

word_20C30E:
	dc.w	0
	dc.w	loc_20C31A-word_20C30E
	dc.w	10
	dc.w	sub_20C344-word_20C30E
	dc.w	150
	dc.w	sub_20C352-word_20C30E

; ------------------------------------------------------------------------------

loc_20C31A:
	move.w	#-8,obj.var_30(a0)
	move.w	#$200,obj.var_34(a0)
	bsr.w	sub_20CF84
	move.b	#$A,obj.anim_id(a0)
	move.w	#$D0,d0
	movem.l	a0-a2,-(sp)
	jsr	PlayFmSound
	movem.l	(sp)+,a0-a2
	rts

; ------------------------------------------------------------------------------

sub_20C344:
	move.b	#$BD,obj.collide_type(a0)
	move.b	#2,obj.collide_status(a0)
	rts

; ------------------------------------------------------------------------------

sub_20C352:
	clr.b	obj.collide_type(a0)
	clr.b	obj.collide_status(a0)
	bra.w	loc_20C188

; ------------------------------------------------------------------------------

ElectricShieldObject:
	movea.w	obj.var_2e(a0),a2
	moveq	#0,d0
	move.b	obj.routine(a0),d0
	move.w	off_20C370(pc,d0.w),d0
	jmp	off_20C370(pc,d0.w)

; ------------------------------------------------------------------------------

off_20C370:
	dc.w	ElectricShieldObject_0_Routine0-*
	dc.w	ElectricShieldObject_0_Routine2-off_20C370

; ------------------------------------------------------------------------------

ElectricShieldObject_0_Routine0:
	move.b	#4,obj.sprite_flags(a0)
	move.b	#5,obj.sprite_layer(a0)
	move.b	#$18,obj.width_2(a0)
	move.b	#$18,obj.height(a0)
	move.w	#$37C,obj.sprite_tile(a0)
	move.l	#ElectricShieldSprites,obj.sprite_data(a0)
	addq.b	#2,obj.routine(a0)

ElectricShieldObject_0_Routine2:
	cmpi.b	#$A,obj.anim_id(a2)
	bne.s	loc_20C3DA
	move.w	obj.x(a2),obj.x(a0)
	move.w	obj.y(a2),obj.y(a0)
	addq.b	#1,obj.var_2a(a0)
	cmpi.b	#5,obj.var_2a(a0)
	beq.s	loc_20C3C4
	jmp	DrawObject

; ------------------------------------------------------------------------------

loc_20C3C4:
	clr.b	obj.var_2a(a0)
	addq.b	#1,obj.sprite_frame(a0)
	cmpi.b	#2,obj.sprite_frame(a0)
	bne.s	locret_20C3D8
	clr.b	obj.sprite_frame(a0)

locret_20C3D8:
	rts

; ------------------------------------------------------------------------------

loc_20C3DA:
	jmp	DeleteObject

; ------------------------------------------------------------------------------

MetalSonicObject_0_Routine10:
	lea	player_object,a3
	bsr.w	sub_20C072
	moveq	#0,d0
	move.b	obj.var_2d(a0),d0
	add.b	d0,d0
	move.w	off_20C3F8(pc,d0.w),d0
	jmp	off_20C3F8(pc,d0.w)

; ------------------------------------------------------------------------------

off_20C3F8:
	dc.w	MetalSonicObject_2_Routine0-*
	dc.w	MetalSonicObject_2_Routine2-off_20C3F8
	dc.w	MetalSonicObject_2_Routine4-off_20C3F8
	dc.w	MetalSonicObject_2_Routine6-off_20C3F8

; ------------------------------------------------------------------------------

MetalSonicObject_2_Routine0:
	move.b	#$B,obj.anim_id(a0)
	move.w	#$3E90,obj.x(a0)
	move.w	#$1CC,obj.y(a0)
	addq.b	#1,obj.var_2d(a0)
	rts

; ------------------------------------------------------------------------------

MetalSonicObject_2_Routine2:
	cmpi.w	#$3DD0,obj.x(a1)
	blt.s	locret_20C42A
	addq.b	#1,obj.var_2d(a0)
	move.b	#$1E,obj.var_2a(a0)

locret_20C42A:
	rts

; ------------------------------------------------------------------------------

MetalSonicObject_2_Routine4:
	bra.w	MetalSonicObject_2_Routine4_0

; ------------------------------------------------------------------------------

MetalSonicObject_2_Routine6:
	move.b	#$C,obj.anim_id(a0)
	rts

; ------------------------------------------------------------------------------

MetalSonicObject_0_Routine12:
	tst.b	obj.var_2d(a0)
	bne.s	loc_20C46A
	moveq	#$64,d0
	jsr	AddPoints
	move.b	#1,obj.var_2d(a0)
	move.b	#$D,obj.anim_id(a0)
	clr.w	obj.x_speed(a0)
	clr.w	obj.var_30(a0)
	move.w	#$FB00,obj.y_speed(a0)
	move.w	#$28,obj.var_32(a0)
	bsr.w	sub_20D070

loc_20C46A:
	cmpi.w	#$F0,obj.var_2a(a0)
	bne.s	loc_20C47A
	addq.l	#4,sp
	jmp	DeleteObject

; ------------------------------------------------------------------------------

loc_20C47A:
	bsr.w	loc_20CEA0
	addq.w	#1,obj.var_2a(a0)
	rts

; ------------------------------------------------------------------------------

EggmanObject:
	lea	player_object,a1
	moveq	#0,d0
	move.b	obj.routine(a0),d0
	move.w	off_20C4B0(pc,d0.w),d0
	jsr	off_20C4B0(pc,d0.w)
	bsr.w	sub_20C97C
	bsr.w	sub_20C940
	lea	EggmanAnims,a1
	jsr	AnimateObject
	jmp	DrawObject

; ------------------------------------------------------------------------------

off_20C4B0:
	dc.w	EggmanObject_0_Routine0-*
	dc.w	EggmanObject_0_Routine2-off_20C4B0
	dc.w	EggmanObject_0_Routine4-off_20C4B0
	dc.w	EggmanObject_0_Routine6-off_20C4B0
	dc.w	EggmanObject_0_Routine8-off_20C4B0

; ------------------------------------------------------------------------------

EggmanObject_0_Routine0:
	move.b	#4,obj.sprite_flags(a0)
	move.b	#1,obj.sprite_layer(a0)
	move.b	#$24,obj.width_2(a0)
	move.b	#$24,obj.height(a0)
	move.w	#$300,obj.sprite_tile(a0)
	move.l	#EggmanSprites,obj.sprite_data(a0)
	addq.b	#7,boss_flags
	move.b	#7,boss_started
	movem.l	d7-a7,-(sp)
	move.w	#6,d0
	jsr	LoadPalette
	movem.l	(sp)+,d7-a7
	move.b	#2,obj.routine(a0)
	bsr.w	sub_20CFBC
	bset	#3,obj.var_2c(a0)
	bsr.w	sub_20CF98
	bsr.w	sub_20CFFA
	rts

; ------------------------------------------------------------------------------

EggmanObject_0_Routine2:
	bsr.w	sub_20C9FC
	moveq	#0,d0
	move.b	obj.var_2d(a0),d0
	add.b	d0,d0
	move.w	off_20C52A(pc,d0.w),d0
	jmp	off_20C52A(pc,d0.w)

; ------------------------------------------------------------------------------

off_20C52A:
	dc.w	EggmanObject_1_Routine0-*
	dc.w	EggmanObject_1_Routine2-off_20C52A
	dc.w	EggmanObject_1_Routine4-off_20C52A
	dc.w	EggmanObject_1_Routine6-off_20C52A
	dc.w	EggmanObject_1_Routine4-off_20C52A
	dc.w	EggmanObject_1_RoutineA-off_20C52A

; ------------------------------------------------------------------------------

EggmanObject_1_Routine0:
	andi.b	#$F0,obj.var_38(a0)
	addq.b	#1,obj.var_38(a0)
	cmpi.w	#$BE0,8(a1)
	blt.w	loc_20C580
	move.w	#-$600,obj.x_speed(a0)
	move.w	#0,obj.var_30(a0)
	addq.b	#1,obj.var_2d(a0)
	bset	#0,obj.flags(a0)
	move.w	#$B40,d0
	move.w	d0,left_bound
	move.w	d0,target_left_bound
	move.w	#$67,d0
	movem.l	a0-a2,-(sp)
	jsr	SubCpuCommand
	movem.l	(sp)+,a0-a2
	rts

; ------------------------------------------------------------------------------

loc_20C580:
	move.w	8(a1),d0
	subi.w	#$A0,d0
	cmp.w	left_bound,d0
	blt.w	locret_20C634
	cmpi.w	#$B40,d0
	bgt.w	locret_20C634
	move.w	d0,left_bound
	move.w	d0,target_left_bound
	rts

; ------------------------------------------------------------------------------

EggmanObject_1_Routine2:
	bsr.w	loc_20CEA0
	move.w	#$B18,d0
	cmp.w	obj.x(a0),d0
	blt.w	locret_20C634
	move.w	d0,obj.x(a0)
	move.w	#$600,obj.x_speed(a0)
	move.w	#0,obj.var_30(a0)
	addq.b	#1,obj.var_2d(a0)
	bclr	#0,obj.flags(a0)
	move.w	#$78,obj.var_2a(a0)
	rts

; ------------------------------------------------------------------------------

EggmanObject_1_Routine6:
	bsr.w	loc_20CEA0
	move.w	#$CA8,d0
	cmp.w	obj.x(a0),d0
	bgt.w	locret_20C634
	move.w	d0,obj.x(a0)
	move.w	#$FA00,obj.x_speed(a0)
	move.w	#0,obj.var_30(a0)
	bset	#0,obj.flags(a0)
	addq.b	#1,obj.var_2d(a0)
	move.w	#$78,obj.var_2a(a0)
	rts

; ------------------------------------------------------------------------------

EggmanObject_1_RoutineA:
	bsr.w	loc_20CEA0
	move.w	#$C20,d0
	cmp.w	obj.x(a0),d0
	blt.s	locret_20C634
	move.w	d0,obj.x(a0)
	clr.w	obj.x_speed(a0)
	clr.w	obj.var_30(a0)
	clr.b	obj.var_2d(a0)
	clr.w	obj.var_2a(a0)
	bclr	#3,obj.var_2c(a0)
	move.b	#4,obj.routine(a0)

locret_20C634:
	rts

; ------------------------------------------------------------------------------

EggmanObject_0_Routine4:
	bsr.w	loc_20CEA0
	move.w	#$B00,d0
	cmp.w	obj.x(a0),d0
	blt.w	loc_20C64A
	move.w	d0,obj.x(a0)

loc_20C64A:
	bsr.w	sub_20C9FC
	lea	word_20C658,a3
	bra.w	sub_20CEE0

; ------------------------------------------------------------------------------

word_20C658:
	dc.w	120
	dc.w	loc_20C688-word_20C658
	dc.w	180
	dc.w	sub_20C6AA-word_20C658
	dc.w	184
	dc.w	sub_20C69C-word_20C658
	dc.w	185
	dc.w	sub_20C6C6-word_20C658
	dc.w	190
	dc.w	sub_20C6B8-word_20C658
	dc.w	220
	dc.w	sub_20C6AA-word_20C658
	dc.w	224
	dc.w	sub_20C69C-word_20C658
	dc.w	230
	dc.w	sub_20C6B8-word_20C658
	dc.w	260
	dc.w	sub_20C6AA-word_20C658
	dc.w	264
	dc.w	sub_20C69C-word_20C658
	dc.w	270
	dc.w	sub_20C6B8-word_20C658
	dc.w	420
	dc.w	sub_20C6D8-word_20C658

; ------------------------------------------------------------------------------

loc_20C688:
	movea.w	obj.var_2e(a0),a2
	move.b	#4,obj.routine(a2)
	clr.w	obj.var_2a(a2)
	clr.b	obj.var_2d(a2)
	rts

; ------------------------------------------------------------------------------

sub_20C69C:
	bset	#6,obj.var_2c(a0)
	bset	#5,obj.var_2c(a0)
	rts

; ------------------------------------------------------------------------------

sub_20C6AA:
	bset	#6,obj.var_2c(a0)
	bclr	#5,obj.var_2c(a0)
	rts

; ------------------------------------------------------------------------------

sub_20C6B8:
	bclr	#6,obj.var_2c(a0)
	bclr	#5,obj.var_2c(a0)
	rts

; ------------------------------------------------------------------------------

sub_20C6C6:
	bset	#3,obj.var_2c(a0)
	move.w	#-$200,obj.x_speed(a0)
	clr.w	obj.var_30(a0)
	rts

; ------------------------------------------------------------------------------

sub_20C6D8:
	bsr.s	sub_20C6AA
	move.b	#6,obj.routine(a0)
	bset	#4,obj.var_2c(a0)
	move.w	#$200,obj.x_speed(a0)
	move.w	#$200,obj.var_34(a0)
	move.w	#2,obj.var_30(a0)
	clr.w	obj.y_speed(a0)
	clr.w	obj.var_32(a0)
	bclr	#0,obj.flags(a0)
	clr.b	obj.var_2d(a0)
	clr.w	obj.var_2a(a0)
	rts

; ------------------------------------------------------------------------------

EggmanObject_0_Routine6:
	move.w	#$3E50,d0
	cmp.w	obj.x(a0),d0
	ble.s	loc_20C726
	bsr.w	sub_20CE68
	bsr.w	sub_20C8A6
	bra.w	sub_20C9FC

; ------------------------------------------------------------------------------

loc_20C726:
	move.w	d0,obj.x(a0)
	move.b	#8,obj.routine(a0)
	clr.b	obj.var_2d(a0)
	clr.w	obj.x_speed(a0)
	clr.w	obj.y_speed(a0)
	rts

; ------------------------------------------------------------------------------

EggmanObject_0_Routine8:
	moveq	#0,d0
	move.b	obj.var_2d(a0),d0
	add.b	d0,d0
	move.w	off_20C74E(pc,d0.w),d0
	jmp	off_20C74E(pc,d0.w)

; ------------------------------------------------------------------------------

off_20C74E:
	dc.w	EggmanObject_2_Routine0-*
	dc.w	EggmanObject_2_Routine2-off_20C74E
	dc.w	EggmanObject_1_Routine4-off_20C74E
	dc.w	EggmanObject_2_Routine6-off_20C74E
	dc.w	EggmanObject_1_Routine4-off_20C74E
	dc.w	EggmanObject_2_RoutineA-off_20C74E
	dc.w	EggmanObject_1_Routine4-off_20C74E
	dc.w	EggmanObject_2_RoutineE-off_20C74E
	dc.w	EggmanObject_1_Routine4-off_20C74E
	dc.w	EggmanObject_2_Routine12-off_20C74E

; ------------------------------------------------------------------------------

EggmanObject_2_Routine0:
	move.b	obj.var_39(a0),d0
	andi.b	#$F,d0
	cmpi.b	#1,d0
	beq.s	loc_20C780
	cmpi.b	#2,d0
	beq.s	EggmanObject_2_Routine2
	rts

; ------------------------------------------------------------------------------

EggmanObject_2_Routine2:
	move.b	#1,obj.var_2d(a0)
	rts

; ------------------------------------------------------------------------------

loc_20C780:
	bclr	#5,obj.var_2c(a0)
	bclr	#4,obj.var_2c(a0)
	andi.b	#$F,obj.var_38(a0)
	move.b	#2,obj.var_2d(a0)
	move.w	#$1E,obj.var_2a(a0)
	rts

; ------------------------------------------------------------------------------

EggmanObject_2_Routine6:
	addq.w	#1,obj.var_2a(a0)
	cmpi.w	#$78,obj.var_2a(a0)
	bge.s	loc_20C7C4
	moveq	#0,d0
	move.w	obj.var_2a(a0),d0
	divu.w	#$14,d0
	swap	d0
	tst.w	d0
	bne.s	locret_20C7C2
	eori.b	#$40,obj.var_2c(a0)

locret_20C7C2:
	rts

; ------------------------------------------------------------------------------

loc_20C7C4:
	bclr	#6,obj.var_2c(a0)
	addq.b	#1,obj.var_2d(a0)
	move.w	#$1E,obj.var_2a(a0)
	clr.w	obj.x_speed(a0)
	move.w	#$200,obj.y_speed(a0)
	moveq	#4,d0
	jsr	AddGfxQueue
	rts

; ------------------------------------------------------------------------------

EggmanObject_2_RoutineA:
	bsr.w	loc_20CEB0
	cmpi.w	#$190,obj.y(a0)
	bge.s	loc_20C7F6
	rts

; ------------------------------------------------------------------------------

loc_20C7F6:
	move.w	#$600,obj.x_speed(a0)
	clr.w	obj.y_speed(a0)
	addq.b	#1,obj.var_2d(a0)
	move.w	#$3C,obj.var_2a(a0)
	rts

; ------------------------------------------------------------------------------

EggmanObject_2_RoutineE:
	bsr.w	loc_20CEB0
	cmpi.w	#$3F60,obj.x(a0)
	bge.s	loc_20C81A
	rts

; ------------------------------------------------------------------------------

loc_20C81A:
	addq.b	#1,obj.var_2d(a0)
	move.w	#$3C,obj.var_2a(a0)
	rts

; ------------------------------------------------------------------------------

EggmanObject_2_Routine12:
	move.w	#$20,d0
	tst.b	good_future
	beq.s	loc_20C836
	move.w	#$1F,d0

loc_20C836:
	movem.l	a0-a2,-(sp)
	jsr	SubCpuCommand
	movem.l	(sp)+,a0-a2
	move.b	#3,obj.var_38(a0)
	bsr.w	sub_20C97C
	jsr	LoadCapsulePalette
	bsr.s	sub_20C85E
	addq.l	#4,sp
	jmp	DeleteObject

; ------------------------------------------------------------------------------

sub_20C85E:
	lea	AmyRosePalette(pc),a3
	lea	palette+$20,a4
	movem.l	(a3)+,d0-d3
	movem.l	d0-d3,(a4)
	movem.l	d0-d3,water_palette-palette(a4)
	movem.l	(a3)+,d0-d3
	movem.l	d0-d3,$10(a4)
	movem.l	d0-d3,$10+(water_palette-palette)(a4)
	rts

; ------------------------------------------------------------------------------

AmyRosePalette:
	incbin	"src/palettes/amy_rose.pal"
	even

; ------------------------------------------------------------------------------

sub_20C8A6:
	move.b	obj.width_2(a0),d0
	move.w	obj.x(a0),d1
	sub.w	scroll_fg_x,d1
	add.w	d0,d1
	bge.s	loc_20C8D2
	addq.w	#1,obj.var_3c(a0)
	bsr.w	sub_20C8FE
	tst.w	obj.var_3a(a0)
	beq.s	loc_20C8CA
	subq.w	#1,obj.var_3a(a0)
	rts

; ------------------------------------------------------------------------------

loc_20C8CA:
	bclr	#2,obj.var_2c(a0)
	rts

; ------------------------------------------------------------------------------

loc_20C8D2:
	clr.w	obj.var_3c(a0)
	bsr.w	sub_20C8FE
	bset	#2,obj.var_2c(a0)
	beq.s	loc_20C8E4
	rts

; ------------------------------------------------------------------------------

loc_20C8E4:
	move.w	#$F0,obj.var_3a(a0)
	move.w	#$100,d1
	move.w	obj.x_speed(a1),d0
	cmp.w	d1,d0
	bge.s	loc_20C8F8
	move.w	d1,d0

loc_20C8F8:
	move.w	d0,obj.x_speed(a0)
	rts

; ------------------------------------------------------------------------------

sub_20C8FE:
	cmpi.w	#-$A0,d1
	ble.s	loc_20C920
	cmpi.w	#$3100,obj.x(a1)
	bge.s	loc_20C91C
	cmpi.w	#$DC0,obj.x(a1)
	bge.s	loc_20C918
	moveq	#0,d0
	bra.s	loc_20C922

; ------------------------------------------------------------------------------

loc_20C918:
	moveq	#4,d0
	bra.s	loc_20C922

; ------------------------------------------------------------------------------

loc_20C91C:
	moveq	#8,d0
	bra.s	loc_20C922

; ------------------------------------------------------------------------------

loc_20C920:
	moveq	#$C,d0

loc_20C922:
	lea	word_20C930(pc,d0.w),a3
	move.w	(a3)+,obj.var_34(a0)
	move.w	(a3),obj.var_30(a0)
	rts

; ------------------------------------------------------------------------------

word_20C930:
	dc.w	$200, 2
	dc.w	$300, 2
	dc.w	$440, 8
	dc.w	$600, 4

; ------------------------------------------------------------------------------

sub_20C940:
	btst	#4,obj.var_2c(a0)
	beq.s	locret_20C97A
	lea	player_object,a3
	tst.b	(a3)
	beq.s	locret_20C97A
	cmpi.b	#6,obj.routine(a3)
	bcc.s	locret_20C97A
	move.w	obj.x(a3),d0
	sub.w	obj.x(a0),d0
	cmpi.w	#$10,d0
	bgt.s	locret_20C97A
	movem.l	a0-a2,-(sp)
	movea.l	a3,a0
	bset	#7,obj.flags(a0)
	bsr.w	KillPlayer
	movem.l	(sp)+,a0-a2

locret_20C97A:
	rts

; ------------------------------------------------------------------------------

sub_20C97C:
	tst.b	obj.var_38(a0)
	bge.s	loc_20C9B4
	move.w	obj.x(a0),d0
	subq.w	#8,d0
	cmpi.w	#$3DA0,d0
	ble.s	loc_20C992
	move.w	#$3DA0,d0

loc_20C992:
	move.w	d0,left_bound
	move.w	d0,target_left_bound
	move.w	obj.x(a1),d0
	sub.w	left_bound,d0
	subi.w	#$A0,d0
	bge.s	loc_20C9B4
	addi.w	#$A0,d0
	andi.w	#$FFFE,d0
	move.w	d0,scroll_focus_x

loc_20C9B4:
	move.b	obj.var_38(a0),d0
	andi.w	#$F,d0
	add.b	d0,d0
	move.w	off_20C9C6(pc,d0.w),d0
	jmp	off_20C9C6(pc,d0.w)

; ------------------------------------------------------------------------------

off_20C9C6:
	dc.w	EggmanObject_3_Routine0-*
	dc.w	EggmanObject_3_Routine2-off_20C9C6
	dc.w	EggmanObject_3_Routine4-off_20C9C6
	dc.w	EggmanObject_3_Routine6-off_20C9C6

; ------------------------------------------------------------------------------

EggmanObject_3_Routine0:
	rts

; ------------------------------------------------------------------------------

EggmanObject_3_Routine2:
	move.w	#$B40,d0
	move.w	d0,right_bound
	move.w	d0,target_right_bound
	rts

; ------------------------------------------------------------------------------

EggmanObject_3_Routine4:
	move.w	#$3DA0,d0
	move.w	d0,right_bound
	move.w	d0,target_right_bound
	rts

; ------------------------------------------------------------------------------

EggmanObject_3_Routine6:
	lea	word_20292E+4,a3
	move.w	(a3),right_bound
	move.w	(a3),target_right_bound
	rts

; ------------------------------------------------------------------------------

sub_20C9FC:
	addi.w	#$80,obj.y(a0)
	bsr.w	sub_20CA64
	subi.w	#$80,obj.y(a0)
	rts

; ------------------------------------------------------------------------------

sub_20CA0E:
	addi.w	#0,obj.y(a0)
	bsr.w	sub_20CA20
	subi.w	#0,obj.y(a0)
	rts

; ------------------------------------------------------------------------------

sub_20CA20:
	movem.l	a1-a2,-(sp)
	jsr	CheckBlockDown
	movem.l	(sp)+,a1-a2
	cmpi.w	#8,d1
	ble.s	loc_20CA4E
	bsr.w	sub_20CA8E
	beq.s	loc_20CA4E
	addi.w	#$30,obj.subtype(a0)
	move.w	obj.subtype(a0),d1
	ext.l	d1
	lsl.l	#8,d1
	add.l	d1,obj.y(a0)
	bra.s	locret_20CA62

; ------------------------------------------------------------------------------

loc_20CA4E:
	clr.w	obj.subtype(a0)
	bra.s	loc_20CA5E

; ------------------------------------------------------------------------------

	cmpi.w	#-8,d1
	bge.s	loc_20CA5E
	bsr.w	sub_20CA8E

loc_20CA5E:
	add.w	d1,obj.y(a0)

locret_20CA62:
	rts

; ------------------------------------------------------------------------------

sub_20CA64:
	movem.l	a1-a2,-(sp)
	jsr	CheckBlockDown
	movem.l	(sp)+,a1-a2
	cmpi.w	#8,d1
	ble.s	loc_20CA7E
	bsr.w	sub_20CA8E
	bra.s	loc_20CA88

; ------------------------------------------------------------------------------

loc_20CA7E:
	cmpi.w	#-8,d1
	bge.s	loc_20CA88
	bsr.w	sub_20CA8E

loc_20CA88:
	add.w	d1,obj.y(a0)
	rts

; ------------------------------------------------------------------------------

sub_20CA8E:
	lea	word_20CABA,a2

loc_20CA94:
	move.w	(a2)+,d2
	bmi.w	locret_20CAB8
	move.w	(a2)+,d3
	move.w	(a2)+,d4
	sub.w	obj.x(a0),d2
	bgt.s	loc_20CAA6
	neg.w	d2

loc_20CAA6:
	cmpi.w	#$40,d2
	bgt.s	loc_20CA94
	add.w	d3,obj.x(a0)
	add.w	d4,obj.y(a0)
	clr.w	d1
	rts

; ------------------------------------------------------------------------------

locret_20CAB8:
	rts

; ------------------------------------------------------------------------------

word_20CABA:
	dc.w	$C30, 0, 0
	dc.w	$1610, 0, -2
	dc.w	$1858, 0, -$10
	dc.w	$2220, 0, -2
	dc.w	$2490, 0, -$10
	dc.w	$2820, 0, -2
	dc.w	$2A79, 0, -$10
	dc.w	$2C60, 0, -$10
	dc.w	$2E60, 0, -$10
	dc.w	$2FC0, 0, 0
	dc.w	$3020, 0, -2
	dc.w	$3030, 0, -2
	dc.w	$3E30, 0, 0
	dc.w	$3FB0, 0, 0
	dc.w	-1

; ------------------------------------------------------------------------------

BossLaserObject:
	movea.w	obj.var_2e(a0),a2
	tst.b	(a2)
	beq.s	loc_20CB26
	moveq	#0,d0
	move.b	obj.routine(a0),d0
	move.w	off_20CB2C(pc,d0.w),d0
	jmp	off_20CB2C(pc,d0.w)

; ------------------------------------------------------------------------------

loc_20CB26:
	jmp	DeleteObject

; ------------------------------------------------------------------------------

off_20CB2C:
	dc.w	BossLaserObject_0_Routine0-*
	dc.w	BossLaserObject_0_Routine2-off_20CB2C
	dc.w	BossLaserObject_0_Routine4-off_20CB2C
	dc.w	BossLaserObject_0_Routine6-off_20CB2C

; ------------------------------------------------------------------------------

BossLaserObject_0_Routine0:
	tst.b	obj.subtype(a0)
	bne.s	loc_20CB68
	move.b	#4,obj.sprite_flags(a0)
	move.b	#2,obj.sprite_layer(a0)
	move.b	#8,obj.width_2(a0)
	move.b	#$10,obj.height(a0)
	move.w	#$2300,obj.sprite_tile(a0)
	move.l	#BossLaserSprites,obj.sprite_data(a0)
	move.b	#2,obj.routine(a0)
	rts

; ------------------------------------------------------------------------------

loc_20CB68:
	move.b	#4,obj.sprite_flags(a0)
	move.b	#1,obj.sprite_layer(a0)
	move.b	#$10,obj.width_2(a0)
	move.b	#$10,obj.height(a0)
	move.w	#$680,obj.sprite_tile(a0)
	move.l	#ExplosionSprites,obj.sprite_data(a0)
	cmpi.b	#2,obj.subtype(a0)
	beq.s	loc_20CBA4
	move.b	#4,obj.routine(a0)
	move.b	#$F,obj.var_2a(a0)
	rts

; ------------------------------------------------------------------------------

loc_20CBA4:
	move.b	#6,obj.routine(a0)
	move.b	#$1E,obj.var_2a(a0)
	rts

; ------------------------------------------------------------------------------

BossLaserObject_0_Routine2:
	clr.w	obj.collide_type(a0)
	btst	#5,$2C(a2)
	beq.s	loc_20CBCA
	move.b	#$BE,obj.collide_type(a0)
	move.b	#2,obj.collide_status(a0)

loc_20CBCA:
	bsr.w	sub_20CC0E
	beq.s	loc_20CC08
	tst.b	obj.subtype_2(a0)
	beq.s	loc_20CBF6
	subq.b	#1,obj.var_2a(a0)
	bcc.s	loc_20CBE6
	bsr.w	sub_20D04A
	move.b	#$A,obj.var_2a(a0)

loc_20CBE6:
	subq.b	#1,obj.var_2b(a0)
	bcc.s	loc_20CBF6
	bsr.w	sub_20D0A8
	move.b	#9,obj.var_2b(a0)

loc_20CBF6:
	lea	BossLaserAnims,a1
	jsr	AnimateObject
	jmp	DrawObject

; ------------------------------------------------------------------------------

loc_20CC08:
	clr.w	obj.var_2a(a0)
	rts

; ------------------------------------------------------------------------------

sub_20CC0E:
	move.w	obj.x(a2),obj.x(a0)
	move.w	obj.y(a2),obj.y(a0)
	move.w	obj.var_36(a0),d0
	move.w	obj.var_38(a0),d1
	add.w	d1,obj.y(a0)
	btst	#0,obj.flags(a2)
	bne.s	loc_20CC3A
	bclr	#0,obj.flags(a0)
	add.w	d0,obj.x(a0)
	bra.s	loc_20CC44

; ------------------------------------------------------------------------------

loc_20CC3A:
	bset	#0,obj.flags(a0)
	sub.w	d0,obj.x(a0)

loc_20CC44:
	bclr	#5,obj.var_2c(a0)
	btst	#5,obj.var_2c(a2)
	beq.s	loc_20CC58
	bset	#5,obj.var_2c(a0)

loc_20CC58:
	btst	#6,obj.var_2c(a2)
	beq.s	loc_20CC6A
	bset	#6,obj.var_2c(a0)
	moveq	#-1,d0
	rts

; ------------------------------------------------------------------------------

loc_20CC6A:
	bclr	#6,obj.var_2c(a0)
	moveq	#0,d0
	rts

; ------------------------------------------------------------------------------

BossLaserObject_0_Routine4:
	bsr.s	sub_20CC0E
	bsr.w	MetalSonicObject_2_Routine4_0
	tst.b	obj.var_2d(a0)
	beq.s	loc_20CC90
	clr.b	obj.var_2d(a0)
	move.b	#6,obj.routine(a0)
	move.b	#$F,obj.var_2a(a0)

loc_20CC90:
	bra.w	loc_20CCA4

; ------------------------------------------------------------------------------

BossLaserObject_0_Routine6:
	bsr.w	MetalSonicObject_2_Routine4_0
	tst.b	obj.var_2d(a0)
	beq.s	loc_20CCA4
	jmp	DeleteObject

; ------------------------------------------------------------------------------

loc_20CCA4:
	lea	BossLaserImpactAnims,a1
	jsr	AnimateObject
	jmp	DrawObject

; ------------------------------------------------------------------------------

BossLaserImpactAnims:
	include	"src/anims/r7/boss_laser_impact.asm"
	even

; ------------------------------------------------------------------------------

DebrisObject:
	bset	#0,obj.routine(a0)
	bne.w	loc_20CD30
	move.b	#4,obj.sprite_flags(a0)
	move.b	#5,obj.sprite_layer(a0)
	move.b	#4,obj.width_2(a0)
	move.b	#4,obj.height(a0)
	move.w	#$451C,obj.sprite_tile(a0)
	move.l	#DebrisSprites,obj.sprite_data(a0)
	jsr	Random
	andi.l	#$FFFF,d0
	ext.l	d0
	move.l	d0,d1
	andi.l	#$7FFF,d0
	divs.w	#$1C0,d1
	swap	d1
	add.w	d1,obj.x_speed(a0)
	move.w	#$FE80,obj.y_speed(a0)
	move.w	#$10,obj.var_32(a0)
	move.w	d0,d1
	andi.w	#$F,d1
	add.w	d1,obj.var_32(a0)
	andi.b	#3,d0
	move.b	d0,obj.sprite_frame(a0)
	rts

; ------------------------------------------------------------------------------

loc_20CD30:
	bsr.w	loc_20CEA0
	move.w	obj.y(a0),d0
	move.w	scroll_fg_y,d1
	addi.w	#$E8,d1
	sub.w	d1,d0
	bgt.s	loc_20CD4A
	jmp	DrawObject

; ------------------------------------------------------------------------------

loc_20CD4A:
	jmp	DeleteObject

; ------------------------------------------------------------------------------

BossExhaustObject:
	moveq	#0,d0
	move.b	obj.routine(a0),d0
	move.w	off_20CD5E(pc,d0.w),d0
	jmp	off_20CD5E(pc,d0.w)

; ------------------------------------------------------------------------------

off_20CD5E:
	dc.w	BossExhaustObject_0_Routine0-*
	dc.w	BossExhaustObject_0_Routine2-off_20CD5E

; ------------------------------------------------------------------------------

BossExhaustObject_0_Routine0:
	move.b	#4,obj.sprite_flags(a0)
	move.b	#5,obj.sprite_layer(a0)
	move.b	#$14,obj.width_2(a0)
	move.b	#8,obj.height(a0)
	move.w	#$2300,obj.sprite_tile(a0)
	move.l	#BossExhaustSprites,obj.sprite_data(a0)
	tst.b	obj.subtype(a0)
	bne.s	loc_20CD9C
	move.w	#$FFCD,obj.var_36(a0)
	move.w	#$1A,obj.var_38(a0)
	bra.s	loc_20CDA8

; ------------------------------------------------------------------------------

loc_20CD9C:
	move.w	#$FFD0,obj.var_36(a0)
	move.w	#$FFF2,obj.var_38(a0)

loc_20CDA8:
	addq.b	#2,obj.routine(a0)

BossExhaustObject_0_Routine2:
	movea.w	obj.var_2e(a0),a2
	tst.b	(a2)
	beq.w	loc_20CDFE
	btst	#3,$2C(a2)
	beq.w	locret_20CE04
	move.b	$22(a2),obj.flags(a0)
	move.w	8(a2),obj.x(a0)
	move.w	$C(a2),obj.y(a0)
	move.w	obj.var_36(a0),d0
	btst	#0,obj.flags(a0)
	beq.s	loc_20CDE0
	neg.w	d0

loc_20CDE0:
	add.w	d0,obj.x(a0)
	move.w	obj.var_38(a0),d0
	add.w	d0,obj.y(a0)
	lea	BossExhaustAnims,a1
	jsr	AnimateObject
	jmp	DrawObject

; ------------------------------------------------------------------------------

loc_20CDFE:
	jmp	DeleteObject

; ------------------------------------------------------------------------------

locret_20CE04:
	rts

; ------------------------------------------------------------------------------

MetalSonicDebrisObject:
	moveq	#0,d0
	move.b	obj.routine(a0),d0
	move.w	off_20CE1A(pc,d0.w),d0
	jsr	off_20CE1A(pc,d0.w)
	jmp	DrawObject

; ------------------------------------------------------------------------------

off_20CE1A:
	dc.w	MetalSonicDebrisObject_0_Routine0-*
	dc.w	MetalSonicDebrisObject_0_Routine2-off_20CE1A

; ------------------------------------------------------------------------------

MetalSonicDebrisObject_0_Routine0:
	move.b	#4,obj.sprite_flags(a0)
	move.b	#1,obj.sprite_layer(a0)
	move.b	#8,obj.width_2(a0)
	move.b	#8,obj.height(a0)
	move.w	#$37C,obj.sprite_tile(a0)
	move.l	#MetalSonicDebrisSprites,obj.sprite_data(a0)

MetalSonicDebrisObject_0_Routine2:
	bsr.w	loc_20CEA0
	cmpi.w	#$270,obj.y(a0)
	bge.s	loc_20CE52
	rts

; ------------------------------------------------------------------------------

loc_20CE52:
	jsr	DeleteObject
	addq.l	#4,sp
	rts

; ------------------------------------------------------------------------------

	move.w	obj.y(a1),obj.y(a0)
	sub.w	d0,obj.y(a0)
	rts

; ------------------------------------------------------------------------------

sub_20CE68:
	move.w	obj.var_32(a0),d0
	add.w	d0,obj.y_speed(a0)
	move.w	obj.var_30(a0),d0
	add.w	d0,obj.x_speed(a0)
	tst.w	obj.var_30(a0)
	beq.s	loc_20CEB0
	bmi.s	loc_20CE90
	move.w	obj.var_34(a0),d0
	cmp.w	obj.x_speed(a0),d0
	bgt.s	loc_20CEB0
	move.w	d0,obj.x_speed(a0)
	bra.s	loc_20CEB0

; ------------------------------------------------------------------------------

loc_20CE90:
	move.w	obj.var_34(a0),d0
	cmp.w	obj.x_speed(a0),d0
	blt.s	loc_20CEB0
	move.w	d0,obj.x_speed(a0)
	bra.s	loc_20CEB0

; ------------------------------------------------------------------------------

loc_20CEA0:
	move.w	obj.var_30(a0),d0
	add.w	d0,obj.x_speed(a0)
	move.w	obj.var_32(a0),d0
	add.w	d0,obj.y_speed(a0)

loc_20CEB0:
	move.w	obj.x_speed(a0),d0
	ext.l	d0
	lsl.l	#8,d0
	add.l	d0,obj.x(a0)
	move.w	obj.y_speed(a0),d0
	ext.l	d0
	lsl.l	#8,d0
	add.l	d0,obj.y(a0)
	rts

; ------------------------------------------------------------------------------

EggmanObject_1_Routine4:
	subq.w	#1,obj.var_2a(a0)
	beq.s	loc_20CEDA
	rts

; ------------------------------------------------------------------------------

MetalSonicObject_2_Routine4_0:
	subq.b	#1,obj.var_2a(a0)
	beq.s	loc_20CEDA
	rts

; ------------------------------------------------------------------------------

loc_20CEDA:
	addq.b	#1,obj.var_2d(a0)
	rts

; ------------------------------------------------------------------------------

sub_20CEE0:
	moveq	#0,d0
	move.b	obj.var_2d(a0),d0
	add.b	d0,d0
	add.b	d0,d0
	move.w	(a3,d0.w),d0
	cmp.w	obj.var_2a(a0),d0
	beq.s	loc_20CEFA
	addq.w	#1,obj.var_2a(a0)
	rts

; ------------------------------------------------------------------------------

loc_20CEFA:
	addq.w	#1,obj.var_2a(a0)
	moveq	#0,d0
	move.b	obj.var_2d(a0),d0
	addq.b	#1,obj.var_2d(a0)
	add.b	d0,d0
	add.b	d0,d0
	move.w	2(a3,d0.w),d0
	adda.w	d0,a3
	jmp	(a3)

; ------------------------------------------------------------------------------

sub_20CF14:
	moveq	#9,d3

loc_20CF16:
	movem.l	d3,-(sp)
	jsr	SpawnObjectAfter
	movem.l	(sp)+,d3
	bne.s	locret_20CF82
	move.l	d3,d0
	divs.w	#5,d0
	swap	d0
	move.b	d0,obj.sprite_frame(a1)
	move.w	a0,obj.var_2e(a1)
	move.b	#$31,obj.id(a1)
	move.w	obj.x(a0),obj.x(a1)
	move.w	obj.y(a0),obj.y(a1)
	jsr	Random
	andi.l	#$FFFF,d0
	ext.l	d0
	move.l	d0,d1
	ori.l	#$FFFF8000,d1
	divs.w	#$280,d1
	swap	d1
	move.w	d1,obj.x_speed(a1)
	move.w	#$FE00,obj.y_speed(a1)
	move.w	#$C,obj.var_32(a1)
	move.w	d0,d1
	andi.w	#$F,d1
	add.w	d1,obj.var_32(a1)
	dbf	d3,loc_20CF16

locret_20CF82:
	rts

; ------------------------------------------------------------------------------

sub_20CF84:
	jsr	SpawnObjectAfter
	bne.s	locret_20CF96
	move.w	a0,obj.var_2e(a1)
	move.b	#$30,obj.id(a1)

locret_20CF96:
	rts

; ------------------------------------------------------------------------------

sub_20CF98:
	jsr	SpawnObjectAfter
	bne.s	locret_20CFBA
	move.w	a0,obj.var_2e(a1)
	move.w	a1,obj.var_2e(a0)
	move.b	#$2F,obj.id(a1)
	move.w	#$C30,obj.x(a1)
	move.w	#$1CD,obj.y(a1)

locret_20CFBA:
	rts

; ------------------------------------------------------------------------------

sub_20CFBC:
	jsr	SpawnObjectAfter
	bne.s	locret_20CFF8
	move.w	a0,obj.var_2e(a1)
	move.b	#$2D,obj.id(a1)
	move.b	#0,obj.subtype(a1)
	move.b	#0,obj.anim_id(a1)
	jsr	SpawnObjectAfter
	bne.s	locret_20CFF8
	move.w	a0,obj.var_2e(a1)
	move.b	#$2D,obj.id(a1)
	move.b	#1,obj.subtype(a1)
	move.b	#1,obj.anim_id(a1)

locret_20CFF8:
	rts

; ------------------------------------------------------------------------------

sub_20CFFA:
	moveq	#3,d2
	movea.l	a0,a3

loc_20CFFE:
	jsr	SpawnObjectAfter
	bne.w	locret_20D048
	move.w	a3,obj.var_2e(a1)
	move.w	a0,obj.var_3a(a1)
	move.b	#$2E,obj.id(a1)
	movea.l	a1,a3
	cmpi.w	#3,d2
	beq.s	loc_20D038
	tst.w	d2
	beq.s	loc_20D024
	bra.s	loc_20D02A

; ------------------------------------------------------------------------------

loc_20D024:
	move.b	#1,obj.subtype_2(a1)

loc_20D02A:
	move.w	#2,obj.var_36(a1)
	move.w	#$20,obj.var_38(a1)
	bra.s	loc2_20D044

; ------------------------------------------------------------------------------

loc_20D038:
	move.w	#0,obj.var_36(a1)
	move.w	#$34,obj.var_38(a1)

loc2_20D044:
	dbf	d2,loc_20CFFE

locret_20D048:
	rts

; ------------------------------------------------------------------------------

sub_20D04A:
	jsr	SpawnObjectAfter
	bne.s	locret_20D06E
	move.w	a0,obj.var_2e(a1)
	move.b	#$2E,obj.id(a1)
	move.b	#1,obj.subtype(a1)
	move.w	#2,obj.var_36(a1)
	move.w	#$10,obj.var_38(a1)

locret_20D06E:
	rts

; ------------------------------------------------------------------------------

sub_20D070:
	jsr	SpawnObjectAfter
	bne.s	locret_20D0A6
	move.w	a0,obj.var_2e(a1)
	move.b	#$2E,obj.id(a1)
	move.b	#2,obj.subtype(a1)
	move.w	obj.x(a0),obj.x(a1)
	move.w	obj.y(a0),obj.y(a1)
	move.w	#$9E,d0
	movem.l	a0-a2,-(sp)
	jsr	PlayFmSound
	movem.l	(sp)+,a0-a2

locret_20D0A6:
	rts

; ------------------------------------------------------------------------------

sub_20D0A8:
	jsr	SpawnObjectAfter
	bne.s	locret_20D0D6
	move.b	#$37,obj.id(a1)
	move.w	obj.x(a0),obj.x(a1)
	move.w	obj.y(a0),obj.y(a1)
	addq.w	#2,obj.x(a1)
	addi.w	#$10,obj.y(a1)
	movea.w	obj.var_3a(a0),a2
	move.w	$10(a2),obj.x_speed(a1)

locret_20D0D6:
	rts

; ------------------------------------------------------------------------------

EggmanAnims:
	include	"src/anims/r7/eggman.asm"
	even

EggmanSprites:
	include	"src/sprites/r7/eggman.asm"
	even

BossLaserAnims:
	include	"src/anims/r7/boss_laser.asm"
	even

BossLaserSprites:
	include	"src/sprites/r7/boss_laser.asm"
	even

BossExhaustAnims:
	include	"src/anims/r7/boss_exhaust.asm"
	even

BossExhaustSprites:
	include	"src/sprites/r7/boss_exhaust.asm"
	even

MetalSonicAnims:
	include	"src/anims/r7/metal_sonic.asm"
	even

MetalSonicSprites:
	include	"src/sprites/r7/metal_sonic.asm"
	even

ElectricShieldSprites:
	include	"src/sprites/r7/electric_shield.asm"
	even

MetalSonicDebrisSprites:
	include	"src/sprites/r7/metal_sonic_debris.asm"
	even

DebrisSprites:
	include	"src/sprites/r7/debris.asm"
	even

; ------------------------------------------------------------------------------
