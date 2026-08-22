; ------------------------------------------------------------------------------

InitScroll:
	lea	player_object,a6
	moveq	#0,d0
	move.b	d0,unused_scroll_x_flag
	move.b	d0,unused_scroll_y_flag
	move.b	d0,unused_scroll_die
	move.b	d0,unused_scroll_timer
	move.b	d0,event_routine
	lea	unk_2027F4,a0
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
	bra.w	loc_202800

; ------------------------------------------------------------------------------

unk_2027F4:
	dc.b	0
	dc.b	4
	dc.b	0
	dc.b	0
	dc.b	$2E
	dc.b	$97
	dc.b	0
	dc.b	0
	dc.b	5
	dc.b	$10
	dc.b	0
	dc.b	$60

; ------------------------------------------------------------------------------

loc_202800:
	tst.b	spawn_mode
	beq.s	loc_202820
	jsr	LoadCheckpoint
	moveq	#0,d0
	moveq	#0,d1
	move.w	8(a6),d1
	move.w	$C(a6),d0
	bpl.s	loc_20281E
	moveq	#0,d0

loc_20281E:
	bra.s	loc2_202836

; ------------------------------------------------------------------------------

loc_202820:
	lea	StagePlayerSpawn,a1
	moveq	#0,d1
	move.w	(a1)+,d1
	move.w	d1,8(a6)
	moveq	#0,d0
	move.w	(a1),d0
	move.w	d0,$C(a6)

loc2_202836:
	subi.w	#$A0,d1
	bcc.s	loc_20283E
	moveq	#0,d1

loc_20283E:
	move.w	right_bound,d2
	cmp.w	d2,d1
	bcs.s	loc2_202848
	move.w	d2,d1

loc2_202848:
	move.w	d1,scroll_fg_x
	subi.w	#$60,d0
	bcc.s	loc_202854
	moveq	#0,d0

loc_202854:
	cmp.w	bottom_bound,d0
	blt.s	loc_20285E
	move.w	bottom_bound,d0

loc_20285E:
	move.w	d0,scroll_fg_y
	bsr.w	sub_20287A
	lea	unk_202876,a1
	move.l	(a1),loop_chunk_1
	rts

; ------------------------------------------------------------------------------

StagePlayerSpawn:
	incbin	"src/maps/r7/spawn_1b.bin"
	even

unk_202876:
	dc.b	$84
	dc.b	$86
	dc.b	$7F
	dc.b	$7F

; ------------------------------------------------------------------------------

sub_20287A:
	swap	d0
	lsr.l	#2,d0
	move.l	d0,d2
	lsr.w	#1,d2
	add.l	d2,d0
	move.l	d0,scroll_bg_y
	swap	d0
	move.w	d0,scroll_bg2_y
	move.w	d0,scroll_bg3_y
	lsr.l	#1,d1
	move.w	d1,scroll_bg2_x
	lsr.l	#1,d1
	move.l	d1,d2
	lsr.l	#1,d2
	add.l	d1,d2
	move.w	d2,scroll_bg3_x
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
	beq.s	loc_2028BE
	rts

; ------------------------------------------------------------------------------

loc_2028BE:
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
	move.l	d4,d3
	asr.l	#1,d3
	add.l	d3,d4
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
	lsr.w	#1,d1
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
	bsr.w	sub_2029E0
	move.w	scroll_bg_x,d0
	neg.w	d0
	moveq	#3,d6

loc_20296E:
	move.w	d0,(a1)+
	dbf	d6,loc_20296E
	bsr.w	sub_202A24
	move.w	scroll_bg3_x,d0
	neg.w	d0
	moveq	#$13,d6

loc_202980:
	move.w	d0,(a1)+
	dbf	d6,loc_202980
	lea	scroll_lines,a1
	lea	bg_scroll_lines,a2
	move.w	scroll_bg_y,d0
	move.w	d0,d2
	move.w	d0,d4
	andi.w	#$3F8,d0
	lsr.w	#2,d0
	moveq	#$1D,d1
	lea	WobbleTable,a4
	addi.w	#$80,bg_water_deform
	lea	(a2,d0.w),a2
	bra.w	loc_202A62

