; ------------------------------------------------------------------------------

GetPlayerObject:
	lea	player_object,a6
	tst.b	use_player_2
	beq.s	locret_202974
	lea	player_object_2,a6

locret_202974:
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
	lea	unk_2029D2,a0
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
	bra.w	loc_2029FE

; ------------------------------------------------------------------------------

unk_2029D2:
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

unk_2029DE:
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

loc_2029FE:
	tst.b	spawn_mode
	beq.s	loc_202A1E
	jsr	LoadCheckpoint
	moveq	#0,d0
	moveq	#0,d1
	move.w	8(a6),d1
	move.w	$C(a6),d0
	bpl.s	loc_202A1C
	moveq	#0,d0

loc_202A1C:
	bra.s	loc_202A5A

; ------------------------------------------------------------------------------

loc_202A1E:
	lea	StagePlayerSpawn,a1
	tst.w	stage_demo
	bpl.s	loc_202A40
	move.w	s1_credits_index,d0
	subq.w	#1,d0
	lsl.w	#2,d0
	lea	unk_2029DE,a1
	adda.w	d0,a1
	bra.s	loc_202A4A

; ------------------------------------------------------------------------------

loc_202A40:
	move.w	stage_demo,d0
	lsl.w	#2,d0
	adda.w	d0,a1

loc_202A4A:
	moveq	#0,d1
	move.w	(a1)+,d1
	move.w	d1,8(a6)
	moveq	#0,d0
	move.w	(a1),d0
	move.w	d0,$C(a6)

loc_202A5A:
	subi.w	#$A0,d1
	bcc.s	loc_202A62
	moveq	#0,d1

loc_202A62:
	move.w	right_bound,d2
	cmp.w	d2,d1
	bcs.s	loc_202A6C
	move.w	d2,d1

loc_202A6C:
	move.w	d1,scroll_fg_x
	subi.w	#$60,d0
	bcc.s	loc_202A78
	moveq	#0,d0

loc_202A78:
	cmp.w	bottom_bound,d0
	blt.s	loc_202A82
	move.w	bottom_bound,d0

loc_202A82:
	move.w	d0,scroll_fg_y
	bsr.w	sub_202A9E
	lea	unk_202A9A,a1
	move.l	(a1),loop_chunk_1
	rts

; ------------------------------------------------------------------------------

StagePlayerSpawn:
	incbin	"src/maps/r5/spawn_2b.bin"
	even

unk_202A9A:
	dc.b	$7F
	dc.b	$7F
	dc.b	$15
	dc.b	$19

; ------------------------------------------------------------------------------

sub_202A9E:
	swap	d0
	lsr.l	#3,d0
	move.l	d0,d2
	lsr.l	#1,d2
	add.l	d2,d0
	move.l	d0,scroll_bg_y
	swap	d0
	move.w	d0,scroll_bg2_y
	move.w	d0,scroll_bg3_y
	lsr.l	#1,d1
	move.l	d1,d2
	lsr.l	#1,d2
	add.l	d1,d2
	move.w	d2,scroll_bg_x
	lsr.l	#1,d1
	move.w	d1,scroll_bg2_x
	lsr.l	#2,d1
	move.l	d1,d2
	add.l	d2,d2
	add.l	d2,d1
	move.w	d1,scroll_bg3_x
	rts

; ------------------------------------------------------------------------------

UpdateScroll:
	lea	player_object,a6
	tst.b	scroll_lock
	beq.s	loc_202AE2
	rts

; ------------------------------------------------------------------------------

loc_202AE2:
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
	asl.l	#4,d4
	move.l	d4,d3
	add.l	d3,d3
	add.l	d3,d4
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
	asl.l	#6,d4
	move.l	d4,d3
	asl.l	#1,d4
	add.l	d3,d4
	moveq	#2,d6
	bsr.w	ScrollBgX
	move.l	scroll_fg_y,d0
	lsr.l	#3,d0
	move.l	d0,d2
	lsr.l	#1,d2
	add.l	d2,d0
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
	btst	#0,r5_bg_change
	beq.w	loc_202BAE
	bsr.w	sub_202C64
	bsr.w	sub_202CAC
	move.w	scroll_bg_x,d0
	neg.w	d0
	moveq	#$11,d6

loc_202BA4:
	move.w	d0,(a1)+
	dbf	d6,loc_202BA4
	bra.w	loc_202BB6

; ------------------------------------------------------------------------------

loc_202BAE:
	bsr.w	sub_202BD4
	bsr.w	sub_202C1C

loc_202BB6:
	lea	scroll_lines,a1
	lea	bg_scroll_lines,a2
	move.w	scroll_bg_y,d0
	move.w	d0,d2
	andi.w	#$1F8,d0
	lsr.w	#2,d0
	moveq	#$1C,d1
	lea	(a2,d0.w),a2
	bra.w	loc_202CF2

