; ------------------------------------------------------------------------------

GetPlayerObject:
	lea	player_object,a6
	tst.b	use_player_2
	beq.s	locret_20285A
	lea	player_object_2,a6

locret_20285A:
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
	lea	word_202856,a0
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
	bra.w	loc_2028E4

; ------------------------------------------------------------------------------

word_202856:
	dc.b	0
	dc.b	4
	dc.b	0
	dc.b	0
	dc.b	$E
	dc.b	$97
	dc.b	0
	dc.b	0
	dc.b	3
	dc.b	$20
	dc.b	0
	dc.b	$60

unk_2028C4:
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

loc_2028E4:
	tst.b	spawn_mode
	beq.s	loc_202904
	jsr	LoadCheckpoint
	moveq	#0,d0
	moveq	#0,d1
	move.w	8(a6),d1
	move.w	$C(a6),d0
	bpl.s	loc_202902
	moveq	#0,d0

loc_202902:
	bra.s	loc_202940

; ------------------------------------------------------------------------------

loc_202904:
	lea	StagePlayerSpawn,a1
	tst.w	stage_demo
	bpl.s	loc_202926
	move.w	s1_credits_index,d0
	subq.w	#1,d0
	lsl.w	#2,d0
	lea	unk_2028C4,a1
	adda.w	d0,a1
	bra.s	loc_202930

; ------------------------------------------------------------------------------

loc_202926:
	move.w	stage_demo,d0
	lsl.w	#2,d0
	adda.w	d0,a1

loc_202930:
	moveq	#0,d1
	move.w	(a1)+,d1
	move.w	d1,8(a6)
	moveq	#0,d0
	move.w	(a1),d0
	move.w	d0,$C(a6)

loc_202940:
	subi.w	#$A0,d1
	bcc.s	loc_202948
	moveq	#0,d1

loc_202948:
	move.w	right_bound,d2
	cmp.w	d2,d1
	bcs.s	loc_202952
	move.w	d2,d1

loc_202952:
	move.w	d1,scroll_fg_x
	subi.w	#$60,d0
	bcc.s	loc_20295E
	moveq	#0,d0

loc_20295E:
	cmp.w	bottom_bound,d0
	blt.s	loc_202968
	move.w	bottom_bound,d0

loc_202968:
	move.w	d0,scroll_fg_y
	bsr.w	sub_202984
	lea	unk_202980,a1
	move.l	(a1),loop_chunk_1
	rts

; ------------------------------------------------------------------------------

StagePlayerSpawn:
	incbin	"src/maps/r5/spawn_3d.bin"
	even

unk_202980:
	dc.b	$7F
	dc.b	$7F
	dc.b	$7F
	dc.b	$7F

; ------------------------------------------------------------------------------

sub_202984:
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
	beq.s	loc_2029C0
	rts

; ------------------------------------------------------------------------------

loc_2029C0:
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
	bsr.w	sub_202AFA
	move.w	scroll_bg_x,d0
	neg.w	d0
	moveq	#$B,d6

loc_202A68:
	move.w	d0,(a1)+
	dbf	d6,loc_202A68
	move.w	scroll_bg_x,d0
	neg.w	d0
	moveq	#3,d6

loc_202A76:
	move.w	d0,(a1)+
	dbf	d6,loc_202A76
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
	bne.s	loc_202AAC
	sub.w	d3,d1
	bcs.s	loc_202AB8
	cmpi.w	#$1C,d1
	bcs.s	loc_202AAE

loc_202AAC:
	moveq	#$1C,d1

loc_202AAE:
	sub.w	d1,d5
	lea	(a2,d0.w),a2
	bsr.w	sub_202B3E

loc_202AB8:
	btst	#0,r5_bg_change
	bne.w	locret_202AF4
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

loc_202AE4:
	move.w	d3,d0
	neg.w	d0
	move.l	d0,(a1)+
	swap	d3
	add.l	d2,d3
	swap	d3
	dbf	d1,loc_202AE4

locret_202AF4:
	rts

; ------------------------------------------------------------------------------

byte_202AF6:
	dc.b	5
	dc.b	$B
	dc.b	5
	dc.b	0

; ------------------------------------------------------------------------------

sub_202AFA:
	move.w	scroll_bg_x,d0
	move.w	scroll_fg_x,d2
	sub.w	d0,d2
	ext.l	d2
	moveq	#7,d1
	asl.l	d1,d2
	divu.w	#6,d2
	ext.l	d2
	moveq	#9,d1
	asl.l	d1,d2
	move.w	scroll_bg_x,d3
	moveq	#2,d6
	adda.w	#$30,a1

loc_202B1E:
	move.w	d3,d0
	neg.w	d0
	moveq	#0,d5
	move.b	byte_202AF6(pc,d6.w),d5

loc_202B28:
	move.w	d0,-(a1)
	dbf	d5,loc_202B28
	swap	d3
	add.l	d2,d3
	swap	d3
	dbf	d6,loc_202B1E
	adda.w	#$30,a1
	rts

; ------------------------------------------------------------------------------

