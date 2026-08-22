; ------------------------------------------------------------------------------

GetPlayerObject:
	lea	player_object,a6
	tst.b	use_player_2
	beq.s	locret_2028AE
	lea	player_object_2,a6

locret_2028AE:
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
	lea	unk_20290C,a0
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
	bra.w	loc_202938

; ------------------------------------------------------------------------------

unk_20290C:
	dc.b	0
	dc.b	4
	dc.b	0
	dc.b	0
	dc.b	$28
	dc.b	$97
	dc.b	0
	dc.b	0
	dc.b	3
	dc.b	$10
	dc.b	0
	dc.b	$60

unk_202918:
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

loc_202938:
	tst.b	spawn_mode
	beq.s	loc_202958
	jsr	LoadCheckpoint
	moveq	#0,d0
	moveq	#0,d1
	move.w	8(a6),d1
	move.w	$C(a6),d0
	bpl.s	loc_202956
	moveq	#0,d0

loc_202956:
	bra.s	loc_202994

; ------------------------------------------------------------------------------

loc_202958:
	lea	StagePlayerSpawn,a1
	tst.w	stage_demo
	bpl.s	loc_20297A
	move.w	s1_credits_index,d0
	subq.w	#1,d0
	lsl.w	#2,d0
	lea	unk_202918,a1
	adda.w	d0,a1
	bra.s	loc_202984

; ------------------------------------------------------------------------------

loc_20297A:
	move.w	stage_demo,d0
	lsl.w	#2,d0
	adda.w	d0,a1

loc_202984:
	moveq	#0,d1
	move.w	(a1)+,d1
	move.w	d1,8(a6)
	moveq	#0,d0
	move.w	(a1),d0
	move.w	d0,$C(a6)

loc_202994:
	subi.w	#$A0,d1
	bcc.s	loc_20299C
	moveq	#0,d1

loc_20299C:
	move.w	right_bound,d2
	cmp.w	d2,d1
	bcs.s	loc_2029A6
	move.w	d2,d1

loc_2029A6:
	move.w	d1,scroll_fg_x
	subi.w	#$60,d0
	bcc.s	loc_2029B2
	moveq	#0,d0

loc_2029B2:
	cmp.w	bottom_bound,d0
	blt.s	loc_2029BC
	move.w	bottom_bound,d0

loc_2029BC:
	move.w	d0,scroll_fg_y
	bsr.w	sub_2029D8
	lea	unk_2029D4,a1
	move.l	(a1),loop_chunk_1
	rts

; ------------------------------------------------------------------------------

StagePlayerSpawn:
	incbin	"src/maps/r1/spawn_2b.bin"
	even

unk_2029D4:
	dc.b	$91
	dc.b	$B6
	dc.b	$7F
	dc.b	$7F

; ------------------------------------------------------------------------------

sub_2029D8:
	swap	d0
	asr.l	#4,d0
	move.l	d0,d2
	add.l	d2,d2
	add.l	d2,d0
	move.l	d0,scroll_bg_y
	swap	d0
	move.w	d0,scroll_bg2_y
	move.w	d0,scroll_bg3_y
	lsr.w	#1,d1
	move.w	d1,scroll_bg_x
	lsr.w	#2,d1
	move.w	d1,scroll_bg3_x
	lsr.w	#1,d1
	move.w	d1,d2
	add.w	d2,d2
	add.w	d2,d1
	move.w	d1,scroll_bg2_x
	lea	bg_scroll_lines,a2
	clr.l	(a2)+
	clr.l	(a2)+
	clr.l	(a2)+
	clr.l	(a2)+
	clr.l	(a2)+
	clr.l	(a2)+
	clr.l	(a2)+
	clr.l	(a2)+
	rts

; ------------------------------------------------------------------------------

UpdateScroll:
	lea	player_object,a6
	tst.b	scroll_lock
	beq.s	loc_202A2A
	rts

; ------------------------------------------------------------------------------

