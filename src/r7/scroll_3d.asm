; ------------------------------------------------------------------------------

InitScroll:
	lea	player_object,a6
	moveq	#0,d0
	move.b	d0,unused_scroll_x_flag
	move.b	d0,unused_scroll_y_flag
	move.b	d0,unused_scroll_die
	move.b	d0,unused_scroll_timer
	move.b	d0,event_routine
	lea	word_20292E,a0
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
	bra.w	loc_2028B8

; ------------------------------------------------------------------------------

word_20292E:
	dc.w	4, 0, $3E97, 0, $510, $60

; ------------------------------------------------------------------------------

loc_2028B8:
	tst.b	spawn_mode
	beq.s	loc_2028D8
	jsr	LoadCheckpoint
	moveq	#0,d0
	moveq	#0,d1
	move.w	8(a6),d1
	move.w	$C(a6),d0
	bpl.s	loc_2028D6
	moveq	#0,d0

loc_2028D6:
	bra.s	loc_2028EE

; ------------------------------------------------------------------------------

loc_2028D8:
	lea	StagePlayerSpawn,a1
	moveq	#0,d1
	move.w	(a1)+,d1
	move.w	d1,8(a6)
	moveq	#0,d0
	move.w	(a1),d0
	move.w	d0,$C(a6)

loc_2028EE:
	subi.w	#$A0,d1
	bcc.s	loc_2028F6
	moveq	#0,d1

loc_2028F6:
	move.w	right_bound,d2
	cmp.w	d2,d1
	bcs.s	loc_202900
	move.w	d2,d1

loc_202900:
	move.w	d1,scroll_fg_x
	subi.w	#$60,d0
	bcc.s	loc_20290C
	moveq	#0,d0

loc_20290C:
	cmp.w	bottom_bound,d0
	blt.s	loc_202916
	move.w	bottom_bound,d0

loc_202916:
	move.w	d0,scroll_fg_y
	bsr.w	sub_202932
	lea	unk_20292E,a1
	move.l	(a1),loop_chunk_1
	rts

; ------------------------------------------------------------------------------

StagePlayerSpawn:
	incbin	"src/maps/r7/spawn_3d.bin"
	even

unk_20292E:
	dc.b	$84
	dc.b	$86
	dc.b	$7F
	dc.b	$7F

; ------------------------------------------------------------------------------

sub_202932:
	swap	d0
	move.l	d0,scroll_bg_y
	swap	d0
	move.w	d0,scroll_bg2_y
	move.w	d0,scroll_bg3_y
	lsr.l	#2,d1
	move.l	d1,d2
	lsr.l	#2,d2
	add.l	d1,d2
	move.w	d2,scroll_bg2_x
	lsr.l	#1,d1
	move.l	d1,d2
	lsr.l	#1,d2
	add.l	d1,d2
	lsr.l	#1,d2
	add.l	d1,d2
	move.w	d2,scroll_bg3_x
	lsr.l	#1,d1
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
	asl.l	#5,d4
	move.l	d4,d3
	add.l	d3,d3
	add.l	d4,d3
	add.l	d3,d3
	add.l	d3,d4
	moveq	#6,d6
	bsr.w	ScrollBg3X
	move.w	scroll_x_move,d4
	ext.l	d4
	asl.l	#6,d4
	move.l	d4,d3
	add.l	d3,d3
	add.l	d3,d3
	add.l	d3,d4
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
	bsr.w	sub_202A80
	move.w	scroll_bg_x,d0
	neg.w	d0
	moveq	#7,d6

loc_202A2C:
	move.w	d0,(a1)+
	dbf	d6,loc_202A2C
	bsr.w	sub_202AC6
	move.w	scroll_bg3_x,d0
	neg.w	d0
	moveq	#$F,d6

loc_202A3E:
	move.w	d0,(a1)+
	dbf	d6,loc_202A3E
	move.w	scroll_bg2_x,d0
	neg.w	d0
	moveq	#$11,d6

loc_202A4C:
	move.w	d0,(a1)+
	dbf	d6,loc_202A4C
	lea	scroll_lines,a1
	lea	bg_scroll_lines,a2
	move.w	scroll_bg_y,d0
	move.w	d0,d2
	andi.w	#$3F8,d0
	lsr.w	#2,d0
	moveq	#$1D,d1
	lea	(a2,d0.w),a2
	bra.w	loc_202B14

