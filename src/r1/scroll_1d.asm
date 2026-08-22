; ------------------------------------------------------------------------------

GetPlayerObject:
	lea	player_object,a6
	tst.b	use_player_2
	beq.s	locret_202806
	lea	player_object_2,a6

locret_202806:
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
	lea	unk_202864,a0
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
	bra.w	loc_202890

; ------------------------------------------------------------------------------

unk_202864:
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

unk_202870:
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

loc_202890:
	tst.b	spawn_mode
	beq.s	loc_2028B0
	jsr	LoadCheckpoint
	moveq	#0,d0
	moveq	#0,d1
	move.w	8(a6),d1
	move.w	$C(a6),d0
	bpl.s	loc_2028AE
	moveq	#0,d0

loc_2028AE:
	bra.s	loc_2028EC

; ------------------------------------------------------------------------------

loc_2028B0:
	lea	StagePlayerSpawn,a1
	tst.w	stage_demo
	bpl.s	loc_2028D2
	move.w	s1_credits_index,d0
	subq.w	#1,d0
	lsl.w	#2,d0
	lea	unk_202870,a1
	adda.w	d0,a1
	bra.s	loc_2028DC

; ------------------------------------------------------------------------------

loc_2028D2:
	move.w	stage_demo,d0
	lsl.w	#2,d0
	adda.w	d0,a1

loc_2028DC:
	moveq	#0,d1
	move.w	(a1)+,d1
	move.w	d1,8(a6)
	moveq	#0,d0
	move.w	(a1),d0
	move.w	d0,$C(a6)

loc_2028EC:
	subi.w	#$A0,d1
	bcc.s	loc_2028F4
	moveq	#0,d1

loc_2028F4:
	move.w	right_bound,d2
	cmp.w	d2,d1
	bcs.s	loc_2028FE
	move.w	d2,d1

loc_2028FE:
	move.w	d1,scroll_fg_x
	subi.w	#$60,d0
	bcc.s	loc_20290A
	moveq	#0,d0

loc_20290A:
	cmp.w	bottom_bound,d0
	blt.s	loc_202914
	move.w	bottom_bound,d0

loc_202914:
	move.w	d0,scroll_fg_y
	bsr.w	sub_202930
	lea	unk_20292C,a1
	move.l	(a1),loop_chunk_1
	rts

; ------------------------------------------------------------------------------

StagePlayerSpawn:
	incbin	"src/maps/r1/spawn_1d.bin"
	even

unk_20292C:
	dc.b	$8C
	dc.b	$7F
	dc.b	$1E
	dc.b	$1E

; ------------------------------------------------------------------------------

sub_202930:
	swap	d0
	asr.l	#4,d0
	add.l	d0,d0
	move.l	d0,scroll_bg_y
	swap	d0
	move.w	d0,scroll_bg2_y
	move.w	d0,scroll_bg3_y
	lsr.w	#2,d1
	move.w	d1,scroll_bg2_x
	lsr.w	#1,d1
	move.w	d1,scroll_bg3_x
	lsr.w	#1,d1
	move.w	d1,d2
	add.w	d2,d2
	add.w	d2,d1
	move.w	d1,scroll_bg_x
	lea	bg_scroll_lines,a2
	clr.l	(a2)+
	clr.l	(a2)+
	clr.l	(a2)+
	clr.l	(a2)+
	rts

; ------------------------------------------------------------------------------

UpdateScroll:
	lea	player_object,a6
	tst.b	scroll_lock
	beq.s	loc_202976
	rts

; ------------------------------------------------------------------------------

loc_202976:
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
	lea	bg_scroll_lines+$10,a1
	move.w	scroll_x_move,d4
	ext.l	d4
	asl.l	#4,d4
	move.l	d4,d3
	add.l	d3,d3
	add.l	d3,d4
	move.w	scroll_y_move,d5
	ext.l	d5
	asl.l	#4,d5
	add.l	d5,d5
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
	addi.l	#$C000,(a2)+
	addi.l	#$8000,(a2)+
	addi.l	#$4000,(a2)+
	move.w	scroll_fg_x,d0
	neg.w	d0
	swap	d0
	move.w	bg_scroll_lines,d0
	add.w	scroll_bg3_x,d0
	neg.w	d0
	move.w	#3,d1

