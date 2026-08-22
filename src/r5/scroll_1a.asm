; ------------------------------------------------------------------------------

GetPlayerObject:
	lea	player_object,a6
	tst.b	use_player_2
	beq.s	locret_2029E0
	lea	player_object_2,a6

locret_2029E0:
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
	lea	unk_202A3E,a0
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
	bra.w	loc_202A6A

; ------------------------------------------------------------------------------

unk_202A3E:
	dc.b	0
	dc.b	4
	dc.b	0
	dc.b	0
	dc.b	$2A
	dc.b	$97
	dc.b	0
	dc.b	0
	dc.b	3
	dc.b	$10
	dc.b	0
	dc.b	$60

unk_202A4A:
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

loc_202A6A:
	tst.b	spawn_mode
	beq.s	loc_202A8A
	jsr	LoadCheckpoint
	moveq	#0,d0
	moveq	#0,d1
	move.w	8(a6),d1
	move.w	$C(a6),d0
	bpl.s	loc_202A88
	moveq	#0,d0

loc_202A88:
	bra.s	loc_202AC6

; ------------------------------------------------------------------------------

loc_202A8A:
	lea	StagePlayerSpawn,a1
	tst.w	stage_demo
	bpl.s	loc_202AAC
	move.w	s1_credits_index,d0
	subq.w	#1,d0
	lsl.w	#2,d0
	lea	unk_202A4A,a1
	adda.w	d0,a1
	bra.s	loc_202AB6

; ------------------------------------------------------------------------------

loc_202AAC:
	move.w	stage_demo,d0
	lsl.w	#2,d0
	adda.w	d0,a1

loc_202AB6:
	moveq	#0,d1
	move.w	(a1)+,d1
	move.w	d1,8(a6)
	moveq	#0,d0
	move.w	(a1),d0
	move.w	d0,$C(a6)

loc_202AC6:
	subi.w	#$A0,d1
	bcc.s	loc_202ACE
	moveq	#0,d1

loc_202ACE:
	move.w	right_bound,d2
	cmp.w	d2,d1
	bcs.s	loc_202AD8
	move.w	d2,d1

loc_202AD8:
	move.w	d1,scroll_fg_x
	subi.w	#$60,d0
	bcc.s	loc_202AE4
	moveq	#0,d0

loc_202AE4:
	cmp.w	bottom_bound,d0
	blt.s	loc_202AEE
	move.w	bottom_bound,d0

loc_202AEE:
	move.w	d0,scroll_fg_y
	bsr.w	InitBgScroll
	lea	unk_202B06,a1
	move.l	(a1),loop_chunk_1
	rts

; ------------------------------------------------------------------------------

StagePlayerSpawn:
	incbin	"src/maps/r5/spawn_1a.bin"
	even

unk_202B06:
	dc.b	$7F
	dc.b	$7F
	dc.b	$15
	dc.b	$5B

; ------------------------------------------------------------------------------

InitBgScroll:
	swap	d0
	btst	#0,r5_bg_change
	beq.s	loc_202B1A
	lsr.l	#2,d0
	bra.s	loc_202B26

; ------------------------------------------------------------------------------

loc_202B1A:
	lsr.l	#1,d0
	move.l	d0,d2
	lsr.l	#2,d2
	add.l	d2,d0
	lsr.l	#1,d2
	add.l	d2,d0

loc_202B26:
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
	beq.s	loc_202B58
	rts

; ------------------------------------------------------------------------------

loc_202B58:
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
	beq.s	loc_202BC6
	lsr.w	#2,d0
	bra.s	loc_202BD2

; ------------------------------------------------------------------------------

loc_202BC6:
	lsr.w	#1,d0
	move.w	d0,d2
	lsr.w	#2,d2
	add.w	d2,d0
	lsr.w	#2,d2
	add.w	d2,d0

loc_202BD2:
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
	beq.s	loc_202C1E
	bsr.w	sub_202CF2
	bsr.w	sub_202D42
	bra.w	loc_202C46

; ------------------------------------------------------------------------------

loc_202C1E:
	move.w	scroll_bg_x,d0
	neg.w	d0
	move.w	#7,d6

loc_202C28:
	move.w	d0,(a1)+
	dbf	d6,loc_202C28
	bsr.w	sub_202C64
	bsr.w	sub_202CAE
	move.w	scroll_bg_x,d0
	neg.w	d0
	move.w	#7,d6

