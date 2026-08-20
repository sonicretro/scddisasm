; ------------------------------------------------------------------------------

CapsuleObject:
	moveq	#0,d0
	move.b	obj.routine(a0),d0
	move.w	off_209CDC(pc,d0.w),d0
	jsr	off_209CDC(pc,d0.w)
	tst.b	obj.routine(a0)
	beq.s	locret_209CDA
	cmpi.b	#$A,obj.routine(a0)
	beq.s	loc_209CD4
	cmpi.b	#6,obj.routine(a0)
	bcc.s	locret_209CDA

loc_209CD4:
	jmp	DrawObject

; ------------------------------------------------------------------------------

locret_209CDA:
	rts

; ------------------------------------------------------------------------------

off_209CDC:
	dc.w	CapsuleInit-*
	dc.w	CapsuleMain-off_209CDC
	dc.w	CapsuleExplode-off_209CDC
	dc.w	StartResults-off_209CDC
	dc.w	ResultsActive-off_209CDC
	dc.w	CapsuleSeed-off_209CDC

; ------------------------------------------------------------------------------

CapsuleInit:
	ori.b	#4,obj.sprite_flags(a0)
	addq.b	#2,obj.routine(a0)
	move.b	#4,obj.sprite_layer(a0)
	move.l	#CapsuleSprites,obj.sprite_data(a0)
	move.w	#$2481,obj.sprite_tile(a0)
	move.b	#$20,obj.width(a0)
	move.b	#$20,obj.width_2(a0)
	move.b	#$18,obj.height(a0)

CapsuleMain:
	lea	CapsuleAnims,a1
	jsr	AnimateObject
	lea	player_object,a6
	bsr.w	sub_209EA2
	beq.s	locret_209D7A
	clr.b	update_hud_time
	move.b	#2,obj.sprite_frame(a0)
	move.b	#$78,obj.var_2a(a0)
	addq.b	#2,obj.routine(a0)
	move.w	player_object+obj.x,d0
	move.b	player_object+obj.width,d1
	ext.w	d1
	addi.w	#$20,d1
	sub.w	obj.x(a0),d0
	add.w	d1,d0
	bmi.s	loc_209D6E
	add.w	d1,d1
	cmp.w	d1,d0
	bcc.s	loc_209D6E
	move.w	player_object+obj.y_speed,d0
	neg.w	d0
	asr.w	#2,d0
	move.w	d0,player_object+obj.y_speed
	rts

; ------------------------------------------------------------------------------

loc_209D6E:
	move.w	player_object+obj.x_speed,d0
	neg.w	d0
	asr.w	#2,d0
	move.w	d0,player_object+obj.x_speed

locret_209D7A:
	rts

; ------------------------------------------------------------------------------

CapsuleExplode:
	subq.b	#1,obj.var_2a(a0)
	bmi.s	loc_209DD8
	move.b	obj.var_2a(a0),d0
	move.b	d0,d1
	andi.b	#3,d1
	bne.s	locret_209DE6
	lsr.w	#2,d0
	andi.w	#7,d0
	add.w	d0,d0
	lea	byte_209DE8(pc,d0.w),a2
	jsr	SpawnObject
	bne.s	locret_209DE6
	move.w	#$9E,d0
	jsr	PlayFmSound
	move.b	#$18,obj.id(a1)
	move.b	#1,obj.routine_2(a1)
	move.w	obj.x(a0),obj.x(a1)
	move.w	obj.y(a0),obj.y(a1)
	move.b	(a2),d0
	ext.w	d0
	add.w	d0,obj.x(a1)
	move.b	1(a2),d0
	ext.w	d0
	add.w	d0,obj.y(a1)
	rts

; ------------------------------------------------------------------------------

loc_209DD8:
	bsr.w	sub_209DF8
	addq.b	#2,obj.routine(a0)
	move.b	#$3C,obj.var_2a(a0)

locret_209DE6:
	rts

; ------------------------------------------------------------------------------

byte_209DE8:
	dc.b	0, 0
	dc.b	$20, -8
	dc.b	-$20, 0
	dc.b	-$18, -8
	dc.b	$18, 8
	dc.b	-$10, 8
	dc.b	$10, 8
	dc.b	-8, -8

