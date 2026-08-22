; ------------------------------------------------------------------------------

InitScroll:
	lea	player_object,a6
	moveq	#0,d0
	move.b	d0,unused_scroll_x_flag
	move.b	d0,unused_scroll_y_flag
	move.b	d0,unused_scroll_die
	move.b	d0,unused_scroll_timer
	move.b	d0,event_routine
	lea	unk_2027AE,a0
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
	bra.w	loc_2027BA

; ------------------------------------------------------------------------------

unk_2027AE:
	dc.b	0
	dc.b	4
	dc.b	0
	dc.b	0
	dc.b	$2E
	dc.b	$97
	dc.b	0
	dc.b	0
	dc.b	7
	dc.b	$10
	dc.b	0
	dc.b	$60

; ------------------------------------------------------------------------------

loc_2027BA:
	tst.b	spawn_mode
	beq.s	loc_2027DA
	jsr	LoadCheckpoint
	moveq	#0,d0
	moveq	#0,d1
	move.w	8(a6),d1
	move.w	$C(a6),d0
	bpl.s	loc_2027D8
	moveq	#0,d0

loc_2027D8:
	bra.s	loc_2027F0

; ------------------------------------------------------------------------------

loc_2027DA:
	lea	StagePlayerSpawn,a1
	moveq	#0,d1
	move.w	(a1)+,d1
	move.w	d1,8(a6)
	moveq	#0,d0
	move.w	(a1),d0
	move.w	d0,$C(a6)

loc_2027F0:
	subi.w	#$A0,d1
	bcc.s	loc_2027F8
	moveq	#0,d1

loc_2027F8:
	move.w	right_bound,d2
	cmp.w	d2,d1
	bcs.s	loc_202802
	move.w	d2,d1

loc_202802:
	move.w	d1,scroll_fg_x
	subi.w	#$60,d0
	bcc.s	loc_20280E
	moveq	#0,d0

loc_20280E:
	cmp.w	bottom_bound,d0
	blt.s	loc_202818
	move.w	bottom_bound,d0

loc_202818:
	move.w	d0,scroll_fg_y
	bsr.w	sub_202834
	lea	unk_202830,a1
	move.l	(a1),loop_chunk_1
	rts

; ------------------------------------------------------------------------------

StagePlayerSpawn:
	incbin	"src/maps/r7/spawn_2a.bin"
	even

unk_202830:
	dc.b	$84
	dc.b	$86
	dc.b	$7F
	dc.b	$7F

; ------------------------------------------------------------------------------

sub_202834:
	swap	d0
	lsr.l	#2,d0
	move.l	d0,d2
	lsr.w	#3,d2
	add.l	d2,d0
	move.l	d0,scroll_bg_y
	swap	d0
	move.w	d0,scroll_bg2_y
	move.w	d0,scroll_bg3_y
	lsr.l	#1,d1
	move.w	d1,scroll_bg2_x
	lsr.l	#1,d1
	move.w	d1,scroll_bg3_x
	lsr.l	#2,d1
	move.l	d1,d2
	add.l	d2,d2
	add.l	d2,d1
	move.w	d1,scroll_bg_x
	rts

; ------------------------------------------------------------------------------

UpdateScroll:
	lea	player_object,a6
	tst.b	scroll_lock
	beq.s	loc_202872
	rts

; ------------------------------------------------------------------------------

loc_202872:
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
	asl.l	#4,d4
	move.l	d4,d3
	add.l	d3,d3
	add.l	d3,d4
	moveq	#2,d6
	bsr.w	ScrollBgX
	move.w	scroll_fg_y,d0
	lsr.w	#2,d0
	move.w	d0,d1
	lsr.w	#3,d1
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
	bsr.w	sub_202988
	move.w	scroll_bg_x,d0
	neg.w	d0
	moveq	#3,d6

loc_20291C:
	move.w	d0,(a1)+
	dbf	d6,loc_20291C
	bsr.w	sub_2029CC
	move.w	scroll_bg3_x,d0
	neg.w	d0
	moveq	#$F,d6

loc_20292E:
	move.w	d0,(a1)+
	dbf	d6,loc_20292E
	bsr.w	sub_202A0A
	lea	scroll_lines,a1
	lea	bg_scroll_lines,a2
	move.w	scroll_bg_y,d0
	move.w	d0,d2
	andi.w	#$3F8,d0
	lsr.w	#2,d0
	moveq	#$1D,d1
	lea	(a2,d0.w),a2
	bra.w	loc_202A46

