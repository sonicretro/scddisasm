; ------------------------------------------------------------------------------

GetPlayerObject:
	lea	player_object,a6
	tst.b	use_player_2
	beq.s	locret_2028DA
	lea	player_object_2,a6

locret_2028DA:
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
	lea	word_202938,a0
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
	bra.w	loc_202964

; ------------------------------------------------------------------------------

word_202938:
	dc.w	4, 0, $1E97, 0, $710, $60
	
	dc.w	$50, $3B0
	dc.w	$EA0, $46C
	dc.w	$1750, $BD
	dc.w	$A00, $62C
	dc.w	$BB0, $4C
	dc.w	$1570, $16C
	dc.w	$1B0, $72C
	dc.w	$1400, $2AC

; ------------------------------------------------------------------------------

loc_202964:
	tst.b	spawn_mode
	beq.s	loc_202984
	jsr	LoadCheckpoint
	moveq	#0,d0
	moveq	#0,d1
	move.w	8(a6),d1
	move.w	$C(a6),d0
	bpl.s	loc_202982
	moveq	#0,d0

loc_202982:
	bra.s	loc_20299A

; ------------------------------------------------------------------------------

loc_202984:
	lea	StagePlayerSpawn,a1
	moveq	#0,d1
	move.w	(a1)+,d1
	move.w	d1,obj.x(a6)
	moveq	#0,d0
	move.w	(a1),d0
	move.w	d0,obj.y(a6)

loc_20299A:
	subi.w	#$A0,d1
	bcc.s	loc_2029A2
	moveq	#0,d1

loc_2029A2:
	move.w	right_bound,d2
	cmp.w	d2,d1
	bcs.s	loc_2029AC
	move.w	d2,d1

loc_2029AC:
	move.w	d1,scroll_fg_x
	subi.w	#$60,d0
	bcc.s	loc_2029B8
	moveq	#0,d0

loc_2029B8:
	cmp.w	bottom_bound,d0
	blt.s	loc_2029C2
	move.w	bottom_bound,d0

loc_2029C2:
	move.w	d0,scroll_fg_y
	bsr.w	sub_2029DE
	lea	byte_2029DA,a1
	move.l	(a1),loop_chunk_1
	rts

; ------------------------------------------------------------------------------

StagePlayerSpawn:
	incbin	"src/maps/r8/spawn_2a.bin"
	even

byte_2029DA:
	dc.b	$7F, $7F, $7F, $7F

; ------------------------------------------------------------------------------

sub_2029DE:
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
	beq.s	loc_202A16
	rts

; ------------------------------------------------------------------------------

loc_202A16:
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
	move.w	scroll_bg_x,d0
	neg.w	d0
	moveq	#5,d6

loc_202AB8:
	move.w	d0,(a1)+
	dbf	d6,loc_202AB8
	bsr.w	sub_202B10
	move.w	scroll_bg2_x,d0
	neg.w	d0
	moveq	#$11,d6

loc_202ACA:
	move.w	d0,(a1)+
	dbf	d6,loc_202ACA
	bsr.w	sub_202B36
	move.w	scroll_bg_x,d0
	neg.w	d0
	moveq	#9,d6

loc_202ADC:
	move.w	d0,(a1)+
	dbf	d6,loc_202ADC
	lea	scroll_lines,a1
	lea	bg_scroll_lines,a2
	move.w	scroll_bg_y,d0
	move.w	d0,d2
	andi.w	#$3F8,d0
	lsr.w	#2,d0
	moveq	#$1C,d1
	lea	(a2,d0.w),a2
	bra.w	loc_202B80

; ------------------------------------------------------------------------------

byte_202B00:
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	1
	dc.b	1
	dc.b	1
	dc.b	0

byte_202B08:
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	0
	dc.b	1
	dc.b	9
	dc.b	1
	dc.b	0

; ------------------------------------------------------------------------------

sub_202B10:
	bsr.w	sub_202B64
	move.w	scroll_bg3_x,d3
	moveq	#6,d6