; ------------------------------------------------------------------------------

sub_209DF8:
	moveq	#0,d0
	move.b	StageDataIndex+$E,d0
	move.l	d7,d6
	jsr	LoadPalette
	move.l	d6,d7
	moveq	#6,d6
	moveq	#0,d1

loc_209E0E:
	jsr	SpawnObject
	bne.s	locret_209E5A
	move.b	#$15,obj.id(a1)
	ori.b	#4,obj.sprite_flags(a1)
	move.w	obj.x(a0),obj.x(a1)
	move.w	obj.y(a0),obj.y(a1)
	move.b	#$A,obj.routine(a1)
	move.l	#CapsuleSprites,obj.sprite_data(a1)
	move.w	#$2481,obj.sprite_tile(a1)
	move.b	#1,obj.anim_id(a1)
	move.w	#$FA00,obj.y_speed(a1)
	move.w	word_209E5C(pc,d1.w),obj.x_speed(a1)
	addq.w	#2,d1
	dbf	d6,loc_209E0E

locret_209E5A:
	rts

; ------------------------------------------------------------------------------

word_209E5C:
	dc.w	0
	dc.w	-$80
	dc.w	$80
	dc.w	-$100
	dc.w	$100
	dc.w	-$180
	dc.w	$180
	dc.w	-$200
	dc.w	$200
	dc.w	-$280
	dc.w	$280

; ------------------------------------------------------------------------------

CapsuleSeed:
	lea	CapsuleAnims,a1
	jsr	AnimateObject
	jsr	MoveObjectFall
	jsr	CheckBlockDown
	tst.w	d1
	bpl.s	locret_209EA0
	move.b	#$1F,obj.id(a0)
	move.b	#1,obj.subtype(a0)
	move.b	#0,obj.routine(a0)

locret_209EA0:
	rts

; ------------------------------------------------------------------------------

sub_209EA2:
	btst	#2,obj.flags(a6)
	beq.s	loc_209EE6
	move.b	obj.width(a6),d1
	ext.w	d1
	addi.w	#$20,d1
	move.w	obj.x(a6),d0
	sub.w	obj.x(a0),d0
	add.w	d1,d0
	bmi.s	loc_209EE6
	add.w	d1,d1
	cmp.w	d1,d0
	bcc.s	loc_209EE6
	move.b	obj.height(a6),d1
	ext.w	d1
	addi.w	#$1C,d1
	move.w	obj.y(a6),d0
	sub.w	obj.y(a0),d0
	add.w	d1,d0
	bmi.s	loc_209EE6
	add.w	d1,d1
	cmp.w	d1,d0
	bcc.s	loc_209EE6
	moveq	#1,d0
	rts

; ------------------------------------------------------------------------------

loc_209EE6:
	moveq	#0,d0
	rts

; ------------------------------------------------------------------------------

BigRingFlashObject:
	moveq	#0,d0
	move.b	obj.routine(a0),d0
	move.w	off_209EFE(pc,d0.w),d0
	jsr	off_209EFE(pc,d0.w)
	jmp	DrawObject

; ------------------------------------------------------------------------------

off_209EFE:
	dc.w	BigRingFlashInit-*
	dc.w	BigRingFlashAnimate-off_209EFE
	dc.w	BigRingFlashDelete-off_209EFE

; ------------------------------------------------------------------------------

BigRingFlashInit:
	ori.b	#4,obj.sprite_flags(a0)
	addq.b	#2,obj.routine(a0)
	move.w	#$3EF,obj.sprite_tile(a0)
	move.l	#BigRingFlashSprites,obj.sprite_data(a0)

BigRingFlashAnimate:
	lea	BigRingFlashAnims,a1
	jmp	AnimateObject

; ------------------------------------------------------------------------------

BigRingFlashDelete:
	jmp	DeleteObject

; ------------------------------------------------------------------------------

BigRingObject:
	tst.b	obj.subtype(a0)
	bne.s	BigRingFlashObject
	cmpi.w	#50,rings
	bcc.s	loc_209F44
	jmp	CheckObjectDespawn

; ------------------------------------------------------------------------------