loc_202A32:
	move.w	d0,(a1)+
	dbf	d1,loc_202A32
	move.w	bg_scroll_lines+4,d0
	add.w	scroll_bg3_x,d0
	neg.w	d0
	move.w	#5,d1

loc_202A46:
	move.w	d0,(a1)+
	dbf	d1,loc_202A46
	move.w	bg_scroll_lines+8,d0
	add.w	scroll_bg3_x,d0
	neg.w	d0
	move.w	#3,d1

loc_202A5A:
	move.w	d0,(a1)+
	dbf	d1,loc_202A5A
	move.w	#7,d1
	move.w	scroll_bg3_x,d0
	neg.w	d0

loc_202A6A:
	move.w	d0,(a1)+
	dbf	d1,loc_202A6A
	move.w	#1,d1
	move.w	scroll_bg_x,d0
	neg.w	d0

loc_202A7A:
	move.w	d0,(a1)+
	dbf	d1,loc_202A7A
	move.w	#5,d1
	move.w	scroll_bg2_x,d0
	neg.w	d0

loc_202A8A:
	move.w	d0,(a1)+
	dbf	d1,loc_202A8A
	lea	scroll_lines,a1
	lea	bg_scroll_lines+$10,a2
	move.w	scroll_bg_y,d0
	move.w	d0,d2
	andi.w	#$1F8,d0
	lsr.w	#2,d0
	moveq	#$1C,d1
	lea	(a2,d0.w),a2
	andi.w	#7,d2
	add.w	d2,d2
	move.w	(a2)+,d0
	jmp	loc_202AB8(pc,d2.w)

; ------------------------------------------------------------------------------

loc_202AB6:
	move.w	(a2)+,d0

loc_202AB8:
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	dbf	d1,loc_202AB6
	rts

; ------------------------------------------------------------------------------

	neg.w	d0
	jmp	loc_202AD6(pc,d2.w)

; ------------------------------------------------------------------------------

	neg.w	d0

loc_202AD6:
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	dbf	d1,loc_202AB6
	rts

; ------------------------------------------------------------------------------

ScrollFgX:
	move.w	scroll_fg_x,d4
	bsr.s	CheckScrollFgX
	move.w	scroll_fg_x,d0
	andi.w	#$10,d0
	move.b	scroll_cross_x,d1
	eor.b	d1,d0
	bne.s	locret_202B1E
	eori.b	#$10,scroll_cross_x
	move.w	scroll_fg_x,d0
	sub.w	d4,d0
	bpl.s	loc_202B18
	bset	#2,scroll_flags_fg
	rts

; ------------------------------------------------------------------------------

loc_202B18:
	bset	#3,scroll_flags_fg

locret_202B1E:
	rts

; ------------------------------------------------------------------------------

CheckScrollFgX:
	move.w	8(a6),d0
	sub.w	scroll_fg_x,d0
	sub.w	scroll_focus_x,d0
	beq.s	loc_202B32
	bcs.s	loc_202B62
	bra.s	loc_202B38

; ------------------------------------------------------------------------------

loc_202B32:
	clr.w	scroll_x_move
	rts

; ------------------------------------------------------------------------------

loc_202B38:
	cmpi.w	#$10,d0
	blt.s	loc_202B42
	move.w	#$10,d0

loc_202B42:
	add.w	scroll_fg_x,d0
	cmp.w	right_bound,d0
	blt.s	loc_202B50
	move.w	right_bound,d0

loc_202B50:
	move.w	d0,d1
	sub.w	scroll_fg_x,d1
	asl.w	#8,d1
	move.w	d0,scroll_fg_x
	move.w	d1,scroll_x_move
	rts

; ------------------------------------------------------------------------------