loc_202A2A:
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
	asl.l	#4,d4
	move.l	d4,d3
	add.l	d3,d3
	add.l	d3,d4
	moveq	#4,d6
	bsr.w	ScrollBg2X
	lea	bg_scroll_lines+$20,a1
	move.w	scroll_x_move,d4
	ext.l	d4
	asl.l	#7,d4
	move.w	scroll_y_move,d5
	ext.l	d5
	asl.l	#4,d5
	move.l	d5,d3
	add.l	d5,d5
	add.l	d3,d5
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
	addi.l	#$10000,(a2)+
	addi.l	#$E000,(a2)+
	addi.l	#$C000,(a2)+
	addi.l	#$A000,(a2)+
	addi.l	#$8000,(a2)+
	addi.l	#$6000,(a2)+
	addi.l	#$5000,(a2)+
	addi.l	#$4000,(a2)+
	move.w	scroll_fg_x,d0
	neg.w	d0
	swap	d0
	lea	bg_scroll_lines,a2
	moveq	#7,d6

loc_202AFA:
	move.l	(a2)+,d1
	swap	d1
	add.w	scroll_bg3_x,d1
	neg.w	d1
	moveq	#0,d5
	lea	unk_202B68,a3
	move.b	(a3,d6.w),d5

loc_202B10:
	move.w	d1,(a1)+
	dbf	d5,loc_202B10
	dbf	d6,loc_202AFA
	move.w	#7,d1
	move.w	scroll_bg3_x,d0
	neg.w	d0

loc_202B24:
	move.w	d0,(a1)+
	dbf	d1,loc_202B24
	move.w	#7,d1
	move.w	scroll_bg2_x,d0
	neg.w	d0

loc_202B34:
	move.w	d0,(a1)+
	dbf	d1,loc_202B34
	move.w	#$1F,d1
	move.w	scroll_bg2_x,d0
	neg.w	d0

loc_202B44:
	move.w	d0,(a1)+
	dbf	d1,loc_202B44
	lea	scroll_lines,a1
	lea	bg_scroll_lines+$20,a2
	move.w	scroll_bg_y,d0
	move.w	d0,d2
	andi.w	#$1F8,d0
	lsr.w	#2,d0
	moveq	#$1D,d1
	lea	(a2,d0.w),a2
	bra.w	loc_202B70

; ------------------------------------------------------------------------------

unk_202B68:
	dc.b	1
	dc.b	1
	dc.b	1
	dc.b	1
	dc.b	1
	dc.b	1
	dc.b	1
	dc.b	1

; ------------------------------------------------------------------------------

loc_202B70:
	andi.w	#7,d2
	add.w	d2,d2
	move.w	(a2)+,d0
	jmp	loc_202B7E(pc,d2.w)

; ------------------------------------------------------------------------------

loc_202B7C:
	move.w	(a2)+,d0

loc_202B7E:
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	dbf	d1,loc_202B7C
	rts

; ------------------------------------------------------------------------------

ScrollFgX:
	move.w	scroll_fg_x,d4
	bsr.s	CheckScrollFgX
	move.w	scroll_fg_x,d0
	andi.w	#$10,d0
	move.b	scroll_cross_x,d1
	eor.b	d1,d0
	bne.s	locret_202BC6
	eori.b	#$10,scroll_cross_x
	move.w	scroll_fg_x,d0
	sub.w	d4,d0
	bpl.s	loc_202BC0
	bset	#2,scroll_flags_fg
	rts

; ------------------------------------------------------------------------------

loc_202BC0:
	bset	#3,scroll_flags_fg

locret_202BC6:
	rts

; ------------------------------------------------------------------------------

CheckScrollFgX:
	move.w	8(a6),d0
	sub.w	scroll_fg_x,d0
	sub.w	scroll_focus_x,d0
	beq.s	loc_202BDA
	bcs.s	loc_202C0A
	bra.s	loc_202BE0

; ------------------------------------------------------------------------------

loc_202BDA:
	clr.w	scroll_x_move
	rts

; ------------------------------------------------------------------------------

loc_202BE0:
	cmpi.w	#$10,d0
	blt.s	loc_202BEA
	move.w	#$10,d0

loc_202BEA:
	add.w	scroll_fg_x,d0
	cmp.w	right_bound,d0
	blt.s	loc_202BF8
	move.w	right_bound,d0

