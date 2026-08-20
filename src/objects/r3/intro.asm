; ------------------------------------------------------------------------------

MetalSonicObject:
	moveq	#0,d0
	move.b	obj.routine(a0),d0
	move.w	off_20DE80(pc,d0.w),d0
	jsr	off_20DE80(pc,d0.w)
	bsr.w	sub_20E300
	cmpi.w	#$4C0,obj.x(a1)
	bcc.w	loc_20E04A
	jmp	DrawObject

; ------------------------------------------------------------------------------

off_20DE80:
	dc.w	MetalSonicObject_0_Routine0-*
	dc.w	MetalSonicObject_0_Routine2-off_20DE80
	dc.w	MetalSonicObject_0_Routine4-off_20DE80
	dc.w	MetalSonicObject_0_Routine6-off_20DE80
	dc.w	MetalSonicObject_0_Routine8-off_20DE80
	dc.w	MetalSonicObject_0_RoutineA-off_20DE80

; ------------------------------------------------------------------------------

MetalSonicObject_0_Routine0:
	addq.b	#2,obj.routine(a0)
	ori.b	#4,obj.sprite_flags(a0)
	move.w	#$3D0,obj.sprite_tile(a0)
	move.b	#2,obj.sprite_layer(a0)
	move.l	#MetalSonicSprites,obj.sprite_data(a0)
	move.b	#$E,obj.sprite_frame(a0)
	move.b	#$20,obj.height(a0)
	move.b	#$3C,obj.var_3a(a0)
	move.b	#0,obj.collide_type(a0)

MetalSonicObject_0_Routine2:
	tst.b	obj.var_3a(a0)
	beq.s	loc_20DECE
	subq.b	#1,obj.var_3a(a0)
	bne.s	locret_20DEEE

loc_20DECE:
	bsr.w	sub_20E254
	move.w	#$FFF0,obj.var_3e(a0)
	addq.b	#2,obj.routine(a0)
	btst	#7,obj.sprite_flags(a0)
	beq.s	locret_20DEEE
	move.w	#$CA,d0
	jsr	PlayFmSound

locret_20DEEE:
	rts

; ------------------------------------------------------------------------------

MetalSonicObject_0_Routine4:
	bsr.w	sub_20E08C
	move.w	obj.var_3e(a0),d0
	add.w	obj.x_speed(a0),d0
	cmpi.w	#-$300,d0
	bgt.s	loc_20DF06
	move.w	#-$300,d0

loc_20DF06:
	move.w	d0,obj.x_speed(a0)
	move.w	#$3E0,d0
	move.w	obj.var_34(a0),d1
	beq.s	loc_20DF1E
	movea.w	d1,a2
	move.w	obj.x(a2),d0
	addi.w	#$20,d0

loc_20DF1E:
	cmp.w	obj.x(a0),d0
	bcs.s	loc_20DF48
	clr.w	obj.x_speed(a0)
	clr.w	obj.var_3e(a0)
	st	obj.var_3d(a0)
	move.b	#2,obj.anim_id(a0)
	bsr.w	sub_20E00C
	clr.b	obj.collide_type(a0)
	move.w	obj.y(a0),obj.var_32(a0)
	addq.b	#2,obj.routine(a0)

loc_20DF48:
	lea	MetalSonicAnims(pc),a1
	bra.w	sub_20E262

; ------------------------------------------------------------------------------

MetalSonicObject_0_Routine6:
	bsr.w	sub_20E300
	bsr.w	sub_20E236
	bsr.w	sub_20DF86
	addq.b	#4,obj.var_3a(a0)
	bcc.s	loc_20DF7E
	addq.b	#2,obj.routine(a0)
	move.w	#-$2C0,obj.y_speed(a0)
	move.w	#$B,obj.var_3e(a0)
	move.b	#$40,obj.var_3b(a0)
	move.b	#$50,obj.var_30(a0)

loc_20DF7E:
	lea	MetalSonicAnims(pc),a1
	bra.w	sub_20E262

; ------------------------------------------------------------------------------

sub_20DF86:
	moveq	#0,d0
	move.b	obj.var_3a(a0),d0
	jsr	SineCosine
	add.w	d0,d0
	add.w	d0,d0
	ext.l	d0
	asl.l	#8,d0
	add.l	obj.var_32(a0),d0
	move.l	d0,obj.y(a0)
	rts