loc_202C40:
	move.w	d0,(a1)+
	dbf	d6,loc_202C40

loc_202C46:
	lea	scroll_lines,a1
	lea	bg_scroll_lines,a2
	move.w	scroll_bg_y,d0
	move.w	d0,d2
	andi.w	#$3F8,d0
	lsr.w	#2,d0
	moveq	#$1C,d1
	lea	(a2,d0.w),a2
	bra.w	loc_202D82

; ------------------------------------------------------------------------------

sub_202C64:
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

loc_202C88:
	move.w	d3,d0
	neg.w	d0
	moveq	#0,d5
	move.b	byte_202CA8(pc,d6.w),d5

loc_202C92:
	move.w	d0,-(a1)
	dbf	d5,loc_202C92
	swap	d3
	add.l	d2,d3
	swap	d3
	dbf	d6,loc_202C88
	adda.w	#$44,a1
	rts

; ------------------------------------------------------------------------------

byte_202CA8:
	dc.b	$D
	dc.b	$B
	dc.b	1
	dc.b	1
	dc.b	1
	dc.b	1

; ------------------------------------------------------------------------------

sub_202CAE:
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

loc_202CCE:
	move.w	d3,d0
	neg.w	d0
	moveq	#0,d5
	move.b	byte_202CEA(pc,d6.w),d5

loc_202CD8:
	move.w	d0,(a1)+
	dbf	d5,loc_202CD8
	swap	d3
	add.l	d2,d3
	swap	d3
	dbf	d6,loc_202CCE
	rts

; ------------------------------------------------------------------------------

byte_202CEA:
	dc.b	$F
	dc.b	$13
	dc.b	1
	dc.b	1
	dc.b	1
	dc.b	1
	dc.b	1
	dc.b	0

; ------------------------------------------------------------------------------

sub_202CF2:
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

loc_202D16:
	move.w	d3,d0
	neg.w	d0
	moveq	#0,d5
	move.b	byte_202D36(pc,d6.w),d5

loc_202D20:
	move.w	d0,-(a1)
	dbf	d5,loc_202D20
	swap	d3
	add.l	d2,d3
	swap	d3
	dbf	d6,loc_202D16
	adda.w	#$2C,a1
	rts

; ------------------------------------------------------------------------------

byte_202D36:
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

sub_202D42:
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

loc_202D62:
	move.w	d3,d0
	neg.w	d0
	moveq	#0,d5
	move.b	byte_202D7E(pc,d6.w),d5

loc_202D6C:
	move.w	d0,(a1)+
	dbf	d5,loc_202D6C
	swap	d3
	add.l	d2,d3
	swap	d3
	dbf	d6,loc_202D62
	rts

; ------------------------------------------------------------------------------

byte_202D7E:
	dc.b	$1F
	dc.b	3
	dc.b	5
	dc.b	0

; ------------------------------------------------------------------------------

loc_202D82:
	andi.w	#7,d2
	add.w	d2,d2
	move.w	(a2)+,d0
	jmp	loc_202D90(pc,d2.w)

; ------------------------------------------------------------------------------

loc_202D8E:
	move.w	(a2)+,d0

loc_202D90:
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	dbf	d1,loc_202D8E
	rts

; ------------------------------------------------------------------------------

	neg.w	d0
	jmp	loc_202DAE(pc,d2.w)

; ------------------------------------------------------------------------------

	neg.w	d0

loc_202DAE:
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	dbf	d1,loc_202D8E
	rts

; ------------------------------------------------------------------------------

ScrollFgX:
	move.w	scroll_fg_x,d4
	bsr.s	CheckScrollFgX
	move.w	scroll_fg_x,d0
	andi.w	#$10,d0
	move.b	scroll_cross_x,d1
	eor.b	d1,d0
	bne.s	locret_202DF6
	eori.b	#$10,scroll_cross_x
	move.w	scroll_fg_x,d0
	sub.w	d4,d0
	bpl.s	loc_202DF0
	bset	#2,scroll_flags_fg
	rts

; ------------------------------------------------------------------------------

loc_202DF0:
	bset	#3,scroll_flags_fg

locret_202DF6:
	rts

; ------------------------------------------------------------------------------

CheckScrollFgX:
	move.w	8(a6),d0
	sub.w	scroll_fg_x,d0
	sub.w	scroll_focus_x,d0
	beq.s	loc_202E0A
	bcs.s	loc_202E3A
	bra.s	loc_202E10

