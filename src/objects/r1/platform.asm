; ------------------------------------------------------------------------------

PlatformObject:
	moveq	#0,d0
	move.b	obj.routine(a0),d0
	move.w	off_20C86E(pc,d0.w),d0
	jsr	off_20C86E(pc,d0.w)
	jsr	DrawObject
	rts

; ------------------------------------------------------------------------------

off_20C86E:
	dc.w	PlatformObject_0_Routine0-*
	dc.w	PlatformObject_0_Routine2-off_20C86E

; ------------------------------------------------------------------------------

loc_20C872:
	lea	player_object,a1
	move.w	obj.x(a0),d3
	move.w	obj.y(a0),d4
	jmp	TopSolidObject

; ------------------------------------------------------------------------------

PlatformObject_0_Routine0:
	ori.b	#4,obj.sprite_flags(a0)
	move.w	#$44BE,obj.sprite_tile(a0)
	move.b	#2,obj.sprite_layer(a0)
	move.w	obj.x(a0),obj.var_38(a0)
	move.w	obj.y(a0),obj.var_3a(a0)
	move.w	obj.y(a0),obj.var_36(a0)
	move.l	#PlatformSprites,d0
	cmpi.w	#0,zone
	beq.s	loc_20C8CE
	move.l	#PlatformSprites,d0
	cmpi.w	#1,zone
	beq.s	loc_20C8CE
	move.l	#PlatformSprites,d0

loc_20C8CE:
	move.l	d0,obj.sprite_data(a0)
	move.b	obj.subtype(a0),d0
	move.b	d0,d1
	andi.w	#3,d0
	move.b	d0,obj.sprite_frame(a0)
	move.b	byte_20C94E(pc,d0.w),obj.width_2(a0)
	move.b	#8,obj.height(a0)
	lsr.b	#2,d1
	andi.w	#3,d1
	move.b	byte_20C952(pc,d1.w),obj.var_2d(a0)
	move.b	obj.subtype_2(a0),d0
	beq.s	loc_20C948
	jsr	SpawnObject
	beq.s	loc_20C90C
	jmp	loc_20CCAC

; ------------------------------------------------------------------------------

loc_20C90C:
	move.b	#$A,obj.id(a1)
	move.w	obj.x(a0),obj.x(a1)
	move.w	obj.y(a0),obj.y(a1)
	subi.w	#$10,obj.y(a1)
	move.b	#-$10,obj.var_39(a1)
	move.w	a0,obj.var_34(a1)
	move.b	obj.subtype_2(a0),d0
	move.b	d0,d1
	andi.b	#2,d1
	move.b	d1,obj.subtype(a1)
	andi.b	#$F8,d0
	move.b	d0,obj.var_38(a1)
	add.w	d0,obj.x(a1)

loc_20C948:
	addq.b	#2,obj.routine(a0)
	rts

; ------------------------------------------------------------------------------

byte_20C94E:
	dc.b	$10
	dc.b	$20
	dc.b	$30
	even

byte_20C952:
	dc.b	2
	dc.b	3
	dc.b	4
	dc.b	6

; ------------------------------------------------------------------------------

PlatformObject_0_Routine2:
	tst.w	time_stop
	beq.s	loc_20C962
	bra.w	loc_20C872

; ------------------------------------------------------------------------------

loc_20C962:
	move.b	obj.subtype(a0),d0
	lsr.b	#4,d0
	andi.w	#$F,d0
	add.w	d0,d0
	move.w	off_20C9A2(pc,d0.w),d0
	jsr	off_20C9A2(pc,d0.w)
	move.w	obj.var_38(a0),d0
	andi.w	#$FF80,d0
	move.w	scroll_fg_x,d1
	subi.w	#$80,d1
	andi.w	#$FF80,d1
	sub.w	d1,d0
	cmpi.w	#$280,d0
	bhi.s	loc_20C994
	rts

; ------------------------------------------------------------------------------

loc_20C994:
	lea	player_object,a1
	jsr	GetOffObject
	bra.w	loc_20CCAC

; ------------------------------------------------------------------------------

