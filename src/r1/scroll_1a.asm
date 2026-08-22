; ------------------------------------------------------------------------------

GetPlayerObject:
	lea	player_object,a6
	tst.b	use_player_2
	beq.s	locret_2028F2
	lea	player_object_2,a6

locret_2028F2:
	rts

; ------------------------------------------------------------------------------

InitScroll:
	moveq	#0,d0
	move.b	d0,unused_scroll_x_flag
	move.b	d0,unused_scroll_y_flag
	move.b	d0,unused_scroll_die
	move.b	d0,unused_scroll_timer
	move.b	d0,event_routine
	lea	unk_20294C,a0
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
	bra.w	loc_202978

; ------------------------------------------------------------------------------

unk_20294C:
	dc.b	0
	dc.b	4
	dc.b	0
	dc.b	0
	dc.b	$28
	dc.b	$97
	dc.b	0
	dc.b	0
	dc.b	7
	dc.b	$10
	dc.b	0
	dc.b	$60
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

loc_202978:
	tst.b	spawn_mode
	beq.s	loc_202998
	jsr	LoadCheckpoint
	moveq	#0,d0
	moveq	#0,d1
	move.w	player_object+obj.x,d1
	move.w	player_object+obj.y,d0
	bpl.s	loc_202996
	moveq	#0,d0

loc_202996:
	bra.s	loc_2029AE

; ------------------------------------------------------------------------------

loc_202998:
	lea	StagePlayerSpawn,a1
	moveq	#0,d1
	move.w	(a1)+,d1
	move.w	d1,player_object+obj.x
	moveq	#0,d0
	move.w	(a1),d0
	move.w	d0,player_object+obj.y

loc_2029AE:
	subi.w	#$A0,d1
	bcc.s	loc_2029B6
	moveq	#0,d1

loc_2029B6:
	move.w	right_bound,d2
	cmp.w	d2,d1
	bcs.s	loc_2029C0
	move.w	d2,d1

loc_2029C0:
	move.w	d1,scroll_fg_x
	subi.w	#$60,d0
	bcc.s	loc_2029CC
	moveq	#0,d0

loc_2029CC:
	cmp.w	bottom_bound,d0
	blt.s	loc_2029D6
	move.w	bottom_bound,d0

loc_2029D6:
	move.w	d0,scroll_fg_y
	bsr.w	sub_2029F2
	lea	unk_2029EE,a1
	move.l	(a1),loop_chunk_1
	rts

; ------------------------------------------------------------------------------

StagePlayerSpawn:
	incbin	"src/maps/r1/spawn_1a.bin"
	even

unk_2029EE:
	dc.b	$7F
	dc.b	$7F
	dc.b	$7F
	dc.b	$7F

; ------------------------------------------------------------------------------

sub_2029F2:
	cmpi.w	#$800,player_object+obj.x
	bcs.s	loc_202A06
	subi.w	#$1E0,d0
	bcs.s	loc_202A02
	lsr.w	#1,d0

loc_202A02:
	addi.w	#$1E0,d0

loc_202A06:
	swap	d0
	move.l	d0,scroll_bg_y
	swap	d0
	move.w	d0,scroll_bg2_y
	move.w	d0,scroll_bg3_y
	lsr.w	#1,d1
	move.w	d1,scroll_bg_x
	lsr.w	#2,d1
	move.w	d1,d2
	add.w	d2,d2
	add.w	d1,d2
	move.w	d2,scroll_bg3_x
	lsr.w	#1,d1
	move.w	d1,d2
	add.w	d2,d2
	add.w	d1,d2
	move.w	d2,scroll_bg2_x
	lea	bg_scroll_speeds,a2
	moveq	#$12,d6

loc_202A3C:
	clr.l	(a2)+
	dbf	d6,loc_202A3C
	rts

; ------------------------------------------------------------------------------

UpdateScroll:
	tst.b	scroll_lock
	beq.s	loc_202A4C
	rts

; ------------------------------------------------------------------------------

loc_202A4C:
	clr.w	scroll_flags_fg
	clr.w	scroll_flags_bg
	clr.w	scroll_flags_bg2
	clr.w	scroll_flags_bg3
	bsr.w	ScrollFgX
	bsr.w	ScrollFgY
	bsr.w	StageEvents
	move.w	scroll_fg_y,scroll_y
	move.w	scroll_bg_y,scroll_y+2
	moveq	#0,d5
	btst	#1,player_object+obj.var_2c
	beq.s	loc_202A8C
	tst.w	scroll_x_move
	beq.s	loc_202A8C
	move.w	player_object+obj.x_speed,d5
	ext.l	d5
	asl.l	#8,d5