; ------------------------------------------------------------------------------

loc_202E0A:
	clr.w	scroll_x_move
	rts

; ------------------------------------------------------------------------------

loc_202E10:
	cmpi.w	#$10,d0
	blt.s	loc_202E1A
	move.w	#$10,d0

loc_202E1A:
	add.w	scroll_fg_x,d0
	cmp.w	right_bound,d0
	blt.s	loc_202E28
	move.w	right_bound,d0

loc_202E28:
	move.w	d0,d1
	sub.w	scroll_fg_x,d1
	asl.w	#8,d1
	move.w	d0,scroll_fg_x
	move.w	d1,scroll_x_move
	rts

; ------------------------------------------------------------------------------

loc_202E3A:
	cmpi.w	#$FFF0,d0
	bge.s	loc_202E44
	move.w	#$FFF0,d0

loc_202E44:
	add.w	scroll_fg_x,d0
	cmp.w	left_bound,d0
	bgt.s	loc_202E28
	move.w	left_bound,d0
	bra.s	loc_202E28

; ------------------------------------------------------------------------------

ScrollFgXSlow:
	tst.w	d0
	bpl.s	loc_202E5E
	move.w	#$FFFE,d0
	bra.s	loc_202E3A

; ------------------------------------------------------------------------------

loc_202E5E:
	move.w	#2,d0
	bra.s	loc_202E10

; ------------------------------------------------------------------------------

ScrollFgY:
	moveq	#0,d1
	move.w	$C(a6),d0
	sub.w	scroll_fg_y,d0
	btst	#2,$22(a6)
	beq.s	loc_202E78
	subq.w	#5,d0

loc_202E78:
	btst	#1,$22(a6)
	beq.s	loc_202E98
	addi.w	#$20,d0
	sub.w	scroll_focus_y,d0
	bcs.s	loc_202EE4
	subi.w	#$40,d0
	bcc.s	loc_202EE4
	tst.b	bottom_bound_shift
	bne.s	loc_202EF6
	bra.s	loc_202EA4

; ------------------------------------------------------------------------------

loc_202E98:
	sub.w	scroll_focus_y,d0
	bne.s	loc_202EAA
	tst.b	bottom_bound_shift
	bne.s	loc_202EF6

loc_202EA4:
	clr.w	scroll_y_move
	rts

; ------------------------------------------------------------------------------

loc_202EAA:
	cmpi.w	#$60,scroll_focus_y
	bne.s	loc_202ED2
	move.w	$14(a6),d1
	bpl.s	loc_202EBA
	neg.w	d1

loc_202EBA:
	cmpi.w	#$800,d1
	bcc.s	loc_202EE4
	move.w	#$600,d1
	cmpi.w	#6,d0
	bgt.s	loc_202F44
	cmpi.w	#$FFFA,d0
	blt.s	loc_202F0E
	bra.s	loc_202EFC

; ------------------------------------------------------------------------------

loc_202ED2:
	move.w	#$200,d1
	cmpi.w	#2,d0
	bgt.s	loc_202F44
	cmpi.w	#$FFFE,d0
	blt.s	loc_202F0E
	bra.s	loc_202EFC

; ------------------------------------------------------------------------------

loc_202EE4:
	move.w	#$1000,d1
	cmpi.w	#$10,d0
	bgt.s	loc_202F44
	cmpi.w	#$FFF0,d0
	blt.s	loc_202F0E
	bra.s	loc_202EFC

; ------------------------------------------------------------------------------

loc_202EF6:
	moveq	#0,d0
	move.b	d0,bottom_bound_shift

loc_202EFC:
	moveq	#0,d1
	move.w	d0,d1
	add.w	scroll_fg_y,d1
	tst.w	d0
	bpl.w	loc_202F4E
	bra.w	loc_202F1A

; ------------------------------------------------------------------------------

loc_202F0E:
	neg.w	d1
	ext.l	d1
	asl.l	#8,d1
	add.l	scroll_fg_y,d1
	swap	d1

loc_202F1A:
	cmp.w	top_bound,d1
	bgt.s	loc_202F72
	cmpi.w	#$FF00,d1
	bgt.s	loc_202F3E
	andi.w	#$7FF,d1
	andi.w	#$7FF,$C(a6)
	andi.w	#$7FF,scroll_fg_y
	andi.w	#$3FF,scroll_bg_y
	bra.s	loc_202F72