; ------------------------------------------------------------------------------

sub_202BD4:
	move.w	scroll_bg3_x,d0
	move.w	scroll_fg_x,d2
	sub.w	d0,d2
	ext.l	d2
	moveq	#6,d1
	asl.l	d1,d2
	divu.w	#8,d2
	ext.l	d2
	moveq	#$A,d1
	asl.l	d1,d2
	move.w	scroll_bg3_x,d3
	moveq	#3,d6
	adda.w	#$28,a1

loc_202BF8:
	move.w	d3,d0
	neg.w	d0
	moveq	#0,d5
	move.b	byte_202C18(pc,d6.w),d5

loc_202C02:
	move.w	d0,-(a1)
	dbf	d5,loc_202C02
	swap	d3
	add.l	d2,d3
	swap	d3
	dbf	d6,loc_202BF8
	adda.w	#$28,a1
	rts

; ------------------------------------------------------------------------------

byte_202C18:
	dc.b	7
	dc.b	3
	dc.b	1
	dc.b	5

; ------------------------------------------------------------------------------

sub_202C1C:
	move.w	scroll_bg2_x,d0
	move.w	scroll_fg_x,d2
	sub.w	d0,d2
	ext.l	d2
	moveq	#6,d1
	asl.l	d1,d2
	divu.w	#$C,d2
	ext.l	d2
	moveq	#$A,d1
	asl.l	d1,d2
	move.w	scroll_bg2_x,d3
	moveq	#$B,d6

loc_202C3C:
	move.w	d3,d0
	neg.w	d0
	moveq	#0,d5
	move.b	byte_202C58(pc,d6.w),d5

loc_202C46:
	move.w	d0,(a1)+
	dbf	d5,loc_202C46
	swap	d3
	add.l	d2,d3
	swap	d3
	dbf	d6,loc_202C3C
	rts

; ------------------------------------------------------------------------------

byte_202C58:
	dc.b	1
	dc.b	1
	dc.b	1
	dc.b	1
	dc.b	1
	dc.b	1
	dc.b	1
	dc.b	2
	dc.b	1
	dc.b	0
	dc.b	0
	dc.b	6

; ------------------------------------------------------------------------------

sub_202C64:
	move.w	scroll_bg3_x,d0
	move.w	scroll_fg_x,d2
	sub.w	d0,d2
	ext.l	d2
	moveq	#6,d1
	asl.l	d1,d2
	divu.w	#8,d2
	ext.l	d2
	moveq	#$A,d1
	asl.l	d1,d2
	move.w	scroll_bg3_x,d3
	moveq	#3,d6
	adda.w	#$1A,a1

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
	adda.w	#$1A,a1
	rts

; ------------------------------------------------------------------------------

byte_202CA8:
	dc.b	3
	dc.b	1
	dc.b	1
	dc.b	4

; ------------------------------------------------------------------------------

sub_202CAC:
	move.w	scroll_bg2_x,d0
	move.w	scroll_bg_x,d2
	sub.w	d0,d2
	ext.l	d2
	moveq	#6,d1
	asl.l	d1,d2
	divu.w	#$E,d2
	ext.l	d2
	moveq	#$A,d1
	asl.l	d1,d2
	move.w	scroll_bg2_x,d3
	moveq	#9,d6

loc_202CCC:
	move.w	d3,d0
	neg.w	d0
	moveq	#0,d5
	move.b	byte_202CE8(pc,d6.w),d5

loc_202CD6:
	move.w	d0,(a1)+
	dbf	d5,loc_202CD6
	swap	d3
	add.l	d2,d3
	swap	d3
	dbf	d6,loc_202CCC
	rts

; ------------------------------------------------------------------------------

byte_202CE8:
	dc.b	0
	dc.b	2
	dc.b	0
	dc.b	2
	dc.b	0
	dc.b	2
	dc.b	1
	dc.b	1
	dc.b	1
	dc.b	2

; ------------------------------------------------------------------------------

loc_202CF2:
	andi.w	#7,d2
	add.w	d2,d2
	move.w	(a2)+,d0
	jmp	loc_202D00(pc,d2.w)

; ------------------------------------------------------------------------------

loc_202CFE:
	move.w	(a2)+,d0

loc_202D00:
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	dbf	d1,loc_202CFE
	rts

; ------------------------------------------------------------------------------