; ------------------------------------------------------------------------------

byte_202956:
	dc.b	1
	dc.b	1
	dc.b	1
	dc.b	1
	dc.b	1
	dc.b	1
	dc.b	1
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0

byte_20297C:
	dc.b	1
	dc.b	1
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0

; ------------------------------------------------------------------------------

sub_202988:
	move.w	scroll_bg_x,d0
	move.w	scroll_fg_x,d2
	sub.w	d0,d2
	ext.l	d2
	moveq	#7,d1
	asl.l	d1,d2
	divu.w	#$25,d2
	ext.l	d2
	moveq	#9,d1
	asl.l	d1,d2
	move.w	scroll_bg_x,d3
	moveq	#$24,d6
	adda.w	#$58,a1

loc_2029AC:
	move.w	d3,d0
	neg.w	d0
	moveq	#0,d5
	move.b	byte_202956(pc,d6.w),d5

loc_2029B6:
	move.w	d0,-(a1)
	dbf	d5,loc_2029B6
	swap	d3
	add.l	d2,d3
	swap	d3
	dbf	d6,loc_2029AC
	adda.w	#$58,a1
	rts

; ------------------------------------------------------------------------------

sub_2029CC:
	move.w	scroll_bg_x,d0
	move.w	scroll_bg3_x,d2
	sub.w	d0,d2
	ext.l	d2
	moveq	#7,d1
	asl.l	d1,d2
	divu.w	#$C,d2
	ext.l	d2
	moveq	#9,d1
	asl.l	d1,d2
	move.w	scroll_bg_x,d3
	moveq	#$B,d6

loc_2029EC:
	move.w	d3,d0
	neg.w	d0
	moveq	#0,d5
	move.b	byte_20297C(pc,d6.w),d5

loc_2029F6:
	move.w	d0,(a1)+
	dbf	d5,loc_2029F6
	swap	d3
	add.l	d2,d3
	swap	d3
	dbf	d6,loc_2029EC
	rts

; ------------------------------------------------------------------------------

byte_202A08:
	dc.b	9
	dc.b	7

; ------------------------------------------------------------------------------

sub_202A0A:
	move.w	scroll_bg2_x,d0
	move.w	scroll_fg_x,d2
	sub.w	d0,d2
	ext.l	d2
	moveq	#7,d1
	asl.l	d1,d2
	divu.w	#8,d2
	ext.l	d2
	moveq	#9,d1
	asl.l	d1,d2
	move.w	scroll_bg2_x,d3
	moveq	#1,d6

loc_202A2A:
	move.w	d3,d0
	neg.w	d0
	moveq	#0,d5
	move.b	byte_202A08(pc,d6.w),d5

loc_202A34:
	move.w	d0,(a1)+
	dbf	d5,loc_202A34
	swap	d3
	add.l	d2,d3
	swap	d3
	dbf	d6,loc_202A2A
	rts

; ------------------------------------------------------------------------------

loc_202A46:
	andi.w	#7,d2
	add.w	d2,d2
	move.w	(a2)+,d0
	jmp	loc_202A54(pc,d2.w)

; ------------------------------------------------------------------------------

loc_202A52:
	move.w	(a2)+,d0

loc_202A54:
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	dbf	d1,loc_202A52
	rts

; ------------------------------------------------------------------------------

	neg.w	d0
	jmp	loc_202A72(pc,d2.w)

; ------------------------------------------------------------------------------

	neg.w	d0

loc_202A72:
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	dbf	d1,loc_202A52
	rts

; ------------------------------------------------------------------------------

ScrollFgX:
	move.w	scroll_fg_x,d4
	bsr.s	CheckScrollFgX
	move.w	scroll_fg_x,d0
	andi.w	#$10,d0
	move.b	scroll_cross_x,d1
	eor.b	d1,d0
	bne.s	locret_202ABA
	eori.b	#$10,scroll_cross_x
	move.w	scroll_fg_x,d0
	sub.w	d4,d0
	bpl.s	loc_202AB4
	bset	#2,scroll_flags_fg
	rts

; ------------------------------------------------------------------------------

loc_202AB4:
	bset	#3,scroll_flags_fg

locret_202ABA:
	rts

; ------------------------------------------------------------------------------

CheckScrollFgX:
	move.w	8(a6),d0
	sub.w	scroll_fg_x,d0
	sub.w	scroll_focus_x,d0
	beq.s	loc_202ACE
	bcs.s	loc_202AFE
	bra.s	loc_202AD4