off_20C9A2:
	dc.w	PlatformObject_1_Routine0-*
	dc.w	PlatformObject_1_Routine2-off_20C9A2
	dc.w	PlatformObject_1_Routine4-off_20C9A2
	dc.w	PlatformObject_1_Routine6-off_20C9A2
	dc.w	PlatformObject_1_Routine8-off_20C9A2
	dc.w	PlatformObject_1_RoutineA-off_20C9A2
	dc.w	PlatformObject_1_RoutineC-off_20C9A2
	dc.w	PlatformObject_1_RoutineE-off_20C9A2
	dc.w	PlatformObject_1_Routine10-off_20C9A2
	dc.w	PlatformObject_1_Routine12-off_20C9A2

; ------------------------------------------------------------------------------

PlatformObject_1_Routine0:
	addq.b	#1,obj.var_2a(a0)
	jsr	loc_20CC94(pc)
	add.w	obj.var_3a(a0),d0
	move.w	d0,obj.y(a0)
	jmp	loc_20C872

; ------------------------------------------------------------------------------

PlatformObject_1_Routine2:
	move.l	obj.x(a0),-(sp)
	jsr	loc_20CC94(pc)
	add.w	obj.var_38(a0),d0
	move.w	d0,obj.x(a0)
	addq.b	#1,obj.var_2a(a0)
	moveq	#0,d0
	move.b	obj.var_2c(a0),d0
	asr.b	#1,d0
	add.w	obj.var_3a(a0),d0
	move.w	d0,obj.y(a0)

loc_20C9F0:
	move.l	(sp)+,d0
	move.l	obj.x(a0),d1
	sub.l	d0,d1
	asr.l	#8,d1
	move.w	d1,obj.x_speed(a0)

loc_20C9FE:
	jsr	loc_20C872(pc)
	beq.s	loc_20CA16
	move.b	obj.var_2c(a0),d0
	cmpi.b	#8,d0
	bcc.s	loc_20CA12
	addq.b	#1,obj.var_2c(a0)

loc_20CA12:
	moveq	#1,d0
	rts

; ------------------------------------------------------------------------------

loc_20CA16:
	moveq	#0,d0
	move.b	obj.var_2c(a0),d0
	beq.s	loc_20CA22
	subq.b	#1,obj.var_2c(a0)

loc_20CA22:
	moveq	#0,d0
	rts

; ------------------------------------------------------------------------------

PlatformObject_1_Routine4:
	move.l	obj.x(a0),-(sp)
	addq.b	#1,obj.var_2a(a0)
	jsr	loc_20CC94(pc)
	add.w	obj.var_3a(a0),d0
	move.w	d0,obj.y(a0)
	jsr	loc_20CC94(pc)
	add.w	obj.var_38(a0),d0
	move.w	d0,obj.x(a0)
	bra.w	loc_20C9F0

; ------------------------------------------------------------------------------

PlatformObject_1_Routine6:
	move.l	obj.x(a0),-(sp)
	addq.b	#1,obj.var_2a(a0)
	jsr	loc_20CC94(pc)
	add.w	obj.var_3a(a0),d0
	move.w	d0,obj.y(a0)
	jsr	loc_20CC94(pc)
	neg.w	d0
	add.w	obj.var_38(a0),d0
	move.w	d0,obj.x(a0)
	bra.w	loc_20C9F0

; ------------------------------------------------------------------------------

PlatformObject_1_Routine8:
	moveq	#0,d0
	move.b	obj.var_2c(a0),d0
	asr.b	#1,d0
	add.w	obj.var_3a(a0),d0
	move.w	d0,obj.y(a0)
	bra.w	loc_20C9FE

; ------------------------------------------------------------------------------

PlatformObject_1_RoutineA:
	move.b	obj.var_2b(a0),d0
	bne.s	loc_20CA9C
	jsr	PlatformObject_1_Routine8(pc)
	bne.s	loc_20CA92
	rts

; ------------------------------------------------------------------------------

loc_20CA92:
	move.b	#$1E,obj.var_2e(a0)
	addq.b	#2,obj.var_2b(a0)

loc_20CA9C:
	move.b	obj.var_2e(a0),d0
	beq.s	loc_20CAAA
	subq.b	#1,obj.var_2e(a0)
	bra.w	PlatformObject_1_Routine8

; ------------------------------------------------------------------------------

loc_20CAAA:
	jsr	loc_20C872(pc)
	move.l	obj.y(a0),d1
	move.w	obj.y_speed(a0),d0
	ext.l	d0
	asl.l	#8,d0
	add.l	d0,d1
	move.l	d1,obj.y(a0)
	move.w	obj.y_speed(a0),d0
	cmpi.w	#$400,d0
	bcc.s	loc_20CAD0
	addi.w	#$40,obj.y_speed(a0)