; ------------------------------------------------------------------------------

byte_202A70:
	dc.b	3
	dc.b	3
	dc.b	1
	dc.b	1
	dc.b	0
	dc.b	0
	dc.b	3
	dc.b	3
	dc.b	1
	dc.b	3
	dc.b	1
	dc.b	1
	dc.b	1
	dc.b	1
	dc.b	0
	dc.b	0

; ------------------------------------------------------------------------------

sub_202A80:
	move.w	scroll_bg_x,d0
	move.w	scroll_fg_x,d2
	add.w	d2,d2
	sub.w	d0,d2
	ext.l	d2
	moveq	#5,d1
	asl.l	d1,d2
	divu.w	#$10,d2
	ext.l	d2
	moveq	#$B,d1
	asl.l	d1,d2
	move.w	scroll_bg_x,d3
	moveq	#$F,d6
	adda.w	#$4C,a1

loc_202AA6:
	move.w	d3,d0
	neg.w	d0
	moveq	#0,d5
	move.b	byte_202A70(pc,d6.w),d5

loc_202AB0:
	move.w	d0,-(a1)
	dbf	d5,loc_202AB0
	swap	d3
	add.l	d2,d3
	swap	d3
	dbf	d6,loc_202AA6
	adda.w	#$4C,a1
	rts

; ------------------------------------------------------------------------------

sub_202AC6:
	move.w	scroll_bg_x,d0
	move.w	scroll_bg3_x,d2
	sub.w	d0,d2
	ext.l	d2
	moveq	#5,d1
	asl.l	d1,d2
	divu.w	#$B,d2
	ext.l	d2
	moveq	#$B,d1
	asl.l	d1,d2
	move.w	scroll_bg_x,d3
	swap	d3
	add.l	d2,d3
	swap	d3
	moveq	#$A,d6

loc_202AEC:
	move.w	d3,d0
	neg.w	d0
	moveq	#0,d5
	move.b	byte_202B08(pc,d6.w),d5

loc_202AF6:
	move.w	d0,(a1)+
	dbf	d5,loc_202AF6
	swap	d3
	add.l	d2,d3
	swap	d3
	dbf	d6,loc_202AEC
	rts

; ------------------------------------------------------------------------------

byte_202B08:
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

; ------------------------------------------------------------------------------

loc_202B14:
	andi.w	#7,d2
	add.w	d2,d2
	move.w	(a2)+,d0
	jmp	loc_202B22(pc,d2.w)

; ------------------------------------------------------------------------------

loc_202B20:
	move.w	(a2)+,d0

loc_202B22:
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	dbf	d1,loc_202B20
	rts

; ------------------------------------------------------------------------------

	neg.w	d0
	jmp	loc_202B40(pc,d2.w)

; ------------------------------------------------------------------------------

	neg.w	d0

loc_202B40:
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	dbf	d1,loc_202B20
	rts

; ------------------------------------------------------------------------------

ScrollFgX:
	move.w	scroll_fg_x,d4
	bsr.s	CheckScrollFgX
	move.w	scroll_fg_x,d0
	andi.w	#$10,d0
	move.b	scroll_cross_x,d1
	eor.b	d1,d0
	bne.s	locret_202B88
	eori.b	#$10,scroll_cross_x
	move.w	scroll_fg_x,d0
	sub.w	d4,d0
	bpl.s	loc_202B82
	bset	#2,scroll_flags_fg
	rts

; ------------------------------------------------------------------------------

loc_202B82:
	bset	#3,scroll_flags_fg

locret_202B88:
	rts

; ------------------------------------------------------------------------------

CheckScrollFgX:
	move.w	8(a6),d0
	sub.w	scroll_fg_x,d0
	sub.w	scroll_focus_x,d0
	beq.s	loc_202B9C
	bcs.s	loc_202BCC
	bra.s	loc_202BA2

; ------------------------------------------------------------------------------

loc_202B9C:
	clr.w	scroll_x_move
	rts

; ------------------------------------------------------------------------------

loc_202BA2:
	cmpi.w	#$10,d0
	blt.s	loc_202BAC
	move.w	#$10,d0

