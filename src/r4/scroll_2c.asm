; ------------------------------------------------------------------------------

GetPlayerObject:
	lea	player_object,a6
	tst.b	use_player_2
	beq.s	locret_202B46
	lea	player_object_2,a6

locret_202B46:
	rts

; ------------------------------------------------------------------------------

InitScroll:
	lea	player_object,a6
	moveq	#0,d0
	move.b	d0,unused_scroll_x_flag
	move.b	d0,unused_scroll_y_flag
	move.b	d0,unused_scroll_die
	move.b	d0,unused_scroll_timer
	move.b	d0,event_routine
	lea	unk_202BA4,a0
	move.w	(a0)+,d0
	move.w	d0,unused_scroll_routine
	move.l	(a0)+,d0
	move.l	d0,left_bound
	move.l	d0,target_left_bound
	move.l	(a0)+,d0
	move.l	d0,top_bound
	move.l	d0,target_top_bound
	move.w	left_bound,d0
	addi.w	#$240,d0
	move.w	d0,unused_scroll_x_keep
	move.w	#$1010,scroll_cross_x
	move.w	(a0)+,d0
	move.w	d0,scroll_focus_y
	move.w	#$A0,scroll_focus_x
	bra.w	loc_202BD0

; ------------------------------------------------------------------------------

unk_202BA4:
	dc.b	0
	dc.b	4
	dc.b	0
	dc.b	0
	dc.b	$1C
	dc.b	$97
	dc.b	0
	dc.b	0
	dc.b	8
	dc.b	0
	dc.b	0
	dc.b	$60

unk_202BB0:
	dc.b	0
	dc.b	$50
	dc.b	3
	dc.b	$B0
	dc.b	$E
	dc.b	$A0
	dc.b	4
	dc.b	$6C
	dc.b	$17
	dc.b	$50
	dc.b	0
	dc.b	$BD
	dc.b	$A
	dc.b	0
	dc.b	6
	dc.b	$2C
	dc.b	$B
	dc.b	$B0
	dc.b	0
	dc.b	$4C
	dc.b	$15
	dc.b	$70
	dc.b	1
	dc.b	$6C
	dc.b	1
	dc.b	$B0
	dc.b	7
	dc.b	$2C
	dc.b	$14
	dc.b	0
	dc.b	2
	dc.b	$AC

; ------------------------------------------------------------------------------

loc_202BD0:
	tst.b	spawn_mode
	beq.s	loc_202BEC
	jsr	LoadCheckpoint
	moveq	#0,d0
	moveq	#0,d1
	move.w	8(a6),d1
	move.w	$C(a6),d0
	bra.s	loc_202C28

; ------------------------------------------------------------------------------

loc_202BEC:
	lea	StagePlayerSpawn,a1
	tst.w	stage_demo
	bpl.s	loc_202C0E
	move.w	s1_credits_index,d0
	subq.w	#1,d0
	lsl.w	#2,d0
	lea	unk_202BB0,a1
	adda.w	d0,a1
	bra.s	loc_202C18

; ------------------------------------------------------------------------------

loc_202C0E:
	move.w	stage_demo,d0
	lsl.w	#2,d0
	adda.w	d0,a1

loc_202C18:
	moveq	#0,d1
	move.w	(a1)+,d1
	move.w	d1,8(a6)
	moveq	#0,d0
	move.w	(a1),d0
	move.w	d0,$C(a6)

loc_202C28:
	subi.w	#$A0,d1
	bcc.s	loc_202C30
	moveq	#0,d1

loc_202C30:
	move.w	right_bound,d2
	cmp.w	d2,d1
	bcs.s	loc_202C3A
	move.w	d2,d1

loc_202C3A:
	move.w	d1,scroll_fg_x
	subi.w	#$60,d0
	bcc.s	loc_202C46
	moveq	#0,d0

loc_202C46:
	cmp.w	bottom_bound,d0
	blt.s	loc_202C50
	move.w	bottom_bound,d0

loc_202C50:
	move.w	d0,scroll_fg_y
	bsr.w	sub_202C6C
	lea	unk_202C68,a1
	move.l	(a1),loop_chunk_1
	rts

; ------------------------------------------------------------------------------

StagePlayerSpawn:
	incbin	"src/maps/r4/spawn_2c.bin"
	even