; ------------------------------------------------------------------------------

byte_2029B2:
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

byte_2029D8:
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0

; ------------------------------------------------------------------------------

sub_2029E0:
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

loc_202A04:
	move.w	d3,d0
	neg.w	d0
	moveq	#0,d5
	move.b	byte_2029B2(pc,d6.w),d5

loc_202A0E:
	move.w	d0,-(a1)
	dbf	d5,loc_202A0E
	swap	d3
	add.l	d2,d3
	swap	d3
	dbf	d6,loc_202A04
	adda.w	#$58,a1
	rts

; ------------------------------------------------------------------------------

sub_202A24:
	move.w	scroll_bg_x,d0
	move.w	scroll_bg3_x,d2
	sub.w	d0,d2
	ext.l	d2
	moveq	#7,d1
	asl.l	d1,d2
	divu.w	#8,d2
	ext.l	d2
	moveq	#9,d1
	asl.l	d1,d2
	move.w	scroll_bg_x,d3
	moveq	#7,d6

loc_202A44:
	move.w	d3,d0
	neg.w	d0
	moveq	#0,d5
	move.b	byte_2029D8(pc,d6.w),d5

loc_202A4E:
	move.w	d0,(a1)+
	dbf	d5,loc_202A4E
	swap	d3
	add.l	d2,d3
	swap	d3
	dbf	d6,loc_202A44
	rts

; ------------------------------------------------------------------------------

	dc.b	9
	dc.b	7

; ------------------------------------------------------------------------------

loc_202A62:
	andi.w	#7,d2
	addq.w	#8,d4
	sub.w	d2,d4
	add.w	d2,d2
	move.w	(a2)+,d0
	jmp	loc_202A7A(pc,d2.w)

; ------------------------------------------------------------------------------

loc_202A72:
	cmpi.w	#$268,d4
	bcc.s	loc_202A92
	move.w	(a2)+,d0

loc_202A7A:
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	addq.w	#8,d4
	dbf	d1,loc_202A72
	rts

; ------------------------------------------------------------------------------

loc_202A92:
	addq.w	#1,d1
	lsl.w	#3,d1
	subq.w	#1,d1
	move.w	d1,d3
	moveq	#0,d2
	move.b	bg_water_deform,d2

loc_202AA0:
	move.w	d2,d0
	andi.b	#$FF,d0
	jsr	SineCosine
	lsr.w	#5,d0
	add.w	scroll_bg3_x,d0
	neg.w	d0
	move.l	d0,(a1)+
	addq.w	#2,d2
	dbf	d3,loc_202AA0
	rts

; ------------------------------------------------------------------------------

ScrollFgX:
	move.w	scroll_fg_x,d4
	bsr.s	CheckScrollFgX
	move.w	scroll_fg_x,d0
	andi.w	#$10,d0
	move.b	scroll_cross_x,d1
	eor.b	d1,d0
	bne.s	locret_202AF0
	eori.b	#$10,scroll_cross_x
	move.w	scroll_fg_x,d0
	sub.w	d4,d0
	bpl.s	loc_202AEA
	bset	#2,scroll_flags_fg
	rts

; ------------------------------------------------------------------------------

loc_202AEA:
	bset	#3,scroll_flags_fg

locret_202AF0:
	rts

; ------------------------------------------------------------------------------

CheckScrollFgX:
	move.w	8(a6),d0
	sub.w	scroll_fg_x,d0
	sub.w	scroll_focus_x,d0
	beq.s	loc_202B04
	bcs.s	loc_202B34
	bra.s	loc_202B0A

; ------------------------------------------------------------------------------

loc_202B04:
	clr.w	scroll_x_move
	rts

; ------------------------------------------------------------------------------

loc_202B0A:
	cmpi.w	#$10,d0
	blt.s	loc_202B14
	move.w	#$10,d0

