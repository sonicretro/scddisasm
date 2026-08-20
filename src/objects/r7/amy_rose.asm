; ------------------------------------------------------------------------------

AmyRoseObject:
	moveq	#0,d0
	move.b	obj.routine(a0),d0
	move.w	off_20EF32(pc,d0.w),d0
	jsr	off_20EF32(pc,d0.w)
	jsr	DrawObject
	jsr	CheckObjectDespawn
	cmpi.b	#$33,obj.id(a0)
	beq.s	locret_20EF30
	lea	StagePalette,a3
	bsr.w	sub_20F3E4

locret_20EF30:
	rts

; ------------------------------------------------------------------------------

off_20EF32:
	dc.w	AmyRoseObject_0_Routine0-*
	dc.w	AmyRoseObject_0_Routine2-off_20EF32
	dc.w	AmyRoseObject_0_Routine4-off_20EF32
	dc.w	AmyRoseObject_0_Routine4-off_20EF32
	dc.w	AmyRoseObject_0_Routine8-off_20EF32
	dc.w	AmyRoseObject_0_RoutineA-off_20EF32
	dc.w	AmyRoseObject_0_RoutineC-off_20EF32
	dc.w	AmyRoseObject_0_RoutineE-off_20EF32
	dc.w	AmyRoseObject_0_Routine8-off_20EF32

; ------------------------------------------------------------------------------

AmyRoseObject_0_Routine0:
	ori.b	#4,obj.sprite_flags(a0)
	move.w	#$A3CB,obj.sprite_tile(a0)
	move.b	#1,obj.sprite_layer(a0)
	move.l	#AmyRoseSprites,obj.sprite_data(a0)
	move.b	#$C,obj.width_2(a0)
	move.b	#$10,obj.height(a0)
	move.w	obj.x(a0),obj.var_36(a0)
	move.b	#$F5,obj.collide_type(a0)
	tst.b	good_future
	bne.s	loc_20EF8A
	move.w	#$3F43,obj.x(a0)
	move.w	#$1AB,obj.y(a0)

loc_20EF8A:
	lea	player_object,a1
	move.w	obj.x(a1),d0
	sub.w	obj.x(a0),d0
	bcc.s	loc_20EF9A
	neg.w	d0

loc_20EF9A:
	move.b	#6,obj.anim_id(a0)
	tst.b	obj.collide_status(a0)
	beq.s	loc_20EFE4
	jsr	SpawnObject
	bne.s	loc_20EFD0
	move.b	#$18,obj.id(a1)
	move.b	#1,obj.routine_2(a1)
	move.w	obj.x(a0),obj.x(a1)
	move.w	obj.y(a0),obj.y(a1)
	move.w	#$9E,d0
	jsr	PlayFmSound

loc_20EFD0:
	lea	player_object,a1
	neg.w	obj.y_speed(a1)
	addq.b	#2,obj.routine(a0)
	move.w	#$258,obj.var_30(a0)
	rts

; ------------------------------------------------------------------------------

loc_20EFE4:
	lea	AmyRoseAnims,a1
	bra.w	loc_20F308

; ------------------------------------------------------------------------------

AmyRoseObject_0_Routine2:
	tst.b	obj.var_3c(a0)
	bmi.s	loc_20F01A
	addi.w	#$10,obj.y_speed(a0)
	bsr.w	loc_20F2EC
	move.w	obj.y(a0),d0
	cmpi.w	#$1D0,d0
	bcs.s	locret_20F018
	move.w	#$1D0,obj.y(a0)
	clr.w	obj.y_speed(a0)
	move.b	#$FF,obj.var_3c(a0)

locret_20F018:
	rts

; ------------------------------------------------------------------------------

loc_20F01A:
	lea	player_object,a1
	bsr.w	sub_20F3B4
	move.b	#$3C,obj.var_3f(a0)
	addq.b	#2,obj.routine(a0)
	lea	AmyRoseAnims,a1
	bra.w	loc_20F308

; ------------------------------------------------------------------------------

AmyRoseObject_0_Routine4:
	bsr.w	sub_20F36A
	lea	player_object,a1
	bsr.w	sub_20F3B4
	tst.w	obj.var_30(a0)
	beq.s	loc_20F050
	subq.w	#1,obj.var_30(a0)
	beq.w	loc_20F138

loc_20F050:
	tst.b	obj.var_3f(a0)
	beq.s	loc_20F05C
	subq.b	#1,obj.var_3f(a0)
	bne.s	loc_20F0A8