loc_202B62:
	cmpi.w	#$FFF0,d0
	bge.s	loc_202B6C
	move.w	#$FFF0,d0

loc_202B6C:
	add.w	scroll_fg_x,d0
	cmp.w	left_bound,d0
	bgt.s	loc_202B50
	move.w	left_bound,d0
	bra.s	loc_202B50

; ------------------------------------------------------------------------------

ScrollFgXSlow:
	tst.w	d0
	bpl.s	loc_202B86
	move.w	#$FFFE,d0
	bra.s	loc_202B62

; ------------------------------------------------------------------------------

loc_202B86:
	move.w	#2,d0
	bra.s	loc_202B38

; ------------------------------------------------------------------------------

ScrollFgY:
	moveq	#0,d1
	move.w	$C(a6),d0
	sub.w	scroll_fg_y,d0
	btst	#2,$22(a6)
	beq.s	loc_202BA0
	subq.w	#5,d0

loc_202BA0:
	btst	#1,$22(a6)
	beq.s	loc_202BC0
	addi.w	#$20,d0
	sub.w	scroll_focus_y,d0
	bcs.s	loc_202C0C
	subi.w	#$40,d0
	bcc.s	loc_202C0C
	tst.b	bottom_bound_shift
	bne.s	loc_202C1E
	bra.s	loc_202BCC

; ------------------------------------------------------------------------------

loc_202BC0:
	sub.w	scroll_focus_y,d0
	bne.s	loc_202BD2
	tst.b	bottom_bound_shift
	bne.s	loc_202C1E

loc_202BCC:
	clr.w	scroll_y_move
	rts

; ------------------------------------------------------------------------------

loc_202BD2:
	cmpi.w	#$60,scroll_focus_y
	bne.s	loc_202BFA
	move.w	$14(a6),d1
	bpl.s	loc_202BE2
	neg.w	d1

loc_202BE2:
	cmpi.w	#$800,d1
	bcc.s	loc_202C0C
	move.w	#$600,d1
	cmpi.w	#6,d0
	bgt.s	loc_202C6C
	cmpi.w	#$FFFA,d0
	blt.s	loc_202C36
	bra.s	loc_202C24

; ------------------------------------------------------------------------------

loc_202BFA:
	move.w	#$200,d1
	cmpi.w	#2,d0
	bgt.s	loc_202C6C
	cmpi.w	#$FFFE,d0
	blt.s	loc_202C36
	bra.s	loc_202C24

; ------------------------------------------------------------------------------

loc_202C0C:
	move.w	#$1000,d1
	cmpi.w	#$10,d0
	bgt.s	loc_202C6C
	cmpi.w	#$FFF0,d0
	blt.s	loc_202C36
	bra.s	loc_202C24

; ------------------------------------------------------------------------------

loc_202C1E:
	moveq	#0,d0
	move.b	d0,bottom_bound_shift

loc_202C24:
	moveq	#0,d1
	move.w	d0,d1
	add.w	scroll_fg_y,d1
	tst.w	d0
	bpl.w	loc_202C76
	bra.w	loc_202C42

; ------------------------------------------------------------------------------

loc_202C36:
	neg.w	d1
	ext.l	d1
	asl.l	#8,d1
	add.l	scroll_fg_y,d1
	swap	d1

loc_202C42:
	cmp.w	top_bound,d1
	bgt.s	loc_202C9A
	cmpi.w	#$FF00,d1
	bgt.s	loc_202C66
	andi.w	#$7FF,d1
	andi.w	#$7FF,$C(a6)
	andi.w	#$7FF,scroll_fg_y
	andi.w	#$3FF,scroll_bg_y
	bra.s	loc_202C9A

; ------------------------------------------------------------------------------

loc_202C66:
	move.w	top_bound,d1
	bra.s	loc_202C9A

; ------------------------------------------------------------------------------

loc_202C6C:
	ext.l	d1
	asl.l	#8,d1
	add.l	scroll_fg_y,d1
	swap	d1