; ------------------------------------------------------------------------------

MetalSonicObject_0_Routine8:
	lea	player_object,a1
	bsr.w	sub_20E236
	tst.b	obj.var_3b(a0)
	beq.s	loc_20DFD2
	bsr.w	sub_20E07C
	move.w	obj.var_3e(a0),d0
	add.w	d0,obj.y_speed(a0)
	subq.b	#1,obj.var_3b(a0)
	bne.s	loc_20E004
	clr.w	obj.var_3e(a0)
	clr.w	obj.y_speed(a0)
	move.w	obj.y(a0),obj.var_32(a0)

loc_20DFD2:
	bsr.w	sub_20DF86
	addq.b	#4,obj.var_3a(a0)
	move.w	obj.x(a0),d0
	sub.w	obj.x(a1),d0
	bcs.s	loc_20DFEA
	cmpi.b	#$A0,d0
	bcc.s	loc_20E004

loc_20DFEA:
	subq.b	#1,obj.var_30(a0)
	bne.s	loc_20E004
	bsr.w	sub_20E246
	move.w	#0,obj.x_speed(a0)
	move.w	#$60,obj.var_3e(a0)
	addq.b	#2,obj.routine(a0)

loc_20E004:
	lea	MetalSonicAnims(pc),a1
	bra.w	sub_20E262

; ------------------------------------------------------------------------------

sub_20E00C:
	jsr	SpawnObject
	bne.s	locret_20E01E
	move.b	#$34,obj.id(a1)
	move.w	a0,obj.var_34(a1)

locret_20E01E:
	rts

; ------------------------------------------------------------------------------

MetalSonicObject_0_RoutineA:
	bsr.w	sub_20E08C
	move.w	obj.var_3e(a0),d0
	add.w	obj.x_speed(a0),d0
	cmpi.w	#$400,d0
	bcs.s	loc_20E036
	move.w	#$400,d0

loc_20E036:
	move.w	d0,obj.x_speed(a0)
	cmpi.w	#$528,obj.x(a0)
	bcc.s	loc_20E04A
	lea	MetalSonicAnims(pc),a1
	bra.w	sub_20E262

; ------------------------------------------------------------------------------

loc_20E04A:
	move.b	#-1,amy_captured
	lea	StagePalette1,a3
	bsr.w	sub_20E2C8
	jmp	DeleteObject

; ------------------------------------------------------------------------------

MetalSonicAnims:
	include	"src/anims/r3/metal_sonic.asm"
	even

; ------------------------------------------------------------------------------

sub_20E07C:
	bsr.s	sub_20E08C
	move.w	obj.y_speed(a0),d0
	ext.l	d0
	asl.l	#8,d0
	add.l	d0,obj.y(a0)
	rts

; ------------------------------------------------------------------------------

sub_20E08C:
	move.w	obj.x_speed(a0),d0
	ext.l	d0
	asl.l	#8,d0
	add.l	d0,obj.x(a0)
	rts

; ------------------------------------------------------------------------------

AmyRoseObject:
	tst.b	time_attack
	bne.w	loc_20E04A
	tst.b	amy_captured
	bne.w	loc_20E04A
	moveq	#0,d0
	move.b	obj.routine(a0),d0
	move.w	off_20E0D0(pc,d0.w),d0
	jsr	off_20E0D0(pc,d0.w)
	bsr.w	sub_20E300
	cmpi.w	#$4C0,obj.x(a1)
	bcc.w	loc_20E04A
	jmp	DrawObject

; ------------------------------------------------------------------------------

off_20E0D0:
	dc.w	AmyRoseObject_0_Routine0-*
	dc.w	AmyRoseObject_0_Routine2-off_20E0D0
	dc.w	AmyRoseObject_0_Routine4-off_20E0D0

; ------------------------------------------------------------------------------

AmyRoseObject_0_Routine0:
	tst.b	obj.var_3e(a0)
	bmi.s	loc_20E0E8
	moveq	#$B,d0
	jsr	AddGfxQueue
	st	obj.var_3e(a0)