loc_20F05C:
	bsr.w	loc_20F24E
	btst	#2,obj.var_3e(a0)
	bne.w	loc_20F090
	tst.w	obj.x_speed(a1)
	bne.s	loc_20F0A8
	move.w	obj.x(a1),d0
	sub.w	obj.x(a0),d0
	bcc.s	loc_20F07C
	neg.w	d0

loc_20F07C:
	cmpi.w	#$A,d0
	bcc.s	loc_20F0A8

loc_20F082:
	bset	#2,obj.var_3e(a0)
	clr.w	obj.x_speed(a0)
	bra.w	loc_20F128

; ------------------------------------------------------------------------------

loc_20F090:
	move.w	obj.x(a1),d0
	sub.w	obj.x(a0),d0
	bcc.s	loc_20F09C
	neg.w	d0

loc_20F09C:
	cmpi.w	#$20,d0
	bcs.s	loc_20F082
	bclr	#2,obj.var_3e(a0)

loc_20F0A8:
	move.w	#$FFE0,d0
	btst	#0,obj.flags(a0)
	bne.s	loc_20F0B6
	neg.w	d0

loc_20F0B6:
	add.w	obj.x_speed(a0),d0
	move.w	d0,d1
	move.w	#$280,d2
	tst.w	d1
	bpl.s	loc_20F0C8
	neg.w	d1
	neg.w	d2

loc_20F0C8:
	cmpi.w	#$280,d1
	bcs.s	loc_20F0D0
	move.w	d2,d0

loc_20F0D0:
	move.w	d0,obj.x_speed(a0)
	tst.w	obj.x_speed(a0)
	bpl.s	loc_20F0FA
	move.w	#$60,d1
	tst.b	good_future
	bne.s	loc_20F0EA
	move.w	#$80,d1

loc_20F0EA:
	move.w	obj.var_36(a0),d0
	sub.w	d1,d0
	cmp.w	obj.x(a0),d0
	bcs.s	loc_20F0FA
	bra.w	loc_20F124

; ------------------------------------------------------------------------------

loc_20F0FA:
	jsr	CheckBlockDown
	cmpi.w	#7,d1
	bpl.s	loc_20F110
	cmpi.w	#-7,d1
	bmi.s	loc_20F110
	add.w	d1,obj.y(a0)

loc_20F110:
	bsr.w	loc_20F2FA
	move.b	#2,obj.anim_id(a0)
	lea	AmyRoseAnims,a1
	bra.w	loc_20F308

; ------------------------------------------------------------------------------

loc_20F124:
	clr.w	obj.x_speed(a0)

loc_20F128:
	move.b	#1,obj.anim_id(a0)
	lea	AmyRoseAnims,a1
	bra.w	loc_20F308

; ------------------------------------------------------------------------------

loc_20F138:
	move.b	#$FF,obj.var_38(a0)
	clr.b	update_hud_time
	move.b	#1,obj.var_2a(a0)
	jmp	StartResults

; ------------------------------------------------------------------------------

AmyRoseObject_0_RoutineE:
	move.b	#6,obj.sprite_frame(a0)
	move.w	#$80,d0
	btst	#0,obj.flags(a0)
	bne.s	loc_20F164
	neg.w	d0

loc_20F164:
	move.w	d0,obj.x_speed(a0)
	move.w	obj.x(a0),d0
	sub.w	obj.var_36(a0),d0
	bcc.s	loc_20F174
	neg.w	d0

loc_20F174:
	cmpi.w	#$80,d0
	bcs.s	loc_20F17E
	clr.w	obj.x_speed(a0)

loc_20F17E:
	move.w	#-$300,obj.y_speed(a0)
	addq.b	#2,obj.routine(a0)

AmyRoseObject_0_Routine8:
	bsr.w	loc_20F2EA
	addi.w	#$40,obj.y_speed(a0)
	tst.w	obj.y_speed(a0)
	bmi.s	loc_20F19E
	move.b	#7,obj.sprite_frame(a0)

loc_20F19E:
	move.w	obj.y(a0),d0
	cmpi.w	#$1D0,d0
	bcs.s	locret_20F1C4
	move.w	#$1D0,obj.y(a0)
	clr.w	obj.x_speed(a0)
	clr.w	obj.y_speed(a0)
	addi.b	#$10,obj.var_3a(a0)
	bcc.s	locret_20F1C4
	move.b	#4,obj.routine(a0)

locret_20F1C4:
	rts