; ------------------------------------------------------------------------------

loc_202ACE:
	clr.w	scroll_x_move
	rts

; ------------------------------------------------------------------------------

loc_202AD4:
	cmpi.w	#$10,d0
	blt.s	loc_202ADE
	move.w	#$10,d0

loc_202ADE:
	add.w	scroll_fg_x,d0
	cmp.w	right_bound,d0
	blt.s	loc_202AEC
	move.w	right_bound,d0

loc_202AEC:
	move.w	d0,d1
	sub.w	scroll_fg_x,d1
	asl.w	#8,d1
	move.w	d0,scroll_fg_x
	move.w	d1,scroll_x_move
	rts

; ------------------------------------------------------------------------------

loc_202AFE:
	cmpi.w	#$FFF0,d0
	bge.s	loc_202B08
	move.w	#$FFF0,d0

loc_202B08:
	add.w	scroll_fg_x,d0
	cmp.w	left_bound,d0
	bgt.s	loc_202AEC
	move.w	left_bound,d0
	bra.s	loc_202AEC

; ------------------------------------------------------------------------------

ScrollFgXSlow:
	tst.w	d0
	bpl.s	loc_202B22
	move.w	#$FFFE,d0
	bra.s	loc_202AFE

; ------------------------------------------------------------------------------

loc_202B22:
	move.w	#2,d0
	bra.s	loc_202AD4

; ------------------------------------------------------------------------------

ScrollFgY:
	moveq	#0,d1
	move.w	$C(a6),d0
	sub.w	scroll_fg_y,d0
	btst	#2,$22(a6)
	beq.s	loc_202B3C
	subq.w	#5,d0

loc_202B3C:
	btst	#1,$22(a6)
	beq.s	loc_202B5C
	addi.w	#$20,d0
	sub.w	scroll_focus_y,d0
	bcs.s	loc_202BA8
	subi.w	#$40,d0
	bcc.s	loc_202BA8
	tst.b	bottom_bound_shift
	bne.s	loc_202BBA
	bra.s	loc_202B68

; ------------------------------------------------------------------------------

loc_202B5C:
	sub.w	scroll_focus_y,d0
	bne.s	loc_202B6E
	tst.b	bottom_bound_shift
	bne.s	loc_202BBA

loc_202B68:
	clr.w	scroll_y_move
	rts

; ------------------------------------------------------------------------------

loc_202B6E:
	cmpi.w	#$60,scroll_focus_y
	bne.s	loc_202B96
	move.w	$14(a6),d1
	bpl.s	loc_202B7E
	neg.w	d1

loc_202B7E:
	cmpi.w	#$800,d1
	bcc.s	loc_202BA8
	move.w	#$600,d1
	cmpi.w	#6,d0
	bgt.s	loc_202C08
	cmpi.w	#$FFFA,d0
	blt.s	loc_202BD2
	bra.s	loc_202BC0

; ------------------------------------------------------------------------------

loc_202B96:
	move.w	#$200,d1
	cmpi.w	#2,d0
	bgt.s	loc_202C08
	cmpi.w	#$FFFE,d0
	blt.s	loc_202BD2
	bra.s	loc_202BC0

; ------------------------------------------------------------------------------

loc_202BA8:
	move.w	#$1000,d1
	cmpi.w	#$10,d0
	bgt.s	loc_202C08
	cmpi.w	#$FFF0,d0
	blt.s	loc_202BD2
	bra.s	loc_202BC0

; ------------------------------------------------------------------------------

loc_202BBA:
	moveq	#0,d0
	move.b	d0,bottom_bound_shift

loc_202BC0:
	moveq	#0,d1
	move.w	d0,d1
	add.w	scroll_fg_y,d1
	tst.w	d0
	bpl.w	loc_202C12
	bra.w	loc_202BDE

; ------------------------------------------------------------------------------

loc_202BD2:
	neg.w	d1
	ext.l	d1
	asl.l	#8,d1
	add.l	scroll_fg_y,d1
	swap	d1

loc_202BDE:
	cmp.w	top_bound,d1
	bgt.s	loc_202C36
	cmpi.w	#$FF00,d1
	bgt.s	loc_202C02
	andi.w	#$7FF,d1
	andi.w	#$7FF,$C(a6)
	andi.w	#$7FF,scroll_fg_y
	andi.w	#$3FF,scroll_bg_y
	bra.s	loc_202C36