; ------------------------------------------------------------------------------

loc_202F3E:
	move.w	top_bound,d1
	bra.s	loc_202F72

; ------------------------------------------------------------------------------

loc_202F44:
	ext.l	d1
	asl.l	#8,d1
	add.l	scroll_fg_y,d1
	swap	d1

loc_202F4E:
	cmp.w	bottom_bound,d1
	blt.s	loc_202F72
	subi.w	#$800,d1
	bcs.s	loc_202F6E
	andi.w	#$7FF,$C(a6)
	subi.w	#$800,scroll_fg_y
	andi.w	#$3FF,scroll_bg_y
	bra.s	loc_202F72

; ------------------------------------------------------------------------------

loc_202F6E:
	move.w	bottom_bound,d1

loc_202F72:
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
	bne.s	locret_202FB4
	eori.b	#$10,scroll_cross_y
	move.w	scroll_fg_y,d0
	sub.w	d4,d0
	bpl.s	loc_202FAE
	bset	#0,scroll_flags_fg
	rts

; ------------------------------------------------------------------------------

loc_202FAE:
	bset	#1,scroll_flags_fg

locret_202FB4:
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
	bne.s	loc_202FEA
	eori.b	#$10,scroll_cross_bg_x
	sub.l	d2,d0
	bpl.s	loc_202FE4
	bset	#2,scroll_flags_bg
	bra.s	loc_202FEA

; ------------------------------------------------------------------------------

loc_202FE4:
	bset	#3,scroll_flags_bg

loc_202FEA:
	move.l	scroll_bg_y,d3
	move.l	d3,d0
	add.l	d5,d0
	move.l	d0,scroll_bg_y
	move.l	d0,d1
	swap	d1
	andi.w	#$10,d1
	move.b	scroll_cross_bg_y,d2
	eor.b	d2,d1
	bne.s	locret_20301E
	eori.b	#$10,scroll_cross_bg_y
	sub.l	d3,d0
	bpl.s	loc_203018
	bset	#0,scroll_flags_bg
	rts

; ------------------------------------------------------------------------------

loc_203018:
	bset	#1,scroll_flags_bg

locret_20301E:
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
	bne.s	locret_203054
	eori.b	#$10,scroll_cross_bg_y
	sub.l	d3,d0
	bpl.s	loc_20304E
	bset	#4,scroll_flags_bg
	rts

; ------------------------------------------------------------------------------

loc_20304E:
	bset	#5,scroll_flags_bg

locret_203054:
	rts

; ------------------------------------------------------------------------------

ScrollBgY:
	move.w	scroll_bg_y,d3
	move.w	d0,scroll_bg_y
	move.w	d0,d1
	andi.w	#$10,d1
	move.b	scroll_cross_bg_y,d2
	eor.b	d2,d1
	bne.s	locret_203084
	eori.b	#$10,scroll_cross_bg_y
	sub.w	d3,d0
	bpl.s	loc_20307E
	bset	#0,scroll_flags_bg
	rts

; ------------------------------------------------------------------------------

loc_20307E:
	bset	#1,scroll_flags_bg

locret_203084:
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
	bne.s	locret_2030B8
	eori.b	#$10,scroll_cross_bg_x
	sub.l	d2,d0
	bpl.s	loc_2030B2
	bset	d6,scroll_flags_bg
	bra.s	locret_2030B8

; ------------------------------------------------------------------------------

loc_2030B2:
	addq.b	#1,d6
	bset	d6,scroll_flags_bg

locret_2030B8:
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
	bne.s	locret_2030EC
	eori.b	#$10,scroll_cross_bg2_x
	sub.l	d2,d0
	bpl.s	loc_2030E6
	bset	d6,scroll_flags_bg2
	bra.s	locret_2030EC

; ------------------------------------------------------------------------------

loc_2030E6:
	addq.b	#1,d6
	bset	d6,scroll_flags_bg2

locret_2030EC:
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
	bne.s	locret_203120
	eori.b	#$10,scroll_cross_bg3_x
	sub.l	d2,d0
	bpl.s	loc_20311A
	bset	d6,scroll_flags_bg3
	bra.s	locret_203120

; ------------------------------------------------------------------------------

loc_20311A:
	addq.b	#1,d6
	bset	d6,scroll_flags_bg3

locret_203120:
	rts

; ------------------------------------------------------------------------------
