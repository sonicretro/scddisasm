; ------------------------------------------------------------------------------

AmyRoseObject:
	tst.b	time_attack
	bne.s	loc_20E8C6
	moveq	#0,d0
	move.b	obj.routine(a0),d0
	move.w	off_20E8D2(pc,d0.w),d0
	jsr	off_20E8D2(pc,d0.w)
	bsr.w	sub_20EE10
	jsr	DrawObject
	jsr	CheckObjectDespawn
	cmpi.b	#$2F,obj.id(a0)
	beq.s	locret_20E8D0

loc_20E8C6:
	lea	StageEndPalette,a3
	bsr.w	sub_20EE90

locret_20E8D0:
	rts

; ------------------------------------------------------------------------------

off_20E8D2:
	dc.w	AmyRoseObject_0_Routine0-*
	dc.w	AmyRoseObject_0_Routine2-off_20E8D2
	dc.w	AmyRoseObject_0_Routine4-off_20E8D2
	dc.w	AmyRoseObject_0_Routine6-off_20E8D2
	dc.w	AmyRoseObject_0_Routine8-off_20E8D2

; ------------------------------------------------------------------------------

AmyRoseObject_0_Routine0:
	ori.b	#4,obj.sprite_flags(a0)
	move.w	#$2370,obj.sprite_tile(a0)
	move.b	#1,obj.sprite_layer(a0)
	move.l	#AmyRoseSprites,obj.sprite_data(a0)
	move.b	#$C,obj.width_2(a0)
	move.b	#$10,obj.height(a0)
	move.w	obj.x(a0),obj.var_36(a0)
	bsr.w	sub_20EE8C

loc_20E90C:
	jsr	CheckBlockDown
	tst.w	d1
	beq.s	loc_20E91E
	add.w	d1,obj.y(a0)
	bra.w	loc_20E90C

; ------------------------------------------------------------------------------

loc_20E91E:
	lea	player_object,a1
	bsr.w	sub_20EE60
	move.w	obj.x(a1),d0
	sub.w	obj.x(a0),d0
	bcc.s	loc_20E932
	neg.w	d0

loc_20E932:
	cmpi.w	#$70,d0
	bcc.s	loc_20E93C
	addq.b	#2,obj.routine(a0)

loc_20E93C:
	move.b	#5,obj.anim_id(a0)
	lea	AmyRoseAnims,a1
	bra.w	loc_20EDAE

; ------------------------------------------------------------------------------

AmyRoseObject_0_Routine2:
	lea	player_object,a1
	bsr.w	sub_20EE60
	btst	#6,obj.var_3e(a0)
	bne.w	loc_20EA2A
	btst	#2,obj.var_3e(a0)
	bne.w	loc_20E98E
	tst.w	$10(a1)
	bne.s	loc_20E9A6
	move.w	8(a1),d0
	sub.w	obj.x(a0),d0
	bcc.s	loc_20E97A
	neg.w	d0

loc_20E97A:
	cmpi.w	#$A,d0
	bcc.s	loc_20E9A6

loc_20E980:
	bset	#2,obj.var_3e(a0)
	clr.w	obj.x_speed(a0)
	bra.w	loc_20EA36

; ------------------------------------------------------------------------------

loc_20E98E:
	move.w	obj.x(a1),d0
	sub.w	obj.x(a0),d0
	bcc.s	loc_20E99A
	neg.w	d0

loc_20E99A:
	cmpi.w	#$20,d0
	bcs.s	loc_20E980
	bclr	#2,obj.var_3e(a0)

loc_20E9A6:
	move.w	#-$10,d0
	btst	#0,obj.flags(a0)
	bne.s	loc_20E9B4
	neg.w	d0

loc_20E9B4:
	add.w	obj.x_speed(a0),d0
	move.w	d0,d1
	move.w	#$200,d2
	tst.w	d1
	bpl.s	loc_20E9C6
	neg.w	d1
	neg.w	d2

loc_20E9C6:
	cmpi.w	#$200,d1
	bcs.s	loc_20E9CE
	move.w	d2,d0

loc_20E9CE:
	move.w	d0,obj.x_speed(a0)
	tst.w	obj.x_speed(a0)
	bpl.s	loc_20E9EA
	move.w	obj.var_36(a0),d0
	subi.w	#$130,d0
	cmp.w	obj.x(a0),d0
	bcs.s	loc_20E9FC
	bra.w	loc_20EA2A

