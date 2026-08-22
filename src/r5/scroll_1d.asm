; ------------------------------------------------------------------------------

GetPlayerObject:
	lea	player_object,a6
	tst.b	use_player_2
	beq.s	locret_2029D0
	lea	player_object_2,a6

locret_2029D0:
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
	lea	unk_202A2E,a0
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
	bra.w	loc_202A5A

; ------------------------------------------------------------------------------

unk_202A2E:
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

unk_202A3A:
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

loc_202A5A:
	tst.b	spawn_mode
	beq.s	loc_202A7A
	jsr	LoadCheckpoint
	moveq	#0,d0
	moveq	#0,d1
	move.w	8(a6),d1
	move.w	$C(a6),d0
	bpl.s	loc_202A78
	moveq	#0,d0

loc_202A78:
	bra.s	loc_202AB6

; ------------------------------------------------------------------------------

loc_202A7A:
	lea	StagePlayerSpawn,a1
	tst.w	stage_demo
	bpl.s	loc_202A9C
	move.w	s1_credits_index,d0
	subq.w	#1,d0
	lsl.w	#2,d0
	lea	unk_202A3A,a1
	adda.w	d0,a1
	bra.s	loc_202AA6

; ------------------------------------------------------------------------------

loc_202A9C:
	move.w	stage_demo,d0
	lsl.w	#2,d0
	adda.w	d0,a1

loc_202AA6:
	moveq	#0,d1
	move.w	(a1)+,d1
	move.w	d1,8(a6)
	moveq	#0,d0
	move.w	(a1),d0
	move.w	d0,$C(a6)

loc_202AB6:
	subi.w	#$A0,d1
	bcc.s	loc_202ABE
	moveq	#0,d1

loc_202ABE:
	move.w	right_bound,d2
	cmp.w	d2,d1
	bcs.s	loc_202AC8
	move.w	d2,d1

loc_202AC8:
	move.w	d1,scroll_fg_x
	subi.w	#$60,d0
	bcc.s	loc_202AD4
	moveq	#0,d0

loc_202AD4:
	cmp.w	bottom_bound,d0
	blt.s	loc_202ADE
	move.w	bottom_bound,d0

loc_202ADE:
	move.w	d0,scroll_fg_y
	bsr.w	sub_202AFA
	lea	unk_202AF6,a1
	move.l	(a1),loop_chunk_1
	rts

; ------------------------------------------------------------------------------

StagePlayerSpawn:
	incbin	"src/maps/r5/spawn_1d.bin"
	even

unk_202AF6:
	dc.b	$7F
	dc.b	$7F
	dc.b	$18
	dc.b	$62

; ------------------------------------------------------------------------------

sub_202AFA:
	swap	d0
	lsr.l	#3,d0
	move.l	d0,d2
	lsr.l	#2,d2
	add.l	d2,d0
	add.l	d2,d2
	add.l	d2,d0
	move.l	d0,scroll_bg_y
	swap	d0
	move.w	d0,scroll_bg2_y
	move.w	d0,scroll_bg3_y
	lsr.l	#1,d1
	move.w	d1,scroll_bg_x
	lsr.l	#1,d1
	move.w	d1,scroll_bg2_x
	lsr.l	#1,d1
	move.w	d1,scroll_bg3_x
	rts

; ------------------------------------------------------------------------------

UpdateScroll:
	lea	player_object,a6
	tst.b	scroll_lock
	beq.s	loc_202B36
	rts

; ------------------------------------------------------------------------------

loc_202B36:
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
	asl.l	#5,d4
	moveq	#6,d6
	bsr.w	ScrollBg3X
	move.w	scroll_x_move,d4
	ext.l	d4
	asl.l	#6,d4
	moveq	#4,d6
	bsr.w	ScrollBg2X
	lea	bg_scroll_lines,a1
	move.w	scroll_x_move,d4
	ext.l	d4
	asl.l	#7,d4
	moveq	#2,d6
	bsr.w	ScrollBgX
	move.w	scroll_fg_y,d0
	lsr.w	#3,d0
	move.w	d0,d1
	lsr.w	#2,d1
	add.w	d1,d0
	add.w	d1,d1
	add.w	d1,d0
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
	beq.w	loc_202BF4
	move.w	scroll_bg2_x,d0
	neg.w	d0
	moveq	#$A,d6

loc_202BE6:
	move.w	d0,(a1)+
	dbf	d6,loc_202BE6
	bsr.w	sub_202CD6
	bra.w	loc_202C14

; ------------------------------------------------------------------------------

loc_202BF4:
	bsr.w	sub_202C92
	move.w	scroll_bg_x,d0
	neg.w	d0
	moveq	#$B,d6