loc_202B14:
	add.w	scroll_fg_x,d0
	cmp.w	right_bound,d0
	blt.s	loc_202B22
	move.w	right_bound,d0

loc_202B22:
	move.w	d0,d1
	sub.w	scroll_fg_x,d1
	asl.w	#8,d1
	move.w	d0,scroll_fg_x
	move.w	d1,scroll_x_move
	rts

; ------------------------------------------------------------------------------

loc_202B34:
	cmpi.w	#$FFF0,d0
	bge.s	loc_202B3E
	move.w	#$FFF0,d0

loc_202B3E:
	add.w	scroll_fg_x,d0
	cmp.w	left_bound,d0
	bgt.s	loc_202B22
	move.w	left_bound,d0
	bra.s	loc_202B22

; ------------------------------------------------------------------------------

ScrollFgXSlow:
	tst.w	d0
	bpl.s	loc_202B58
	move.w	#$FFFE,d0
	bra.s	loc_202B34

; ------------------------------------------------------------------------------

loc_202B58:
	move.w	#2,d0
	bra.s	loc_202B0A

; ------------------------------------------------------------------------------

ScrollFgY:
	moveq	#0,d1
	move.w	$C(a6),d0
	sub.w	scroll_fg_y,d0
	btst	#2,$22(a6)
	beq.s	loc_202B72
	subq.w	#5,d0

loc_202B72:
	btst	#1,$22(a6)
	beq.s	loc_202B92
	addi.w	#$20,d0
	sub.w	scroll_focus_y,d0
	bcs.s	loc_202BDE
	subi.w	#$40,d0
	bcc.s	loc_202BDE
	tst.b	bottom_bound_shift
	bne.s	loc_202BF0
	bra.s	loc_202B9E

; ------------------------------------------------------------------------------

loc_202B92:
	sub.w	scroll_focus_y,d0
	bne.s	loc_202BA4
	tst.b	bottom_bound_shift
	bne.s	loc_202BF0

loc_202B9E:
	clr.w	scroll_y_move
	rts

; ------------------------------------------------------------------------------

loc_202BA4:
	cmpi.w	#$60,scroll_focus_y
	bne.s	loc_202BCC
	move.w	$14(a6),d1
	bpl.s	loc_202BB4
	neg.w	d1

loc_202BB4:
	cmpi.w	#$800,d1
	bcc.s	loc_202BDE
	move.w	#$600,d1
	cmpi.w	#6,d0
	bgt.s	loc_202C3E
	cmpi.w	#$FFFA,d0
	blt.s	loc_202C08
	bra.s	loc_202BF6

; ------------------------------------------------------------------------------

loc_202BCC:
	move.w	#$200,d1
	cmpi.w	#2,d0
	bgt.s	loc_202C3E
	cmpi.w	#$FFFE,d0
	blt.s	loc_202C08
	bra.s	loc_202BF6

; ------------------------------------------------------------------------------

loc_202BDE:
	move.w	#$1000,d1
	cmpi.w	#$10,d0
	bgt.s	loc_202C3E
	cmpi.w	#$FFF0,d0
	blt.s	loc_202C08
	bra.s	loc_202BF6

; ------------------------------------------------------------------------------

loc_202BF0:
	moveq	#0,d0
	move.b	d0,bottom_bound_shift

loc_202BF6:
	moveq	#0,d1
	move.w	d0,d1
	add.w	scroll_fg_y,d1
	tst.w	d0
	bpl.w	loc_202C48
	bra.w	loc_202C14

; ------------------------------------------------------------------------------

loc_202C08:
	neg.w	d1
	ext.l	d1
	asl.l	#8,d1
	add.l	scroll_fg_y,d1
	swap	d1

loc_202C14:
	cmp.w	top_bound,d1
	bgt.s	loc_202C6C
	cmpi.w	#$FF00,d1
	bgt.s	loc_202C38
	andi.w	#$7FF,d1
	andi.w	#$7FF,$C(a6)
	andi.w	#$7FF,scroll_fg_y
	andi.w	#$3FF,scroll_bg_y
	bra.s	loc_202C6C