; ------------------------------------------------------------------------------

loc_20E9EA:
	move.w	obj.var_36(a0),d0
	addi.w	#$90,d0
	cmp.w	obj.x(a0),d0
	bcc.s	loc_20E9FC
	bra.w	loc_20EA2A

; ------------------------------------------------------------------------------

loc_20E9FC:
	jsr	CheckBlockDown
	cmpi.w	#7,d1
	bpl.s	loc_20EA2A
	cmpi.w	#-7,d1
	bmi.s	loc_20EA2A
	add.w	d1,obj.y(a0)
	bsr.w	loc_20EDA0
	bsr.w	loc_20EC6C
	move.b	#2,obj.anim_id(a0)
	lea	AmyRoseAnims,a1
	bra.w	loc_20EDAE

; ------------------------------------------------------------------------------

loc_20EA2A:
	clr.w	obj.x_speed(a0)
	btst	#7,obj.var_3e(a0)
	bne.s	loc_20EA50

loc_20EA36:
	jsr	CheckBlockDown
	add.w	d1,obj.y(a0)
	move.b	#1,obj.anim_id(a0)
	lea	AmyRoseAnims,a1
	bra.w	loc_20EDAE

; ------------------------------------------------------------------------------

loc_20EA50:
	btst	#6,obj.var_3e(a0)
	bne.s	loc_20EA86
	cmpi.b	#3,obj.var_3f(a0)
	bcs.s	loc_20EA7A
	addq.b	#4,obj.var_3a(a0)
	bcc.s	loc_20EA6A
	clr.b	obj.var_3f(a0)

loc_20EA6A:
	move.b	#4,obj.anim_id(a0)
	lea	AmyRoseAnims,a1
	bra.w	loc_20EDAE

; ------------------------------------------------------------------------------

loc_20EA7A:
	move.w	#-$300,obj.y_speed(a0)
	bset	#6,obj.var_3e(a0)

loc_20EA86:
	bsr.w	loc_20ED92
	addi.w	#$40,obj.y_speed(a0)
	move.b	#6,obj.sprite_frame(a0)
	tst.w	obj.y_speed(a0)
	bmi.s	loc_20EAA2
	move.b	#4,obj.sprite_frame(a0)

loc_20EAA2:
	jsr	CheckBlockDown
	tst.w	d1
	bpl.s	locret_20EABA
	clr.w	obj.y_speed(a0)
	bclr	#6,obj.var_3e(a0)
	addq.b	#1,obj.var_3f(a0)

locret_20EABA:
	rts

; ------------------------------------------------------------------------------

AmyRoseObject_0_Routine4:
	lea	player_object,a1
	bset	#0,obj.var_2c(a1)
	move.b	#5,obj.anim_id(a1)
	bsr.w	loc_20EBAC
	bsr.w	sub_20EE60
	moveq	#$C,d0
	btst	#0,obj.flags(a1)
	bne.s	loc_20EAE0
	neg.w	d0

loc_20EAE0:
	add.w	obj.x(a1),d0
	move.w	d0,obj.x(a0)
	move.w	obj.y(a1),obj.y(a0)
	move.w	p1_joy_hold,player_joy_hold
	bsr.w	loc_20EBE8
	btst	#0,obj.var_2c(a1)
	beq.s	loc_20EB1C
	cmpi.l	#$93200,time
	bcc.s	loc_20EB2A
	move.b	#3,obj.anim_id(a0)
	lea	AmyRoseAnims,a1
	bra.w	loc_20EDAE

; ------------------------------------------------------------------------------

loc_20EB1C:
	bclr	#0,obj.var_3e(a0)
	move.b	#6,obj.routine(a0)
	rts

; ------------------------------------------------------------------------------

loc_20EB2A:
	bsr.w	loc_20EBF4
	bclr	#0,obj.var_3e(a0)
	move.b	#2,obj.routine(a0)
	rts

; ------------------------------------------------------------------------------

AmyRoseObject_0_Routine6:
	move.b	#6,obj.sprite_frame(a0)
	move.w	#$80,d0
	btst	#0,obj.flags(a0)
	bne.s	loc_20EB50
	neg.w	d0

loc_20EB50:
	move.w	d0,obj.x_speed(a0)
	move.w	obj.x(a0),d0
	sub.w	obj.var_36(a0),d0
	bcc.s	loc_20EB60
	neg.w	d0

