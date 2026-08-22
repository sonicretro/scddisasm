; ------------------------------------------------------------------------------

GetPlayerObject:
	lea	player_object,a6
	tst.b	use_player_2
	beq.s	locret_202862
	lea	player_object_2,a6

locret_202862:
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
	lea	unk_2028C0,a0
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
	bra.w	loc_2028EC

; ------------------------------------------------------------------------------

unk_2028C0:
	dc.w	4, 0, $1E97, 0, $710, $60

unk_2028CC:
	dc.w	$50, $3B0
	dc.w	$EA0, $46C
	dc.w	$1750, $BD
	dc.w	$A00, $62C
	dc.w	$BB0, $4C
	dc.w	$1570, $16C
	dc.w	$1B0, $72C
	dc.w	$1400, $2AC

; ------------------------------------------------------------------------------

loc_2028EC:
	tst.b	spawn_mode
	beq.s	loc_20290C
	jsr	LoadCheckpoint
	moveq	#0,d0
	moveq	#0,d1
	move.w	8(a6),d1
	move.w	$C(a6),d0
	bpl.s	loc_20290A
	moveq	#0,d0

loc_20290A:
	bra.s	loc_202948

; ------------------------------------------------------------------------------

loc_20290C:
	lea	StagePlayerSpawn,a1
	tst.w	stage_demo
	bpl.s	loc_20292E
	move.w	s1_credits_index,d0
	subq.w	#1,d0
	lsl.w	#2,d0
	lea	unk_2028CC,a1
	adda.w	d0,a1
	bra.s	loc_202938

; ------------------------------------------------------------------------------

loc_20292E:
	move.w	stage_demo,d0
	lsl.w	#2,d0
	adda.w	d0,a1

loc_202938:
	moveq	#0,d1
	move.w	(a1)+,d1
	move.w	d1,8(a6)
	moveq	#0,d0
	move.w	(a1),d0
	move.w	d0,$C(a6)

loc_202948:
	subi.w	#$A0,d1
	bcc.s	loc_202950
	moveq	#0,d1

loc_202950:
	move.w	right_bound,d2
	cmp.w	d2,d1
	bcs.s	loc_20295A
	move.w	d2,d1

loc_20295A:
	move.w	d1,scroll_fg_x
	subi.w	#$60,d0
	bcc.s	loc_202966
	moveq	#0,d0

loc_202966:
	cmp.w	bottom_bound,d0
	blt.s	loc_202970
	move.w	bottom_bound,d0

loc_202970:
	move.w	d0,scroll_fg_y
	bsr.w	sub_20298C
	lea	unk_202988,a1
	move.l	(a1),loop_chunk_1
	rts

; ------------------------------------------------------------------------------

StagePlayerSpawn:
	incbin	"src/maps/r8/spawn_2b.bin"
	even

unk_202988:
	dc.b	$7F, $7F, $7F, $7F

; ------------------------------------------------------------------------------

sub_20298C:
	swap	d0
	lsr.l	#3,d0
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
	beq.s	loc_2029C4
	rts

; ------------------------------------------------------------------------------

loc_2029C4:
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
	move.l	scroll_fg_y,d0
	lsr.l	#3,d0
	swap	d0
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
	bsr.w	sub_202AF2
	move.w	scroll_bg_x,d0
	neg.w	d0
	moveq	#3,d6

loc_202A6A:
	move.w	d0,(a1)+
	dbf	d6,loc_202A6A
	bsr.w	sub_202AC2
	move.w	scroll_bg3_x,d0
	neg.w	d0
	moveq	#9,d6

loc_202A7C:
	move.w	d0,(a1)+
	dbf	d6,loc_202A7C
	move.w	scroll_bg2_x,d0
	neg.w	d0
	moveq	#$B,d6

loc_202A8A:
	move.w	d0,(a1)+
	dbf	d6,loc_202A8A
	lea	scroll_lines,a1
	lea	bg_scroll_lines,a2
	move.w	scroll_bg_y,d0
	move.w	d0,d2
	andi.w	#$3F8,d0
	lsr.w	#2,d0
	moveq	#$1C,d1
	lea	(a2,d0.w),a2
	bra.w	loc_202B3C