loc_20CAD0:
	move.w	scroll_fg_y,d0
	addi.w	#$100,d0
	cmp.w	obj.y(a0),d0
	bcc.s	locret_20CAEE
	lea	player_object,a1
	jsr	GetOffObject
	jmp	DeleteObject

; ------------------------------------------------------------------------------

locret_20CAEE:
	rts

; ------------------------------------------------------------------------------

PlatformObject_1_RoutineC:
	move.b	obj.var_2b(a0),d0
	andi.w	#$FF,d0
	move.w	off_20CB00(pc,d0.w),d0
	jmp	off_20CB00(pc,d0.w)

; ------------------------------------------------------------------------------

off_20CB00:
	dc.w	PlatformObject_2_Routine0-*
	dc.w	PlatformObject_2_Routine2-off_20CB00
	dc.w	PlatformObject_2_Routine4-off_20CB00

; ------------------------------------------------------------------------------

PlatformObject_2_Routine0:
	jsr	PlatformObject_1_Routine8(pc)
	bne.s	loc_20CB0E
	rts

; ------------------------------------------------------------------------------

loc_20CB0E:
	addq.b	#2,obj.var_2b(a0)

PlatformObject_2_Routine2:
	move.b	obj.var_2a(a0),d0
	cmpi.b	#$40,d0
	bcc.w	loc_20CB36
	jsr	loc_20CC94(pc)
	neg.w	d0
	add.w	obj.var_3a(a0),d0
	move.w	d0,obj.y(a0)
	addq.b	#2,obj.var_2a(a0)
	jmp	loc_20C872

; ------------------------------------------------------------------------------

loc_20CB36:
	move.w	obj.y(a0),obj.var_3a(a0)
	addq.b	#2,obj.var_2b(a0)

PlatformObject_2_Routine4:
	bra.w	PlatformObject_1_Routine8

; ------------------------------------------------------------------------------

PlatformObject_1_RoutineE:
	move.b	obj.var_2b(a0),d0
	andi.w	#$FF,d0
	move.w	off_20CB54(pc,d0.w),d0
	jmp	off_20CB54(pc,d0.w)

; ------------------------------------------------------------------------------

off_20CB54:
	dc.w	PlatformObject_3_Routine0-*
	dc.w	PlatformObject_3_Routine2-off_20CB54
	dc.w	PlatformObject_3_Routine4-off_20CB54

; ------------------------------------------------------------------------------

PlatformObject_3_Routine0:
	jsr	PlatformObject_1_Routine8(pc)
	bne.s	loc_20CB62
	rts

; ------------------------------------------------------------------------------

loc_20CB62:
	addq.b	#2,obj.var_2b(a0)
	move.b	#$3C,obj.var_2e(a0)

PlatformObject_3_Routine2:
	move.b	obj.var_2e(a0),d0
	beq.s	loc_20CB7A
	subq.b	#1,obj.var_2e(a0)
	bra.w	PlatformObject_1_Routine8

; ------------------------------------------------------------------------------

loc_20CB7A:
	jsr	MoveObject
	subq.w	#8,obj.y_speed(a0)
	jsr	CheckBlockUp
	tst.w	d1
	bmi.s	loc_20CB92
	bra.w	loc_20C9FE

; ------------------------------------------------------------------------------

loc_20CB92:
	sub.w	d1,obj.y(a0)
	move.w	obj.y(a0),obj.var_3a(a0)
	addq.b	#2,obj.var_2b(a0)

PlatformObject_3_Routine4:
	bra.w	PlatformObject_1_Routine8

; ------------------------------------------------------------------------------

PlatformObject_1_Routine10:
	move.b	obj.var_2b(a0),d0
	andi.w	#$FF,d0
	move.w	off_20CBB4(pc,d0.w),d0
	jmp	off_20CBB4(pc,d0.w)

; ------------------------------------------------------------------------------

off_20CBB4:
	dc.w	PlatformObject_4_Routine0-*
	dc.w	PlatformObject_4_Routine2-off_20CBB4
	dc.w	PlatformObject_4_Routine4-off_20CBB4

; ------------------------------------------------------------------------------

PlatformObject_4_Routine0:
	jsr	PlatformObject_1_Routine8(pc)
	bne.s	loc_20CBC2
	rts

; ------------------------------------------------------------------------------