loc_20EB60:
	cmpi.w	#$80,d0
	bcs.s	loc_20EB6A
	clr.w	obj.x_speed(a0)

loc_20EB6A:
	move.w	#-$300,obj.y_speed(a0)
	addq.b	#2,obj.routine(a0)

AmyRoseObject_0_Routine8:
	bsr.w	loc_20ED90
	addi.w	#$40,obj.y_speed(a0)
	tst.w	obj.y_speed(a0)
	bmi.s	loc_20EB8A
	move.b	#7,obj.sprite_frame(a0)

loc_20EB8A:
	jsr	CheckBlockDown
	tst.w	d1
	bpl.s	locret_20EBAA
	clr.w	obj.x_speed(a0)
	clr.w	obj.y_speed(a0)
	addi.b	#$10,obj.var_3a(a0)
	bcc.s	locret_20EBAA
	move.b	#2,obj.routine(a0)

locret_20EBAA:
	rts

; ------------------------------------------------------------------------------

loc_20EBAC:
	tst.w	obj.x_speed(a0)
	beq.s	locret_20EBE6
	movem.l	a0-a1,-(sp)
	exg	a0,a1
	bsr.w	loc_20EDA0
	jsr	CheckBlockDown
	add.w	d1,obj.y(a0)
	movem.l	(sp)+,a0-a1
	tst.w	obj.x_speed(a1)
	bmi.s	loc_20EBDA
	subi.w	#$40,obj.x_speed(a1)
	bpl.s	locret_20EBE6
	bra.s	loc_20EBE2

; ------------------------------------------------------------------------------

loc_20EBDA:
	addi.w	#$40,obj.x_speed(a1)
	bmi.s	locret_20EBE6

loc_20EBE2:
	clr.w	obj.x_speed(a1)

locret_20EBE6:
	rts

; ------------------------------------------------------------------------------

loc_20EBE8:
	move.b	player_joy_tap,d0
	andi.b	#$70,d0
	beq.w	locret_20EC62

loc_20EBF4:
	clr.b	obj.var_2c(a1)
	move.w	#$680,d2
	moveq	#0,d0
	move.b	obj.angle(a1),d0
	subi.b	#$40,d0
	jsr	SineCosine
	muls.w	d2,d1
	asr.l	#8,d1
	add.w	d1,obj.x_speed(a1)
	muls.w	d2,d0
	asr.l	#8,d0
	add.w	d0,obj.y_speed(a1)
	bset	#1,obj.flags(a1)
	bclr	#5,obj.flags(a1)
	move.b	#1,obj.var_3c(a1)
	clr.b	obj.var_38(a1)
	move.b	#$13,obj.height(a1)
	move.b	#9,obj.width(a1)
	btst	#2,obj.flags(a1)
	bne.s	loc_20EC64
	move.b	#$E,obj.height(a1)
	move.b	#7,obj.width(a1)
	addq.w	#5,obj.y(a1)
	bset	#2,obj.flags(a1)
	move.b	#2,obj.anim_id(a1)

locret_20EC62:
	rts

; ------------------------------------------------------------------------------

loc_20EC64:
	bset	#4,obj.flags(a1)
	rts

; ------------------------------------------------------------------------------

loc_20EC6C:
	tst.w	obj.x_speed(a0)
	bpl.s	loc_20EC84
	move.w	obj.var_36(a0),d0
	subi.w	#$130,d0
	cmp.w	obj.x(a0),d0
	bcs.s	loc_20EC96
	bra.w	locret_20ED5A

; ------------------------------------------------------------------------------

loc_20EC84:
	move.w	obj.var_36(a0),d0
	addi.w	#$90,d0
	cmp.w	obj.x(a0),d0
	bcc.s	loc_20EC96
	bra.w	locret_20ED5A

; ------------------------------------------------------------------------------

loc_20EC96:
	cmpi.l	#$93200,time
	bcc.w	locret_20ED5A
	lea	player_object,a1
	tst.b	debug_mode
	bne.w	locret_20ED5A
	btst	#0,obj.flags(a1)
	bne.s	loc_20ECC4
	move.w	obj.x(a1),d0
	sub.w	obj.x(a0),d0
	bra.s	loc_20ECCC

; ------------------------------------------------------------------------------

