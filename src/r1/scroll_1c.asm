; ------------------------------------------------------------------------------

GetPlayerObject:
	lea	player_object,a6
	tst.b	use_player_2
	beq.s	locret_20279A
	lea	player_object_2,a6

locret_20279A:
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
	lea	unk_2027F8,a0
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
	bra.w	loc_202824

; ------------------------------------------------------------------------------

unk_2027F8:
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

unk_202804:
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

loc_202824:
	tst.b	spawn_mode
	beq.s	loc_202844
	jsr	LoadCheckpoint
	moveq	#0,d0
	moveq	#0,d1
	move.w	8(a6),d1
	move.w	$C(a6),d0
	bpl.s	loc_202842
	moveq	#0,d0

loc_202842:
	bra.s	loc_202880

; ------------------------------------------------------------------------------

loc_202844:
	lea	StagePlayerSpawn,a1
	tst.w	stage_demo
	bpl.s	loc_202866
	move.w	s1_credits_index,d0
	subq.w	#1,d0
	lsl.w	#2,d0
	lea	unk_202804,a1
	adda.w	d0,a1
	bra.s	loc_202870

; ------------------------------------------------------------------------------

loc_202866:
	move.w	stage_demo,d0
	lsl.w	#2,d0
	adda.w	d0,a1

loc_202870:
	moveq	#0,d1
	move.w	(a1)+,d1
	move.w	d1,8(a6)
	moveq	#0,d0
	move.w	(a1),d0
	move.w	d0,$C(a6)

loc_202880:
	subi.w	#$A0,d1
	bcc.s	loc_202888
	moveq	#0,d1

loc_202888:
	move.w	right_bound,d2
	cmp.w	d2,d1
	bcs.s	loc_202892
	move.w	d2,d1

loc_202892:
	move.w	d1,scroll_fg_x
	subi.w	#$60,d0
	bcc.s	loc_20289E
	moveq	#0,d0

loc_20289E:
	cmp.w	bottom_bound,d0
	blt.s	loc_2028A8
	move.w	bottom_bound,d0

loc_2028A8:
	move.w	d0,scroll_fg_y
	bsr.w	sub_2028C4
	lea	unk_2028C0,a1
	move.l	(a1),loop_chunk_1
	rts

; ------------------------------------------------------------------------------

StagePlayerSpawn:
	incbin	"src/maps/r1/spawn_1c.bin"
	even

unk_2028C0:
	dc.b	$8C
	dc.b	$7F
	dc.b	$1E
	dc.b	$1E

; ------------------------------------------------------------------------------

sub_2028C4:
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
	beq.s	loc_20290A
	rts

; ------------------------------------------------------------------------------

loc_20290A:
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

loc_2029C6:
	move.w	d0,(a1)+
	dbf	d1,loc_2029C6
	move.w	bg_scroll_lines+4,d0
	add.w	scroll_bg3_x,d0
	neg.w	d0
	move.w	#3,d1

loc_2029DA:
	move.w	d0,(a1)+
	dbf	d1,loc_2029DA
	move.w	bg_scroll_lines+8,d0
	add.w	scroll_bg3_x,d0
	neg.w	d0
	move.w	#1,d1

loc_2029EE:
	move.w	d0,(a1)+
	dbf	d1,loc_2029EE
	move.w	bg_scroll_lines+$C,d0
	add.w	scroll_bg3_x,d0
	neg.w	d0
	move.w	#1,d1

loc_202A02:
	move.w	d0,(a1)+
	dbf	d1,loc_202A02
	move.w	#5,d1
	move.w	scroll_bg3_x,d0
	neg.w	d0

loc_202A12:
	move.w	d0,(a1)+
	dbf	d1,loc_202A12
	move.w	#1,d1
	move.w	scroll_bg_x,d0
	neg.w	d0

loc_202A22:
	move.w	d0,(a1)+
	dbf	d1,loc_202A22
	move.w	#7,d1
	move.w	scroll_bg2_x,d0
	neg.w	d0

loc_202A32:
	move.w	d0,(a1)+
	dbf	d1,loc_202A32
	lea	scroll_lines,a1
	lea	bg_scroll_lines+$10,a2
	move.w	scroll_bg_y,d0
	move.w	d0,d2
	andi.w	#$1F8,d0
	lsr.w	#2,d0
	move.w	d0,d3
	lsr.w	#1,d3
	moveq	#$1B,d1
	moveq	#$1C,d5
	sub.w	d3,d1
	bcs.s	loc_202A62
	sub.w	d1,d5
	lea	(a2,d0.w),a2
	bsr.w	sub_202A94

loc_202A62:
	move.w	scroll_bg2_x,d0
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

loc_202A82:
	move.w	d3,d0
	neg.w	d0
	move.l	d0,(a1)+
	swap	d3
	add.l	d2,d3
	swap	d3
	dbf	d1,loc_202A82
	rts

; ------------------------------------------------------------------------------

sub_202A94:
	andi.w	#7,d2
	add.w	d2,d2
	move.w	(a2)+,d0
	jmp	loc_202AA2(pc,d2.w)

