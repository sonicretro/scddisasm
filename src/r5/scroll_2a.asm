; ------------------------------------------------------------------------------

GetPlayerObject:
	lea	player_object,a6
	tst.b	use_player_2
	beq.s	locret_2029F6
	lea	player_object_2,a6

locret_2029F6:
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
	lea	unk_202A54,a0
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
	bra.w	loc_202A80

; ------------------------------------------------------------------------------

unk_202A54:
	dc.b	0
	dc.b	4
	dc.b	0
	dc.b	0
	dc.b	$2A
	dc.b	$97
	dc.b	0
	dc.b	0
	dc.b	3
	dc.b	$20
	dc.b	0
	dc.b	$60

unk_202A60:
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

loc_202A80:
	tst.b	spawn_mode
	beq.s	loc_202AA0
	jsr	LoadCheckpoint
	moveq	#0,d0
	moveq	#0,d1
	move.w	8(a6),d1
	move.w	$C(a6),d0
	bpl.s	loc_202A9E
	moveq	#0,d0

loc_202A9E:
	bra.s	loc_202ADC

; ------------------------------------------------------------------------------

loc_202AA0:
	lea	StagePlayerSpawn,a1
	tst.w	stage_demo
	bpl.s	loc_202AC2
	move.w	s1_credits_index,d0
	subq.w	#1,d0
	lsl.w	#2,d0
	lea	unk_202A60,a1
	adda.w	d0,a1
	bra.s	loc_202ACC

; ------------------------------------------------------------------------------

loc_202AC2:
	move.w	stage_demo,d0
	lsl.w	#2,d0
	adda.w	d0,a1

loc_202ACC:
	moveq	#0,d1
	move.w	(a1)+,d1
	move.w	d1,8(a6)
	moveq	#0,d0
	move.w	(a1),d0
	move.w	d0,$C(a6)

loc_202ADC:
	subi.w	#$A0,d1
	bcc.s	loc_202AE4
	moveq	#0,d1

loc_202AE4:
	move.w	right_bound,d2
	cmp.w	d2,d1
	bcs.s	loc_202AEE
	move.w	d2,d1

loc_202AEE:
	move.w	d1,scroll_fg_x
	subi.w	#$60,d0
	bcc.s	loc_202AFA
	moveq	#0,d0

loc_202AFA:
	cmp.w	bottom_bound,d0
	blt.s	loc_202B04
	move.w	bottom_bound,d0

loc_202B04:
	move.w	d0,scroll_fg_y
	bsr.w	InitBgScroll
	lea	unk_202B1C,a1
	move.l	(a1),loop_chunk_1
	rts

; ------------------------------------------------------------------------------

StagePlayerSpawn:
	incbin	"src/maps/r5/spawn_2a.bin"
	even

unk_202B1C:
	dc.b	$7F
	dc.b	$7F
	dc.b	$15
	dc.b	$5B

; ------------------------------------------------------------------------------

InitBgScroll:
	swap	d0
	btst	#0,r5_bg_change
	beq.s	loc_202B30
	lsr.l	#2,d0
	bra.s	loc_202B3C

; ------------------------------------------------------------------------------

loc_202B30:
	lsr.l	#1,d0
	move.l	d0,d2
	lsr.l	#2,d2
	add.l	d2,d0
	lsr.l	#1,d2
	add.l	d2,d0

loc_202B3C:
	move.l	d0,scroll_bg_y
	swap	d0
	move.w	d0,scroll_bg2_y
	move.w	d0,scroll_bg3_y
	move.l	d1,d2
	lsr.l	#2,d2
	add.l	d1,d2
	move.w	d2,scroll_bg_x
	lsr.l	#1,d1
	move.w	d1,scroll_bg2_x
	lsr.l	#1,d1
	move.w	d1,scroll_bg3_x
	rts

; ------------------------------------------------------------------------------

UpdateScroll:
	lea	player_object,a6
	tst.b	scroll_lock
	beq.s	loc_202B6E
	rts

; ------------------------------------------------------------------------------