loc_202BAC:
	add.w	scroll_fg_x,d0
	cmp.w	right_bound,d0
	blt.s	loc_202BBA
	move.w	right_bound,d0

loc_202BBA:
	move.w	d0,d1
	sub.w	scroll_fg_x,d1
	asl.w	#8,d1
	move.w	d0,scroll_fg_x
	move.w	d1,scroll_x_move
	rts

; ------------------------------------------------------------------------------

loc_202BCC:
	cmpi.w	#$FFF0,d0
	bge.s	loc_202BD6
	move.w	#$FFF0,d0

loc_202BD6:
	add.w	scroll_fg_x,d0
	cmp.w	left_bound,d0
	bgt.s	loc_202BBA
	move.w	left_bound,d0
	bra.s	loc_202BBA

; ------------------------------------------------------------------------------

ScrollFgXSlow:
	tst.w	d0
	bpl.s	loc_202BF0
	move.w	#$FFFE,d0
	bra.s	loc_202BCC

; ------------------------------------------------------------------------------

loc_202BF0:
	move.w	#2,d0
	bra.s	loc_202BA2

; ------------------------------------------------------------------------------

ScrollFgY:
	moveq	#0,d1
	move.w	$C(a6),d0
	sub.w	scroll_fg_y,d0
	btst	#2,$22(a6)
	beq.s	loc_202C0A
	subq.w	#5,d0

loc_202C0A:
	btst	#1,$22(a6)
	beq.s	loc_202C2A
	addi.w	#$20,d0
	sub.w	scroll_focus_y,d0
	bcs.s	loc_202C76
	subi.w	#$40,d0
	bcc.s	loc_202C76
	tst.b	bottom_bound_shift
	bne.s	loc_202C88
	bra.s	loc_202C36

; ------------------------------------------------------------------------------

loc_202C2A:
	sub.w	scroll_focus_y,d0
	bne.s	loc_202C3C
	tst.b	bottom_bound_shift
	bne.s	loc_202C88

loc_202C36:
	clr.w	scroll_y_move
	rts

; ------------------------------------------------------------------------------

loc_202C3C:
	cmpi.w	#$60,scroll_focus_y
	bne.s	loc_202C64
	move.w	$14(a6),d1
	bpl.s	loc_202C4C
	neg.w	d1

loc_202C4C:
	cmpi.w	#$800,d1
	bcc.s	loc_202C76
	move.w	#$600,d1
	cmpi.w	#6,d0
	bgt.s	loc_202CD6
	cmpi.w	#$FFFA,d0
	blt.s	loc_202CA0
	bra.s	loc_202C8E

; ------------------------------------------------------------------------------

loc_202C64:
	move.w	#$200,d1
	cmpi.w	#2,d0
	bgt.s	loc_202CD6
	cmpi.w	#$FFFE,d0
	blt.s	loc_202CA0
	bra.s	loc_202C8E

; ------------------------------------------------------------------------------

loc_202C76:
	move.w	#$1000,d1
	cmpi.w	#$10,d0
	bgt.s	loc_202CD6
	cmpi.w	#$FFF0,d0
	blt.s	loc_202CA0
	bra.s	loc_202C8E

; ------------------------------------------------------------------------------

loc_202C88:
	moveq	#0,d0
	move.b	d0,bottom_bound_shift

loc_202C8E:
	moveq	#0,d1
	move.w	d0,d1
	add.w	scroll_fg_y,d1
	tst.w	d0
	bpl.w	loc_202CE0
	bra.w	loc_202CAC

; ------------------------------------------------------------------------------

loc_202CA0:
	neg.w	d1
	ext.l	d1
	asl.l	#8,d1
	add.l	scroll_fg_y,d1
	swap	d1

loc_202CAC:
	cmp.w	top_bound,d1
	bgt.s	loc_202D04
	cmpi.w	#$FF00,d1
	bgt.s	loc_202CD0
	andi.w	#$7FF,d1
	andi.w	#$7FF,$C(a6)
	andi.w	#$7FF,scroll_fg_y
	andi.w	#$3FF,scroll_bg_y
	bra.s	loc_202D04

; ------------------------------------------------------------------------------

loc_202CD0:
	move.w	top_bound,d1
	bra.s	loc_202D04