; ------------------------------------------------------------------------------

AmyRoseObject_0_RoutineA:
	bsr.w	sub_20F36A
	lea	player_object,a1
	bset	#0,control_locked
	move.w	#0,player_joy_hold
	move.b	#5,obj.anim_id(a1)
	bsr.w	sub_20F3B4
	moveq	#$C,d0
	btst	#0,obj.flags(a1)
	bne.s	loc_20F1F0
	neg.w	d0

loc_20F1F0:
	add.w	obj.x(a1),d0
	move.w	d0,obj.x(a0)
	move.w	obj.y(a1),obj.y(a0)
	move.b	#$E,obj.sprite_frame(a0)
	tst.b	obj.var_38(a0)
	bne.s	locret_20F21C
	clr.b	update_hud_time
	move.b	#1,obj.var_2a(a0)
	jmp	StartResults

; ------------------------------------------------------------------------------

locret_20F21C:
	rts

; ------------------------------------------------------------------------------

AmyRoseObject_0_RoutineC:
	bsr.w	sub_20F36A
	lea	player_object,a1
	bsr.w	sub_20F3B4
	moveq	#$C,d0
	btst	#0,obj.flags(a1)
	bne.s	loc_20F236
	neg.w	d0

loc_20F236:
	add.w	obj.x(a1),d0
	nop
	nop
	nop
	nop
	move.w	d0,obj.x(a0)
	move.b	#$E,obj.sprite_frame(a0)
	rts

; ------------------------------------------------------------------------------

loc_20F24E:
	lea	player_object,a1
	tst.b	debug_mode
	bne.w	locret_20F2E0
	btst	#0,obj.flags(a1)
	bne.s	loc_20F26E
	move.w	obj.x(a1),d0
	sub.w	obj.x(a0),d0
	bra.s	loc_20F276

; ------------------------------------------------------------------------------

loc_20F26E:
	move.w	obj.x(a0),d0
	sub.w	obj.x(a1),d0

loc_20F276:
	bcs.w	locret_20F2E0
	cmpi.w	#8,d0
	bcs.w	locret_20F2E0
	cmpi.w	#$1C,d0
	bcc.s	locret_20F2E0
	moveq	#8,d1
	move.w	obj.y(a1),d0
	sub.w	obj.y(a0),d0
	add.w	d1,d0
	bmi.s	locret_20F2E0
	move.w	d1,d2
	add.w	d2,d2
	cmp.w	d2,d0
	bcc.s	locret_20F2E0
	move.w	obj.x_speed(a1),d0
	bpl.s	loc_20F2A6
	neg.w	d0

loc_20F2A6:
	btst	#1,obj.flags(a1)
	bne.s	loc_20F2E2
	btst	#2,obj.flags(a1)
	bne.s	loc_20F2E2
	bclr	#2,obj.flags(a1)
	ori.b	#$81,obj.var_3e(a0)
	clr.w	obj.y_speed(a0)
	clr.w	obj.x_speed(a0)
	move.b	#7,obj.sprite_frame(a0)
	move.b	#$A,obj.routine(a0)
	move.w	#$7C,d0
	jsr	SubCpuCommand

locret_20F2E0:
	rts

; ------------------------------------------------------------------------------

loc_20F2E2:
	move.b	#$E,obj.routine(a0)
	rts

; ------------------------------------------------------------------------------

loc_20F2EA:
	bsr.s	loc_20F2FA

loc_20F2EC:
	move.w	obj.y_speed(a0),d0
	ext.l	d0
	asl.l	#8,d0
	add.l	d0,obj.y(a0)
	rts

; ------------------------------------------------------------------------------

loc_20F2FA:
	move.w	obj.x_speed(a0),d0
	ext.l	d0
	asl.l	#8,d0
	add.l	d0,obj.x(a0)
	rts

; ------------------------------------------------------------------------------

loc_20F308:
	moveq	#0,d0
	move.b	obj.anim_id(a0),d0
	cmp.b	obj.prev_anim_id(a0),d0
	beq.s	loc_20F320
	move.b	d0,obj.prev_anim_id(a0)
	clr.b	obj.anim_index(a0)
	clr.b	obj.anim_timer(a0)

loc_20F320:
	subq.b	#1,obj.anim_timer(a0)
	bpl.s	locret_20F368
	add.w	d0,d0
	adda.w	(a1,d0.w),a1