loc_202C76:
	cmp.w	bottom_bound,d1
	blt.s	loc_202C9A
	subi.w	#$800,d1
	bcs.s	loc_202C96
	andi.w	#$7FF,$C(a6)
	subi.w	#$800,scroll_fg_y
	andi.w	#$3FF,scroll_bg_y
	bra.s	loc_202C9A

; ------------------------------------------------------------------------------

loc_202C96:
	move.w	bottom_bound,d1

loc_202C9A:
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
	bne.s	locret_202CDC
	eori.b	#$10,scroll_cross_y
	move.w	scroll_fg_y,d0
	sub.w	d4,d0
	bpl.s	loc_202CD6
	bset	#0,scroll_flags_fg
	rts

; ------------------------------------------------------------------------------

loc_202CD6:
	bset	#1,scroll_flags_fg

locret_202CDC:
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
	bne.s	loc_202D12
	eori.b	#$10,scroll_cross_bg_x
	sub.l	d2,d0
	bpl.s	loc_202D0C
	bset	#2,scroll_flags_bg
	bra.s	loc_202D12

; ------------------------------------------------------------------------------

loc_202D0C:
	bset	#3,scroll_flags_bg

loc_202D12:
	move.l	scroll_bg_y,d3
	move.l	d3,d0
	add.l	d5,d0
	move.l	d0,scroll_bg_y
	move.l	d0,d1
	swap	d1
	andi.w	#$10,d1
	move.b	scroll_cross_bg_y,d2
	eor.b	d2,d1
	bne.s	locret_202D46
	eori.b	#$10,scroll_cross_bg_y
	sub.l	d3,d0
	bpl.s	loc_202D40
	bset	#0,scroll_flags_bg
	rts

; ------------------------------------------------------------------------------

loc_202D40:
	bset	#1,scroll_flags_bg

locret_202D46:
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
	bne.s	locret_202D7C
	eori.b	#$10,scroll_cross_bg_y
	sub.l	d3,d0
	bpl.s	loc_202D76
	bset	#4,scroll_flags_bg
	rts

; ------------------------------------------------------------------------------

loc_202D76:
	bset	#5,scroll_flags_bg

locret_202D7C:
	rts

; ------------------------------------------------------------------------------

ScrollBgY:
	move.w	scroll_bg_y,d3
	move.w	d0,scroll_bg_y
	move.w	d0,d1
	andi.w	#$10,d1
	move.b	scroll_cross_bg_y,d2
	eor.b	d2,d1
	bne.s	locret_202DAC
	eori.b	#$10,scroll_cross_bg_y
	sub.w	d3,d0
	bpl.s	loc_202DA6
	bset	#0,scroll_flags_bg
	rts

; ------------------------------------------------------------------------------

loc_202DA6:
	bset	#1,scroll_flags_bg

locret_202DAC:
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
	bne.s	locret_202DE0
	eori.b	#$10,scroll_cross_bg_x
	sub.l	d2,d0
	bpl.s	loc_202DDA
	bset	d6,scroll_flags_bg
	bra.s	locret_202DE0

; ------------------------------------------------------------------------------

loc_202DDA:
	addq.b	#1,d6
	bset	d6,scroll_flags_bg

locret_202DE0:
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
	bne.s	locret_202E14
	eori.b	#$10,scroll_cross_bg2_x
	sub.l	d2,d0
	bpl.s	loc_202E0E
	bset	d6,scroll_flags_bg2
	bra.s	locret_202E14

; ------------------------------------------------------------------------------

loc_202E0E:
	addq.b	#1,d6
	bset	d6,scroll_flags_bg2

locret_202E14:
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
	bne.s	locret_202E48
	eori.b	#$10,scroll_cross_bg3_x
	sub.l	d2,d0
	bpl.s	loc_202E42
	bset	d6,scroll_flags_bg3
	bra.s	locret_202E48

; ------------------------------------------------------------------------------

loc_202E42:
	addq.b	#1,d6
	bset	d6,scroll_flags_bg3

locret_202E48:
	rts

; ------------------------------------------------------------------------------