loc_202C00:
	move.w	d0,(a1)+
	dbf	d6,loc_202C00
	move.w	scroll_bg_x,d0
	neg.w	d0
	moveq	#3,d6

loc_202C0E:
	move.w	d0,(a1)+
	dbf	d6,loc_202C0E

loc_202C14:
	lea	scroll_lines,a1
	lea	bg_scroll_lines,a2
	move.w	scroll_bg_y,d0
	move.w	d0,d2
	andi.w	#$1F8,d0
	lsr.w	#2,d0
	move.w	d0,d3
	lsr.w	#1,d3
	moveq	#$27,d1
	moveq	#$1D,d5
	btst	#0,r5_bg_change
	bne.s	loc_202C44
	sub.w	d3,d1
	bcs.s	loc_202C50
	cmpi.w	#$1C,d1
	bcs.s	loc_202C46

loc_202C44:
	moveq	#$1C,d1

loc_202C46:
	sub.w	d1,d5
	lea	(a2,d0.w),a2
	bsr.w	sub_202D18

loc_202C50:
	btst	#0,r5_bg_change
	bne.w	locret_202C8C
	move.w	scroll_bg_x,d0
	move.w	scroll_fg_x,d2
	sub.w	d0,d2
	ext.l	d2
	asl.l	#8,d2
	divs.w	#$100,d2
	ext.l	d2
	asl.l	#8,d2
	moveq	#0,d3
	move.w	d0,d3
	move.w	d5,d1
	lsl.w	#3,d1
	subq.w	#1,d1

loc_202C7C:
	move.w	d3,d0
	neg.w	d0
	move.l	d0,(a1)+
	swap	d3
	add.l	d2,d3
	swap	d3
	dbf	d1,loc_202C7C

locret_202C8C:
	rts

; ------------------------------------------------------------------------------

byte_202C8E:
	dc.b	5
	dc.b	$B
	dc.b	5
	dc.b	0

; ------------------------------------------------------------------------------

sub_202C92:
	move.w	scroll_bg_x,d0
	move.w	scroll_fg_x,d2
	sub.w	d0,d2
	ext.l	d2
	moveq	#6,d1
	asl.l	d1,d2
	divu.w	#6,d2
	ext.l	d2
	moveq	#$A,d1
	asl.l	d1,d2
	move.w	scroll_bg_x,d3
	moveq	#2,d6
	adda.w	#$30,a1

loc_202CB6:
	move.w	d3,d0
	neg.w	d0
	moveq	#0,d5
	move.b	byte_202C8E(pc,d6.w),d5

loc_202CC0:
	move.w	d0,-(a1)
	dbf	d5,loc_202CC0
	swap	d3
	add.l	d2,d3
	swap	d3
	dbf	d6,loc_202CB6
	adda.w	#$30,a1
	rts

; ------------------------------------------------------------------------------

sub_202CD6:
	move.w	scroll_bg2_x,d0
	move.w	scroll_fg_x,d2
	sub.w	d0,d2
	ext.l	d2
	moveq	#7,d1
	asl.l	d1,d2
	divu.w	#$C,d2
	ext.l	d2
	moveq	#9,d1
	asl.l	d1,d2
	move.w	scroll_bg2_x,d3
	moveq	#5,d6

loc_202CF6:
	move.w	d3,d0
	neg.w	d0
	moveq	#0,d5
	move.b	byte_202D12(pc,d6.w),d5

loc_202D00:
	move.w	d0,(a1)+
	dbf	d5,loc_202D00
	swap	d3
	add.l	d2,d3
	swap	d3
	dbf	d6,loc_202CF6
	rts

; ------------------------------------------------------------------------------

byte_202D12:
	dc.b	$D
	dc.b	7
	dc.b	5
	dc.b	3
	dc.b	3
	dc.b	0

; ------------------------------------------------------------------------------

sub_202D18:
	andi.w	#7,d2
	add.w	d2,d2
	move.w	(a2)+,d0
	jmp	loc_202D26(pc,d2.w)

; ------------------------------------------------------------------------------

loc_202D24:
	move.w	(a2)+,d0

loc_202D26:
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	dbf	d1,loc_202D24
	rts

; ------------------------------------------------------------------------------

ScrollFgX:
	move.w	scroll_fg_x,d4
	bsr.s	CheckScrollFgX
	move.w	scroll_fg_x,d0
	andi.w	#$10,d0
	move.b	scroll_cross_x,d1
	eor.b	d1,d0
	bne.s	locret_202D6E
	eori.b	#$10,scroll_cross_x
	move.w	scroll_fg_x,d0
	sub.w	d4,d0
	bpl.s	loc_202D68
	bset	#2,scroll_flags_fg
	rts