loc_20F32C:
	move.b	obj.anim_index(a0),d0
	lea	(a1,d0.w),a2
	move.b	(a2),d0
	bpl.s	loc_20F33E
	clr.b	obj.anim_index(a0)
	bra.s	loc_20F32C

; ------------------------------------------------------------------------------

loc_20F33E:
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

locret_20F368:
	rts

; ------------------------------------------------------------------------------

sub_20F36A:
	addq.b	#6,obj.var_3b(a0)
	bcc.s	locret_20F3AC
	jsr	SpawnObject
	bne.s	locret_20F3AC
	move.b	#$34,obj.id(a1)
	moveq	#8,d1
	btst	#0,obj.flags(a0)
	beq.s	loc_20F38C
	move.w	#-$A,d1

loc_20F38C:
	btst	#0,obj.var_3e(a0)
	beq.s	loc_20F396
	neg.w	d1

loc_20F396:
	move.w	obj.x(a0),d0
	add.w	d1,d0
	move.w	d0,obj.x(a1)
	move.w	obj.y(a0),d0
	subi.w	#$C,d0
	move.w	d0,obj.y(a1)

locret_20F3AC:
	rts

; ------------------------------------------------------------------------------

	lea	player_object,a1
	rts

; ------------------------------------------------------------------------------

sub_20F3B4:
	bsr.s	sub_20F3C4
	move.w	obj.x(a0),d0
	sub.w	obj.x(a1),d0
	bcs.s	locret_20F3C2
	bsr.s	sub_20F3D2

locret_20F3C2:
	rts

; ------------------------------------------------------------------------------

sub_20F3C4:
	bclr	#0,obj.flags(a0)
	bclr	#0,obj.sprite_flags(a0)
	rts

; ------------------------------------------------------------------------------

sub_20F3D2:
	bset	#0,obj.flags(a0)
	bset	#0,obj.sprite_flags(a0)
	rts

; ------------------------------------------------------------------------------

	lea	AmyRosePalette2(pc),a3

; ------------------------------------------------------------------------------

sub_20F3E4:
	lea	palette+$20,a4
	movem.l	(a3)+,d0-d3
	movem.l	d0-d3,(a4)
	movem.l	(a3)+,d0-d3
	movem.l	d0-d3,$10(a4)
	rts

; ------------------------------------------------------------------------------

AmyRosePalette2:
	incbin	"src/palettes/amy_rose.pal"
	even

; ------------------------------------------------------------------------------

HeartObject:
	moveq	#0,d0
	move.b	obj.routine(a0),d0
	move.w	off_20F436(pc,d0.w),d0
	jsr	off_20F436(pc,d0.w)
	jsr	DrawObject
	jmp	CheckObjectDespawn

; ------------------------------------------------------------------------------

off_20F436:
	dc.w	HeartObject_0_Routine0-*
	dc.w	HeartObject_0_Routine2-off_20F436

; ------------------------------------------------------------------------------

HeartObject_0_Routine0:
	addq.b	#2,obj.routine(a0)
	ori.b	#4,obj.sprite_flags(a0)
	move.w	#$3CB,obj.sprite_tile(a0)
	move.l	#AmyRoseSprites,obj.sprite_data(a0)
	move.b	#8,obj.sprite_frame(a0)
	move.w	#$FFA0,obj.y_speed(a0)
	move.b	#3,obj.sprite_layer(a0)

HeartObject_0_Routine2:
	tst.b	obj.var_3c(a0)
	bne.s	loc_20F482
	moveq	#0,d0
	move.b	obj.var_3a(a0),d0
	add.b	d0,d0
	add.b	obj.var_3a(a0),d0
	jsr	SineCosine
	asr.w	#2,d0
	move.w	d0,obj.x_speed(a0)

loc_20F482:
	bsr.w	loc_20F2EA
	addq.b	#1,obj.var_3a(a0)
	move.b	obj.var_3a(a0),d0
	cmpi.b	#$14,d0
	bne.s	loc_20F498
	addq.b	#1,obj.sprite_frame(a0)

loc_20F498:
	cmpi.b	#$6E,d0
	bne.s	loc_20F4AE
	addq.b	#1,obj.sprite_frame(a0)
	clr.w	obj.y_speed(a0)
	clr.w	obj.x_speed(a0)
	st	obj.var_3c(a0)

loc_20F4AE:
	cmpi.b	#$78,d0
	bne.s	locret_20F4BA
	jmp	DeleteObject

; ------------------------------------------------------------------------------

locret_20F4BA:
	rts

; ------------------------------------------------------------------------------