loc_202A8C:
	move.w	scroll_x_move,d4
	ext.l	d4
	asl.l	#5,d4
	add.l	d5,d4
	moveq	#6,d6
	bsr.w	ScrollBg3X
	move.w	scroll_x_move,d4
	ext.l	d4
	asl.l	#4,d4
	move.l	d4,d3
	add.l	d3,d3
	add.l	d3,d4
	add.l	d5,d4
	add.l	d5,d4
	moveq	#4,d6
	bsr.w	ScrollBg2X
	lea	bg_scroll_lines,a1
	move.w	scroll_x_move,d4
	ext.l	d4
	asl.l	#7,d4
	add.l	d5,d4
	moveq	#2,d6
	bsr.w	ScrollBgX
	move.w	scroll_fg_y,d0
	cmpi.w	#$800,player_object+obj.x
	bcs.s	loc_202AE0
	subi.w	#$1E0,d0
	bcs.s	loc_202ADC
	lsr.w	#1,d0

loc_202ADC:
	addi.w	#$1E0,d0

loc_202AE0:
	bsr.w	ScrollBgY
	move.w	scroll_bg_y,scroll_y+2
	move.w	scroll_bg_y,scroll_bg2_y
	move.w	scroll_bg_y,scroll_bg3_y
	move.b	scroll_flags_bg3,d0
	or.b	scroll_flags_bg2,d0
	or.b	d0,scroll_flags_bg
	clr.b	scroll_flags_bg3
	clr.b	scroll_flags_bg2
	lea	bg_scroll_speeds,a2
	addi.l	#$10000,(a2)+
	addi.l	#$E000,(a2)+
	addi.l	#$C000,(a2)+
	addi.l	#$A000,(a2)+
	addi.l	#$8000,(a2)+
	addi.l	#$6000,(a2)+
	addi.l	#$4800,(a2)+
	addi.l	#$4000,(a2)+
	addi.l	#$2800,(a2)+
	addi.l	#$2000,(a2)+
	addi.l	#$2000,(a2)+
	addi.l	#$4000,(a2)+
	addi.l	#$8000,(a2)+
	addi.l	#$C000,(a2)+
	addi.l	#$10000,(a2)+
	addi.l	#$C000,(a2)+
	addi.l	#$8000,(a2)+
	addi.l	#$4000,(a2)+
	addi.l	#$2000,(a2)+
	move.w	scroll_fg_x,d0
	neg.w	d0
	swap	d0
	lea	bg_scroll_speeds,a2
	moveq	#9,d6

loc_202B92:
	move.l	(a2)+,d1
	swap	d1
	add.w	scroll_bg3_x,d1
	neg.w	d1
	moveq	#0,d5
	lea	unk_202C6E,a3
	move.b	(a3,d6.w),d5

loc_202BA8:
	move.w	d1,(a1)+
	dbf	d5,loc_202BA8
	dbf	d6,loc_202B92
	move.w	scroll_bg2_x,d0
	neg.w	d0
	moveq	#$13,d6

loc_202BBA:
	move.w	d0,(a1)+
	dbf	d6,loc_202BBA
	move.w	scroll_bg_x,d0
	neg.w	d0
	moveq	#3,d6

loc_202BC8:
	move.w	d0,(a1)+
	dbf	d6,loc_202BC8
	move.w	scroll_bg_x,d0
	neg.w	d0
	move.w	#$37,d6

loc_202BD8:
	move.w	d0,(a1)+
	dbf	d6,loc_202BD8
	move.w	scroll_bg_x,d0
	neg.w	d0
	moveq	#3,d6

loc_202BE6:
	move.w	d0,(a1)+
	dbf	d6,loc_202BE6
	move.w	scroll_bg2_x,d0
	neg.w	d0
	moveq	#$13,d6

loc_202BF4:
	move.w	d0,(a1)+
	dbf	d6,loc_202BF4
	moveq	#8,d6

loc_202BFC:
	move.l	(a2)+,d1
	swap	d1
	add.w	scroll_bg3_x,d1
	neg.w	d1
	moveq	#0,d5
	lea	unk_202C78,a3
	move.b	(a3,d6.w),d5

loc_202C12:
	move.w	d1,(a1)+
	dbf	d5,loc_202C12
	dbf	d6,loc_202BFC
	move.w	scroll_bg2_x,d0
	neg.w	d0
	moveq	#$13,d6

loc_202C24:
	move.w	d0,(a1)+
	dbf	d6,loc_202C24
	move.w	scroll_bg_x,d0
	neg.w	d0
	moveq	#3,d6

