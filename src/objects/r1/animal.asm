; ------------------------------------------------------------------------------

AnimalObject:
	jsr	CheckAnimalPrescence
	move.b	obj.subtype(a0),d0
	andi.b	#$7F,d0
	bne.w	loc_20D0C2
	moveq	#0,d0
	move.b	obj.routine(a0),d0
	move.w	off_20CFC0(pc,d0.w),d0
	jmp	off_20CFC0(pc,d0.w)

; ------------------------------------------------------------------------------

off_20CFC0:
	dc.w	AnimalObject_1_Routine0-*
	dc.w	AnimalObject_1_Routine2-off_20CFC0
	dc.w	AnimalObject_1_Routine4-off_20CFC0

; ------------------------------------------------------------------------------

AnimalObject_1_Routine0:
	addq.b	#2,obj.routine(a0)
	move.b	#4,obj.sprite_flags(a0)
	move.l	#$8080408,obj.height(a0)
	move.l	#AnimalSprites1,obj.sprite_data(a0)
	move.w	obj.x(a0),obj.var_2a(a0)
	move.w	obj.y(a0),obj.var_2c(a0)
	bsr.w	FlipAnimal
	bsr.w	SetAnimalSpriteTile
	tst.b	obj.subtype(a0)
	bmi.s	loc_20D00E
	move.b	#4,obj.sprite_layer(a0)
	ori.w	#$8000,obj.sprite_tile(a0)
	move.w	#$101,obj.var_2e(a0)
	rts

; ------------------------------------------------------------------------------

loc_20D00E:
	addq.b	#2,obj.routine(a0)
	move.b	#1,obj.anim_id(a0)
	move.b	#3,obj.sprite_layer(a0)
	rts

; ------------------------------------------------------------------------------

AnimalObject_1_Routine2:
	moveq	#1,d2
	moveq	#1,d3
	bsr.w	sub_20D0A2
	move.b	obj.var_2e(a0),d0
	add.b	obj.var_2f(a0),d0
	move.b	d0,d1
	subq.b	#1,d1
	subi.b	#$7F,d1
	bcs.s	loc_20D046
	move.b	obj.var_2e(a0),d0
	neg.b	obj.var_2f(a0)
	bsr.w	FlipAnimal

loc_20D046:
	move.b	d0,obj.var_2e(a0)
	lea	AnimalAnims1(pc),a1
	jsr	AnimateObject
	jsr	DrawObject
	move.w	obj.var_2a(a0),d0
	jmp	CheckObjectDespawn2

; ------------------------------------------------------------------------------

AnimalObject_1_Routine4:
	movea.w	obj.var_3e(a0),a1
	cmpi.b	#$2E,obj.id(a1)
	bne.w	loc_20D18A
	tst.b	obj.var_3f(a1)
	bne.w	loc_20D18A
	moveq	#3,d2
	moveq	#4,d3
	bsr.w	sub_20D0A2
	addq.b	#4,obj.var_2e(a0)
	move.b	obj.var_2e(a0),d0
	andi.b	#$7F,d0
	beq.w	FlipAnimal
	lea	AnimalAnims1(pc),a1
	jsr	AnimateObject
	jmp	DrawObject

; ------------------------------------------------------------------------------

sub_20D0A2:
	move.b	obj.var_2e(a0),d0
	jsr	SineCosine
	asr.w	d2,d1
	asr.w	d3,d0
	add.w	obj.var_2a(a0),d1
	add.w	obj.var_2c(a0),d0
	move.w	d1,obj.x(a0)
	move.w	d0,obj.y(a0)
	rts

; ------------------------------------------------------------------------------

loc_20D0C2:
	moveq	#0,d0
	move.b	obj.routine(a0),d0
	move.w	off_20D0D0(pc,d0.w),d0
	jmp	off_20D0D0(pc,d0.w)

; ------------------------------------------------------------------------------

off_20D0D0:
	dc.w	AnimalObject_0_Routine0-*
	dc.w	AnimalObject_0_Routine2-off_20D0D0
	dc.w	AnimalObject_0_Routine4-off_20D0D0

; ------------------------------------------------------------------------------

AnimalObject_0_Routine0:
	addq.b	#2,obj.routine(a0)
	move.b	#4,obj.sprite_flags(a0)
	move.l	#$8080408,obj.height(a0)
	move.l	#AnimalSprites2,obj.sprite_data(a0)
	move.w	obj.x(a0),obj.var_2a(a0)
	bsr.w	SetAnimalSpriteTile
	tst.b	obj.subtype(a0)
	bmi.s	loc_20D112
	move.l	#$10000,obj.var_2c(a0)
	move.l	#-$40000,obj.var_30(a0)
	rts

; ------------------------------------------------------------------------------

loc_20D112:
	move.b	#4,obj.routine(a0)
	bra.w	FlipAnimal

; ------------------------------------------------------------------------------

AnimalObject_0_Routine2:
	move.l	obj.var_2c(a0),d0
	add.l	d0,obj.x(a0)
	move.l	obj.var_30(a0),d0
	add.l	d0,obj.y(a0)
	addi.l	#$2000,obj.var_30(a0)
	smi	d0
	addq.b	#1,d0
	move.b	d0,obj.sprite_frame(a0)
	jsr	CheckBlockDown
	tst.w	d1
	bpl.s	loc_20D158
	add.w	d1,obj.y(a0)
	move.l	#-$40000,obj.var_30(a0)
	neg.l	obj.var_2c(a0)
	bsr.s	FlipAnimal

loc_20D158:
	jsr	DrawObject
	jmp	CheckObjectDespawn

; ------------------------------------------------------------------------------

AnimalObject_0_Routine4:
	movea.w	obj.var_3e(a0),a1
	cmpi.b	#$2E,obj.id(a1)
	bne.w	loc_20D18A
	tst.b	obj.var_3f(a1)
	bne.w	loc_20D18A
	lea	AnimalAnims2(pc),a1
	jsr	AnimateObject
	jmp	DrawObject

; ------------------------------------------------------------------------------

loc_20D18A:
	jmp	DeleteObject

; ------------------------------------------------------------------------------

FlipAnimal:
	bchg	#0,obj.sprite_flags(a0)
	bchg	#0,obj.flags(a0)
	rts

; ------------------------------------------------------------------------------

SetAnimalSpriteTile:
	lea	word_20D272(pc),a1
	moveq	#0,d0
	move.b	act,d0
	asl.w	#2,d0
	add.b	time_zone,d0
	add.w	d0,d0
	move.w	(a1,d0.w),obj.sprite_tile(a0)
	rts

; ------------------------------------------------------------------------------

AnimalAnims1:
	include	"src/anims/r1/animal_1.asm"
	even

AnimalAnims2:
	include	"src/anims/r1/animal_2.asm"
	even

AnimalSprites1:
	include	"src/sprites/r1/animal_1.asm"
	even

AnimalSprites2:
	include	"src/sprites/r1/animal_2.asm"
	even

word_20D272:
	dc.w	$4F7, $388, $463, 0
	dc.w	$4F7, $38F, $461, 0
	dc.w	0, 0, $3CF

; ------------------------------------------------------------------------------