loc_20E0E8:
	ori.b	#4,obj.sprite_flags(a0)
	move.w	#$235E,obj.sprite_tile(a0)
	move.b	#1,obj.sprite_layer(a0)
	move.l	#AmyRoseSprites,obj.sprite_data(a0)
	bsr.w	sub_20E2C4
	bsr.w	sub_20E300
	bsr.w	sub_20E236
	move.w	obj.x(a1),d0
	cmp.w	obj.x(a0),d0
	bcs.s	loc_20E11C
	addq.b	#2,obj.routine(a0)

loc_20E11C:
	lea	AmyRoseAnims,a1
	bra.w	sub_20E262

; ------------------------------------------------------------------------------

	rts

; ------------------------------------------------------------------------------

AmyRoseObject_0_Routine2:
	bsr.w	sub_20E300
	move.w	obj.var_34(a0),d0
	beq.s	loc_20E14E
	movea.w	d0,a2
	tst.b	obj.var_3d(a2)
	beq.s	loc_20E14E
	move.b	#4,obj.routine(a0)
	move.w	#$7D,d0
	jsr	SubCpuCommand
	bra.w	loc_20E1E0

; ------------------------------------------------------------------------------

loc_20E14E:
	bsr.w	sub_20E236
	btst	#0,obj.flags(a0)
	beq.s	loc_20E16E
	cmpi.w	#$80,obj.x(a0)
	bcc.s	loc_20E16E
	clr.b	obj.anim_id(a0)
	clr.w	obj.x_speed(a0)
	bra.w	loc_20E1E0

; ------------------------------------------------------------------------------

loc_20E16E:
	cmpi.w	#$3C0,obj.x(a0)
	bcc.s	loc_20E1B4
	move.w	#$FFE0,d0
	btst	#0,obj.flags(a0)
	bne.s	loc_20E184
	neg.w	d0

loc_20E184:
	add.w	obj.x_speed(a0),d0
	move.w	d0,d1
	move.w	#$200,d2
	tst.w	d1
	bpl.s	loc_20E196
	neg.w	d1
	neg.w	d2

loc_20E196:
	cmpi.w	#$200,d1
	bcs.s	loc_20E19E
	move.w	d2,d0

loc_20E19E:
	move.w	d0,obj.x_speed(a0)
	bsr.w	sub_20E08C
	move.b	#1,obj.anim_id(a0)
	cmpi.w	#$3C0,obj.x(a0)
	bcs.s	loc_20E1E0

loc_20E1B4:
	clr.b	obj.anim_id(a0)
	tst.w	obj.var_34(a0)
	bne.s	loc_20E1E0
	jsr	SpawnObject
	bne.s	loc_20E1E0
	move.b	#$31,obj.id(a1)
	move.w	#$500,obj.x(a1)
	move.w	#$3E8,obj.y(a1)
	move.w	a0,obj.var_34(a1)
	move.w	a1,obj.var_34(a0)

loc_20E1E0:
	lea	AmyRoseAnims,a1
	bsr.w	sub_20E262
	bra.w	loc_20E306

; ------------------------------------------------------------------------------

AmyRoseObject_0_Routine4:
	movea.w	obj.var_34(a0),a1
	cmpi.b	#$31,obj.id(a1)
	bne.s	loc_20E230
	moveq	#8,d0
	bsr.w	sub_20E254
	btst	#0,obj.flags(a1)
	beq.s	loc_20E20E
	neg.w	d0
	bsr.w	sub_20E246

loc_20E20E:
	add.w	obj.x(a1),d0
	move.w	d0,obj.x(a0)
	move.w	obj.y(a1),d0
	addq.w	#4,d0
	move.w	d0,obj.y(a0)
	move.b	#2,obj.anim_id(a0)
	lea	AmyRoseAnims,a1
	bra.w	sub_20E262

; ------------------------------------------------------------------------------

loc_20E230:
	jmp	DeleteObject

; ------------------------------------------------------------------------------

sub_20E236:
	bsr.s	sub_20E246
	move.w	obj.x(a0),d0
	sub.w	obj.x(a1),d0
	bcs.s	locret_20E244
	bsr.s	sub_20E254

locret_20E244:
	rts

; ------------------------------------------------------------------------------

sub_20E246:
	bclr	#0,obj.flags(a0)
	bclr	#0,obj.sprite_flags(a0)
	rts

; ------------------------------------------------------------------------------