loc_202BF8:
	move.w	d0,d1
	sub.w	scroll_fg_x,d1
	asl.w	#8,d1
	move.w	d0,scroll_fg_x
	move.w	d1,scroll_x_move
	rts

; ------------------------------------------------------------------------------

loc_202C0A:
	cmpi.w	#$FFF0,d0
	bge.s	loc_202C14
	move.w	#$FFF0,d0

loc_202C14:
	add.w	scroll_fg_x,d0
	cmp.w	left_bound,d0
	bgt.s	loc_202BF8
	move.w	left_bound,d0
	bra.s	loc_202BF8

; ------------------------------------------------------------------------------

ScrollFgXSlow:
	tst.w	d0
	bpl.s	loc_202C2E
	move.w	#$FFFE,d0
	bra.s	loc_202C0A

; ------------------------------------------------------------------------------

loc_202C2E:
	move.w	#2,d0
	bra.s	loc_202BE0

; ------------------------------------------------------------------------------

ScrollFgY:
	moveq	#0,d1
	move.w	$C(a6),d0
	sub.w	scroll_fg_y,d0
	btst	#2,$22(a6)
	beq.s	loc_202C48
	subq.w	#5,d0

loc_202C48:
	btst	#1,$22(a6)
	beq.s	loc_202C68
	addi.w	#$20,d0
	sub.w	scroll_focus_y,d0
	bcs.s	loc_202CB4
	subi.w	#$40,d0
	bcc.s	loc_202CB4
	tst.b	bottom_bound_shift
	bne.s	loc_202CC6
	bra.s	loc_202C74

; ------------------------------------------------------------------------------

loc_202C68:
	sub.w	scroll_focus_y,d0
	bne.s	loc_202C7A
	tst.b	bottom_bound_shift
	bne.s	loc_202CC6

loc_202C74:
	clr.w	scroll_y_move
	rts

; ------------------------------------------------------------------------------

loc_202C7A:
	cmpi.w	#$60,scroll_focus_y
	bne.s	loc_202CA2
	move.w	$14(a6),d1
	bpl.s	loc_202C8A
	neg.w	d1

loc_202C8A:
	cmpi.w	#$800,d1
	bcc.s	loc_202CB4
	move.w	#$600,d1
	cmpi.w	#6,d0
	bgt.s	loc_202D14
	cmpi.w	#$FFFA,d0
	blt.s	loc_202CDE
	bra.s	loc_202CCC

; ------------------------------------------------------------------------------

loc_202CA2:
	move.w	#$200,d1
	cmpi.w	#2,d0
	bgt.s	loc_202D14
	cmpi.w	#$FFFE,d0
	blt.s	loc_202CDE
	bra.s	loc_202CCC

; ------------------------------------------------------------------------------

loc_202CB4:
	move.w	#$1000,d1
	cmpi.w	#$10,d0
	bgt.s	loc_202D14
	cmpi.w	#$FFF0,d0
	blt.s	loc_202CDE
	bra.s	loc_202CCC

; ------------------------------------------------------------------------------

loc_202CC6:
	moveq	#0,d0
	move.b	d0,bottom_bound_shift

loc_202CCC:
	moveq	#0,d1
	move.w	d0,d1
	add.w	scroll_fg_y,d1
	tst.w	d0
	bpl.w	loc_202D1E
	bra.w	loc_202CEA

; ------------------------------------------------------------------------------

loc_202CDE:
	neg.w	d1
	ext.l	d1
	asl.l	#8,d1
	add.l	scroll_fg_y,d1
	swap	d1

loc_202CEA:
	cmp.w	top_bound,d1
	bgt.s	loc_202D42
	cmpi.w	#$FF00,d1
	bgt.s	loc_202D0E
	andi.w	#$7FF,d1
	andi.w	#$7FF,$C(a6)
	andi.w	#$7FF,scroll_fg_y
	andi.w	#$3FF,scroll_bg_y
	bra.s	loc_202D42

; ------------------------------------------------------------------------------

loc_202D0E:
	move.w	top_bound,d1
	bra.s	loc_202D42

; ------------------------------------------------------------------------------