loc_202C32:
	move.w	d0,(a1)+
	dbf	d6,loc_202C32
	move.w	scroll_bg_x,d0
	neg.w	d0
	move.w	#$F,d6

loc_202C42:
	move.w	d0,(a1)+
	dbf	d6,loc_202C42
	lea	scroll_lines,a1
	lea	bg_scroll_lines,a2
	move.w	scroll_bg_y,d0
	move.w	d0,d2
	move.w	d0,d4
	andi.w	#$7F8,d0
	lsr.w	#2,d0
	moveq	#$1D,d1
	lea	(a2,d0.w),a2
	lea	word_202C82,a3
	bra.w	loc_202C8E

; ------------------------------------------------------------------------------

unk_202C6E:
	dc.b	1
	dc.b	3
	dc.b	5
	dc.b	7
	dc.b	7
	dc.b	7
	dc.b	3
	dc.b	5
	dc.b	5
	dc.b	3

unk_202C78:
	dc.b	1
	dc.b	3
	dc.b	5
	dc.b	7
	dc.b	$F
	dc.b	3
	dc.b	9
	dc.b	3
	dc.b	1
	dc.b	0

word_202C82:
	dc.w	$280
	dc.w	$E0
	dc.w	$780
	dc.w	$80
	dc.w	$7FFF
	dc.w	$360

; ------------------------------------------------------------------------------

loc_202C8E:
	cmp.w	(a3),d4
	bcc.s	loc_202CC4

loc_202C92:
	andi.w	#7,d2
	sub.w	d2,d4
	addq.w	#8,d4
	add.w	d2,d2
	move.w	(a2)+,d0
	jmp	loc_202CAE(pc,d2.w)

; ------------------------------------------------------------------------------

loc_202CA2:
	tst.w	d1
	bmi.s	locret_202CC2
	cmp.w	(a3),d4
	bcc.s	loc_202CC4
	addq.w	#8,d4
	move.w	(a2)+,d0

loc_202CAE:
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	move.l	d0,(a1)+
	dbf	d1,loc_202CA2

locret_202CC2:
	rts

; ------------------------------------------------------------------------------

loc_202CC4:
	move.w	d4,d5
	sub.w	(a3),d5
	move.w	2(a3),d6
	sub.w	d5,d6
	bcs.s	loc_202D34
	beq.s	loc_202D2E
	move.w	#$E0,d3
	move.w	scroll_bg_x,d0
	move.w	scroll_fg_x,d2
	sub.w	d0,d2
	ext.l	d2
	asl.l	#8,d2
	divs.w	d3,d2
	ext.l	d2
	asl.l	#8,d2
	moveq	#0,d3
	move.w	d0,d3
	subq.w	#1,d5
	bmi.s	loc_202CFE

loc_202CF2:
	move.w	d3,d0
	swap	d3
	add.l	d2,d3
	swap	d3
	dbf	d5,loc_202CF2

loc_202CFE:
	move.w	d6,d5
	lsr.w	#3,d5
	sub.w	d5,d1
	bcc.s	loc_202D10
	move.w	d1,d5
	neg.w	d5
	lsl.w	#3,d5
	sub.w	d5,d6
	beq.s	loc_202D2E

loc_202D10:
	subq.w	#1,d6

loc_202D12:
	move.w	d3,d0
	neg.w	d0
	move.l	d0,(a1)+
	swap	d3
	add.l	d2,d3
	swap	d3
	addq.w	#1,d4
	move.w	d4,d0
	andi.w	#7,d0
	bne.s	loc_202D2A
	addq.w	#2,a2

loc_202D2A:
	dbf	d6,loc_202D12

loc_202D2E:
	addq.w	#4,a3
	bra.w	loc_202CA2

; ------------------------------------------------------------------------------

loc_202D34:
	addq.w	#4,a3
	move.w	d4,d2
	bra.w	loc_202C92

; ------------------------------------------------------------------------------

ScrollFgX:
	move.w	scroll_fg_x,d4
	bsr.s	CheckScrollFgX
	move.w	scroll_fg_x,d0
	andi.w	#$10,d0
	move.b	scroll_cross_x,d1
	eor.b	d1,d0
	bne.s	locret_202D6E
	eori.b	#$10,scroll_cross_x
	move.w	scroll_fg_x,d0
	sub.w	d4,d0
	bpl.s	loc_202D68
	bset	#2,scroll_flags_fg
	rts

; ------------------------------------------------------------------------------