loc_202B1A:
	move.w	d3,d0
	neg.w	d0
	moveq	#0,d5
	move.b	byte_202B00(pc,d6.w),d5

loc_202B24:
	move.w	d0,(a1)+
	dbf	d5,loc_202B24
	swap	d3
	add.l	d2,d3
	swap	d3
	dbf	d6,loc_202B1A
	rts

; ------------------------------------------------------------------------------

sub_202B36:
	bsr.w	sub_202B64
	move.w	scroll_bg3_x,d3
	adda.w	#$24,a1
	moveq	#6,d6

loc_202B44:
	move.w	d3,d0
	neg.w	d0
	moveq	#0,d5
	move.b	byte_202B08(pc,d6.w),d5

loc_202B4E:
	move.w	d0,-(a1)
	dbf	d5,loc_202B4E
	swap	d3
	add.l	d2,d3
	swap	d3
	dbf	d6,loc_202B44
	adda.w	#$24,a1
	rts

; ------------------------------------------------------------------------------

sub_202B64:
	move.w	scroll_bg3_x,d0
	move.w	scroll_bg2_x,d2
	sub.w	d0,d2
	ext.l	d2
	moveq	#7,d1
	asl.l	d1,d2
	divu.w	#5,d2
	ext.l	d2
	moveq	#9,d1
	asl.l	d1,d2
	rts

; ------------------------------------------------------------------------------

loc_202B80:
	andi.w	#7,d2
	add.w	d2,d2
	move.w	(a2)+,d0
	jmp	loc_202B8E(pc,d2.w)

; ------------------------------------------------------------------------------

loc_202B8C:
	move.w	(a2)+,d0

loc_202B8E:
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	dbf	d1,loc_202B8C
	rts

; ------------------------------------------------------------------------------

	neg.w	d0
	jmp	loc_202BAC(pc,d2.w)

; ------------------------------------------------------------------------------

	neg.w	d0

loc_202BAC:
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	dbf	d1,loc_202B8C
	rts

; ------------------------------------------------------------------------------

ScrollFgX:
	move.w	scroll_fg_x,d4
	bsr.s	CheckScrollFgX
	move.w	scroll_fg_x,d0
	andi.w	#$10,d0
	move.b	scroll_cross_x,d1
	eor.b	d1,d0
	bne.s	locret_202BF4
	eori.b	#$10,scroll_cross_x
	move.w	scroll_fg_x,d0
	sub.w	d4,d0
	bpl.s	loc_202BEE
	bset	#2,scroll_flags_fg
	rts

; ------------------------------------------------------------------------------

loc_202BEE:
	bset	#3,scroll_flags_fg

locret_202BF4:
	rts

; ------------------------------------------------------------------------------

CheckScrollFgX:
	move.w	8(a6),d0
	sub.w	scroll_fg_x,d0
	sub.w	scroll_focus_x,d0
	beq.s	loc_202C08
	bcs.s	loc_202C38
	bra.s	loc_202C0E

; ------------------------------------------------------------------------------

loc_202C08:
	clr.w	scroll_x_move
	rts

; ------------------------------------------------------------------------------

loc_202C0E:
	cmpi.w	#$10,d0
	blt.s	loc_202C18
	move.w	#$10,d0

loc_202C18:
	add.w	scroll_fg_x,d0
	cmp.w	right_bound,d0
	blt.s	loc_202C26
	move.w	right_bound,d0

loc_202C26:
	move.w	d0,d1
	sub.w	scroll_fg_x,d1
	asl.w	#8,d1
	move.w	d0,scroll_fg_x
	move.w	d1,scroll_x_move
	rts

; ------------------------------------------------------------------------------

loc_202C38:
	cmpi.w	#$FFF0,d0
	bge.s	loc_202C42
	move.w	#$FFF0,d0