loc_202B6E:
	clr.w	scroll_flags_fg
	clr.w	scroll_flags_bg
	clr.w	scroll_flags_bg2
	clr.w	scroll_flags_bg3
	bsr.w	ScrollFgX
	bsr.w	ScrollFgY
	bsr.w	StageEvents
	move.w	scroll_fg_y,scroll_y
	move.w	scroll_bg_y,scroll_y+2
	move.w	scroll_x_move,d4
	ext.l	d4
	asl.l	#6,d4
	moveq	#6,d6
	bsr.w	ScrollBg3X
	move.w	scroll_x_move,d4
	ext.l	d4
	asl.l	#7,d4
	moveq	#4,d6
	bsr.w	ScrollBg2X
	lea	bg_scroll_lines,a1
	move.w	scroll_x_move,d4
	ext.l	d4
	asl.l	#6,d4
	move.l	d4,d3
	asl.l	#2,d4
	add.l	d3,d4
	moveq	#2,d6
	bsr.w	ScrollBgX
	move.w	scroll_fg_y,d0
	btst	#0,r5_bg_change
	beq.s	loc_202BDC
	lsr.w	#2,d0
	bra.s	loc_202BE8

; ------------------------------------------------------------------------------

loc_202BDC:
	lsr.w	#1,d0
	move.w	d0,d2
	lsr.w	#2,d2
	add.w	d2,d0
	lsr.w	#1,d2
	add.w	d2,d0

loc_202BE8:
	bsr.w	ScrollBgY
	move.w	scroll_bg_y,scroll_y+2
	move.w	scroll_bg_y,scroll_bg2_y
	move.w	scroll_bg_y,scroll_bg3_y
	move.b	scroll_flags_bg3,d0
	or.b	scroll_flags_bg2,d0
	or.b	d0,scroll_flags_bg
	clr.b	scroll_flags_bg3
	clr.b	scroll_flags_bg2
	lea	bg_scroll_lines,a1
	move.w	scroll_fg_x,d0
	neg.w	d0
	swap	d0
	btst	#0,r5_bg_change
	beq.s	loc_202C34
	bsr.w	sub_202D08
	bsr.w	sub_202D58
	bra.w	loc_202C5C

; ------------------------------------------------------------------------------

loc_202C34:
	move.w	scroll_bg_x,d0
	neg.w	d0
	move.w	#7,d6

loc_202C3E:
	move.w	d0,(a1)+
	dbf	d6,loc_202C3E
	bsr.w	sub_202C7A
	bsr.w	sub_202CC4
	move.w	scroll_bg_x,d0
	neg.w	d0
	move.w	#7,d6

loc_202C56:
	move.w	d0,(a1)+
	dbf	d6,loc_202C56

loc_202C5C:
	lea	scroll_lines,a1
	lea	bg_scroll_lines,a2
	move.w	scroll_bg_y,d0
	move.w	d0,d2
	andi.w	#$3F8,d0
	lsr.w	#2,d0
	moveq	#$1C,d1
	lea	(a2,d0.w),a2
	bra.w	loc_202D98

; ------------------------------------------------------------------------------

sub_202C7A:
	move.w	scroll_bg3_x,d0
	move.w	scroll_fg_x,d2
	sub.w	d0,d2
	ext.l	d2
	moveq	#6,d1
	asl.l	d1,d2
	divu.w	#$C,d2
	ext.l	d2
	moveq	#$A,d1
	asl.l	d1,d2
	move.w	scroll_bg3_x,d3
	moveq	#5,d6
	adda.w	#$44,a1

loc_202C9E:
	move.w	d3,d0
	neg.w	d0
	moveq	#0,d5
	move.b	byte_202CBE(pc,d6.w),d5

loc_202CA8:
	move.w	d0,-(a1)
	dbf	d5,loc_202CA8
	swap	d3
	add.l	d2,d3
	swap	d3
	dbf	d6,loc_202C9E
	adda.w	#$44,a1
	rts

; ------------------------------------------------------------------------------

byte_202CBE:
	dc.b	$D
	dc.b	$B
	dc.b	1
	dc.b	1
	dc.b	1
	dc.b	1

; ------------------------------------------------------------------------------

sub_202CC4:
	move.w	scroll_bg3_x,d0
	move.w	scroll_fg_x,d2
	sub.w	d0,d2
	ext.l	d2
	moveq	#6,d1
	asl.l	d1,d2
	divu.w	#$E,d2
	ext.l	d2
	moveq	#$A,d1
	asl.l	d1,d2
	move.w	scroll_bg3_x,d3
	moveq	#6,d6