; ------------------------------------------------------------------------------

loc_202AA0:
	move.w	(a2)+,d0

loc_202AA2:
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	dbf	d1,loc_202AA0
	rts

; ------------------------------------------------------------------------------

	neg.w	d0
	jmp	loc_202AC0(pc,d2.w)

; ------------------------------------------------------------------------------

	neg.w	d0

loc_202AC0:
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	dbf	d1,loc_202AA0
	rts

; ------------------------------------------------------------------------------

ScrollFgX:
	move.w	scroll_fg_x,d4
	bsr.s	CheckScrollFgX
	move.w	scroll_fg_x,d0
	andi.w	#$10,d0
	move.b	scroll_cross_x,d1
	eor.b	d1,d0
	bne.s	locret_202B08
	eori.b	#$10,scroll_cross_x
	move.w	scroll_fg_x,d0
	sub.w	d4,d0
	bpl.s	loc_202B02
	bset	#2,scroll_flags_fg
	rts

; ------------------------------------------------------------------------------

loc_202B02:
	bset	#3,scroll_flags_fg

locret_202B08:
	rts

; ------------------------------------------------------------------------------

CheckScrollFgX:
	move.w	8(a6),d0
	sub.w	scroll_fg_x,d0
	sub.w	scroll_focus_x,d0
	beq.s	loc_202B1C
	bcs.s	loc_202B4C
	bra.s	loc_202B22

; ------------------------------------------------------------------------------

loc_202B1C:
	clr.w	scroll_x_move
	rts

; ------------------------------------------------------------------------------

loc_202B22:
	cmpi.w	#$10,d0
	blt.s	loc_202B2C
	move.w	#$10,d0

loc_202B2C:
	add.w	scroll_fg_x,d0
	cmp.w	right_bound,d0
	blt.s	loc_202B3A
	move.w	right_bound,d0

loc_202B3A:
	move.w	d0,d1
	sub.w	scroll_fg_x,d1
	asl.w	#8,d1
	move.w	d0,scroll_fg_x
	move.w	d1,scroll_x_move
	rts

; ------------------------------------------------------------------------------

loc_202B4C:
	cmpi.w	#$FFF0,d0
	bge.s	loc_202B56
	move.w	#$FFF0,d0

loc_202B56:
	add.w	scroll_fg_x,d0
	cmp.w	left_bound,d0
	bgt.s	loc_202B3A
	move.w	left_bound,d0
	bra.s	loc_202B3A

; ------------------------------------------------------------------------------

ScrollFgXSlow:
	tst.w	d0
	bpl.s	loc_202B70
	move.w	#$FFFE,d0
	bra.s	loc_202B4C

; ------------------------------------------------------------------------------

loc_202B70:
	move.w	#2,d0
	bra.s	loc_202B22

; ------------------------------------------------------------------------------

ScrollFgY:
	moveq	#0,d1
	move.w	$C(a6),d0
	sub.w	scroll_fg_y,d0
	btst	#2,$22(a6)
	beq.s	loc_202B8A
	subq.w	#5,d0

loc_202B8A:
	btst	#1,$22(a6)
	beq.s	loc_202BAA
	addi.w	#$20,d0
	sub.w	scroll_focus_y,d0
	bcs.s	loc_202BF6
	subi.w	#$40,d0
	bcc.s	loc_202BF6
	tst.b	bottom_bound_shift
	bne.s	loc_202C08
	bra.s	loc_202BB6

; ------------------------------------------------------------------------------

loc_202BAA:
	sub.w	scroll_focus_y,d0
	bne.s	loc_202BBC
	tst.b	bottom_bound_shift
	bne.s	loc_202C08

loc_202BB6:
	clr.w	scroll_y_move
	rts

; ------------------------------------------------------------------------------

loc_202BBC:
	cmpi.w	#$60,scroll_focus_y
	bne.s	loc_202BE4
	move.w	$14(a6),d1
	bpl.s	loc_202BCC
	neg.w	d1

loc_202BCC:
	cmpi.w	#$800,d1
	bcc.s	loc_202BF6
	move.w	#$600,d1
	cmpi.w	#6,d0
	bgt.s	loc_202C56
	cmpi.w	#$FFFA,d0
	blt.s	loc_202C20
	bra.s	loc_202C0E

; ------------------------------------------------------------------------------

loc_202BE4:
	move.w	#$200,d1
	cmpi.w	#2,d0
	bgt.s	loc_202C56
	cmpi.w	#$FFFE,d0
	blt.s	loc_202C20
	bra.s	loc_202C0E

; ------------------------------------------------------------------------------

loc_202BF6:
	move.w	#$1000,d1
	cmpi.w	#$10,d0
	bgt.s	loc_202C56
	cmpi.w	#$FFF0,d0
	blt.s	loc_202C20
	bra.s	loc_202C0E

; ------------------------------------------------------------------------------

loc_202C08:
	moveq	#0,d0
	move.b	d0,bottom_bound_shift

