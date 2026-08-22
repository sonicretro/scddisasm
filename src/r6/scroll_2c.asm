; ------------------------------------------------------------------------------

InitScroll:
	lea	player_object,a6
	moveq	#0,d0
	move.b	d0,unused_scroll_x_flag
	move.b	d0,unused_scroll_y_flag
	move.b	d0,unused_scroll_die
	move.b	d0,unused_scroll_timer
	move.b	d0,event_routine
	lea	unk_2028BA,a0
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
	bra.w	loc2_2028C6

; ------------------------------------------------------------------------------

unk_2028BA:
	dc.b	0
	dc.b	4
	dc.b	0
	dc.b	0
	dc.b	$23
	dc.b	$97
	dc.b	0
	dc.b	0
	dc.b	7
	dc.b	$10
	dc.b	0
	dc.b	$60

; ------------------------------------------------------------------------------

loc2_2028C6:
	tst.b	spawn_mode
	beq.s	loc_2028E6
	jsr	LoadCheckpoint
	moveq	#0,d0
	moveq	#0,d1
	move.w	8(a6),d1
	move.w	$C(a6),d0
	bpl.s	loc_2028E4
	moveq	#0,d0

loc_2028E4:
	bra.s	loc_2028FC

; ------------------------------------------------------------------------------

loc_2028E6:
	lea	StagePlayerSpawn,a1
	moveq	#0,d1
	move.w	(a1)+,d1
	move.w	d1,8(a6)
	moveq	#0,d0
	move.w	(a1),d0
	move.w	d0,$C(a6)

loc_2028FC:
	subi.w	#$A0,d1
	bcc.s	loc_202904
	moveq	#0,d1

loc_202904:
	move.w	right_bound,d2
	cmp.w	d2,d1
	bcs.s	loc_20290E
	move.w	d2,d1

loc_20290E:
	move.w	d1,scroll_fg_x
	subi.w	#$60,d0
	bcc.s	loc_20291A
	moveq	#0,d0

loc_20291A:
	cmp.w	bottom_bound,d0
	blt.s	loc_202924
	move.w	bottom_bound,d0

loc_202924:
	move.w	d0,scroll_fg_y
	bsr.w	sub_202940
	lea	unk_20293C,a1
	move.l	(a1),loop_chunk_1
	rts

; ------------------------------------------------------------------------------

StagePlayerSpawn:
	incbin	"src/maps/r6/spawn_2c.bin"
	even

unk_20293C:
	dc.b	$7F
	dc.b	$7F
	dc.b	$7F
	dc.b	$7F

; ------------------------------------------------------------------------------

sub_202940:
	swap	d0
	lsr.l	#2,d0
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
	beq.s	loc_202978
	rts

; ------------------------------------------------------------------------------

loc_202978:
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
	bsr.w	sub_202A58
	move.w	scroll_bg3_x,d0
	neg.w	d0
	moveq	#$17,d6

loc_202A1C:
	move.w	d0,(a1)+
	dbf	d6,loc_202A1C
	move.w	scroll_bg2_x,d0
	neg.w	d0
	moveq	#$2D,d6

loc_202A2A:
	move.w	d0,(a1)+
	dbf	d6,loc_202A2A
	lea	scroll_lines,a1
	lea	bg_scroll_lines,a2
	move.w	scroll_bg_y,d0
	move.w	d0,d2
	andi.w	#$3F8,d0
	lsr.w	#2,d0
	moveq	#$1D,d1
	lea	(a2,d0.w),a2
	bra.w	loc_202A9E

; ------------------------------------------------------------------------------

byte_202A4E:
	dc.b	5
	dc.b	3
	dc.b	2
	dc.b	2
	dc.b	1
	dc.b	1
	dc.b	1
	dc.b	1
	dc.b	1
	dc.b	0

; ------------------------------------------------------------------------------

sub_202A58:
	move.w	scroll_bg_x,d0
	move.w	scroll_fg_x,d2
	sub.w	d0,d2
	ext.l	d2
	moveq	#0,d3
	move.w	scroll_bg_x,d4
	moveq	#8,d6
	adda.w	#$34,a1

loc_202A70:
	move.b	d3,d0
	jsr	SineCosine
	move.w	#$100,d5
	sub.w	d1,d5
	muls.w	d2,d5
	lsr.l	#8,d5
	add.w	d4,d5
	neg.w	d5
	moveq	#0,d1
	move.b	byte_202A4E(pc,d6.w),d1

loc_202A8C:
	move.w	d5,-(a1)
	dbf	d1,loc_202A8C
	addq.b	#6,d3
	dbf	d6,loc_202A70
	adda.w	#$34,a1
	rts

; ------------------------------------------------------------------------------

loc_202A9E:
	andi.w	#7,d2
	add.w	d2,d2
	move.w	(a2)+,d0
	jmp	loc_202AAC(pc,d2.w)

; ------------------------------------------------------------------------------

loc_202AAA:
	move.w	(a2)+,d0