loc_202CE4:
	move.w	d3,d0
	neg.w	d0
	moveq	#0,d5
	move.b	byte_202D00(pc,d6.w),d5

loc_202CEE:
	move.w	d0,(a1)+
	dbf	d5,loc_202CEE
	swap	d3
	add.l	d2,d3
	swap	d3
	dbf	d6,loc_202CE4
	rts

; ------------------------------------------------------------------------------

byte_202D00:
	dc.b	$F
	dc.b	$13
	dc.b	1
	dc.b	1
	dc.b	1
	dc.b	1
	dc.b	1
	dc.b	0

; ------------------------------------------------------------------------------

sub_202D08:
	move.w	scroll_bg3_x,d0
	move.w	scroll_fg_x,d2
	sub.w	d0,d2
	ext.l	d2
	moveq	#7,d1
	asl.l	d1,d2
	divu.w	#$16,d2
	ext.l	d2
	moveq	#9,d1
	asl.l	d1,d2
	move.w	scroll_bg3_x,d3
	moveq	#$A,d6
	adda.w	#$2C,a1

loc_202D2C:
	move.w	d3,d0
	neg.w	d0
	moveq	#0,d5
	move.b	byte_202D4C(pc,d6.w),d5

loc_202D36:
	move.w	d0,-(a1)
	dbf	d5,loc_202D36
	swap	d3
	add.l	d2,d3
	swap	d3
	dbf	d6,loc_202D2C
	adda.w	#$2C,a1
	rts

; ------------------------------------------------------------------------------

byte_202D4C:
	dc.b	1
	dc.b	1
	dc.b	1
	dc.b	1
	dc.b	1
	dc.b	1
	dc.b	1
	dc.b	1
	dc.b	1
	dc.b	1
	dc.b	1
	dc.b	0

; ------------------------------------------------------------------------------

sub_202D58:
	move.w	scroll_bg3_x,d0
	move.w	scroll_fg_x,d2
	sub.w	d0,d2
	ext.l	d2
	moveq	#6,d1
	asl.l	d1,d2
	divu.w	#$C,d2
	ext.l	d2
	moveq	#$A,d1
	asl.l	d1,d2
	move.w	scroll_bg3_x,d3
	moveq	#2,d6

loc_202D78:
	move.w	d3,d0
	neg.w	d0
	moveq	#0,d5
	move.b	byte_202D94(pc,d6.w),d5

loc_202D82:
	move.w	d0,(a1)+
	dbf	d5,loc_202D82
	swap	d3
	add.l	d2,d3
	swap	d3
	dbf	d6,loc_202D78
	rts

; ------------------------------------------------------------------------------

byte_202D94:
	dc.b	$1F
	dc.b	3
	dc.b	5
	dc.b	0

; ------------------------------------------------------------------------------

loc_202D98:
	andi.w	#7,d2
	add.w	d2,d2
	move.w	(a2)+,d0
	jmp	loc_202DA6(pc,d2.w)

; ------------------------------------------------------------------------------

loc_202DA4:
	move.w	(a2)+,d0

loc_202DA6:
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	dbf	d1,loc_202DA4
	rts

; ------------------------------------------------------------------------------

	neg.w	d0
	jmp	loc_202DC4(pc,d2.w)

; ------------------------------------------------------------------------------

	neg.w	d0

loc_202DC4:
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	dbf	d1,loc_202DA4
	rts

; ------------------------------------------------------------------------------

ScrollFgX:
	move.w	scroll_fg_x,d4
	bsr.s	CheckScrollFgX
	move.w	scroll_fg_x,d0
	andi.w	#$10,d0
	move.b	scroll_cross_x,d1
	eor.b	d1,d0
	bne.s	locret_202E0C
	eori.b	#$10,scroll_cross_x
	move.w	scroll_fg_x,d0
	sub.w	d4,d0
	bpl.s	loc_202E06
	bset	#2,scroll_flags_fg
	rts

; ------------------------------------------------------------------------------

loc_202E06:
	bset	#3,scroll_flags_fg

locret_202E0C:
	rts

; ------------------------------------------------------------------------------

CheckScrollFgX:
	move.w	8(a6),d0
	sub.w	scroll_fg_x,d0
	sub.w	scroll_focus_x,d0
	beq.s	loc_202E20
	bcs.s	loc_202E50
	bra.s	loc_202E26