unk_202C68:
	dc.b	$7F
	dc.b	$7F
	dc.b	$7F
	dc.b	$7F

; ------------------------------------------------------------------------------

sub_202C6C:
	move.w	scroll_fg_y,d0
	lsr.w	#1,d0
	move.w	d0,scroll_bg_y
	move.w	#0,scroll_bg_y+2
	move.w	d0,scroll_bg2_y
	move.w	d0,scroll_bg3_y
	lsr.w	#4,d1
	move.w	d1,scroll_bg3_x
	lsr.w	#1,d1
	move.w	d1,d2
	add.w	d2,d2
	add.w	d1,d2
	move.w	d2,scroll_bg2_x
	lsr.w	#1,d1
	move.w	d1,d2
	add.w	d2,d2
	add.w	d1,d2
	move.w	d2,scroll_bg_x
	rts

; ------------------------------------------------------------------------------

UpdateScroll:
	lea	player_object,a6
	tst.b	scroll_lock
	beq.s	loc_202CB0
	rts

; ------------------------------------------------------------------------------

loc_202CB0:
	clr.w	scroll_flags_fg
	clr.w	scroll_flags_bg
	clr.w	scroll_flags_bg2
	clr.w	scroll_flags_bg3
	bsr.w	ScrollFgX
	bsr.w	ScrollFgY
	bsr.w	StageEvents
	move.w	scroll_fg_y,scroll_y
	move.w	scroll_bg_y,scroll_y+2
	lea	bg_scroll_lines,a1
	move.w	scroll_x_move,d4
	ext.l	d4
	asl.l	#2,d4
	move.l	d4,d3
	add.l	d3,d3
	add.l	d3,d4
	moveq	#2,d6
	move.w	scroll_y_move,d5
	ext.l	d5
	asl.l	#7,d5
	bsr.w	ScrollBgXY
	move.w	scroll_bg_y,scroll_y+2
	move.w	scroll_bg_y,scroll_bg2_y
	move.w	scroll_bg_y,scroll_bg3_y
	move.b	scroll_flags_bg3,d0
	or.b	scroll_flags_bg2,d0
	or.b	d0,scroll_flags_bg
	clr.b	scroll_flags_bg3
	clr.b	scroll_flags_bg2
	lea	bg_scroll_lines,a2
	move.w	scroll_bg_x,d0
	neg.w	d0
	move.w	#$BF,d6

loc_202D2C:
	move.w	d0,(a1)+
	dbf	d6,loc_202D2C
	lea	scroll_lines,a1
	lea	bg_scroll_lines,a2
	move.w	scroll_fg_x,d0
	neg.w	d0
	move.w	d0,d5
	swap	d0
	move.w	scroll_bg_y,d0
	move.w	d0,d2
	andi.w	#$3F8,d0
	lsr.w	#2,d0
	lea	(a2,d0.w),a2
	bra.w	*+4

; ------------------------------------------------------------------------------

loc_202D58:
	lea	byte_202DD6,a3
	lea	WobbleTable,a4
	move.b	bg_water_deform,d3
	move.b	d3,d4
	addi.w	#$80,bg_water_deform
	add.w	scroll_bg_y,d3
	andi.w	#$FF,d3
	add.w	scroll_fg_y,d4
	andi.w	#$FF,d4
	move.w	#$E7,d6
	andi.w	#7,d2
	move.w	(a2)+,d0
	move.w	scroll_fg_y,d1

loc_202D8E:
	cmp.w	water_y,d1
	bge.s	loc_202DAE
	move.l	d0,(a1)+
	addq.w	#1,d1
	addq.b	#1,d3
	addq.b	#1,d4
	addq.b	#1,d2
	cmpi.b	#8,d2
	bne.s	loc_202DA8
	moveq	#0,d2
	move.w	(a2)+,d0

loc_202DA8:
	dbf	d6,loc_202D8E
	rts

; ------------------------------------------------------------------------------

loc_202DAE:
	move.w	#0,d1
	add.w	d5,d1
	move.w	d1,(a1)+
	move.b	(a4,d3.w),d1
	ext.w	d1
	add.w	d0,d1
	move.w	d1,(a1)+
	addq.b	#1,d3
	addq.b	#1,d4
	addq.b	#1,d2
	cmpi.b	#8,d2
	bne.s	loc_202DD0
	moveq	#0,d2
	move.w	(a2)+,d0