loc_202AAC:
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	dbf	d1,loc_202AAA
	rts

; ------------------------------------------------------------------------------

	neg.w	d0
	jmp	loc_202ACA(pc,d2.w)

; ------------------------------------------------------------------------------

	neg.w	d0

loc_202ACA:
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	dbf	d1,loc_202AAA
	rts

; ------------------------------------------------------------------------------

ScrollFgX:
	move.w	scroll_fg_x,d4
	bsr.s	CheckScrollFgX
	move.w	scroll_fg_x,d0
	andi.w	#$10,d0
	move.b	scroll_cross_x,d1
	eor.b	d1,d0
	bne.s	locret_202B12
	eori.b	#$10,scroll_cross_x
	move.w	scroll_fg_x,d0
	sub.w	d4,d0
	bpl.s	loc_202B0C
	bset	#2,scroll_flags_fg
	rts

; ------------------------------------------------------------------------------

loc_202B0C:
	bset	#3,scroll_flags_fg

locret_202B12:
	rts

; ------------------------------------------------------------------------------

CheckScrollFgX:
	move.w	8(a6),d0
	sub.w	scroll_fg_x,d0
	sub.w	scroll_focus_x,d0
	beq.s	loc_202B26
	bcs.s	loc_202B56
	bra.s	loc_202B2C

; ------------------------------------------------------------------------------

loc_202B26:
	clr.w	scroll_x_move
	rts

; ------------------------------------------------------------------------------

loc_202B2C:
	cmpi.w	#$10,d0
	blt.s	loc_202B36
	move.w	#$10,d0

loc_202B36:
	add.w	scroll_fg_x,d0
	cmp.w	right_bound,d0
	blt.s	loc_202B44
	move.w	right_bound,d0

loc_202B44:
	move.w	d0,d1
	sub.w	scroll_fg_x,d1
	asl.w	#8,d1
	move.w	d0,scroll_fg_x
	move.w	d1,scroll_x_move
	rts

; ------------------------------------------------------------------------------

loc_202B56:
	cmpi.w	#$FFF0,d0
	bge.s	loc_202B60
	move.w	#$FFF0,d0

loc_202B60:
	add.w	scroll_fg_x,d0
	cmp.w	left_bound,d0
	bgt.s	loc_202B44
	move.w	left_bound,d0
	bra.s	loc_202B44

; ------------------------------------------------------------------------------

ScrollFgXSlow:
	tst.w	d0
	bpl.s	loc_202B7A
	move.w	#$FFFE,d0
	bra.s	loc_202B56

; ------------------------------------------------------------------------------

loc_202B7A:
	move.w	#2,d0
	bra.s	loc_202B2C

; ------------------------------------------------------------------------------

ScrollFgY:
	moveq	#0,d1
	move.w	$C(a6),d0
	sub.w	scroll_fg_y,d0
	btst	#2,$22(a6)
	beq.s	loc_202B94
	subq.w	#5,d0

loc_202B94:
	btst	#1,$22(a6)
	beq.s	loc_202BB4
	addi.w	#$20,d0
	sub.w	scroll_focus_y,d0
	bcs.s	loc_202C00
	subi.w	#$40,d0
	bcc.s	loc_202C00
	tst.b	bottom_bound_shift
	bne.s	loc_202C12
	bra.s	loc_202BC0

; ------------------------------------------------------------------------------

loc_202BB4:
	sub.w	scroll_focus_y,d0
	bne.s	loc_202BC6
	tst.b	bottom_bound_shift
	bne.s	loc_202C12

loc_202BC0:
	clr.w	scroll_y_move
	rts

; ------------------------------------------------------------------------------

loc_202BC6:
	cmpi.w	#$60,scroll_focus_y
	bne.s	loc_202BEE
	move.w	$14(a6),d1
	bpl.s	loc_202BD6
	neg.w	d1

loc_202BD6:
	cmpi.w	#$800,d1
	bcc.s	loc_202C00
	move.w	#$600,d1
	cmpi.w	#6,d0
	bgt.s	loc_202C60
	cmpi.w	#$FFFA,d0
	blt.s	loc_202C2A
	bra.s	loc_202C18

; ------------------------------------------------------------------------------

loc_202BEE:
	move.w	#$200,d1
	cmpi.w	#2,d0
	bgt.s	loc_202C60
	cmpi.w	#$FFFE,d0
	blt.s	loc_202C2A
	bra.s	loc_202C18

; ------------------------------------------------------------------------------

loc_202C00:
	move.w	#$1000,d1
	cmpi.w	#$10,d0
	bgt.s	loc_202C60
	cmpi.w	#$FFF0,d0
	blt.s	loc_202C2A
	bra.s	loc_202C18

; ------------------------------------------------------------------------------

loc_202C12:
	moveq	#0,d0
	move.b	d0,bottom_bound_shift

loc_202C18:
	moveq	#0,d1
	move.w	d0,d1
	add.w	scroll_fg_y,d1
	tst.w	d0
	bpl.w	loc_202C6A
	bra.w	loc_202C36