loc_202C0E:
	moveq	#0,d1
	move.w	d0,d1
	add.w	scroll_fg_y,d1
	tst.w	d0
	bpl.w	loc_202C60
	bra.w	loc_202C2C

; ------------------------------------------------------------------------------

loc_202C20:
	neg.w	d1
	ext.l	d1
	asl.l	#8,d1
	add.l	scroll_fg_y,d1
	swap	d1

loc_202C2C:
	cmp.w	top_bound,d1
	bgt.s	loc_202C84
	cmpi.w	#$FF00,d1
	bgt.s	loc_202C50
	andi.w	#$7FF,d1
	andi.w	#$7FF,$C(a6)
	andi.w	#$7FF,scroll_fg_y
	andi.w	#$3FF,scroll_bg_y
	bra.s	loc_202C84

; ------------------------------------------------------------------------------

loc_202C50:
	move.w	top_bound,d1
	bra.s	loc_202C84

; ------------------------------------------------------------------------------

loc_202C56:
	ext.l	d1
	asl.l	#8,d1
	add.l	scroll_fg_y,d1
	swap	d1

loc_202C60:
	cmp.w	bottom_bound,d1
	blt.s	loc_202C84
	subi.w	#$800,d1
	bcs.s	loc_202C80
	andi.w	#$7FF,$C(a6)
	subi.w	#$800,scroll_fg_y
	andi.w	#$3FF,scroll_bg_y
	bra.s	loc_202C84

; ------------------------------------------------------------------------------

loc_202C80:
	move.w	bottom_bound,d1

loc_202C84:
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
	bne.s	locret_202CC6
	eori.b	#$10,scroll_cross_y
	move.w	scroll_fg_y,d0
	sub.w	d4,d0
	bpl.s	loc_202CC0
	bset	#0,scroll_flags_fg
	rts

; ------------------------------------------------------------------------------

loc_202CC0:
	bset	#1,scroll_flags_fg

locret_202CC6:
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
	bne.s	loc_202CFC
	eori.b	#$10,scroll_cross_bg_x
	sub.l	d2,d0
	bpl.s	loc_202CF6
	bset	#2,scroll_flags_bg
	bra.s	loc_202CFC

; ------------------------------------------------------------------------------

loc_202CF6:
	bset	#3,scroll_flags_bg

loc_202CFC:
	move.l	scroll_bg_y,d3
	move.l	d3,d0
	add.l	d5,d0
	move.l	d0,scroll_bg_y
	move.l	d0,d1
	swap	d1
	andi.w	#$10,d1
	move.b	scroll_cross_bg_y,d2
	eor.b	d2,d1
	bne.s	locret_202D30
	eori.b	#$10,scroll_cross_bg_y
	sub.l	d3,d0
	bpl.s	loc_202D2A
	bset	#0,scroll_flags_bg
	rts

; ------------------------------------------------------------------------------

loc_202D2A:
	bset	#1,scroll_flags_bg

locret_202D30:
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
	bne.s	locret_202D66
	eori.b	#$10,scroll_cross_bg_y
	sub.l	d3,d0
	bpl.s	loc_202D60
	bset	#4,scroll_flags_bg
	rts

; ------------------------------------------------------------------------------

loc_202D60:
	bset	#5,scroll_flags_bg

locret_202D66:
	rts

; ------------------------------------------------------------------------------

ScrollBgY:
	move.w	scroll_bg_y,d3
	move.w	d0,scroll_bg_y
	move.w	d0,d1
	andi.w	#$10,d1
	move.b	scroll_cross_bg_y,d2
	eor.b	d2,d1
	bne.s	locret_202D96
	eori.b	#$10,scroll_cross_bg_y
	sub.w	d3,d0
	bpl.s	loc_202D90
	bset	#0,scroll_flags_bg
	rts

; ------------------------------------------------------------------------------

loc_202D90:
	bset	#1,scroll_flags_bg

locret_202D96:
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
	bne.s	locret_202DCA
	eori.b	#$10,scroll_cross_bg_x
	sub.l	d2,d0
	bpl.s	loc_202DC4
	bset	d6,scroll_flags_bg
	bra.s	locret_202DCA

; ------------------------------------------------------------------------------

loc_202DC4:
	addq.b	#1,d6
	bset	d6,scroll_flags_bg

locret_202DCA:
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
	bne.s	locret_202DFE
	eori.b	#$10,scroll_cross_bg2_x
	sub.l	d2,d0
	bpl.s	loc_202DF8
	bset	d6,scroll_flags_bg2
	bra.s	locret_202DFE

; ------------------------------------------------------------------------------

loc_202DF8:
	addq.b	#1,d6
	bset	d6,scroll_flags_bg2

locret_202DFE:
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
	bne.s	locret_202E32
	eori.b	#$10,scroll_cross_bg3_x
	sub.l	d2,d0
	bpl.s	loc_202E2C
	bset	d6,scroll_flags_bg3
	bra.s	locret_202E32

; ------------------------------------------------------------------------------

loc_202E2C:
	addq.b	#1,d6
	bset	d6,scroll_flags_bg3

locret_202E32:
	rts

; ------------------------------------------------------------------------------