; ------------------------------------------------------------------------------

loc_202CD6:
	ext.l	d1
	asl.l	#8,d1
	add.l	scroll_fg_y,d1
	swap	d1

loc_202CE0:
	cmp.w	bottom_bound,d1
	blt.s	loc_202D04
	subi.w	#$800,d1
	bcs.s	loc_202D00
	andi.w	#$7FF,$C(a6)
	subi.w	#$800,scroll_fg_y
	andi.w	#$3FF,scroll_bg_y
	bra.s	loc_202D04

; ------------------------------------------------------------------------------

loc_202D00:
	move.w	bottom_bound,d1

loc_202D04:
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
	bne.s	locret_202D46
	eori.b	#$10,scroll_cross_y
	move.w	scroll_fg_y,d0
	sub.w	d4,d0
	bpl.s	loc_202D40
	bset	#0,scroll_flags_fg
	rts

; ------------------------------------------------------------------------------

loc_202D40:
	bset	#1,scroll_flags_fg

locret_202D46:
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
	bne.s	loc_202D7C
	eori.b	#$10,scroll_cross_bg_x
	sub.l	d2,d0
	bpl.s	loc_202D76
	bset	#2,scroll_flags_bg
	bra.s	loc_202D7C

; ------------------------------------------------------------------------------

loc_202D76:
	bset	#3,scroll_flags_bg

loc_202D7C:
	move.l	scroll_bg_y,d3
	move.l	d3,d0
	add.l	d5,d0
	move.l	d0,scroll_bg_y
	move.l	d0,d1
	swap	d1
	andi.w	#$10,d1
	move.b	scroll_cross_bg_y,d2
	eor.b	d2,d1
	bne.s	locret_202DB0
	eori.b	#$10,scroll_cross_bg_y
	sub.l	d3,d0
	bpl.s	loc_202DAA
	bset	#0,scroll_flags_bg
	rts

; ------------------------------------------------------------------------------

loc_202DAA:
	bset	#1,scroll_flags_bg

locret_202DB0:
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
	bne.s	locret_202DE6
	eori.b	#$10,scroll_cross_bg_y
	sub.l	d3,d0
	bpl.s	loc_202DE0
	bset	#4,scroll_flags_bg
	rts

; ------------------------------------------------------------------------------

loc_202DE0:
	bset	#5,scroll_flags_bg

locret_202DE6:
	rts

; ------------------------------------------------------------------------------

ScrollBgY:
	move.w	scroll_bg_y,d3
	move.w	d0,scroll_bg_y
	move.w	d0,d1
	andi.w	#$10,d1
	move.b	scroll_cross_bg_y,d2
	eor.b	d2,d1
	bne.s	locret_202E16
	eori.b	#$10,scroll_cross_bg_y
	sub.w	d3,d0
	bpl.s	loc_202E10
	bset	#0,scroll_flags_bg
	rts

; ------------------------------------------------------------------------------

loc_202E10:
	bset	#1,scroll_flags_bg

locret_202E16:
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
	bne.s	locret_202E4A
	eori.b	#$10,scroll_cross_bg_x
	sub.l	d2,d0
	bpl.s	loc_202E44
	bset	d6,scroll_flags_bg
	bra.s	locret_202E4A

; ------------------------------------------------------------------------------

loc_202E44:
	addq.b	#1,d6
	bset	d6,scroll_flags_bg

locret_202E4A:
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
	bne.s	locret_202E7E
	eori.b	#$10,scroll_cross_bg2_x
	sub.l	d2,d0
	bpl.s	loc_202E78
	bset	d6,scroll_flags_bg2
	bra.s	locret_202E7E

; ------------------------------------------------------------------------------

loc_202E78:
	addq.b	#1,d6
	bset	d6,scroll_flags_bg2

locret_202E7E:
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
	bne.s	locret_202EB2
	eori.b	#$10,scroll_cross_bg3_x
	sub.l	d2,d0
	bpl.s	loc_202EAC
	bset	d6,scroll_flags_bg3
	bra.s	locret_202EB2

; ------------------------------------------------------------------------------

loc_202EAC:
	addq.b	#1,d6
	bset	d6,scroll_flags_bg3

locret_202EB2:
	rts

; ------------------------------------------------------------------------------