loc_209F44:
	moveq	#0,d0
	move.b	obj.routine(a0),d0
	move.w	off_209F62(pc,d0.w),d0
	jsr	off_209F62(pc,d0.w)
	cmpi.b	#4,obj.routine(a0)
	beq.s	locret_209F60
	jmp	DrawObject

; ------------------------------------------------------------------------------

locret_209F60:
	rts

; ------------------------------------------------------------------------------

off_209F62:
	dc.w	BigRingInit-*
	dc.w	BigRingMain-off_209F62
	dc.w	BigRingAnimate-off_209F62

; ------------------------------------------------------------------------------

BigRingInit:
	cmpi.b	#$7F,game_time_stones
	bne.s	loc_209F78
	jmp	DeleteObject

; ------------------------------------------------------------------------------

loc_209F78:
	tst.b	time_attack
	beq.s	loc_209F86
	jmp	DeleteObject

; ------------------------------------------------------------------------------

loc_209F86:
	addq.b	#2,obj.routine(a0)
	ori.b	#4,obj.sprite_flags(a0)
	move.w	#$2488,obj.sprite_tile(a0)
	move.l	#BigRingSprites,obj.sprite_data(a0)
	move.b	#$20,obj.width(a0)
	move.b	#$20,obj.width_2(a0)
	move.b	#$20,obj.height(a0)

BigRingMain:
	lea	player_object,a1
	bsr.w	sub_20A026
	beq.s	BigRingAnimate
	move.b	#1,enter_special_stage
	addq.b	#2,obj.routine(a0)
	move.w	scroll_fg_x,d0
	addi.w	#$150,d0
	move.w	d0,obj.x(a1)
	bset	#0,control_locked
	move.w	#$808,player_joy_hold
	move.w	#0,obj.x_speed(a1)
	move.w	#0,obj.ground_speed(a1)
	move.b	#1,scroll_lock
	move.w	#$AF,d0
	jsr	PlayFmSound
	jsr	SpawnObject
	bne.s	BigRingMain
	move.b	#$14,obj.id(a1)
	move.w	obj.x(a0),obj.x(a1)
	move.w	obj.y(a0),obj.y(a1)
	move.b	#1,obj.subtype(a1)

BigRingAnimate:
	lea	BigRingAnims,a1
	jmp	AnimateObject

; ------------------------------------------------------------------------------

sub_20A026:
	move.b	obj.width(a1),d1
	ext.w	d1
	addi.w	#$10,d1
	move.w	obj.x(a1),d0
	sub.w	obj.x(a0),d0
	add.w	d1,d0
	bmi.s	loc_20A062
	add.w	d1,d1
	cmp.w	d1,d0
	bcc.s	loc_20A062
	move.b	obj.height(a1),d1
	ext.w	d1
	addi.w	#$20,d1
	move.w	obj.y(a1),d0
	sub.w	obj.y(a0),d0
	add.w	d1,d0
	bmi.s	loc_20A062
	add.w	d1,d1
	cmp.w	d1,d0
	bcc.s	loc_20A062
	moveq	#1,d0
	rts

; ------------------------------------------------------------------------------

loc_20A062:
	moveq	#0,d0
	rts

; ------------------------------------------------------------------------------

GoalObject:
	lea	player_object,a6
	moveq	#0,d0
	move.b	obj.routine(a0),d0
	move.w	off_20A08E(pc,d0.w),d0
	jsr	off_20A08E(pc,d0.w)
	cmpi.b	#2,act
	beq.s	loc_20A088
	jsr	DrawObject

loc_20A088:
	jmp	CheckObjectDespawn

; ------------------------------------------------------------------------------

off_20A08E:
	dc.w	GoalInit-*
	dc.w	GoalMain-off_20A08E
	dc.w	GoalDone-off_20A08E

; ------------------------------------------------------------------------------

GoalInit:
	cmpi.w	#$201,zone
	bne.s	loc_20A0C4
	cmpi.b	#1,time_zone
	bne.s	loc_20A0C4
	tst.b	obj.subtype(a0)
	bne.s	loc_20A0BC
	move.b	#1,obj.subtype(a0)
	moveq	#$13,d0
	jmp	AddGfxQueue