ScrollFgX:
	move.w	scroll_fg_x,d4
	bsr.s	CheckScrollFgX
	move.w	scroll_fg_x,d0
	andi.w	#$10,d0
	move.b	scroll_cross_x,d1
	eor.b	d1,d0
	bne.s	locret_202D48
	eori.b	#$10,scroll_cross_x
	move.w	scroll_fg_x,d0
	sub.w	d4,d0
	bpl.s	loc_202D42
	bset	#2,scroll_flags_fg
	rts

; ------------------------------------------------------------------------------

loc_202D42:
	bset	#3,scroll_flags_fg

locret_202D48:
	rts

; ------------------------------------------------------------------------------

CheckScrollFgX:
	move.w	8(a6),d0
	sub.w	scroll_fg_x,d0
	sub.w	scroll_focus_x,d0
	beq.s	loc_202D5C
	bcs.s	loc_202D8C
	bra.s	loc_202D62

; ------------------------------------------------------------------------------

loc_202D5C:
	clr.w	scroll_x_move
	rts

; ------------------------------------------------------------------------------

loc_202D62:
	cmpi.w	#$10,d0
	blt.s	loc_202D6C
	move.w	#$10,d0

loc_202D6C:
	add.w	scroll_fg_x,d0
	cmp.w	right_bound,d0
	blt.s	loc_202D7A
	move.w	right_bound,d0

loc_202D7A:
	move.w	d0,d1
	sub.w	scroll_fg_x,d1
	asl.w	#8,d1
	move.w	d0,scroll_fg_x
	move.w	d1,scroll_x_move
	rts

; ------------------------------------------------------------------------------

loc_202D8C:
	cmpi.w	#$FFF0,d0
	bge.s	loc_202D96
	move.w	#$FFF0,d0

loc_202D96:
	add.w	scroll_fg_x,d0
	cmp.w	left_bound,d0
	bgt.s	loc_202D7A
	move.w	left_bound,d0
	bra.s	loc_202D7A

; ------------------------------------------------------------------------------

ScrollFgXSlow:
	tst.w	d0
	bpl.s	loc_202DB0
	move.w	#$FFFE,d0
	bra.s	loc_202D8C

; ------------------------------------------------------------------------------

loc_202DB0:
	move.w	#2,d0
	bra.s	loc_202D62

; ------------------------------------------------------------------------------

ScrollFgY:
	moveq	#0,d1
	move.w	$C(a6),d0
	sub.w	scroll_fg_y,d0
	btst	#2,$22(a6)
	beq.s	loc_202DCA
	subq.w	#5,d0

loc_202DCA:
	btst	#1,$22(a6)
	beq.s	loc_202DEA
	addi.w	#$20,d0
	sub.w	scroll_focus_y,d0
	bcs.s	loc_202E36
	subi.w	#$40,d0
	bcc.s	loc_202E36
	tst.b	bottom_bound_shift
	bne.s	loc_202E48
	bra.s	loc_202DF6

; ------------------------------------------------------------------------------

loc_202DEA:
	sub.w	scroll_focus_y,d0
	bne.s	loc_202DFC
	tst.b	bottom_bound_shift
	bne.s	loc_202E48

loc_202DF6:
	clr.w	scroll_y_move
	rts

; ------------------------------------------------------------------------------

loc_202DFC:
	cmpi.w	#$60,scroll_focus_y
	bne.s	loc_202E24
	move.w	$14(a6),d1
	bpl.s	loc_202E0C
	neg.w	d1

loc_202E0C:
	cmpi.w	#$800,d1
	bcc.s	loc_202E36
	move.w	#$600,d1
	cmpi.w	#6,d0
	bgt.s	loc_202E96
	cmpi.w	#$FFFA,d0
	blt.s	loc_202E60
	bra.s	loc_202E4E

; ------------------------------------------------------------------------------

loc_202E24:
	move.w	#$200,d1
	cmpi.w	#2,d0
	bgt.s	loc_202E96
	cmpi.w	#$FFFE,d0
	blt.s	loc_202E60
	bra.s	loc_202E4E

; ------------------------------------------------------------------------------

loc_202E36:
	move.w	#$1000,d1
	cmpi.w	#$10,d0
	bgt.s	loc_202E96
	cmpi.w	#$FFF0,d0
	blt.s	loc_202E60
	bra.s	loc_202E4E

; ------------------------------------------------------------------------------

loc_202E48:
	moveq	#0,d0
	move.b	d0,bottom_bound_shift

loc_202E4E:
	moveq	#0,d1
	move.w	d0,d1
	add.w	scroll_fg_y,d1
	tst.w	d0
	bpl.w	loc_202EA0
	bra.w	loc_202E6C

; ------------------------------------------------------------------------------

loc_202E60:
	neg.w	d1
	ext.l	d1
	asl.l	#8,d1
	add.l	scroll_fg_y,d1
	swap	d1