sub_20E254:
	bset	#0,obj.flags(a0)
	bset	#0,obj.sprite_flags(a0)
	rts

; ------------------------------------------------------------------------------

sub_20E262:
	moveq	#0,d0
	move.b	obj.anim_id(a0),d0
	cmp.b	obj.prev_anim_id(a0),d0
	beq.s	loc_20E27A
	move.b	d0,obj.prev_anim_id(a0)
	clr.b	obj.anim_index(a0)
	clr.b	obj.anim_timer(a0)

loc_20E27A:
	subq.b	#1,obj.anim_timer(a0)
	bpl.s	locret_20E2C2
	add.w	d0,d0
	adda.w	(a1,d0.w),a1

loc_20E286:
	move.b	obj.anim_index(a0),d0
	lea	(a1,d0.w),a2
	move.b	(a2),d0
	bpl.s	loc_20E298
	clr.b	obj.anim_index(a0)
	bra.s	loc_20E286

; ------------------------------------------------------------------------------

loc_20E298:
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

locret_20E2C2:
	rts

; ------------------------------------------------------------------------------

sub_20E2C4:
	lea	AmyRosePalette(pc),a3

; ------------------------------------------------------------------------------

sub_20E2C8:
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

sub_20E300:
	lea	player_object,a1
	rts

; ------------------------------------------------------------------------------

loc_20E306:
	addq.b	#8,obj.var_3b(a0)
	bcc.s	locret_20E33E
	jsr	SpawnObject
	bne.s	locret_20E33E
	move.b	#$33,obj.id(a1)
	moveq	#$C,d1
	btst	#0,obj.flags(a0)
	beq.s	loc_20E328
	move.w	#-$E,d1

loc_20E328:
	move.w	obj.x(a0),d0
	add.w	d1,d0
	move.w	d0,obj.x(a1)
	move.w	obj.y(a0),d0
	subi.w	#$C,d0
	move.w	d0,obj.y(a1)

locret_20E33E:
	rts

; ------------------------------------------------------------------------------

IntroSpikesObject:
	tst.b	time_attack
	bne.w	loc_20E56C
	moveq	#0,d0
	move.b	obj.routine(a0),d0
	move.w	off_20E35E(pc,d0.w),d0
	jsr	off_20E35E(pc,d0.w)
	jmp	DrawObject

; ------------------------------------------------------------------------------

off_20E35E:
	dc.w	IntroSpikesObject_0_Routine0-*
	dc.w	IntroSpikesObject_0_Routine2-off_20E35E
	dc.w	IntroSpikesObject_0_Routine4-off_20E35E

; ------------------------------------------------------------------------------

loc_20E364:
	cmpi.b	#1,obj.subtype(a0)
	beq.s	loc_20E376
	lea	player_object,a1
	jmp	SolidObject

; ------------------------------------------------------------------------------

loc_20E376:
	lea	player_object,a1
	jsr	SolidObject
	beq.s	locret_20E3CA
	btst	#3,obj.flags(a0)
	beq.s	locret_20E3CA
	tst.b	warping
	bne.s	locret_20E3CA
	tst.b	invincible
	bne.s	locret_20E3CA
	move.l	a0,-(sp)
	movea.l	a0,a2
	lea	player_object,a0
	cmpi.b	#4,obj.routine(a0)
	bcc.s	loc_20E3C8
	tst.w	obj.var_30(a0)
	bne.s	loc_20E3C8
	move.l	obj.y(a0),d3
	move.w	obj.y_speed(a0),d0
	ext.l	d0
	asl.l	#8,d0
	sub.l	d0,d3
	move.l	d3,obj.y(a0)
	jsr	HurtPlayer

loc_20E3C8:
	movea.l	(sp)+,a0

locret_20E3CA:
	rts

; ------------------------------------------------------------------------------