loc_20ECC4:
	move.w	obj.x(a0),d0
	sub.w	obj.x(a1),d0

loc_20ECCC:
	bcs.w	locret_20ED5A
	cmpi.w	#$C,d0
	bcs.w	locret_20ED5A
	cmpi.w	#$18,d0
	bcc.s	locret_20ED5A
	moveq	#8,d1
	move.w	obj.y(a1),d0
	sub.w	obj.y(a0),d0
	add.w	d1,d0
	bmi.s	locret_20ED5A
	move.w	d1,d2
	add.w	d2,d2
	cmp.w	d2,d0
	bcc.s	locret_20ED5A
	move.w	obj.x_speed(a1),d0
	bpl.s	loc_20ECFC
	neg.w	d0

loc_20ECFC:
	btst	#1,obj.flags(a1)
	bne.s	loc_20ED5C
	btst	#2,obj.flags(a1)
	bne.s	loc_20ED5C
	tst.b	obj.var_30(a1)
	bne.s	loc_20ED5C
	cmpi.w	#$680,d0
	bcc.s	loc_20ED5C
	tst.b	shield
	bne.s	loc_20ED5C
	tst.b	warping
	bne.s	loc_20ED5C
	tst.b	invincible
	bne.s	loc_20ED5C
	bclr	#2,obj.flags(a1)
	ori.b	#$81,obj.var_3e(a0)
	clr.w	obj.y_speed(a0)
	clr.w	obj.x_speed(a0)
	move.b	#7,obj.sprite_frame(a0)
	move.b	#4,obj.routine(a0)
	move.w	#$7C,d0
	jsr	SubCpuCommand

locret_20ED5A:
	rts

; ------------------------------------------------------------------------------

loc_20ED5C:
	move.b	#6,obj.routine(a0)
	rts

; ------------------------------------------------------------------------------

AmyRoseUnknown1:
	lea	player_object,a1
	move.w	obj.x(a0),d0
	sub.w	obj.x(a1),d0
	bcc.s	loc_20ED74
	neg.w	d0

loc_20ED74:
	cmpi.w	#$34,d0
	rts

; ------------------------------------------------------------------------------

AmyRoseUnknown2:
	lea	player_object,a1
	move.w	obj.x(a0),d0
	sub.w	obj.x(a1),d0
	bcc.s	loc_20ED8A
	neg.w	d0

loc_20ED8A:
	cmpi.w	#$7C,d0
	rts

; ------------------------------------------------------------------------------

loc_20ED90:
	bsr.s	loc_20EDA0

loc_20ED92:
	move.w	obj.y_speed(a0),d0
	ext.l	d0
	asl.l	#8,d0
	add.l	d0,obj.y(a0)
	rts

; ------------------------------------------------------------------------------

loc_20EDA0:
	move.w	obj.x_speed(a0),d0
	ext.l	d0
	asl.l	#8,d0
	add.l	d0,obj.x(a0)
	rts

; ------------------------------------------------------------------------------

loc_20EDAE:
	moveq	#0,d0
	move.b	obj.anim_id(a0),d0
	cmp.b	obj.prev_anim_id(a0),d0
	beq.s	loc_20EDC6
	move.b	d0,obj.prev_anim_id(a0)
	clr.b	obj.anim_index(a0)
	clr.b	obj.anim_timer(a0)

loc_20EDC6:
	subq.b	#1,obj.anim_timer(a0)
	bpl.s	locret_20EE0E
	add.w	d0,d0
	adda.w	(a1,d0.w),a1

loc_20EDD2:
	move.b	obj.anim_index(a0),d0
	lea	(a1,d0.w),a2
	move.b	(a2),d0
	bpl.s	loc_20EDE4
	clr.b	obj.anim_index(a0)
	bra.s	loc_20EDD2

; ------------------------------------------------------------------------------

loc_20EDE4:
	move.b	d0,d1
	andi.b	#$1F,d0
	move.b	d0,obj.sprite_frame(a0)
	move.b	obj.flags(a0),d0
	rol.b	#3,d1
	eor.b	d0,d1
	andi.b	#3,d1
	andi.b	#$FC,obj.sprite_flags(a0)
	or.b	d1,obj.sprite_flags(a0)
	move.b	1(a2),obj.anim_timer(a0)
	addq.b	#2,obj.anim_index(a0)

locret_20EE0E:
	rts