loc_202E6C:
	cmp.w	top_bound,d1
	bgt.s	loc_202EC4
	cmpi.w	#$FF00,d1
	bgt.s	loc_202E90
	andi.w	#$7FF,d1
	andi.w	#$7FF,$C(a6)
	andi.w	#$7FF,scroll_fg_y
	andi.w	#$3FF,scroll_bg_y
	bra.s	loc_202EC4

; ------------------------------------------------------------------------------

loc_202E90:
	move.w	top_bound,d1
	bra.s	loc_202EC4

; ------------------------------------------------------------------------------

loc_202E96:
	ext.l	d1
	asl.l	#8,d1
	add.l	scroll_fg_y,d1
	swap	d1

loc_202EA0:
	cmp.w	bottom_bound,d1
	blt.s	loc_202EC4
	subi.w	#$800,d1
	bcs.s	loc_202EC0
	andi.w	#$7FF,$C(a6)
	subi.w	#$800,scroll_fg_y
	andi.w	#$3FF,scroll_bg_y
	bra.s	loc_202EC4

; ------------------------------------------------------------------------------

loc_202EC0:
	move.w	bottom_bound,d1

loc_202EC4:
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
	bne.s	locret_202F06
	eori.b	#$10,scroll_cross_y
	move.w	scroll_fg_y,d0
	sub.w	d4,d0
	bpl.s	loc_202F00
	bset	#0,scroll_flags_fg
	rts

; ------------------------------------------------------------------------------

loc_202F00:
	bset	#1,scroll_flags_fg

locret_202F06:
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
	bne.s	loc_202F3C
	eori.b	#$10,scroll_cross_bg_x
	sub.l	d2,d0
	bpl.s	loc_202F36
	bset	#2,scroll_flags_bg
	bra.s	loc_202F3C

; ------------------------------------------------------------------------------

loc_202F36:
	bset	#3,scroll_flags_bg

loc_202F3C:
	move.l	scroll_bg_y,d3
	move.l	d3,d0
	add.l	d5,d0
	move.l	d0,scroll_bg_y
	move.l	d0,d1
	swap	d1
	andi.w	#$10,d1
	move.b	scroll_cross_bg_y,d2
	eor.b	d2,d1
	bne.s	locret_202F70
	eori.b	#$10,scroll_cross_bg_y
	sub.l	d3,d0
	bpl.s	loc_202F6A
	bset	#0,scroll_flags_bg
	rts

; ------------------------------------------------------------------------------

loc_202F6A:
	bset	#1,scroll_flags_bg

locret_202F70:
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
	bne.s	locret_202FA6
	eori.b	#$10,scroll_cross_bg_y
	sub.l	d3,d0
	bpl.s	loc_202FA0
	bset	#4,scroll_flags_bg
	rts

; ------------------------------------------------------------------------------

loc_202FA0:
	bset	#5,scroll_flags_bg

locret_202FA6:
	rts

; ------------------------------------------------------------------------------

ScrollBgY:
	move.w	scroll_bg_y,d3
	move.w	d0,scroll_bg_y
	move.w	d0,d1
	andi.w	#$10,d1
	move.b	scroll_cross_bg_y,d2
	eor.b	d2,d1
	bne.s	locret_202FD6
	eori.b	#$10,scroll_cross_bg_y
	sub.w	d3,d0
	bpl.s	loc_202FD0
	bset	#0,scroll_flags_bg
	rts

; ------------------------------------------------------------------------------

loc_202FD0:
	bset	#1,scroll_flags_bg

locret_202FD6:
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
	bne.s	locret_20300A
	eori.b	#$10,scroll_cross_bg_x
	sub.l	d2,d0
	bpl.s	loc_203004
	bset	d6,scroll_flags_bg
	bra.s	locret_20300A

; ------------------------------------------------------------------------------

loc_203004:
	addq.b	#1,d6
	bset	d6,scroll_flags_bg

locret_20300A:
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
	bne.s	locret_20303E
	eori.b	#$10,scroll_cross_bg2_x
	sub.l	d2,d0
	bpl.s	loc_203038
	bset	d6,scroll_flags_bg2
	bra.s	locret_20303E

; ------------------------------------------------------------------------------

loc_203038:
	addq.b	#1,d6
	bset	d6,scroll_flags_bg2

locret_20303E:
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
	bne.s	locret_203072
	eori.b	#$10,scroll_cross_bg3_x
	sub.l	d2,d0
	bpl.s	loc_20306C
	bset	d6,scroll_flags_bg3
	bra.s	locret_203072

; ------------------------------------------------------------------------------

loc_20306C:
	addq.b	#1,d6
	bset	d6,scroll_flags_bg3

locret_203072:
	rts

; ------------------------------------------------------------------------------