loc_202DD0:
	dbf	d6,loc_202DAE
	rts

; ------------------------------------------------------------------------------

byte_202DD6:
	dc.b	1, 1, 2, 2, 3, 3, 3, 3, 2, 2, 1, 1, 0, 0, 0, 0
	dc.b	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	dc.b	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	dc.b	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	dc.b	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	dc.b	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	dc.b	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	dc.b	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	dc.b	-1, -1, -2, -2, -3, -3, -3, -3, -2, -2, -1, -1, 0, 0, 0, 0
	dc.b	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	dc.b	1, 1, 2, 2, 3, 3, 3, 3, 2, 2, 1, 1, 0, 0, 0, 0
	dc.b	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	dc.b	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	dc.b	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	dc.b	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	dc.b	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

; ------------------------------------------------------------------------------

ScrollFgX:
	move.w	scroll_fg_x,d4
	bsr.s	CheckScrollFgX
	move.w	scroll_fg_x,d0
	andi.w	#$10,d0
	move.b	scroll_cross_x,d1
	eor.b	d1,d0
	bne.s	locret_202F08
	eori.b	#$10,scroll_cross_x
	move.w	scroll_fg_x,d0
	sub.w	d4,d0
	bpl.s	loc_202F02
	bset	#2,scroll_flags_fg
	rts

; ------------------------------------------------------------------------------

loc_202F02:
	bset	#3,scroll_flags_fg

locret_202F08:
	rts

; ------------------------------------------------------------------------------

CheckScrollFgX:
	move.w	8(a6),d0
	sub.w	scroll_fg_x,d0
	sub.w	scroll_focus_x,d0
	beq.s	loc_202F1C
	bcs.s	loc_202F4C
	bra.s	loc_202F22

; ------------------------------------------------------------------------------

loc_202F1C:
	clr.w	scroll_x_move
	rts

; ------------------------------------------------------------------------------

loc_202F22:
	cmpi.w	#$10,d0
	blt.s	loc_202F2C
	move.w	#$10,d0

loc_202F2C:
	add.w	scroll_fg_x,d0
	cmp.w	right_bound,d0
	blt.s	loc_202F3A
	move.w	right_bound,d0

loc_202F3A:
	move.w	d0,d1
	sub.w	scroll_fg_x,d1
	asl.w	#8,d1
	move.w	d0,scroll_fg_x
	move.w	d1,scroll_x_move
	rts

; ------------------------------------------------------------------------------

loc_202F4C:
	cmpi.w	#$FFF0,d0
	bge.s	loc_202F56
	move.w	#$FFF0,d0

loc_202F56:
	add.w	scroll_fg_x,d0
	cmp.w	left_bound,d0
	bgt.s	loc_202F3A
	move.w	left_bound,d0
	bra.s	loc_202F3A

; ------------------------------------------------------------------------------

ScrollFgXSlow:
	tst.w	d0
	bpl.s	loc_202F70
	move.w	#$FFFE,d0
	bra.s	loc_202F4C

; ------------------------------------------------------------------------------

loc_202F70:
	move.w	#2,d0
	bra.s	loc_202F22

; ------------------------------------------------------------------------------

ScrollFgY:
	moveq	#0,d1
	move.w	$C(a6),d0
	sub.w	scroll_fg_y,d0
	btst	#2,$22(a6)
	beq.s	loc_202F8A
	subq.w	#5,d0

loc_202F8A:
	btst	#1,$22(a6)
	beq.s	loc_202FAA
	addi.w	#$20,d0
	sub.w	scroll_focus_y,d0
	bcs.s	loc_202FF6
	subi.w	#$40,d0
	bcc.s	loc_202FF6
	tst.b	bottom_bound_shift
	bne.s	loc_203008
	bra.s	loc_202FB6

; ------------------------------------------------------------------------------

loc_202FAA:
	sub.w	scroll_focus_y,d0
	bne.s	loc_202FBC
	tst.b	bottom_bound_shift
	bne.s	loc_203008

loc_202FB6:
	clr.w	scroll_y_move
	rts

; ------------------------------------------------------------------------------