loc_202D68:
	bset	#3,scroll_flags_fg

locret_202D6E:
	rts

; ------------------------------------------------------------------------------

CheckScrollFgX:
	move.w	player_object+obj.x,d0
	sub.w	scroll_fg_x,d0
	sub.w	scroll_focus_x,d0
	beq.s	loc_202D82
	bcs.s	loc_202DB2
	bra.s	loc_202D88

; ------------------------------------------------------------------------------

loc_202D82:
	clr.w	scroll_x_move
	rts

; ------------------------------------------------------------------------------

loc_202D88:
	cmpi.w	#$10,d0
	blt.s	loc_202D92
	move.w	#$10,d0

loc_202D92:
	add.w	scroll_fg_x,d0
	cmp.w	right_bound,d0
	blt.s	loc_202DA0
	move.w	right_bound,d0

loc_202DA0:
	move.w	d0,d1
	sub.w	scroll_fg_x,d1
	asl.w	#8,d1
	move.w	d0,scroll_fg_x
	move.w	d1,scroll_x_move
	rts

; ------------------------------------------------------------------------------

loc_202DB2:
	cmpi.w	#$FFF0,d0
	bge.s	loc_202DBC
	move.w	#$FFF0,d0

loc_202DBC:
	add.w	scroll_fg_x,d0
	cmp.w	left_bound,d0
	bgt.s	loc_202DA0
	move.w	left_bound,d0
	bra.s	loc_202DA0

; ------------------------------------------------------------------------------

ScrollFgXSlow:
	tst.w	d0
	bpl.s	loc_202DD6
	move.w	#$FFFE,d0
	bra.s	loc_202DB2

; ------------------------------------------------------------------------------

loc_202DD6:
	move.w	#2,d0
	bra.s	loc_202D88

; ------------------------------------------------------------------------------

ScrollFgY:
	moveq	#0,d1
	move.w	player_object+obj.y,d0
	sub.w	scroll_fg_y,d0
	btst	#2,player_object+obj.flags
	beq.s	loc_202DF0
	subq.w	#5,d0

loc_202DF0:
	btst	#1,player_object+obj.flags
	beq.s	loc_202E10
	addi.w	#$20,d0
	sub.w	scroll_focus_y,d0
	bcs.s	loc_202E5C
	subi.w	#$40,d0
	bcc.s	loc_202E5C
	tst.b	bottom_bound_shift
	bne.s	loc_202E6E
	bra.s	loc_202E1C

; ------------------------------------------------------------------------------

loc_202E10:
	sub.w	scroll_focus_y,d0
	bne.s	loc_202E22
	tst.b	bottom_bound_shift
	bne.s	loc_202E6E

loc_202E1C:
	clr.w	scroll_y_move
	rts

; ------------------------------------------------------------------------------

loc_202E22:
	cmpi.w	#$60,scroll_focus_y
	bne.s	loc_202E4A
	move.w	player_object+obj.ground_speed,d1
	bpl.s	loc_202E32
	neg.w	d1

loc_202E32:
	cmpi.w	#$800,d1
	bcc.s	loc_202E5C
	move.w	#$600,d1
	cmpi.w	#6,d0
	bgt.s	loc_202EBC
	cmpi.w	#$FFFA,d0
	blt.s	loc_202E86
	bra.s	loc_202E74

; ------------------------------------------------------------------------------

loc_202E4A:
	move.w	#$200,d1
	cmpi.w	#2,d0
	bgt.s	loc_202EBC
	cmpi.w	#$FFFE,d0
	blt.s	loc_202E86
	bra.s	loc_202E74

; ------------------------------------------------------------------------------

loc_202E5C:
	move.w	#$1000,d1
	cmpi.w	#$10,d0
	bgt.s	loc_202EBC
	cmpi.w	#$FFF0,d0
	blt.s	loc_202E86
	bra.s	loc_202E74

; ------------------------------------------------------------------------------

loc_202E6E:
	moveq	#0,d0
	move.b	d0,bottom_bound_shift

loc_202E74:
	moveq	#0,d1
	move.w	d0,d1
	add.w	scroll_fg_y,d1
	tst.w	d0
	bpl.w	loc_202EC6
	bra.w	loc_202E92

; ------------------------------------------------------------------------------

loc_202E86:
	neg.w	d1
	ext.l	d1
	asl.l	#8,d1
	add.l	scroll_fg_y,d1
	swap	d1