; ------------------------------------------------------------------------------

sub_20EE10:
	moveq	#6,d0
	btst	#0,obj.var_3e(a0)
	beq.s	loc_20EE1C
	moveq	#$10,d0

loc_20EE1C:
	add.b	d0,obj.var_3b(a0)
	bcc.s	locret_20EE5E
	jsr	SpawnObject
	bne.s	locret_20EE5E
	move.b	#$30,obj.id(a1)
	moveq	#8,d1
	btst	#0,obj.flags(a0)
	beq.s	loc_20EE3E
	move.w	#-$A,d1

loc_20EE3E:
	btst	#0,obj.var_3e(a0)
	beq.s	loc_20EE48
	neg.w	d1

loc_20EE48:
	move.w	obj.x(a0),d0
	add.w	d1,d0
	move.w	d0,obj.x(a1)
	move.w	obj.y(a0),d0
	subi.w	#$C,d0
	move.w	d0,obj.y(a1)

locret_20EE5E:
	rts

; ------------------------------------------------------------------------------

sub_20EE60:
	bsr.s	sub_20EE70
	move.w	obj.x(a0),d0
	sub.w	obj.x(a1),d0
	bcs.s	locret_20EE6E
	bsr.s	sub_20EE7E

locret_20EE6E:
	rts

; ------------------------------------------------------------------------------

sub_20EE70:
	bclr	#0,obj.flags(a0)
	bclr	#0,obj.sprite_flags(a0)
	rts

; ------------------------------------------------------------------------------

sub_20EE7E:
	bset	#0,obj.flags(a0)
	bset	#0,obj.sprite_flags(a0)
	rts

; ------------------------------------------------------------------------------

sub_20EE8C:
	lea	AmyRosePalette(pc),a3

; ------------------------------------------------------------------------------

sub_20EE90:
	lea	palette+$20,a4
	movem.l	(a3)+,d0-d3
	movem.l	d0-d3,(a4)
	movem.l	(a3)+,d0-d3
	movem.l	d0-d3,$10(a4)
	rts

; ------------------------------------------------------------------------------

AmyRosePalette:
	incbin	"src/palettes/amy_rose.pal"
	even

; ------------------------------------------------------------------------------

HeartObject:
	moveq	#0,d0
	move.b	obj.routine(a0),d0
	move.w	off_20EEE2(pc,d0.w),d0
	jsr	off_20EEE2(pc,d0.w)
	jsr	DrawObject
	jmp	CheckObjectDespawn

; ------------------------------------------------------------------------------

off_20EEE2:
	dc.w	HeartObject_0_Routine0-*
	dc.w	HeartObject_0_Routine2-off_20EEE2

; ------------------------------------------------------------------------------

HeartObject_0_Routine0:
	addq.b	#2,obj.routine(a0)
	ori.b	#4,obj.sprite_flags(a0)
	move.w	#$370,obj.sprite_tile(a0)
	move.l	#AmyRoseSprites,obj.sprite_data(a0)
	move.b	#8,obj.sprite_frame(a0)
	move.w	#$FFA0,obj.y_speed(a0)
	move.b	#3,obj.sprite_layer(a0)

HeartObject_0_Routine2:
	tst.b	obj.var_3c(a0)
	bne.s	loc_20EF2E
	moveq	#0,d0
	move.b	obj.var_3a(a0),d0
	add.b	d0,d0
	add.b	obj.var_3a(a0),d0
	jsr	SineCosine
	asr.w	#2,d0
	move.w	d0,obj.x_speed(a0)

loc_20EF2E:
	bsr.w	loc_20ED90
	addq.b	#1,obj.var_3a(a0)
	move.b	obj.var_3a(a0),d0
	cmpi.b	#$14,d0
	bne.s	loc_20EF44
	addq.b	#1,obj.sprite_frame(a0)

loc_20EF44:
	cmpi.b	#$6E,d0
	bne.s	loc_20EF5A
	addq.b	#1,obj.sprite_frame(a0)
	clr.w	obj.y_speed(a0)
	clr.w	obj.x_speed(a0)
	st	obj.var_3c(a0)

loc_20EF5A:
	cmpi.b	#$78,d0
	bne.s	locret_20EF66
	jmp	DeleteObject

; ------------------------------------------------------------------------------

locret_20EF66:
	rts

; ------------------------------------------------------------------------------