; ------------------------------------------------------------------------------

byte_202AAE:
	dc.b	1
	dc.b	1
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0

byte_202AB6:
	dc.b	1
	dc.b	1
	dc.b	1
	dc.b	1
	dc.b	1
	dc.b	1
	dc.b	1
	dc.b	3
	dc.b	3
	dc.b	1
	dc.b	1
	dc.b	1

; ------------------------------------------------------------------------------

sub_202AC2:
	move.w	scroll_bg_x,d0
	move.w	scroll_bg3_x,d2
	moveq	#8,d6
	bsr.w	sub_202B2A
	move.w	scroll_bg_x,d3
	moveq	#7,d6

loc_202AD6:
	move.w	d3,d0
	neg.w	d0
	moveq	#0,d5
	move.b	byte_202AAE(pc,d6.w),d5

loc_202AE0:
	move.w	d0,(a1)+
	dbf	d5,loc_202AE0
	swap	d3
	add.l	d2,d3
	swap	d3
	dbf	d6,loc_202AD6
	rts

; ------------------------------------------------------------------------------

sub_202AF2:
	move.w	scroll_bg_x,d0
	move.w	scroll_fg_x,d2
	moveq	#$C,d6
	bsr.w	sub_202B2A
	move.w	scroll_bg_x,d3
	moveq	#$B,d6
	adda.w	#$38,a1

loc_202B0A:
	move.w	d3,d0
	neg.w	d0
	moveq	#0,d5
	move.b	byte_202AB6(pc,d6.w),d5

loc_202B14:
	move.w	d0,-(a1)
	dbf	d5,loc_202B14
	swap	d3
	add.l	d2,d3
	swap	d3
	dbf	d6,loc_202B0A
	adda.w	#$38,a1
	rts

; ------------------------------------------------------------------------------

sub_202B2A:
	sub.w	d0,d2
	ext.l	d2
	moveq	#6,d1
	asl.l	d1,d2
	divu.w	d6,d2
	ext.l	d2
	moveq	#$A,d1
	asl.l	d1,d2
	rts

; ------------------------------------------------------------------------------

loc_202B3C:
	andi.w	#7,d2
	add.w	d2,d2
	move.w	(a2)+,d0
	jmp	loc_202B4A(pc,d2.w)

; ------------------------------------------------------------------------------

loc_202B48:
	move.w	(a2)+,d0

loc_202B4A:
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	dbf	d1,loc_202B48
	rts

; ------------------------------------------------------------------------------

	neg.w	d0
	jmp	loc_202B68(pc,d2.w)

; ------------------------------------------------------------------------------

	neg.w	d0

loc_202B68:
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	dbf	d1,loc_202B48
	rts

; ------------------------------------------------------------------------------

ScrollFgX:
	move.w	scroll_fg_x,d4
	bsr.s	CheckScrollFgX
	move.w	scroll_fg_x,d0
	andi.w	#$10,d0
	move.b	scroll_cross_x,d1
	eor.b	d1,d0
	bne.s	locret_202BB0
	eori.b	#$10,scroll_cross_x
	move.w	scroll_fg_x,d0
	sub.w	d4,d0
	bpl.s	loc_202BAA
	bset	#2,scroll_flags_fg
	rts

; ------------------------------------------------------------------------------

loc_202BAA:
	bset	#3,scroll_flags_fg

locret_202BB0:
	rts

; ------------------------------------------------------------------------------

CheckScrollFgX:
	move.w	8(a6),d0
	sub.w	scroll_fg_x,d0
	sub.w	scroll_focus_x,d0
	beq.s	loc_202BC4
	bcs.s	loc_202BF4
	bra.s	loc_202BCA

; ------------------------------------------------------------------------------

loc_202BC4:
	clr.w	scroll_x_move
	rts

; ------------------------------------------------------------------------------

loc_202BCA:
	cmpi.w	#$10,d0
	blt.s	loc_202BD4
	move.w	#$10,d0

loc_202BD4:
	add.w	scroll_fg_x,d0
	cmp.w	right_bound,d0
	blt.s	loc_202BE2
	move.w	right_bound,d0