; ------------------------------------------------------------------------------

loc_202C2A:
	neg.w	d1
	ext.l	d1
	asl.l	#8,d1
	add.l	scroll_fg_y,d1
	swap	d1

loc_202C36:
	cmp.w	top_bound,d1
	bgt.s	loc_202C8E
	cmpi.w	#$FF00,d1
	bgt.s	loc_202C5A
	andi.w	#$7FF,d1
	andi.w	#$7FF,$C(a6)
	andi.w	#$7FF,scroll_fg_y
	andi.w	#$3FF,scroll_bg_y
	bra.s	loc_202C8E

; ------------------------------------------------------------------------------

loc_202C5A:
	move.w	top_bound,d1
	bra.s	loc_202C8E

; ------------------------------------------------------------------------------

loc_202C60:
	ext.l	d1
	asl.l	#8,d1
	add.l	scroll_fg_y,d1
	swap	d1

loc_202C6A:
	cmp.w	bottom_bound,d1
	blt.s	loc_202C8E
	subi.w	#$800,d1
	bcs.s	loc_202C8A
	andi.w	#$7FF,$C(a6)
	subi.w	#$800,scroll_fg_y
	andi.w	#$3FF,scroll_bg_y
	bra.s	loc_202C8E

; ------------------------------------------------------------------------------

loc_202C8A:
	move.w	bottom_bound,d1

loc_202C8E:
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
	bne.s	locret_202CD0
	eori.b	#$10,scroll_cross_y
	move.w	scroll_fg_y,d0
	sub.w	d4,d0
	bpl.s	loc_202CCA
	bset	#0,scroll_flags_fg
	rts

; ------------------------------------------------------------------------------

loc_202CCA:
	bset	#1,scroll_flags_fg

locret_202CD0:
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
	bne.s	loc_202D06
	eori.b	#$10,scroll_cross_bg_x
	sub.l	d2,d0
	bpl.s	loc_202D00
	bset	#2,scroll_flags_bg
	bra.s	loc_202D06

; ------------------------------------------------------------------------------

loc_202D00:
	bset	#3,scroll_flags_bg

loc_202D06:
	move.l	scroll_bg_y,d3
	move.l	d3,d0
	add.l	d5,d0
	move.l	d0,scroll_bg_y
	move.l	d0,d1
	swap	d1
	andi.w	#$10,d1
	move.b	scroll_cross_bg_y,d2
	eor.b	d2,d1
	bne.s	locret_202D3A
	eori.b	#$10,scroll_cross_bg_y
	sub.l	d3,d0
	bpl.s	loc_202D34
	bset	#0,scroll_flags_bg
	rts

; ------------------------------------------------------------------------------

loc_202D34:
	bset	#1,scroll_flags_bg

locret_202D3A:
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
	bne.s	locret_202D70
	eori.b	#$10,scroll_cross_bg_y
	sub.l	d3,d0
	bpl.s	loc_202D6A
	bset	#4,scroll_flags_bg
	rts

; ------------------------------------------------------------------------------

loc_202D6A:
	bset	#5,scroll_flags_bg

locret_202D70:
	rts

; ------------------------------------------------------------------------------

ScrollBgY:
	move.w	scroll_bg_y,d3
	move.w	d0,scroll_bg_y
	move.w	d0,d1
	andi.w	#$10,d1
	move.b	scroll_cross_bg_y,d2
	eor.b	d2,d1
	bne.s	locret_202DA0
	eori.b	#$10,scroll_cross_bg_y
	sub.w	d3,d0
	bpl.s	loc_202D9A
	bset	#0,scroll_flags_bg
	rts

; ------------------------------------------------------------------------------

loc_202D9A:
	bset	#1,scroll_flags_bg

locret_202DA0:
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
	bne.s	locret_202DD4
	eori.b	#$10,scroll_cross_bg_x
	sub.l	d2,d0
	bpl.s	loc_202DCE
	bset	d6,scroll_flags_bg
	bra.s	locret_202DD4

; ------------------------------------------------------------------------------

loc_202DCE:
	addq.b	#1,d6
	bset	d6,scroll_flags_bg

locret_202DD4:
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
	bne.s	locret_202E08
	eori.b	#$10,scroll_cross_bg2_x
	sub.l	d2,d0
	bpl.s	loc_202E02
	bset	d6,scroll_flags_bg2
	bra.s	locret_202E08

; ------------------------------------------------------------------------------

loc_202E02:
	addq.b	#1,d6
	bset	d6,scroll_flags_bg2

locret_202E08:
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
	bne.s	locret_202E3C
	eori.b	#$10,scroll_cross_bg3_x
	sub.l	d2,d0
	bpl.s	loc_202E36
	bset	d6,scroll_flags_bg3
	bra.s	locret_202E3C

; ------------------------------------------------------------------------------

loc_202E36:
	addq.b	#1,d6
	bset	d6,scroll_flags_bg3

locret_202E3C:
	rts

; ------------------------------------------------------------------------------