loc_20CBC2:
	addq.b	#2,obj.var_2b(a0)
	move.b	#60,obj.var_2e(a0)

PlatformObject_4_Routine2:
	move.b	obj.var_2e(a0),d0
	beq.s	loc_20CBDA
	subq.b	#1,obj.var_2e(a0)
	bra.w	PlatformObject_1_Routine8

; ------------------------------------------------------------------------------

loc_20CBDA:
	move.b	obj.var_2a(a0),d0
	cmpi.b	#$40,d0
	bcc.w	loc_20CC0E
	move.l	obj.x(a0),-(sp)
	jsr	loc_20CC94(pc)
	add.w	obj.var_38(a0),d0
	move.w	d0,obj.x(a0)
	addq.b	#1,obj.var_2a(a0)
	moveq	#0,d0
	move.b	obj.var_2c(a0),d0
	asr.b	#1,d0
	add.w	obj.var_3a(a0),d0
	move.w	d0,obj.y(a0)
	bra.w	loc_20C9F0

; ------------------------------------------------------------------------------

loc_20CC0E:
	move.w	obj.x(a0),obj.var_38(a0)
	addq.b	#2,obj.var_2b(a0)

PlatformObject_4_Routine4:
	bra.w	PlatformObject_1_Routine8

; ------------------------------------------------------------------------------

PlatformObject_1_Routine12:
	move.b	obj.var_2b(a0),d0
	andi.w	#$FF,d0
	move.w	off_20CC2C(pc,d0.w),d0
	jmp	off_20CC2C(pc,d0.w)

; ------------------------------------------------------------------------------

off_20CC2C:
	dc.w	PlatformObject_5_Routine0-*
	dc.w	PlatformObject_5_Routine2-off_20CC2C
	dc.w	PlatformObject_5_Routine4-off_20CC2C

; ------------------------------------------------------------------------------

PlatformObject_5_Routine0:
	jsr	PlatformObject_1_Routine8(pc)
	bne.s	loc_20CC3A
	rts

; ------------------------------------------------------------------------------

loc_20CC3A:
	addq.b	#2,obj.var_2b(a0)
	move.b	#60,obj.var_2e(a0)

PlatformObject_5_Routine2:
	move.b	obj.var_2e(a0),d0
	beq.s	loc_20CC52
	subq.b	#1,obj.var_2e(a0)
	bra.w	PlatformObject_1_Routine8

; ------------------------------------------------------------------------------

loc_20CC52:
	move.b	obj.var_2a(a0),d0
	cmpi.b	#$40,d0
	bcc.s	loc_20CC86
	move.l	obj.x(a0),-(sp)
	jsr	loc_20CC94(pc)
	neg.w	d0
	add.w	obj.var_38(a0),d0
	move.w	d0,obj.x(a0)
	addq.b	#1,obj.var_2a(a0)
	moveq	#0,d0
	move.b	obj.var_2c(a0),d0
	asr.b	#1,d0
	add.w	obj.var_3a(a0),d0
	move.w	d0,obj.y(a0)
	bra.w	loc_20C9F0

; ------------------------------------------------------------------------------

loc_20CC86:
	move.w	obj.x(a0),obj.var_38(a0)
	addq.b	#2,obj.var_2b(a0)

PlatformObject_5_Routine4:
	bra.w	PlatformObject_1_Routine8

; ------------------------------------------------------------------------------

loc_20CC94:
	moveq	#0,d0
	move.b	obj.var_2a(a0),d0
	jsr	SineCosine
	moveq	#0,d2
	move.b	obj.var_2d(a0),d2
	muls.w	d2,d0
	asr.w	#4,d0
	rts

; ------------------------------------------------------------------------------

loc_20CCAC:
	moveq	#0,d0
	move.b	obj.state_id(a0),d0
	beq.s	loc_20CCD0
	lea	object_states,a1
	move.w	d0,d1
	add.w	d1,d1
	add.w	d1,d0
	moveq	#0,d1
	move.b	time_zone,d1
	add.w	d1,d0
	bclr	#7,2(a1,d0.w)

loc_20CCD0:
	jmp	DeleteObject

; ------------------------------------------------------------------------------

PlatformSprites:
	include	"src/sprites/r1/platform.asm"
	even

UnusedPlatformSprites:
	include	"src/sprites/r1/unused_platform.asm"
	even

; ------------------------------------------------------------------------------