loc_202BE2:
	move.w	d0,d1
	sub.w	scroll_fg_x,d1
	asl.w	#8,d1
	move.w	d0,scroll_fg_x
	move.w	d1,scroll_x_move
	rts

; ------------------------------------------------------------------------------

loc_202BF4:
	cmpi.w	#$FFF0,d0
	bge.s	loc_202BFE
	move.w	#$FFF0,d0

loc_202BFE:
	add.w	scroll_fg_x,d0
	cmp.w	left_bound,d0
	bgt.s	loc_202BE2
	move.w	left_bound,d0
	bra.s	loc_202BE2

; ------------------------------------------------------------------------------

ScrollFgXSlow:
	tst.w	d0
	bpl.s	loc_202C18
	move.w	#$FFFE,d0
	bra.s	loc_202BF4

; ------------------------------------------------------------------------------

loc_202C18:
	move.w	#2,d0
	bra.s	loc_202BCA

; ------------------------------------------------------------------------------

ScrollFgY:
	moveq	#0,d1
	move.w	$C(a6),d0
	sub.w	scroll_fg_y,d0
	btst	#2,$22(a6)
	beq.s	loc_202C32
	subq.w	#5,d0

loc_202C32:
	btst	#1,$22(a6)
	beq.s	loc_202C52
	addi.w	#$20,d0
	sub.w	scroll_focus_y,d0
	bcs.s	loc_202C9E
	subi.w	#$40,d0
	bcc.s	loc_202C9E
	tst.b	bottom_bound_shift
	bne.s	loc_202CB0
	bra.s	loc_202C5E

; ------------------------------------------------------------------------------

loc_202C52:
	sub.w	scroll_focus_y,d0
	bne.s	loc_202C64
	tst.b	bottom_bound_shift
	bne.s	loc_202CB0

loc_202C5E:
	clr.w	scroll_y_move
	rts

; ------------------------------------------------------------------------------

loc_202C64:
	cmpi.w	#$60,scroll_focus_y
	bne.s	loc_202C8C
	move.w	$14(a6),d1
	bpl.s	loc_202C74
	neg.w	d1

loc_202C74:
	cmpi.w	#$800,d1
	bcc.s	loc_202C9E
	move.w	#$600,d1
	cmpi.w	#6,d0
	bgt.s	loc_202CFE
	cmpi.w	#$FFFA,d0
	blt.s	loc_202CC8
	bra.s	loc_202CB6

; ------------------------------------------------------------------------------

loc_202C8C:
	move.w	#$200,d1
	cmpi.w	#2,d0
	bgt.s	loc_202CFE
	cmpi.w	#$FFFE,d0
	blt.s	loc_202CC8
	bra.s	loc_202CB6

; ------------------------------------------------------------------------------

loc_202C9E:
	move.w	#$1000,d1
	cmpi.w	#$10,d0
	bgt.s	loc_202CFE
	cmpi.w	#$FFF0,d0
	blt.s	loc_202CC8
	bra.s	loc_202CB6

; ------------------------------------------------------------------------------

loc_202CB0:
	moveq	#0,d0
	move.b	d0,bottom_bound_shift

loc_202CB6:
	moveq	#0,d1
	move.w	d0,d1
	add.w	scroll_fg_y,d1
	tst.w	d0
	bpl.w	loc_202D08
	bra.w	loc_202CD4

; ------------------------------------------------------------------------------

loc_202CC8:
	neg.w	d1
	ext.l	d1
	asl.l	#8,d1
	add.l	scroll_fg_y,d1
	swap	d1

loc_202CD4:
	cmp.w	top_bound,d1
	bgt.s	loc_202D2C
	cmpi.w	#$FF00,d1
	bgt.s	loc_202CF8
	andi.w	#$7FF,d1
	andi.w	#$7FF,$C(a6)
	andi.w	#$7FF,scroll_fg_y
	andi.w	#$3FF,scroll_bg_y
	bra.s	loc_202D2C

; ------------------------------------------------------------------------------

loc_202CF8:
	move.w	top_bound,d1
	bra.s	loc_202D2C

; ------------------------------------------------------------------------------