loc_202C42:
	add.w	scroll_fg_x,d0
	cmp.w	left_bound,d0
	bgt.s	loc_202C26
	move.w	left_bound,d0
	bra.s	loc_202C26

; ------------------------------------------------------------------------------

ScrollFgXSlow:
	tst.w	d0
	bpl.s	loc_202C5C
	move.w	#$FFFE,d0
	bra.s	loc_202C38

; ------------------------------------------------------------------------------

loc_202C5C:
	move.w	#2,d0
	bra.s	loc_202C0E

; ------------------------------------------------------------------------------

ScrollFgY:
	moveq	#0,d1
	move.w	$C(a6),d0
	sub.w	scroll_fg_y,d0
	btst	#2,$22(a6)
	beq.s	loc_202C76
	subq.w	#5,d0

loc_202C76:
	btst	#1,$22(a6)
	beq.s	loc_202C96
	addi.w	#$20,d0
	sub.w	scroll_focus_y,d0
	bcs.s	loc_202CE2
	subi.w	#$40,d0
	bcc.s	loc_202CE2
	tst.b	bottom_bound_shift
	bne.s	loc_202CF4
	bra.s	loc_202CA2

; ------------------------------------------------------------------------------

loc_202C96:
	sub.w	scroll_focus_y,d0
	bne.s	loc_202CA8
	tst.b	bottom_bound_shift
	bne.s	loc_202CF4

loc_202CA2:
	clr.w	scroll_y_move
	rts

; ------------------------------------------------------------------------------

loc_202CA8:
	cmpi.w	#$60,scroll_focus_y
	bne.s	loc_202CD0
	move.w	$14(a6),d1
	bpl.s	loc_202CB8
	neg.w	d1

loc_202CB8:
	cmpi.w	#$800,d1
	bcc.s	loc_202CE2
	move.w	#$600,d1
	cmpi.w	#6,d0
	bgt.s	loc_202D42
	cmpi.w	#$FFFA,d0
	blt.s	loc_202D0C
	bra.s	loc_202CFA

; ------------------------------------------------------------------------------

loc_202CD0:
	move.w	#$200,d1
	cmpi.w	#2,d0
	bgt.s	loc_202D42
	cmpi.w	#$FFFE,d0
	blt.s	loc_202D0C
	bra.s	loc_202CFA

; ------------------------------------------------------------------------------

loc_202CE2:
	move.w	#$1000,d1
	cmpi.w	#$10,d0
	bgt.s	loc_202D42
	cmpi.w	#$FFF0,d0
	blt.s	loc_202D0C
	bra.s	loc_202CFA

; ------------------------------------------------------------------------------

loc_202CF4:
	moveq	#0,d0
	move.b	d0,bottom_bound_shift

loc_202CFA:
	moveq	#0,d1
	move.w	d0,d1
	add.w	scroll_fg_y,d1
	tst.w	d0
	bpl.w	loc_202D4C
	bra.w	loc_202D18

; ------------------------------------------------------------------------------

loc_202D0C:
	neg.w	d1
	ext.l	d1
	asl.l	#8,d1
	add.l	scroll_fg_y,d1
	swap	d1

loc_202D18:
	cmp.w	top_bound,d1
	bgt.s	loc_202D70
	cmpi.w	#$FF00,d1
	bgt.s	loc_202D3C
	andi.w	#$7FF,d1
	andi.w	#$7FF,$C(a6)
	andi.w	#$7FF,scroll_fg_y
	andi.w	#$3FF,scroll_bg_y
	bra.s	loc_202D70

; ------------------------------------------------------------------------------

loc_202D3C:
	move.w	top_bound,d1
	bra.s	loc_202D70

; ------------------------------------------------------------------------------

loc_202D42:
	ext.l	d1
	asl.l	#8,d1
	add.l	scroll_fg_y,d1
	swap	d1