; ------------------------------------------------------------------------------

loc_202D68:
	bset	#3,scroll_flags_fg

locret_202D6E:
	rts

; ------------------------------------------------------------------------------

CheckScrollFgX:
	move.w	8(a6),d0
	sub.w	scroll_fg_x,d0
	sub.w	scroll_focus_x,d0
	beq.s	loc_202D82
	bcs.s	loc_202DB2
	bra.s	loc_202D88

; ------------------------------------------------------------------------------

loc_202D82:
	clr.w	scroll_x_move
	rts

; ------------------------------------------------------------------------------

loc_202D88:
	cmpi.w	#$10,d0
	blt.s	loc_202D92
	move.w	#$10,d0

loc_202D92:
	add.w	scroll_fg_x,d0
	cmp.w	right_bound,d0
	blt.s	loc_202DA0
	move.w	right_bound,d0

loc_202DA0:
	move.w	d0,d1
	sub.w	scroll_fg_x,d1
	asl.w	#8,d1
	move.w	d0,scroll_fg_x
	move.w	d1,scroll_x_move
	rts

; ------------------------------------------------------------------------------

loc_202DB2:
	cmpi.w	#$FFF0,d0
	bge.s	loc_202DBC
	move.w	#$FFF0,d0

loc_202DBC:
	add.w	scroll_fg_x,d0
	cmp.w	left_bound,d0
	bgt.s	loc_202DA0
	move.w	left_bound,d0
	bra.s	loc_202DA0

; ------------------------------------------------------------------------------

ScrollFgXSlow:
	tst.w	d0
	bpl.s	loc_202DD6
	move.w	#$FFFE,d0
	bra.s	loc_202DB2

; ------------------------------------------------------------------------------

loc_202DD6:
	move.w	#2,d0
	bra.s	loc_202D88

; ------------------------------------------------------------------------------

ScrollFgY:
	moveq	#0,d1
	move.w	$C(a6),d0
	sub.w	scroll_fg_y,d0
	btst	#2,$22(a6)
	beq.s	loc_202DF0
	subq.w	#5,d0

loc_202DF0:
	btst	#1,$22(a6)
	beq.s	loc_202E10
	addi.w	#$20,d0
	sub.w	scroll_focus_y,d0
	bcs.s	loc_202E5C
	subi.w	#$40,d0
	bcc.s	loc_202E5C
	tst.b	bottom_bound_shift
	bne.s	loc_202E6E
	bra.s	loc_202E1C

; ------------------------------------------------------------------------------

loc_202E10:
	sub.w	scroll_focus_y,d0
	bne.s	loc_202E22
	tst.b	bottom_bound_shift
	bne.s	loc_202E6E

loc_202E1C:
	clr.w	scroll_y_move
	rts

; ------------------------------------------------------------------------------

loc_202E22:
	cmpi.w	#$60,scroll_focus_y
	bne.s	loc_202E4A
	move.w	$14(a6),d1
	bpl.s	loc_202E32
	neg.w	d1

loc_202E32:
	cmpi.w	#$800,d1
	bcc.s	loc_202E5C
	move.w	#$600,d1
	cmpi.w	#6,d0
	bgt.s	loc_202EBC
	cmpi.w	#$FFFA,d0
	blt.s	loc_202E86
	bra.s	loc_202E74

; ------------------------------------------------------------------------------

loc_202E4A:
	move.w	#$200,d1
	cmpi.w	#2,d0
	bgt.s	loc_202EBC
	cmpi.w	#$FFFE,d0
	blt.s	loc_202E86
	bra.s	loc_202E74

; ------------------------------------------------------------------------------

loc_202E5C:
	move.w	#$1000,d1
	cmpi.w	#$10,d0
	bgt.s	loc_202EBC
	cmpi.w	#$FFF0,d0
	blt.s	loc_202E86
	bra.s	loc_202E74

; ------------------------------------------------------------------------------

loc_202E6E:
	moveq	#0,d0
	move.b	d0,bottom_bound_shift

loc_202E74:
	moveq	#0,d1
	move.w	d0,d1
	add.w	scroll_fg_y,d1
	tst.w	d0
	bpl.w	loc_202EC6
	bra.w	loc_202E92

; ------------------------------------------------------------------------------

loc_202E86:
	neg.w	d1
	ext.l	d1
	asl.l	#8,d1
	add.l	scroll_fg_y,d1
	swap	d1

