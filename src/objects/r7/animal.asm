; ------------------------------------------------------------------------------

AnimalObject:
	jsr	CheckAnimalPrescence
	move.b	obj.subtype(a0),d0
	andi.b	#$7F,d0
	bne.w	loc_20E896
	moveq	#0,d0
	move.b	obj.routine(a0),d0
	move.w	off_20E7A0(pc,d0.w),d0
	jmp	off_20E7A0(pc,d0.w)

; ------------------------------------------------------------------------------

off_20E7A0:
	dc.w	AnimalObject_1_Routine0-*
	dc.w	AnimalObject_1_Routine2-off_20E7A0
	dc.w	AnimalObject_1_Routine4-off_20E7A0

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
	bmi.s	loc_20E7E2
	move.w	#$101,obj.var_2e(a0)
	rts

; ------------------------------------------------------------------------------

loc_20E7E2:
	addq.b	#2,obj.routine(a0)
	move.b	#1,obj.anim_id(a0)
	move.b	#3,obj.sprite_layer(a0)
	rts

; ------------------------------------------------------------------------------

AnimalObject_1_Routine2:
	moveq	#1,d2
	moveq	#1,d3
	bsr.w	sub_20E876
	move.b	obj.var_2e(a0),d0
	add.b	obj.var_2f(a0),d0
	move.b	d0,d1
	subq.b	#1,d1
	subi.b	#$7F,d1
	bcs.s	loc_20E81A
	move.b	obj.var_2e(a0),d0
	neg.b	obj.var_2f(a0)
	bsr.w	FlipAnimal

loc_20E81A:
	move.b	d0,obj.var_2e(a0)
	lea	AnimalAnims1(pc),a1
	jsr	AnimateObject
	jsr	DrawObject
	move.w	obj.var_2a(a0),d0
	jmp	CheckObjectDespawn2

; ------------------------------------------------------------------------------

AnimalObject_1_Routine4:
	movea.w	obj.var_3e(a0),a1
	cmpi.b	#$27,obj.id(a1)
	bne.w	loc_20E968
	tst.b	obj.var_3f(a1)
	bne.w	loc_20E968
	moveq	#3,d2
	moveq	#4,d3
	bsr.w	sub_20E876
	addq.b	#4,obj.var_2e(a0)
	move.b	obj.var_2e(a0),d0
	andi.b	#$7F,d0
	beq.w	FlipAnimal
	lea	AnimalAnims1(pc),a1
	jsr	AnimateObject
	jmp	DrawObject

; ------------------------------------------------------------------------------

sub_20E876:
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

loc_20E896:
	moveq	#0,d0
	move.b	obj.routine(a0),d0
	move.w	off_20E8A4(pc,d0.w),d0
	jmp	off_20E8A4(pc,d0.w)

; ------------------------------------------------------------------------------

off_20E8A4:
	dc.w	AnimalObject_0_Routine0-*
	dc.w	AnimalObject_0_Routine2-off_20E8A4
	dc.w	AnimalObject_0_Routine2-off_20E8A4
	dc.w	AnimalObject_0_Routine6-off_20E8A4
	dc.w	AnimalObject_0_Routine8-off_20E8A4

; ------------------------------------------------------------------------------

AnimalObject_0_Routine0:
	addq.b	#2,obj.routine(a0)
	move.b	#4,obj.sprite_flags(a0)
	move.l	#$C080408,obj.height(a0)
	move.l	#AnimalSprites2,obj.sprite_data(a0)
	bsr.w	SetAnimalSpriteTile
	tst.b	obj.subtype(a0)
	bmi.s	loc_20E8E4
	move.l	#$10000,obj.var_2c(a0)
	move.l	#-$40000,obj.var_30(a0)
	rts

; ------------------------------------------------------------------------------

loc_20E8E4:
	move.b	#8,obj.routine(a0)
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
	bpl.s	loc_20E928
	addq.b	#2,obj.routine(a0)
	add.w	d1,obj.y(a0)
	move.l	#$FFFC0000,obj.var_30(a0)

loc_20E928:
	jsr	DrawObject
	jmp	CheckObjectDespawn

; ------------------------------------------------------------------------------

AnimalObject_0_Routine6:
	move.b	#2,obj.routine(a0)
	neg.l	obj.var_2c(a0)
	bsr.s	FlipAnimal
	bra.s	loc_20E928

; ------------------------------------------------------------------------------

AnimalObject_0_Routine8:
	movea.w	obj.var_3e(a0),a1
	cmpi.b	#$27,obj.id(a1)
	bne.w	loc_20E968
	tst.b	obj.var_3f(a1)
	bne.w	loc_20E968
	lea	AnimalAnims2(pc),a1
	jsr	AnimateObject
	jmp	DrawObject

; ------------------------------------------------------------------------------

loc_20E968:
	jmp	DeleteObject

; ------------------------------------------------------------------------------

FlipAnimal:
	bchg	#0,obj.sprite_flags(a0)
	bchg	#0,obj.flags(a0)
	rts

; ------------------------------------------------------------------------------

SetAnimalSpriteTile:
	lea	word_20EA50(pc),a1
	moveq	#0,d0
	move.b	act,d0
	asl.w	#2,d0
	add.b	time_zone,d0
	add.w	d0,d0
	move.w	(a1,d0.w),obj.sprite_tile(a0)
	rts

; ------------------------------------------------------------------------------

AnimalAnims1:
	include	"src/anims/r7/animal_1.asm"
	even

AnimalAnims2:
	include	"src/anims/r7/animal_2.asm"
	even

AnimalSprites1:
	include	"src/sprites/r7/animal_1.asm"
	even

AnimalSprites2:
	include	"src/sprites/r7/animal_2.asm"
	even

word_20EA50:
	dc.w	$396, $396, $396, 0
	dc.w	$396, $396, $396, 0
	dc.w	0, 0, $396
	
; ------------------------------------------------------------------------------