IntroSpikesObject_0_Routine0:
	tst.b	amy_captured
	bne.w	loc_20E56C
	addq.b	#2,obj.routine(a0)
	ori.b	#4,obj.sprite_flags(a0)
	move.w	#$31E,obj.sprite_tile(a0)
	move.b	#3,obj.sprite_layer(a0)
	move.l	#IntroSpikesSprites,obj.sprite_data(a0)
	move.b	#$12,obj.width_2(a0)
	move.b	#8,obj.height(a0)
	cmpi.b	#1,obj.subtype(a0)
	beq.s	loc_20E436
	move.b	#$20,obj.height(a0)
	cmpi.b	#0,obj.subtype(a0)
	beq.s	loc_20E436
	move.b	#9,obj.sprite_frame(a0)
	move.b	#$86,obj.collide_type(a0)
	move.b	#$C,obj.width_2(a0)
	cmpi.b	#2,obj.subtype(a0)
	beq.s	loc_20E436
	move.b	#$E,obj.sprite_frame(a0)

loc_20E436:
	tst.b	obj.var_3c(a0)
	beq.s	IntroSpikesObject_0_Routine2
	clr.b	obj.collide_type(a0)
	addq.b	#2,obj.routine(a0)
	bsr.w	sub_20E526
	bra.w	IntroSpikesObject_0_Routine4

; ------------------------------------------------------------------------------

IntroSpikesObject_0_Routine2:
	cmpi.b	#1,obj.subtype(a0)
	beq.w	loc_20E364
	lea	object_spawn_pool,a1
	move.w	#$5F,d0

loc_20E45E:
	cmpi.b	#$31,obj.id(a1)
	beq.s	loc_20E470
	lea	obj.struct_len(a1),a1
	dbf	d0,loc_20E45E
	bra.s	loc_20E4BC

; ------------------------------------------------------------------------------

loc_20E470:
	move.b	obj.width_2(a0),d1
	ext.w	d1
	addi.w	#$10,d1
	move.w	obj.x(a1),d0
	sub.w	obj.x(a0),d0
	add.w	d1,d0
	bmi.s	loc_20E4BC
	move.w	d1,d2
	add.w	d2,d2
	cmp.w	d2,d0
	bcc.s	loc_20E4BC
	move.b	obj.height(a0),d1
	ext.w	d1
	addi.w	#$10,d1
	move.w	obj.y(a1),d0
	sub.w	obj.y(a0),d0
	add.w	d1,d0
	bmi.s	loc_20E4BC
	move.w	d1,d2
	add.w	d2,d2
	cmp.w	d2,d0
	bcc.s	loc_20E4BC
	addq.b	#2,obj.routine(a0)
	bsr.s	sub_20E4C0
	lea	player_object,a1
	jmp	GetOffObject

; ------------------------------------------------------------------------------

loc_20E4BC:
	bra.w	loc_20E364

; ------------------------------------------------------------------------------

sub_20E4C0:
	moveq	#3,d1
	move.b	#4,obj.sprite_frame(a0)
	moveq	#0,d2
	cmpi.b	#0,obj.subtype(a0)
	beq.s	loc_20E4EA
	move.b	#8,obj.sprite_frame(a0)
	moveq	#4,d2
	cmpi.b	#2,obj.subtype(a0)
	beq.s	loc_20E4EA
	move.b	#$D,obj.sprite_frame(a0)
	moveq	#9,d2

loc_20E4EA:
	jsr	SpawnObject
	bne.s	loc_20E510
	move.b	#$30,obj.id(a1)
	move.w	obj.x(a0),obj.x(a1)
	move.w	obj.y(a0),obj.y(a1)
	move.b	d1,d3
	add.b	d2,d3
	move.b	d3,obj.sprite_frame(a1)
	move.b	d1,obj.var_3c(a1)

loc_20E510:
	subq.b	#1,d1
	bne.s	loc_20E4EA
	btst	#7,obj.sprite_flags(a0)
	beq.s	sub_20E526
	move.w	#$A3,d0
	jsr	PlayFmSound

; ------------------------------------------------------------------------------

sub_20E526:
	moveq	#0,d0
	move.b	obj.var_3c(a0),d0
	asl.l	#2,d0
	lea	word_20E548(pc,d0.w),a2
	move.w	(a2)+,obj.x_speed(a0)
	move.w	(a2)+,obj.y_speed(a0)
	move.w	#$60,obj.var_3e(a0)
	move.b	#$78,obj.var_3a(a0)
	rts

; ------------------------------------------------------------------------------

word_20E548:
	dc.w	$200, -$200
	dc.w	-$100, -$400
	dc.w	-$100, -$200
	dc.w	$200, -$400

; ------------------------------------------------------------------------------