sub_202B3E:
	andi.w	#7,d2
	add.w	d2,d2
	move.w	(a2)+,d0
	jmp	loc_202B4C(pc,d2.w)

; ------------------------------------------------------------------------------

loc_202B4A:
	move.w	(a2)+,d0

loc_202B4C:
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	dbf	d1,loc_202B4A
	rts

; ------------------------------------------------------------------------------

ScrollFgX:
	move.w	scroll_fg_x,d4
	bsr.s	CheckScrollFgX
	move.w	scroll_fg_x,d0
	andi.w	#$10,d0
	move.b	scroll_cross_x,d1
	eor.b	d1,d0
	bne.s	locret_202B94
	eori.b	#$10,scroll_cross_x
	move.w	scroll_fg_x,d0
	sub.w	d4,d0
	bpl.s	loc_202B8E
	bset	#2,scroll_flags_fg
	rts

; ------------------------------------------------------------------------------

loc_202B8E:
	bset	#3,scroll_flags_fg

locret_202B94:
	rts

; ------------------------------------------------------------------------------

CheckScrollFgX:
	move.w	8(a6),d0
	sub.w	scroll_fg_x,d0
	sub.w	scroll_focus_x,d0
	beq.s	loc_202BA8
	bcs.s	loc_202BD8
	bra.s	loc_202BAE

; ------------------------------------------------------------------------------

loc_202BA8:
	clr.w	scroll_x_move
	rts

; ------------------------------------------------------------------------------

loc_202BAE:
	cmpi.w	#$10,d0
	blt.s	loc_202BB8
	move.w	#$10,d0

loc_202BB8:
	add.w	scroll_fg_x,d0
	cmp.w	right_bound,d0
	blt.s	loc_202BC6
	move.w	right_bound,d0

loc_202BC6:
	move.w	d0,d1
	sub.w	scroll_fg_x,d1
	asl.w	#8,d1
	move.w	d0,scroll_fg_x
	move.w	d1,scroll_x_move
	rts

; ------------------------------------------------------------------------------

loc_202BD8:
	cmpi.w	#$FFF0,d0
	bge.s	loc_202BE2
	move.w	#$FFF0,d0

loc_202BE2:
	add.w	scroll_fg_x,d0
	cmp.w	left_bound,d0
	bgt.s	loc_202BC6
	move.w	left_bound,d0
	bra.s	loc_202BC6

; ------------------------------------------------------------------------------

ScrollFgXSlow:
	tst.w	d0
	bpl.s	loc_202BFC
	move.w	#$FFFE,d0
	bra.s	loc_202BD8

; ------------------------------------------------------------------------------

loc_202BFC:
	move.w	#2,d0
	bra.s	loc_202BAE

; ------------------------------------------------------------------------------

ScrollFgY:
	moveq	#0,d1
	move.w	$C(a6),d0
	sub.w	scroll_fg_y,d0
	btst	#2,$22(a6)
	beq.s	loc_202C16
	subq.w	#5,d0

loc_202C16:
	btst	#1,$22(a6)
	beq.s	loc_202C36
	addi.w	#$20,d0
	sub.w	scroll_focus_y,d0
	bcs.s	loc_202C82
	subi.w	#$40,d0
	bcc.s	loc_202C82
	tst.b	bottom_bound_shift
	bne.s	loc_202C94
	bra.s	loc_202C42

; ------------------------------------------------------------------------------

loc_202C36:
	sub.w	scroll_focus_y,d0
	bne.s	loc_202C48
	tst.b	bottom_bound_shift
	bne.s	loc_202C94

loc_202C42:
	clr.w	scroll_y_move
	rts

; ------------------------------------------------------------------------------

loc_202C48:
	cmpi.w	#$60,scroll_focus_y
	bne.s	loc_202C70
	move.w	$14(a6),d1
	bpl.s	loc_202C58
	neg.w	d1

loc_202C58:
	cmpi.w	#$800,d1
	bcc.s	loc_202C82
	move.w	#$600,d1
	cmpi.w	#6,d0
	bgt.s	loc_202CE2
	cmpi.w	#$FFFA,d0
	blt.s	loc_202CAC
	bra.s	loc_202C9A

; ------------------------------------------------------------------------------

loc_202C70:
	move.w	#$200,d1
	cmpi.w	#2,d0
	bgt.s	loc_202CE2
	cmpi.w	#$FFFE,d0
	blt.s	loc_202CAC
	bra.s	loc_202C9A

; ------------------------------------------------------------------------------

loc_202C82:
	move.w	#$1000,d1
	cmpi.w	#$10,d0
	bgt.s	loc_202CE2
	cmpi.w	#$FFF0,d0
	blt.s	loc_202CAC
	bra.s	loc_202C9A

; ------------------------------------------------------------------------------

loc_202C94:
	moveq	#0,d0
	move.b	d0,bottom_bound_shift

loc_202C9A:
	moveq	#0,d1
	move.w	d0,d1
	add.w	scroll_fg_y,d1
	tst.w	d0
	bpl.w	loc_202CEC
	bra.w	loc_202CB8