loc_202D4C:
	cmp.w	bottom_bound,d1
	blt.s	loc_202D70
	subi.w	#$800,d1
	bcs.s	loc_202D6C
	andi.w	#$7FF,$C(a6)
	subi.w	#$800,scroll_fg_y
	andi.w	#$3FF,scroll_bg_y
	bra.s	loc_202D70

; ------------------------------------------------------------------------------

loc_202D6C:
	move.w	bottom_bound,d1

loc_202D70:
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
	bne.s	locret_202DB2
	eori.b	#$10,scroll_cross_y
	move.w	scroll_fg_y,d0
	sub.w	d4,d0
	bpl.s	loc_202DAC
	bset	#0,scroll_flags_fg
	rts

; ------------------------------------------------------------------------------

loc_202DAC:
	bset	#1,scroll_flags_fg

locret_202DB2:
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
	bne.s	loc_202DE8
	eori.b	#$10,scroll_cross_bg_x
	sub.l	d2,d0
	bpl.s	loc_202DE2
	bset	#2,scroll_flags_bg
	bra.s	loc_202DE8

; ------------------------------------------------------------------------------

loc_202DE2:
	bset	#3,scroll_flags_bg

loc_202DE8:
	move.l	scroll_bg_y,d3
	move.l	d3,d0
	add.l	d5,d0
	move.l	d0,scroll_bg_y
	move.l	d0,d1
	swap	d1
	andi.w	#$10,d1
	move.b	scroll_cross_bg_y,d2
	eor.b	d2,d1
	bne.s	locret_202E1C
	eori.b	#$10,scroll_cross_bg_y
	sub.l	d3,d0
	bpl.s	loc_202E16
	bset	#0,scroll_flags_bg
	rts

; ------------------------------------------------------------------------------

loc_202E16:
	bset	#1,scroll_flags_bg

locret_202E1C:
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
	bne.s	locret_202E52
	eori.b	#$10,scroll_cross_bg_y
	sub.l	d3,d0
	bpl.s	loc_202E4C
	bset	#4,scroll_flags_bg
	rts

; ------------------------------------------------------------------------------

loc_202E4C:
	bset	#5,scroll_flags_bg

locret_202E52:
	rts

; ------------------------------------------------------------------------------

ScrollBgY:
	move.w	scroll_bg_y,d3
	move.w	d0,scroll_bg_y
	move.w	d0,d1
	andi.w	#$10,d1
	move.b	scroll_cross_bg_y,d2
	eor.b	d2,d1
	bne.s	locret_202E82
	eori.b	#$10,scroll_cross_bg_y
	sub.w	d3,d0
	bpl.s	loc_202E7C
	bset	#0,scroll_flags_bg
	rts

; ------------------------------------------------------------------------------

loc_202E7C:
	bset	#1,scroll_flags_bg

locret_202E82:
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
	bne.s	locret_202EB6
	eori.b	#$10,scroll_cross_bg_x
	sub.l	d2,d0
	bpl.s	loc_202EB0
	bset	d6,scroll_flags_bg
	bra.s	locret_202EB6

; ------------------------------------------------------------------------------

loc_202EB0:
	addq.b	#1,d6
	bset	d6,scroll_flags_bg

locret_202EB6:
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
	bne.s	locret_202EEA
	eori.b	#$10,scroll_cross_bg2_x
	sub.l	d2,d0
	bpl.s	loc_202EE4
	bset	d6,scroll_flags_bg2
	bra.s	locret_202EEA

; ------------------------------------------------------------------------------

loc_202EE4:
	addq.b	#1,d6
	bset	d6,scroll_flags_bg2

locret_202EEA:
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
	bne.s	locret_202F1E
	eori.b	#$10,scroll_cross_bg3_x
	sub.l	d2,d0
	bpl.s	loc_202F18
	bset	d6,scroll_flags_bg3
	bra.s	locret_202F1E

; ------------------------------------------------------------------------------

loc_202F18:
	addq.b	#1,d6
	bset	d6,scroll_flags_bg3

locret_202F1E:
	rts

; ------------------------------------------------------------------------------