; ------------------------------------------------------------------------------

loc_20A0BC:
	tst.l	gfx_queue
	beq.s	loc_20A0C4
	rts

; ------------------------------------------------------------------------------

loc_20A0C4:
	addq.b	#2,obj.routine(a0)
	ori.b	#4,obj.sprite_flags(a0)
	move.b	#4,obj.sprite_layer(a0)
	move.l	#SignpostSprites,obj.sprite_data(a0)
	move.b	#$10,obj.width(a0)
	move.b	#$10,obj.width_2(a0)
	move.b	#$20,obj.height(a0)
	move.b	#5,obj.sprite_frame(a0)
	bsr.w	sub_20A140

GoalMain:
	move.w	obj.y(a6),d0
	sub.w	obj.y(a0),d0
	addi.w	#$80,d0
	bmi.s	locret_20A13C
	cmpi.w	#$100,d0
	bcc.s	locret_20A13C
	move.w	obj.x(a6),d0
	cmp.w	obj.x(a0),d0
	bcs.s	locret_20A13C
	addq.b	#2,obj.routine(a0)
	move.w	scroll_fg_x,left_bound
	move.w	scroll_fg_x,target_left_bound
	clr.w	warp_timer
	clr.b	warp_direction
	clr.b	warping
	moveq	#$12,d0
	jmp	AddGfxQueue

; ------------------------------------------------------------------------------

locret_20A13C:
	rts

; ------------------------------------------------------------------------------

GoalDone:
	rts

; ------------------------------------------------------------------------------

sub_20A140:
	moveq	#0,d0
	move.w	zone,d0
	lsl.b	#7,d0
	lsr.w	#4,d0
	move.b	time_zone,d1
	cmpi.b	#2,d1
	bne.s	loc_20A15E
	add.b	good_future,d1

loc_20A15E:
	add.b	d1,d1
	add.b	d1,d0
	move.w	word_20A17A(pc,d0.w),obj.sprite_tile(a0)
	cmpi.b	#3,zone
	beq.s	locret_20A178
	ori.w	#$8000,obj.sprite_tile(a0)

locret_20A178:
	rts

; ------------------------------------------------------------------------------

word_20A17A:
	dc.w	$35A, $4F7, $4F7, $4F7
	dc.w	$381, $4F7, $4F7, $4F7
	dc.w	$300, $300, $300, $300
	dc.w	$300, $300, $300, $300
	dc.w	$4F2, $4F2, $4F2, $4F2
	dc.w	$4F2, $4F2, $4F2, $4F2
	dc.w	$2BA, $2CC, $2B3, $2B1
	dc.w	$2BA, $2CC, $2B3, $2B1
	dc.w	$254, $22C, $294, $238
	dc.w	$278, $28A, $2BC, $298
	dc.w	$3AE, $3AE, $3AE, $3AE
	dc.w	$3AE, $3AE, $3AE, $3AE
	dc.w	$220, $221, $24C, $236
	dc.w	$23E, $24A, $25D, $246

; ------------------------------------------------------------------------------

SignpostObject:
	moveq	#0,d0
	move.b	obj.routine(a0),d0
	move.w	off_20A1FE(pc,d0.w),d0
	jsr	off_20A1FE(pc,d0.w)
	jmp	DrawObject

; ------------------------------------------------------------------------------

off_20A1FE:
	dc.w	SignpostInit-*
	dc.w	SignpostMain-off_20A1FE
	dc.w	SignpostSpin-off_20A1FE
	dc.w	StartResults-off_20A1FE
	dc.w	ResultsActive-off_20A1FE

; ------------------------------------------------------------------------------

SignpostInit:
	addq.b	#2,obj.routine(a0)
	ori.b	#4,obj.sprite_flags(a0)
	move.b	#$18,obj.width(a0)
	move.b	#$18,obj.width_2(a0)
	move.b	#$20,obj.height(a0)
	move.b	#4,obj.sprite_layer(a0)
	move.w	#$43C,obj.sprite_tile(a0)
	cmpi.b	#3,zone
	beq.s	loc_20A240
	ori.b	#$80,obj.sprite_tile(a0)