loc_202E92:
	cmp.w	top_bound,d1
	bgt.s	loc_202EEA
	cmpi.w	#$FF00,d1
	bgt.s	loc_202EB6
	andi.w	#$7FF,d1
	andi.w	#$7FF,$C(a6)
	andi.w	#$7FF,scroll_fg_y
	andi.w	#$3FF,scroll_bg_y
	bra.s	loc_202EEA

; ------------------------------------------------------------------------------

loc_202EB6:
	move.w	top_bound,d1
	bra.s	loc_202EEA

; ------------------------------------------------------------------------------

loc_202EBC:
	ext.l	d1
	asl.l	#8,d1
	add.l	scroll_fg_y,d1
	swap	d1

loc_202EC6:
	cmp.w	bottom_bound,d1
	blt.s	loc_202EEA
	subi.w	#$800,d1
	bcs.s	loc_202EE6
	andi.w	#$7FF,$C(a6)
	subi.w	#$800,scroll_fg_y
	andi.w	#$3FF,scroll_bg_y
	bra.s	loc_202EEA

; ------------------------------------------------------------------------------

loc_202EE6:
	move.w	bottom_bound,d1

loc_202EEA:
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
	bne.s	locret_202F2C
	eori.b	#$10,scroll_cross_y
	move.w	scroll_fg_y,d0
	sub.w	d4,d0
	bpl.s	loc_202F26
	bset	#0,scroll_flags_fg
	rts

; ------------------------------------------------------------------------------

loc_202F26:
	bset	#1,scroll_flags_fg

locret_202F2C:
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
	bne.s	loc_202F62
	eori.b	#$10,scroll_cross_bg_x
	sub.l	d2,d0
	bpl.s	loc_202F5C
	bset	#2,scroll_flags_bg
	bra.s	loc_202F62

; ------------------------------------------------------------------------------

loc_202F5C:
	bset	#3,scroll_flags_bg

loc_202F62:
	move.l	scroll_bg_y,d3
	move.l	d3,d0
	add.l	d5,d0
	move.l	d0,scroll_bg_y
	move.l	d0,d1
	swap	d1
	andi.w	#$10,d1
	move.b	scroll_cross_bg_y,d2
	eor.b	d2,d1
	bne.s	locret_202F96
	eori.b	#$10,scroll_cross_bg_y
	sub.l	d3,d0
	bpl.s	loc_202F90
	bset	#0,scroll_flags_bg
	rts

; ------------------------------------------------------------------------------

loc_202F90:
	bset	#1,scroll_flags_bg

locret_202F96:
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
	bne.s	locret_202FCC
	eori.b	#$10,scroll_cross_bg_y
	sub.l	d3,d0
	bpl.s	loc_202FC6
	bset	#4,scroll_flags_bg
	rts

; ------------------------------------------------------------------------------

loc_202FC6:
	bset	#5,scroll_flags_bg

locret_202FCC:
	rts

; ------------------------------------------------------------------------------

ScrollBgY:
	move.w	scroll_bg_y,d3
	move.w	d0,scroll_bg_y
	move.w	d0,d1
	andi.w	#$10,d1
	move.b	scroll_cross_bg_y,d2
	eor.b	d2,d1
	bne.s	locret_202FFC
	eori.b	#$10,scroll_cross_bg_y
	sub.w	d3,d0
	bpl.s	loc_202FF6
	bset	#0,scroll_flags_bg
	rts

; ------------------------------------------------------------------------------

loc_202FF6:
	bset	#1,scroll_flags_bg

locret_202FFC:
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
	bne.s	locret_203030
	eori.b	#$10,scroll_cross_bg_x
	sub.l	d2,d0
	bpl.s	loc_20302A
	bset	d6,scroll_flags_bg
	bra.s	locret_203030

; ------------------------------------------------------------------------------

loc_20302A:
	addq.b	#1,d6
	bset	d6,scroll_flags_bg

locret_203030:
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
	bne.s	locret_203064
	eori.b	#$10,scroll_cross_bg2_x
	sub.l	d2,d0
	bpl.s	loc_20305E
	bset	d6,scroll_flags_bg2
	bra.s	locret_203064

; ------------------------------------------------------------------------------

loc_20305E:
	addq.b	#1,d6
	bset	d6,scroll_flags_bg2

locret_203064:
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
	bne.s	locret_203098
	eori.b	#$10,scroll_cross_bg3_x
	sub.l	d2,d0
	bpl.s	loc_203092
	bset	d6,scroll_flags_bg3
	bra.s	locret_203098

; ------------------------------------------------------------------------------

loc_203092:
	addq.b	#1,d6
	bset	d6,scroll_flags_bg3

locret_203098:
	rts

; ------------------------------------------------------------------------------