loc_202D14:
	ext.l	d1
	asl.l	#8,d1
	add.l	scroll_fg_y,d1
	swap	d1

loc_202D1E:
	cmp.w	bottom_bound,d1
	blt.s	loc_202D42
	subi.w	#$800,d1
	bcs.s	loc_202D3E
	andi.w	#$7FF,$C(a6)
	subi.w	#$800,scroll_fg_y
	andi.w	#$3FF,scroll_bg_y
	bra.s	loc_202D42

; ------------------------------------------------------------------------------

loc_202D3E:
	move.w	bottom_bound,d1

loc_202D42:
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
	bne.s	locret_202D84
	eori.b	#$10,scroll_cross_y
	move.w	scroll_fg_y,d0
	sub.w	d4,d0
	bpl.s	loc_202D7E
	bset	#0,scroll_flags_fg
	rts

; ------------------------------------------------------------------------------

loc_202D7E:
	bset	#1,scroll_flags_fg

locret_202D84:
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
	bne.s	loc_202DBA
	eori.b	#$10,scroll_cross_bg_x
	sub.l	d2,d0
	bpl.s	loc_202DB4
	bset	#2,scroll_flags_bg
	bra.s	loc_202DBA

; ------------------------------------------------------------------------------

loc_202DB4:
	bset	#3,scroll_flags_bg

loc_202DBA:
	move.l	scroll_bg_y,d3
	move.l	d3,d0
	add.l	d5,d0
	move.l	d0,scroll_bg_y
	move.l	d0,d1
	swap	d1
	andi.w	#$10,d1
	move.b	scroll_cross_bg_y,d2
	eor.b	d2,d1
	bne.s	locret_202DEE
	eori.b	#$10,scroll_cross_bg_y
	sub.l	d3,d0
	bpl.s	loc_202DE8
	bset	#0,scroll_flags_bg
	rts

; ------------------------------------------------------------------------------

loc_202DE8:
	bset	#1,scroll_flags_bg

locret_202DEE:
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
	bne.s	locret_202E24
	eori.b	#$10,scroll_cross_bg_y
	sub.l	d3,d0
	bpl.s	loc_202E1E
	bset	#4,scroll_flags_bg
	rts

; ------------------------------------------------------------------------------

loc_202E1E:
	bset	#5,scroll_flags_bg

locret_202E24:
	rts

; ------------------------------------------------------------------------------

ScrollBgY:
	move.w	scroll_bg_y,d3
	move.w	d0,scroll_bg_y
	move.w	d0,d1
	andi.w	#$10,d1
	move.b	scroll_cross_bg_y,d2
	eor.b	d2,d1
	bne.s	locret_202E54
	eori.b	#$10,scroll_cross_bg_y
	sub.w	d3,d0
	bpl.s	loc_202E4E
	bset	#0,scroll_flags_bg
	rts

; ------------------------------------------------------------------------------

loc_202E4E:
	bset	#1,scroll_flags_bg

locret_202E54:
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
	bne.s	locret_202E88
	eori.b	#$10,scroll_cross_bg_x
	sub.l	d2,d0
	bpl.s	loc_202E82
	bset	d6,scroll_flags_bg
	bra.s	locret_202E88

; ------------------------------------------------------------------------------

loc_202E82:
	addq.b	#1,d6
	bset	d6,scroll_flags_bg

locret_202E88:
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
	bne.s	locret_202EBC
	eori.b	#$10,scroll_cross_bg2_x
	sub.l	d2,d0
	bpl.s	loc_202EB6
	bset	d6,scroll_flags_bg2
	bra.s	locret_202EBC

; ------------------------------------------------------------------------------

loc_202EB6:
	addq.b	#1,d6
	bset	d6,scroll_flags_bg2

locret_202EBC:
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
	bne.s	locret_202EF0
	eori.b	#$10,scroll_cross_bg3_x
	sub.l	d2,d0
	bpl.s	loc_202EEA
	bset	d6,scroll_flags_bg3
	bra.s	locret_202EF0

; ------------------------------------------------------------------------------

loc_202EEA:
	addq.b	#1,d6
	bset	d6,scroll_flags_bg3

locret_202EF0:
	rts

; ------------------------------------------------------------------------------