loc_20A240:
	move.l	#SignpostSprites,obj.sprite_data(a0)

SignpostMain:
	lea	player_object,a6
	move.w	obj.y(a6),d0
	sub.w	obj.y(a0),d0
	addi.w	#$80,d0
	bmi.s	locret_20A2A2
	cmpi.w	#$100,d0
	bcc.s	locret_20A2A2
	move.w	obj.x(a0),d0
	cmp.w	obj.x(a6),d0
	bcc.s	locret_20A2A2
	move.w	scroll_fg_x,left_bound
	move.w	scroll_fg_x,target_left_bound
	clr.b	update_hud_time
	move.b	#120,obj.var_2a(a0)
	move.b	#0,obj.sprite_frame(a0)
	addq.b	#2,obj.routine(a0)
	clr.b	speed_shoes
	clr.b	invincible
	move.w	#$9D,d0
	jmp	PlayFmSound

; ------------------------------------------------------------------------------

locret_20A2A2:
	rts

; ------------------------------------------------------------------------------

SignpostSpin:
	lea	SignpostAnims,a1
	jsr	AnimateObject
	subq.b	#1,obj.var_2a(a0)
	bne.s	locret_20A2C6
	addq.b	#2,obj.routine(a0)
	move.b	#3,obj.sprite_frame(a0)
	move.b	#60,obj.var_2a(a0)

locret_20A2C6:
	rts

; ------------------------------------------------------------------------------

StartResults:
	subq.b	#1,obj.var_2a(a0)
	bne.w	locret_20A362
	tst.b	time_zone
	bne.s	loc_20A2E2
	move.w	#$82,d0
	jsr	SubCpuCommand

loc_20A2E2:
	move.w	#$6B,d0
	jsr	SubCpuCommand
	bset	#0,control_locked
	move.w	#$808,player_joy_hold
	cmpi.w	#$502,zone
	bne.s	loc_20A308
	move.w	#0,player_joy_hold

loc_20A308:
	move.b	#$B4,obj.var_2a(a0)
	addq.b	#2,obj.routine(a0)
	jsr	SpawnObject
	move.b	#$3A,obj.id(a1)
	move.b	#$10,obj.var_32(a1)
	move.b	#1,update_hud_bonus
	moveq	#0,d0
	move.b	time_minutes,d0
	mulu.w	#$3C,d0
	moveq	#0,d1
	move.b	time_seconds,d1
	add.w	d1,d0
	divu.w	#$F,d0
	moveq	#$14,d1
	cmp.w	d1,d0
	bcs.s	loc_20A34C
	move.w	d1,d0

loc_20A34C:
	add.w	d0,d0
	move.w	word_20A364(pc,d0.w),time_bonus
	move.w	rings,d0
	mulu.w	#$64,d0
	move.w	d0,ring_bonus

locret_20A362:
	rts

; ------------------------------------------------------------------------------

word_20A364:
	dc.w	50000
	dc.w	50000
	dc.w	10000
	dc.w	5000
	dc.w	4000
	dc.w	4000
	dc.w	3000
	dc.w	3000
	dc.w	2000
	dc.w	2000
	dc.w	2000
	dc.w	2000
	dc.w	1000
	dc.w	1000
	dc.w	1000
	dc.w	1000
	dc.w	500
	dc.w	500
	dc.w	500
	dc.w	500
	dc.w	0

; ------------------------------------------------------------------------------

ResultsActive:
	rts

; ------------------------------------------------------------------------------

LoadCapsulePalette:
	move.w	#$20/4-1,d6
	lea	CapsulePalette,a1
	lea	palette+$20,a2

loc_20A39E:
	move.l	(a1)+,(a2)+
	dbf	d6,loc_20A39E
	rts

; ------------------------------------------------------------------------------

CapsulePalette:
	incbin	"src/palettes/capsule.pal"
	even

BigRingFlashAnims:
	include	"src/anims/big_ring_flash.asm"
	even

BigRingFlashSprites:
	include	"src/sprites/big_ring_flash.asm"
	even

BigRingFlashGfx:
	incbin	"src/gfx/big_ring_flash.nem"
	even

; ------------------------------------------------------------------------------