; ------------------------------------------------------------------------------

loc_202C38:
	move.w	top_bound,d1
	bra.s	loc_202C6C

; ------------------------------------------------------------------------------

loc_202C3E:
	ext.l	d1
	asl.l	#8,d1
	add.l	scroll_fg_y,d1
	swap	d1

loc_202C48:
	cmp.w	bottom_bound,d1
	blt.s	loc_202C6C
	subi.w	#$800,d1
	bcs.s	loc_202C68
	andi.w	#$7FF,$C(a6)
	subi.w	#$800,scroll_fg_y
	andi.w	#$3FF,scroll_bg_y
	bra.s	loc_202C6C

; ------------------------------------------------------------------------------

loc_202C68:
	move.w	bottom_bound,d1

loc_202C6C:
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
	bne.s	locret_202CAE
	eori.b	#$10,scroll_cross_y
	move.w	scroll_fg_y,d0
	sub.w	d4,d0
	bpl.s	loc_202CA8
	bset	#0,scroll_flags_fg
	rts

; ------------------------------------------------------------------------------

loc_202CA8:
	bset	#1,scroll_flags_fg

locret_202CAE:
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
	bne.s	loc_202CE4
	eori.b	#$10,scroll_cross_bg_x
	sub.l	d2,d0
	bpl.s	loc_202CDE
	bset	#2,scroll_flags_bg
	bra.s	loc_202CE4

; ------------------------------------------------------------------------------

loc_202CDE:
	bset	#3,scroll_flags_bg

loc_202CE4:
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
	bset	#0,scroll_flags_bg
	rts

; ------------------------------------------------------------------------------

loc_202D12:
	bset	#1,scroll_flags_bg

locret_202D18:
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
	bne.s	locret_202D4E
	eori.b	#$10,scroll_cross_bg_y
	sub.l	d3,d0
	bpl.s	loc_202D48
	bset	#4,scroll_flags_bg
	rts

; ------------------------------------------------------------------------------

loc_202D48:
	bset	#5,scroll_flags_bg

locret_202D4E:
	rts

; ------------------------------------------------------------------------------

ScrollBgY:
	move.w	scroll_bg_y,d3
	move.w	d0,scroll_bg_y
	move.w	d0,d1
	andi.w	#$10,d1
	move.b	scroll_cross_bg_y,d2
	eor.b	d2,d1
	bne.s	locret_202D7E
	eori.b	#$10,scroll_cross_bg_y
	sub.w	d3,d0
	bpl.s	loc_202D78
	bset	#0,scroll_flags_bg
	rts

; ------------------------------------------------------------------------------

loc_202D78:
	bset	#1,scroll_flags_bg

locret_202D7E:
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
	bne.s	locret_202DB2
	eori.b	#$10,scroll_cross_bg_x
	sub.l	d2,d0
	bpl.s	loc_202DAC
	bset	d6,scroll_flags_bg
	bra.s	locret_202DB2

; ------------------------------------------------------------------------------

loc_202DAC:
	addq.b	#1,d6
	bset	d6,scroll_flags_bg

locret_202DB2:
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
	bne.s	locret_202DE6
	eori.b	#$10,scroll_cross_bg2_x
	sub.l	d2,d0
	bpl.s	loc_202DE0
	bset	d6,scroll_flags_bg2
	bra.s	locret_202DE6

; ------------------------------------------------------------------------------

loc_202DE0:
	addq.b	#1,d6
	bset	d6,scroll_flags_bg2

locret_202DE6:
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
	bne.s	locret_202E1A
	eori.b	#$10,scroll_cross_bg3_x
	sub.l	d2,d0
	bpl.s	loc_202E14
	bset	d6,scroll_flags_bg3
	bra.s	locret_202E1A

; ------------------------------------------------------------------------------

loc_202E14:
	addq.b	#1,d6
	bset	d6,scroll_flags_bg3

locret_202E1A:
	rts

; ------------------------------------------------------------------------------