loc_202FBC:
	cmpi.w	#$60,scroll_focus_y
	bne.s	loc_202FE4
	move.w	$14(a6),d1
	bpl.s	loc_202FCC
	neg.w	d1

loc_202FCC:
	cmpi.w	#$800,d1
	bcc.s	loc_202FF6
	move.w	#$600,d1
	cmpi.w	#6,d0
	bgt.s	loc_203056
	cmpi.w	#$FFFA,d0
	blt.s	loc_203020
	bra.s	loc_20300E

; ------------------------------------------------------------------------------

loc_202FE4:
	move.w	#$200,d1
	cmpi.w	#2,d0
	bgt.s	loc_203056
	cmpi.w	#$FFFE,d0
	blt.s	loc_203020
	bra.s	loc_20300E

; ------------------------------------------------------------------------------

loc_202FF6:
	move.w	#$1000,d1
	cmpi.w	#$10,d0
	bgt.s	loc_203056
	cmpi.w	#$FFF0,d0
	blt.s	loc_203020
	bra.s	loc_20300E

; ------------------------------------------------------------------------------

loc_203008:
	moveq	#0,d0
	move.b	d0,bottom_bound_shift

loc_20300E:
	moveq	#0,d1
	move.w	d0,d1
	add.w	scroll_fg_y,d1
	tst.w	d0
	bpl.w	loc_203060
	bra.w	loc_20302C

; ------------------------------------------------------------------------------

loc_203020:
	neg.w	d1
	ext.l	d1
	asl.l	#8,d1
	add.l	scroll_fg_y,d1
	swap	d1

loc_20302C:
	cmp.w	top_bound,d1
	bgt.s	loc_203084
	cmpi.w	#0,d1
	bgt.s	loc_203050
	addi.w	#$800,d1
	addi.w	#$800,$C(a6)
	addi.w	#$800,scroll_fg_y
	andi.w	#$3FF,scroll_bg_y
	bra.s	loc_203084

; ------------------------------------------------------------------------------

loc_203050:
	move.w	top_bound,d1
	bra.s	loc_203084

; ------------------------------------------------------------------------------

loc_203056:
	ext.l	d1
	asl.l	#8,d1
	add.l	scroll_fg_y,d1
	swap	d1

loc_203060:
	cmp.w	bottom_bound,d1
	blt.s	loc_203084
	subi.w	#$800,d1
	bcs.s	loc_203080
	andi.w	#$7FF,$C(a6)
	subi.w	#$800,scroll_fg_y
	andi.w	#$3FF,scroll_bg_y
	bra.s	loc_203084

; ------------------------------------------------------------------------------

loc_203080:
	move.w	bottom_bound,d1

loc_203084:
	move.w	scroll_fg_y,d4
	swap	d1
	move.l	d1,d3
	sub.l	scroll_fg_y,d3
	ror.l	#8,d3
	move.w	d3,scroll_y_move
	move.l	d1,scroll_fg_y
	move.w	scroll_fg_y,d0
	andi.w	#$10,d0
	move.b	scroll_cross_y,d1
	eor.b	d1,d0
	bne.s	locret_2030C6
	eori.b	#$10,scroll_cross_y
	move.w	scroll_fg_y,d0
	sub.w	d4,d0
	bpl.s	loc_2030C0
	bset	#0,scroll_flags_fg
	rts

; ------------------------------------------------------------------------------

loc_2030C0:
	bset	#1,scroll_flags_fg

locret_2030C6:
	rts

; ------------------------------------------------------------------------------

ScrollBgXY:
	move.l	scroll_bg_x,d2
	move.l	d2,d0
	add.l	d4,d0
	move.l	d0,scroll_bg_x
	move.l	d0,d1
	swap	d1
	andi.w	#$10,d1
	move.b	scroll_cross_bg_x,d3
	eor.b	d3,d1
	bne.s	loc_2030FC
	eori.b	#$10,scroll_cross_bg_x
	sub.l	d2,d0
	bpl.s	loc_2030F6
	bset	#2,scroll_flags_bg
	bra.s	loc_2030FC

; ------------------------------------------------------------------------------

loc_2030F6:
	bset	#3,scroll_flags_bg