; ------------------------------------------------------------------------------

loc_202C02:
	move.w	top_bound,d1
	bra.s	loc_202C36

; ------------------------------------------------------------------------------

loc_202C08:
	ext.l	d1
	asl.l	#8,d1
	add.l	scroll_fg_y,d1
	swap	d1

loc_202C12:
	cmp.w	bottom_bound,d1
	blt.s	loc_202C36
	subi.w	#$800,d1
	bcs.s	loc_202C32
	andi.w	#$7FF,$C(a6)
	subi.w	#$800,scroll_fg_y
	andi.w	#$3FF,scroll_bg_y
	bra.s	loc_202C36

; ------------------------------------------------------------------------------

loc_202C32:
	move.w	bottom_bound,d1

loc_202C36:
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
	bne.s	locret_202C78
	eori.b	#$10,scroll_cross_y
	move.w	scroll_fg_y,d0
	sub.w	d4,d0
	bpl.s	loc_202C72
	bset	#0,scroll_flags_fg
	rts

; ------------------------------------------------------------------------------

loc_202C72:
	bset	#1,scroll_flags_fg

locret_202C78:
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
	bne.s	loc_202CAE
	eori.b	#$10,scroll_cross_bg_x
	sub.l	d2,d0
	bpl.s	loc_202CA8
	bset	#2,scroll_flags_bg
	bra.s	loc_202CAE

; ------------------------------------------------------------------------------

loc_202CA8:
	bset	#3,scroll_flags_bg

loc_202CAE:
	move.l	scroll_bg_y,d3
	move.l	d3,d0
	add.l	d5,d0
	move.l	d0,scroll_bg_y
	move.l	d0,d1
	swap	d1
	andi.w	#$10,d1
	move.b	scroll_cross_bg_y,d2
	eor.b	d2,d1
	bne.s	locret_202CE2
	eori.b	#$10,scroll_cross_bg_y
	sub.l	d3,d0
	bpl.s	loc_202CDC
	bset	#0,scroll_flags_bg
	rts

; ------------------------------------------------------------------------------

loc_202CDC:
	bset	#1,scroll_flags_bg

locret_202CE2:
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
	bne.s	locret_202D18
	eori.b	#$10,scroll_cross_bg_y
	sub.l	d3,d0
	bpl.s	loc_202D12
	bset	#4,scroll_flags_bg
	rts

; ------------------------------------------------------------------------------

loc_202D12:
	bset	#5,scroll_flags_bg

locret_202D18:
	rts

; ------------------------------------------------------------------------------

ScrollBgY:
	move.w	scroll_bg_y,d3
	move.w	d0,scroll_bg_y
	move.w	d0,d1
	andi.w	#$10,d1
	move.b	scroll_cross_bg_y,d2
	eor.b	d2,d1
	bne.s	locret_202D48
	eori.b	#$10,scroll_cross_bg_y
	sub.w	d3,d0
	bpl.s	loc_202D42
	bset	#0,scroll_flags_bg
	rts

; ------------------------------------------------------------------------------

loc_202D42:
	bset	#1,scroll_flags_bg

locret_202D48:
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
	bne.s	locret_202D7C
	eori.b	#$10,scroll_cross_bg_x
	sub.l	d2,d0
	bpl.s	loc_202D76
	bset	d6,scroll_flags_bg
	bra.s	locret_202D7C

; ------------------------------------------------------------------------------

loc_202D76:
	addq.b	#1,d6
	bset	d6,scroll_flags_bg

locret_202D7C:
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
	bne.s	locret_202DB0
	eori.b	#$10,scroll_cross_bg2_x
	sub.l	d2,d0
	bpl.s	loc_202DAA
	bset	d6,scroll_flags_bg2
	bra.s	locret_202DB0

; ------------------------------------------------------------------------------

loc_202DAA:
	addq.b	#1,d6
	bset	d6,scroll_flags_bg2

locret_202DB0:
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
	bne.s	locret_202DE4
	eori.b	#$10,scroll_cross_bg3_x
	sub.l	d2,d0
	bpl.s	loc_202DDE
	bset	d6,scroll_flags_bg3
	bra.s	locret_202DE4

; ------------------------------------------------------------------------------

loc_202DDE:
	addq.b	#1,d6
	bset	d6,scroll_flags_bg3

locret_202DE4:
	rts

; ------------------------------------------------------------------------------