; ------------------------------------------------------------------------------

loc_202E20:
	clr.w	scroll_x_move
	rts

; ------------------------------------------------------------------------------

loc_202E26:
	cmpi.w	#$10,d0
	blt.s	loc_202E30
	move.w	#$10,d0

loc_202E30:
	add.w	scroll_fg_x,d0
	cmp.w	right_bound,d0
	blt.s	loc_202E3E
	move.w	right_bound,d0

loc_202E3E:
	move.w	d0,d1
	sub.w	scroll_fg_x,d1
	asl.w	#8,d1
	move.w	d0,scroll_fg_x
	move.w	d1,scroll_x_move
	rts

; ------------------------------------------------------------------------------

loc_202E50:
	cmpi.w	#$FFF0,d0
	bge.s	loc_202E5A
	move.w	#$FFF0,d0

loc_202E5A:
	add.w	scroll_fg_x,d0
	cmp.w	left_bound,d0
	bgt.s	loc_202E3E
	move.w	left_bound,d0
	bra.s	loc_202E3E

; ------------------------------------------------------------------------------

ScrollFgXSlow:
	tst.w	d0
	bpl.s	loc_202E74
	move.w	#$FFFE,d0
	bra.s	loc_202E50

; ------------------------------------------------------------------------------

loc_202E74:
	move.w	#2,d0
	bra.s	loc_202E26

; ------------------------------------------------------------------------------

ScrollFgY:
	moveq	#0,d1
	move.w	$C(a6),d0
	sub.w	scroll_fg_y,d0
	btst	#2,$22(a6)
	beq.s	loc_202E8E
	subq.w	#5,d0

loc_202E8E:
	btst	#1,$22(a6)
	beq.s	loc_202EAE
	addi.w	#$20,d0
	sub.w	scroll_focus_y,d0
	bcs.s	loc_202EFA
	subi.w	#$40,d0
	bcc.s	loc_202EFA
	tst.b	bottom_bound_shift
	bne.s	loc_202F0C
	bra.s	loc_202EBA

; ------------------------------------------------------------------------------

loc_202EAE:
	sub.w	scroll_focus_y,d0
	bne.s	loc_202EC0
	tst.b	bottom_bound_shift
	bne.s	loc_202F0C

loc_202EBA:
	clr.w	scroll_y_move
	rts

; ------------------------------------------------------------------------------

loc_202EC0:
	cmpi.w	#$60,scroll_focus_y
	bne.s	loc_202EE8
	move.w	$14(a6),d1
	bpl.s	loc_202ED0
	neg.w	d1

loc_202ED0:
	cmpi.w	#$800,d1
	bcc.s	loc_202EFA
	move.w	#$600,d1
	cmpi.w	#6,d0
	bgt.s	loc_202F5A
	cmpi.w	#$FFFA,d0
	blt.s	loc_202F24
	bra.s	loc_202F12

; ------------------------------------------------------------------------------

loc_202EE8:
	move.w	#$200,d1
	cmpi.w	#2,d0
	bgt.s	loc_202F5A
	cmpi.w	#$FFFE,d0
	blt.s	loc_202F24
	bra.s	loc_202F12

; ------------------------------------------------------------------------------

loc_202EFA:
	move.w	#$1000,d1
	cmpi.w	#$10,d0
	bgt.s	loc_202F5A
	cmpi.w	#$FFF0,d0
	blt.s	loc_202F24
	bra.s	loc_202F12

; ------------------------------------------------------------------------------

loc_202F0C:
	moveq	#0,d0
	move.b	d0,bottom_bound_shift

loc_202F12:
	moveq	#0,d1
	move.w	d0,d1
	add.w	scroll_fg_y,d1
	tst.w	d0
	bpl.w	loc_202F64
	bra.w	loc_202F30

; ------------------------------------------------------------------------------

loc_202F24:
	neg.w	d1
	ext.l	d1
	asl.l	#8,d1
	add.l	scroll_fg_y,d1
	swap	d1

loc_202F30:
	cmp.w	top_bound,d1
	bgt.s	loc_202F88
	cmpi.w	#$FF00,d1
	bgt.s	loc_202F54
	andi.w	#$7FF,d1
	andi.w	#$7FF,$C(a6)
	andi.w	#$7FF,scroll_fg_y
	andi.w	#$3FF,scroll_bg_y
	bra.s	loc_202F88