; ------------------------------------------------------------------------------

loc_202CAC:
	neg.w	d1
	ext.l	d1
	asl.l	#8,d1
	add.l	scroll_fg_y,d1
	swap	d1

loc_202CB8:
	cmp.w	top_bound,d1
	bgt.s	loc_202D10
	cmpi.w	#$FF00,d1
	bgt.s	loc_202CDC
	andi.w	#$7FF,d1
	andi.w	#$7FF,$C(a6)
	andi.w	#$7FF,scroll_fg_y
	andi.w	#$3FF,scroll_bg_y
	bra.s	loc_202D10

; ------------------------------------------------------------------------------

loc_202CDC:
	move.w	top_bound,d1
	bra.s	loc_202D10

; ------------------------------------------------------------------------------

loc_202CE2:
	ext.l	d1
	asl.l	#8,d1
	add.l	scroll_fg_y,d1
	swap	d1

loc_202CEC:
	cmp.w	bottom_bound,d1
	blt.s	loc_202D10
	subi.w	#$800,d1
	bcs.s	loc_202D0C
	andi.w	#$7FF,$C(a6)
	subi.w	#$800,scroll_fg_y
	andi.w	#$3FF,scroll_bg_y
	bra.s	loc_202D10

; ------------------------------------------------------------------------------

loc_202D0C:
	move.w	bottom_bound,d1

loc_202D10:
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
	bne.s	locret_202D52
	eori.b	#$10,scroll_cross_y
	move.w	scroll_fg_y,d0
	sub.w	d4,d0
	bpl.s	loc_202D4C
	bset	#0,scroll_flags_fg
	rts

; ------------------------------------------------------------------------------

loc_202D4C:
	bset	#1,scroll_flags_fg

locret_202D52:
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
	bne.s	loc_202D88
	eori.b	#$10,scroll_cross_bg_x
	sub.l	d2,d0
	bpl.s	loc_202D82
	bset	#2,scroll_flags_bg
	bra.s	loc_202D88

; ------------------------------------------------------------------------------

loc_202D82:
	bset	#3,scroll_flags_bg

loc_202D88:
	move.l	scroll_bg_y,d3
	move.l	d3,d0
	add.l	d5,d0
	move.l	d0,scroll_bg_y
	move.l	d0,d1
	swap	d1
	andi.w	#$10,d1
	move.b	scroll_cross_bg_y,d2
	eor.b	d2,d1
	bne.s	locret_202DBC
	eori.b	#$10,scroll_cross_bg_y
	sub.l	d3,d0
	bpl.s	loc_202DB6
	bset	#0,scroll_flags_bg
	rts

; ------------------------------------------------------------------------------

loc_202DB6:
	bset	#1,scroll_flags_bg

locret_202DBC:
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
	bne.s	locret_202DF2
	eori.b	#$10,scroll_cross_bg_y
	sub.l	d3,d0
	bpl.s	loc_202DEC
	bset	#4,scroll_flags_bg
	rts

; ------------------------------------------------------------------------------

loc_202DEC:
	bset	#5,scroll_flags_bg

locret_202DF2:
	rts

; ------------------------------------------------------------------------------

ScrollBgY:
	move.w	scroll_bg_y,d3
	move.w	d0,scroll_bg_y
	move.w	d0,d1
	andi.w	#$10,d1
	move.b	scroll_cross_bg_y,d2
	eor.b	d2,d1
	bne.s	locret_202E22
	eori.b	#$10,scroll_cross_bg_y
	sub.w	d3,d0
	bpl.s	loc_202E1C
	bset	#0,scroll_flags_bg
	rts

; ------------------------------------------------------------------------------

loc_202E1C:
	bset	#1,scroll_flags_bg

locret_202E22:
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
	bne.s	locret_202E56
	eori.b	#$10,scroll_cross_bg_x
	sub.l	d2,d0
	bpl.s	loc_202E50
	bset	d6,scroll_flags_bg
	bra.s	locret_202E56

; ------------------------------------------------------------------------------

loc_202E50:
	addq.b	#1,d6
	bset	d6,scroll_flags_bg

locret_202E56:
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
	bne.s	locret_202E8A
	eori.b	#$10,scroll_cross_bg2_x
	sub.l	d2,d0
	bpl.s	loc_202E84
	bset	d6,scroll_flags_bg2
	bra.s	locret_202E8A

; ------------------------------------------------------------------------------

loc_202E84:
	addq.b	#1,d6
	bset	d6,scroll_flags_bg2

locret_202E8A:
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
	bne.s	locret_202EBE
	eori.b	#$10,scroll_cross_bg3_x
	sub.l	d2,d0
	bpl.s	loc_202EB8
	bset	d6,scroll_flags_bg3
	bra.s	locret_202EBE

; ------------------------------------------------------------------------------

loc_202EB8:
	addq.b	#1,d6
	bset	d6,scroll_flags_bg3

locret_202EBE:
	rts

; ------------------------------------------------------------------------------