IntroSpikesObject_0_Routine4:
	bsr.w	sub_20E07C
	move.w	obj.var_3e(a0),d0
	add.w	d0,obj.y_speed(a0)
	subq.b	#1,obj.var_3a(a0)
	beq.s	loc_20E56C
	rts

; ------------------------------------------------------------------------------

loc_20E56C:
	jmp	DeleteObject

; ------------------------------------------------------------------------------

HeartObject:
	moveq	#0,d0
	move.b	obj.routine(a0),d0
	move.w	off_20E58C(pc,d0.w),d0
	jsr	off_20E58C(pc,d0.w)
	jsr	DrawObject
	jmp	CheckObjectDespawn

; ------------------------------------------------------------------------------

off_20E58C:
	dc.w	HeartObject_0_Routine0-*
	dc.w	HeartObject_0_Routine2-off_20E58C

; ------------------------------------------------------------------------------

HeartObject_0_Routine0:
	addq.b	#2,obj.routine(a0)
	ori.b	#4,obj.sprite_flags(a0)
	move.w	#$35E,obj.sprite_tile(a0)
	move.l	#AmyRoseSprites,obj.sprite_data(a0)
	move.b	#3,obj.sprite_layer(a0)
	move.w	#-$60,obj.y_speed(a0)
	move.b	#$A,obj.sprite_frame(a0)

HeartObject_0_Routine2:
	tst.b	obj.var_3c(a0)
	bne.s	loc_20E5D8
	moveq	#0,d0
	move.b	obj.var_3a(a0),d0
	add.b	d0,d0
	add.b	obj.var_3a(a0),d0
	jsr	SineCosine
	asr.w	#2,d0
	move.w	d0,obj.x_speed(a0)

loc_20E5D8:
	bsr.w	sub_20E07C
	addq.b	#1,obj.var_3a(a0)
	move.b	obj.var_3a(a0),d0
	cmpi.b	#$14,d0
	bne.s	loc_20E5EE
	addq.b	#1,obj.sprite_frame(a0)

loc_20E5EE:
	cmpi.b	#$6E,d0
	bne.s	loc_20E604
	addq.b	#1,obj.sprite_frame(a0)
	clr.w	obj.y_speed(a0)
	clr.w	obj.x_speed(a0)
	st	obj.var_3c(a0)

loc_20E604:
	cmpi.b	#$78,d0
	bne.s	locret_20E610
	jmp	DeleteObject

; ------------------------------------------------------------------------------

locret_20E610:
	rts

; ------------------------------------------------------------------------------

MetalSonicExhaustObject:
	moveq	#0,d0
	move.b	obj.routine(a0),d0
	move.w	off_20E626(pc,d0.w),d0
	jsr	off_20E626(pc,d0.w)
	jmp	DrawObject

; ------------------------------------------------------------------------------

off_20E626:
	dc.w	MetalSonicExhaustObject_0_Routine0-*
	dc.w	MetalSonicExhaustObject_0_Routine2-off_20E626

; ------------------------------------------------------------------------------

MetalSonicExhaustObject_0_Routine0:
	addq.b	#2,obj.routine(a0)
	ori.b	#4,obj.sprite_flags(a0)
	move.w	#$3D0,obj.sprite_tile(a0)
	move.l	#MetalSonicSprites,obj.sprite_data(a0)
	move.b	#3,obj.sprite_layer(a0)

MetalSonicExhaustObject_0_Routine2:
	move.w	obj.var_34(a0),d0
	movea.w	d0,a1
	cmpi.b	#$31,obj.id(a1)
	bne.s	loc_20E680
	move.w	obj.x(a1),d0
	subi.w	#$10,d0
	btst	#0,obj.flags(a1)
	beq.s	loc_20E66A
	addi.w	#$20,d0

loc_20E66A:
	move.w	d0,obj.x(a0)
	move.w	obj.y(a1),d0
	move.w	d0,obj.y(a0)
	lea	MetalSonicExhaustAnims(pc),a1
	jmp	AnimateObject

; ------------------------------------------------------------------------------

loc_20E680:
	jmp	DeleteObject

; ------------------------------------------------------------------------------

MetalSonicExhaustAnims:
	include	"src/anims/r3/metal_sonic_exhaust.asm"
	even

; ------------------------------------------------------------------------------