; ------------------------------------------------------------------------------

loc_202F54:
	move.w	top_bound,d1
	bra.s	loc_202F88

; ------------------------------------------------------------------------------

loc_202F5A:
	ext.l	d1
	asl.l	#8,d1
	add.l	scroll_fg_y,d1
	swap	d1

loc_202F64:
	cmp.w	bottom_bound,d1
	blt.s	loc_202F88
	subi.w	#$800,d1
	bcs.s	loc_202F84
	andi.w	#$7FF,$C(a6)
	subi.w	#$800,scroll_fg_y
	andi.w	#$3FF,scroll_bg_y
	bra.s	loc_202F88

; ------------------------------------------------------------------------------

loc_202F84:
	move.w	bottom_bound,d1

loc_202F88:
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
	bne.s	locret_202FCA
	eori.b	#$10,scroll_cross_y
	move.w	scroll_fg_y,d0
	sub.w	d4,d0
	bpl.s	loc_202FC4
	bset	#0,scroll_flags_fg
	rts

; ------------------------------------------------------------------------------

loc_202FC4:
	bset	#1,scroll_flags_fg

locret_202FCA:
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
	bne.s	loc_203000
	eori.b	#$10,scroll_cross_bg_x
	sub.l	d2,d0
	bpl.s	loc_202FFA
	bset	#2,scroll_flags_bg
	bra.s	loc_203000

; ------------------------------------------------------------------------------

loc_202FFA:
	bset	#3,scroll_flags_bg

loc_203000:
	move.l	scroll_bg_y,d3
	move.l	d3,d0
	add.l	d5,d0
	move.l	d0,scroll_bg_y
	move.l	d0,d1
	swap	d1
	andi.w	#$10,d1
	move.b	scroll_cross_bg_y,d2
	eor.b	d2,d1
	bne.s	locret_203034
	eori.b	#$10,scroll_cross_bg_y
	sub.l	d3,d0
	bpl.s	loc_20302E
	bset	#0,scroll_flags_bg
	rts

; ------------------------------------------------------------------------------

loc_20302E:
	bset	#1,scroll_flags_bg

locret_203034:
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
	bne.s	locret_20306A
	eori.b	#$10,scroll_cross_bg_y
	sub.l	d3,d0
	bpl.s	loc_203064
	bset	#4,scroll_flags_bg
	rts

; ------------------------------------------------------------------------------

loc_203064:
	bset	#5,scroll_flags_bg

locret_20306A:
	rts

; ------------------------------------------------------------------------------

ScrollBgY:
	move.w	scroll_bg_y,d3
	move.w	d0,scroll_bg_y
	move.w	d0,d1
	andi.w	#$10,d1
	move.b	scroll_cross_bg_y,d2
	eor.b	d2,d1
	bne.s	locret_20309A
	eori.b	#$10,scroll_cross_bg_y
	sub.w	d3,d0
	bpl.s	loc_203094
	bset	#0,scroll_flags_bg
	rts

; ------------------------------------------------------------------------------

loc_203094:
	bset	#1,scroll_flags_bg

locret_20309A:
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
	bne.s	locret_2030CE
	eori.b	#$10,scroll_cross_bg_x
	sub.l	d2,d0
	bpl.s	loc_2030C8
	bset	d6,scroll_flags_bg
	bra.s	locret_2030CE

; ------------------------------------------------------------------------------

loc_2030C8:
	addq.b	#1,d6
	bset	d6,scroll_flags_bg

locret_2030CE:
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
	bne.s	locret_203102
	eori.b	#$10,scroll_cross_bg2_x
	sub.l	d2,d0
	bpl.s	loc_2030FC
	bset	d6,scroll_flags_bg2
	bra.s	locret_203102

; ------------------------------------------------------------------------------

loc_2030FC:
	addq.b	#1,d6
	bset	d6,scroll_flags_bg2

locret_203102:
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
	bne.s	locret_203136
	eori.b	#$10,scroll_cross_bg3_x
	sub.l	d2,d0
	bpl.s	loc_203130
	bset	d6,scroll_flags_bg3
	bra.s	locret_203136

; ------------------------------------------------------------------------------

loc_203130:
	addq.b	#1,d6
	bset	d6,scroll_flags_bg3

locret_203136:
	rts

; ------------------------------------------------------------------------------