loc_2030FC:
	move.l	scroll_bg_y,d3
	move.l	d3,d0
	add.l	d5,d0
	move.l	d0,scroll_bg_y
	move.l	d0,d1
	swap	d1
	andi.w	#$10,d1
	move.b	scroll_cross_bg_y,d2
	eor.b	d2,d1
	bne.s	locret_203130
	eori.b	#$10,scroll_cross_bg_y
	sub.l	d3,d0
	bpl.s	loc_20312A
	bset	#0,scroll_flags_bg
	rts

; ------------------------------------------------------------------------------

loc_20312A:
	bset	#1,scroll_flags_bg

locret_203130:
	rts

; ------------------------------------------------------------------------------

UnkScrollBgY:
	move.l	scroll_bg_y,d3
	move.l	d3,d0
	add.l	d5,d0
	move.l	d0,scroll_bg_y
	move.l	d0,d1
	swap	d1
	andi.w	#$10,d1
	move.b	scroll_cross_bg_y,d2
	eor.b	d2,d1
	bne.s	locret_203166
	eori.b	#$10,scroll_cross_bg_y
	sub.l	d3,d0
	bpl.s	loc_203160
	bset	#4,scroll_flags_bg
	rts

; ------------------------------------------------------------------------------

loc_203160:
	bset	#5,scroll_flags_bg

locret_203166:
	rts

; ------------------------------------------------------------------------------

ScrollBgY:
	move.w	scroll_bg_y,d3
	move.w	d0,scroll_bg_y
	move.w	d0,d1
	andi.w	#$10,d1
	move.b	scroll_cross_bg_y,d2
	eor.b	d2,d1
	bne.s	locret_203196
	eori.b	#$10,scroll_cross_bg_y
	sub.w	d3,d0
	bpl.s	loc_203190
	bset	#0,scroll_flags_bg
	rts

; ------------------------------------------------------------------------------

loc_203190:
	bset	#1,scroll_flags_bg

locret_203196:
	rts

; ------------------------------------------------------------------------------

ScrollBgX:
	move.l	scroll_bg_x,d2
	move.l	d2,d0
	add.l	d4,d0
	move.l	d0,scroll_bg_x
	move.l	d0,d1
	swap	d1
	andi.w	#$10,d1
	move.b	scroll_cross_bg_x,d3
	eor.b	d3,d1
	bne.s	locret_2031CA
	eori.b	#$10,scroll_cross_bg_x
	sub.l	d2,d0
	bpl.s	loc_2031C4
	bset	d6,scroll_flags_bg
	bra.s	locret_2031CA

; ------------------------------------------------------------------------------

loc_2031C4:
	addq.b	#1,d6
	bset	d6,scroll_flags_bg

locret_2031CA:
	rts

; ------------------------------------------------------------------------------

ScrollBg2X:
	move.l	scroll_bg2_x,d2
	move.l	d2,d0
	add.l	d4,d0
	move.l	d0,scroll_bg2_x
	move.l	d0,d1
	swap	d1
	andi.w	#$10,d1
	move.b	scroll_cross_bg2_x,d3
	eor.b	d3,d1
	bne.s	locret_2031FE
	eori.b	#$10,scroll_cross_bg2_x
	sub.l	d2,d0
	bpl.s	loc_2031F8
	bset	d6,scroll_flags_bg2
	bra.s	locret_2031FE

; ------------------------------------------------------------------------------

loc_2031F8:
	addq.b	#1,d6
	bset	d6,scroll_flags_bg2

locret_2031FE:
	rts

; ------------------------------------------------------------------------------

ScrollBg3X:
	move.l	scroll_bg3_x,d2
	move.l	d2,d0
	add.l	d4,d0
	move.l	d0,scroll_bg3_x
	move.l	d0,d1
	swap	d1
	andi.w	#$10,d1
	move.b	scroll_cross_bg3_x,d3
	eor.b	d3,d1
	bne.s	locret_203232
	eori.b	#$10,scroll_cross_bg3_x
	sub.l	d2,d0
	bpl.s	loc_20322C
	bset	d6,scroll_flags_bg3
	bra.s	locret_203232

; ------------------------------------------------------------------------------

loc_20322C:
	addq.b	#1,d6
	bset	d6,scroll_flags_bg3

locret_203232:
	rts

; ------------------------------------------------------------------------------