loc_202CFE:
	ext.l	d1
	asl.l	#8,d1
	add.l	scroll_fg_y,d1
	swap	d1

loc_202D08:
	cmp.w	bottom_bound,d1
	blt.s	loc_202D2C
	subi.w	#$800,d1
	bcs.s	loc_202D28
	andi.w	#$7FF,$C(a6)
	subi.w	#$800,scroll_fg_y
	andi.w	#$3FF,scroll_bg_y
	bra.s	loc_202D2C

; ------------------------------------------------------------------------------

loc_202D28:
	move.w	bottom_bound,d1

loc_202D2C:
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
	bne.s	locret_202D6E
	eori.b	#$10,scroll_cross_y
	move.w	scroll_fg_y,d0
	sub.w	d4,d0
	bpl.s	loc_202D68
	bset	#0,scroll_flags_fg
	rts

; ------------------------------------------------------------------------------

loc_202D68:
	bset	#1,scroll_flags_fg

locret_202D6E:
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
	bne.s	loc_202DA4
	eori.b	#$10,scroll_cross_bg_x
	sub.l	d2,d0
	bpl.s	loc_202D9E
	bset	#2,scroll_flags_bg
	bra.s	loc_202DA4

; ------------------------------------------------------------------------------

loc_202D9E:
	bset	#3,scroll_flags_bg

loc_202DA4:
	move.l	scroll_bg_y,d3
	move.l	d3,d0
	add.l	d5,d0
	move.l	d0,scroll_bg_y
	move.l	d0,d1
	swap	d1
	andi.w	#$10,d1
	move.b	scroll_cross_bg_y,d2
	eor.b	d2,d1
	bne.s	locret_202DD8
	eori.b	#$10,scroll_cross_bg_y
	sub.l	d3,d0
	bpl.s	loc_202DD2
	bset	#0,scroll_flags_bg
	rts

; ------------------------------------------------------------------------------

loc_202DD2:
	bset	#1,scroll_flags_bg

locret_202DD8:
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
	bne.s	locret_202E0E
	eori.b	#$10,scroll_cross_bg_y
	sub.l	d3,d0
	bpl.s	loc_202E08
	bset	#4,scroll_flags_bg
	rts

; ------------------------------------------------------------------------------

loc_202E08:
	bset	#5,scroll_flags_bg

locret_202E0E:
	rts

; ------------------------------------------------------------------------------

ScrollBgY:
	move.w	scroll_bg_y,d3
	move.w	d0,scroll_bg_y
	move.w	d0,d1
	andi.w	#$10,d1
	move.b	scroll_cross_bg_y,d2
	eor.b	d2,d1
	bne.s	locret_202E3E
	eori.b	#$10,scroll_cross_bg_y
	sub.w	d3,d0
	bpl.s	loc_202E38
	bset	#0,scroll_flags_bg
	rts

; ------------------------------------------------------------------------------

loc_202E38:
	bset	#1,scroll_flags_bg

locret_202E3E:
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
	bne.s	locret_202E72
	eori.b	#$10,scroll_cross_bg_x
	sub.l	d2,d0
	bpl.s	loc_202E6C
	bset	d6,scroll_flags_bg
	bra.s	locret_202E72

; ------------------------------------------------------------------------------

loc_202E6C:
	addq.b	#1,d6
	bset	d6,scroll_flags_bg

locret_202E72:
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
	bne.s	locret_202EA6
	eori.b	#$10,scroll_cross_bg2_x
	sub.l	d2,d0
	bpl.s	loc_202EA0
	bset	d6,scroll_flags_bg2
	bra.s	locret_202EA6

; ------------------------------------------------------------------------------

loc_202EA0:
	addq.b	#1,d6
	bset	d6,scroll_flags_bg2

locret_202EA6:
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
	bne.s	locret_202EDA
	eori.b	#$10,scroll_cross_bg3_x
	sub.l	d2,d0
	bpl.s	loc_202ED4
	bset	d6,scroll_flags_bg3
	bra.s	locret_202EDA

; ------------------------------------------------------------------------------

loc_202ED4:
	addq.b	#1,d6
	bset	d6,scroll_flags_bg3

locret_202EDA:
	rts

; ------------------------------------------------------------------------------