loc_202E92:
	cmp.w	top_bound,d1
	bgt.s	loc_202EEA
	cmpi.w	#$FF00,d1
	bgt.s	loc_202EB6
	andi.w	#$7FF,d1
	andi.w	#$7FF,player_object+obj.y
	andi.w	#$7FF,scroll_fg_y
	andi.w	#$3FF,scroll_bg_y
	bra.s	loc_202EEA

; ------------------------------------------------------------------------------

loc_202EB6:
	move.w	top_bound,d1
	bra.s	loc_202EEA

; ------------------------------------------------------------------------------

loc_202EBC:
	ext.l	d1
	asl.l	#8,d1
	add.l	scroll_fg_y,d1
	swap	d1

loc_202EC6:
	cmp.w	bottom_bound,d1
	blt.s	loc_202EEA
	subi.w	#$800,d1
	bcs.s	loc_202EE6
	andi.w	#$7FF,player_object+obj.y
	subi.w	#$800,scroll_fg_y
	andi.w	#$3FF,scroll_bg_y
	bra.s	loc_202EEA

; ------------------------------------------------------------------------------

loc_202EE6:
	move.w	bottom_bound,d1

loc_202EEA:
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
	bne.s	locret_202F2C
	eori.b	#$10,scroll_cross_y
	move.w	scroll_fg_y,d0
	sub.w	d4,d0
	bpl.s	loc_202F26
	bset	#0,scroll_flags_fg
	rts

; ------------------------------------------------------------------------------

loc_202F26:
	bset	#1,scroll_flags_fg

locret_202F2C:
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
	bne.s	loc_202F62
	eori.b	#$10,scroll_cross_bg_x
	sub.l	d2,d0
	bpl.s	loc_202F5C
	bset	#2,scroll_flags_bg
	bra.s	loc_202F62

; ------------------------------------------------------------------------------

loc_202F5C:
	bset	#3,scroll_flags_bg

loc_202F62:
	move.l	scroll_bg_y,d3
	move.l	d3,d0
	add.l	d5,d0
	move.l	d0,scroll_bg_y
	move.l	d0,d1
	swap	d1
	andi.w	#$10,d1
	move.b	scroll_cross_bg_y,d2
	eor.b	d2,d1
	bne.s	locret_202F96
	eori.b	#$10,scroll_cross_bg_y
	sub.l	d3,d0
	bpl.s	loc_202F90
	bset	#0,scroll_flags_bg
	rts

; ------------------------------------------------------------------------------

loc_202F90:
	bset	#1,scroll_flags_bg

locret_202F96:
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
	bne.s	locret_202FCC
	eori.b	#$10,scroll_cross_bg_y
	sub.l	d3,d0
	bpl.s	loc_202FC6
	bset	#4,scroll_flags_bg
	rts

; ------------------------------------------------------------------------------

loc_202FC6:
	bset	#5,scroll_flags_bg

locret_202FCC:
	rts

; ------------------------------------------------------------------------------

ScrollBgY:
	move.w	scroll_bg_y,d3
	move.w	d0,scroll_bg_y
	move.w	d0,d1
	andi.w	#$10,d1
	move.b	scroll_cross_bg_y,d2
	eor.b	d2,d1
	bne.s	locret_202FFC
	eori.b	#$10,scroll_cross_bg_y
	sub.w	d3,d0
	bpl.s	loc_202FF6
	bset	#0,scroll_flags_bg
	rts

; ------------------------------------------------------------------------------

loc_202FF6:
	bset	#1,scroll_flags_bg

locret_202FFC:
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
	bne.s	locret_203030
	eori.b	#$10,scroll_cross_bg_x
	sub.l	d2,d0
	bpl.s	loc_20302A
	bset	d6,scroll_flags_bg
	bra.s	locret_203030

; ------------------------------------------------------------------------------

loc_20302A:
	addq.b	#1,d6
	bset	d6,scroll_flags_bg

locret_203030:
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
	bne.s	locret_203064
	eori.b	#$10,scroll_cross_bg2_x
	sub.l	d2,d0
	bpl.s	loc_20305E
	bset	d6,scroll_flags_bg2
	bra.s	locret_203064

; ------------------------------------------------------------------------------

loc_20305E:
	addq.b	#1,d6
	bset	d6,scroll_flags_bg2

locret_203064:
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
	bne.s	locret_203098
	eori.b	#$10,scroll_cross_bg3_x
	sub.l	d2,d0
	bpl.s	loc_203092
	bset	d6,scroll_flags_bg3
	bra.s	locret_203098

; ------------------------------------------------------------------------------

loc_203092:
	addq.b	#1,d6
	bset	d6,scroll_flags_bg3

locret_203098:
	rts

; ------------------------------------------------------------------------------
