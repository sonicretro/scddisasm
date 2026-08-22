; ------------------------------------------------------------------------------

InitScroll:
	lea	player_object,a6
	moveq	#0,d0
	move.b	d0,unused_scroll_x_flag
	move.b	d0,unused_scroll_y_flag
	move.b	d0,unused_scroll_die
	move.b	d0,unused_scroll_timer
	move.b	d0,event_routine
	lea	unk_202C12,a0
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
	bra.w	loc_202C1E

; ------------------------------------------------------------------------------

unk_202C12:
	dc.b	0
	dc.b	4
	dc.b	0
	dc.b	0
	dc.b	$1C
	dc.b	$97
	dc.b	0
	dc.b	0
	dc.b	5
	dc.b	$10
	dc.b	0
	dc.b	$60

; ------------------------------------------------------------------------------

loc_202C1E:
	tst.b	spawn_mode
	beq.s	loc_202C3A
	jsr	LoadCheckpoint
	moveq	#0,d0
	moveq	#0,d1
	move.w	8(a6),d1
	move.w	$C(a6),d0
	bra.s	loc_202C50

; ------------------------------------------------------------------------------

loc_202C3A:
	lea	StagePlayerSpawn,a1
	moveq	#0,d1
	move.w	(a1)+,d1
	move.w	d1,8(a6)
	moveq	#0,d0
	move.w	(a1),d0
	move.w	d0,$C(a6)

loc_202C50:
	subi.w	#$A0,d1
	bcc.s	loc_202C58
	moveq	#0,d1

loc_202C58:
	move.w	right_bound,d2
	cmp.w	d2,d1
	bcs.s	loc_202C62
	move.w	d2,d1

loc_202C62:
	move.w	d1,scroll_fg_x
	subi.w	#$60,d0
	bcc.s	loc_202C6E
	moveq	#0,d0

loc_202C6E:
	cmp.w	bottom_bound,d0
	blt.s	loc_202C78
	move.w	bottom_bound,d0

loc_202C78:
	move.w	d0,scroll_fg_y
	bsr.w	sub_202C94
	lea	unk_202C90,a1
	move.l	(a1),loop_chunk_1
	rts

; ------------------------------------------------------------------------------

StagePlayerSpawn:
	incbin	"src/maps/r4/spawn_1a.bin"
	even

unk_202C90:
	dc.b	$7F
	dc.b	$7F
	dc.b	$7F
	dc.b	$7F

; ------------------------------------------------------------------------------

sub_202C94:
	moveq	#0,d0
	move.w	scroll_fg_y,d0
	cmpi.w	#$200,d0
	bcc.s	loc_202CAE
	cmpi.w	#$280,scroll_fg_x
	bcs.s	loc_202CCA
	move.w	#$200,d0
	bra.s	loc_202CCA

; ------------------------------------------------------------------------------

loc_202CAE:
	subi.w	#$200,d0
	swap	d0
	lsr.l	#2,d0
	move.l	d0,d2
	add.l	d2,d2
	add.l	d2,d0
	addi.l	#$2000000,d0
	move.l	d0,scroll_bg_y
	swap	d0
	bra.s	loc_202CD4

; ------------------------------------------------------------------------------

loc_202CCA:
	move.w	d0,scroll_bg_y
	move.w	#0,scroll_bg_y+2

loc_202CD4:
	move.w	d0,scroll_bg2_y
	move.w	d0,scroll_bg3_y
	lsr.w	#4,d1
	move.w	d1,scroll_bg3_x
	lsr.w	#1,d1
	move.w	d1,d2
	add.w	d2,d2
	add.w	d1,d2
	move.w	d2,scroll_bg2_x
	lsr.w	#1,d1
	move.w	d1,d2
	add.w	d2,d2
	add.w	d1,d2
	move.w	d2,scroll_bg_x
	lea	bg_scroll_lines,a2
	moveq	#$E,d2

loc_202D00:
	clr.l	(a2)+
	dbf	d2,loc_202D00
	rts

; ------------------------------------------------------------------------------

UpdateScroll:
	lea	player_object,a6
	tst.b	scroll_lock
	beq.s	loc_202D14
	rts

; ------------------------------------------------------------------------------

loc_202D14:
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
	moveq	#6,d6
	bsr.w	ScrollBg3X
	move.w	scroll_x_move,d4
	ext.l	d4
	asl.l	#3,d4
	move.l	d4,d3
	add.l	d3,d3
	add.l	d3,d4
	moveq	#4,d6
	bsr.w	ScrollBg2X
	lea	bg_scroll_lines,a1
	move.w	scroll_x_move,d4
	ext.l	d4
	asl.l	#2,d4
	move.l	d4,d3
	add.l	d3,d3
	add.l	d3,d4
	moveq	#2,d6
	bsr.w	ScrollBgX
	moveq	#0,d0
	move.w	scroll_fg_y,d0
	cmpi.w	#$200,d0
	bcc.s	loc_202D90
	cmpi.w	#$280,scroll_fg_x
	bcs.s	loc_202DA6
	move.w	#$200,d0
	bra.s	loc_202DA6

; ------------------------------------------------------------------------------

loc_202D90:
	subi.w	#$200,d0
	swap	d0
	lsr.l	#2,d0
	move.l	d0,d2
	add.l	d2,d2
	add.l	d2,d0
	addi.l	#$2000000,d0
	swap	d0

loc_202DA6:
	bsr.w	ScrollBgY
	move.w	scroll_bg_y,scroll_y+2
	move.w	scroll_bg_y,scroll_bg2_y
	move.w	scroll_bg_y,scroll_bg3_y
	move.b	scroll_flags_bg3,d0
	or.b	scroll_flags_bg2,d0
	or.b	d0,scroll_flags_bg
	clr.b	scroll_flags_bg3
	clr.b	scroll_flags_bg2
	lea	bg_scroll_lines,a2
	move.w	scroll_bg_x,d0
	neg.w	d0
	moveq	#$F,d6

loc_202DDC:
	move.w	d0,(a1)+
	dbf	d6,loc_202DDC
	bsr.w	sub_202E22
	move.w	scroll_bg2_x,d0
	neg.w	d0
	move.w	#$8F,d6

loc_202DF0:
	move.w	d0,(a1)+
	dbf	d6,loc_202DF0
	lea	scroll_lines,a1
	lea	bg_scroll_lines,a2
	move.w	scroll_fg_x,d0
	neg.w	d0
	move.w	d0,d5
	swap	d0
	move.w	scroll_bg_y,d0
	move.w	d0,d2
	andi.w	#$7F8,d0
	lsr.w	#2,d0
	lea	(a2,d0.w),a2
	bra.w	loc_202E5E

; ------------------------------------------------------------------------------

byte_202E1C:
	dc.b	$D
	dc.b	9
	dc.b	3
	dc.b	1
	dc.b	1
	dc.b	0

; ------------------------------------------------------------------------------

sub_202E22:
	move.w	scroll_bg3_x,d0
	move.w	scroll_fg_x,d2
	sub.w	d0,d2
	ext.l	d2
	moveq	#7,d1
	asl.l	d1,d2
	divu.w	#5,d2
	ext.l	d2
	moveq	#9,d1
	asl.l	d1,d2
	move.w	scroll_bg3_x,d3
	moveq	#4,d6

loc_202E42:
	move.w	d3,d0
	neg.w	d0
	moveq	#0,d5
	move.b	byte_202E1C(pc,d6.w),d5

loc_202E4C:
	move.w	d0,(a1)+
	dbf	d5,loc_202E4C
	swap	d3
	add.l	d2,d3
	swap	d3
	dbf	d6,loc_202E42
	rts

; ------------------------------------------------------------------------------

loc_202E5E:
	lea	unk_202EDC,a3
	lea	WobbleTable,a4
	move.b	bg_water_deform,d3
	move.b	d3,d4
	addi.w	#$80,bg_water_deform
	add.w	scroll_bg_y,d3
	andi.w	#$FF,d3
	add.w	scroll_fg_y,d4
	andi.w	#$FF,d4
	move.w	#$E7,d6
	andi.w	#7,d2
	move.w	(a2)+,d0
	move.w	scroll_fg_y,d1

loc_202E94:
	cmp.w	water_y,d1
	bge.s	loc_202EB4
	move.l	d0,(a1)+
	addq.w	#1,d1
	addq.b	#1,d3
	addq.b	#1,d4
	addq.b	#1,d2
	cmpi.b	#8,d2
	bne.s	loc_202EAE
	moveq	#0,d2
	move.w	(a2)+,d0

loc_202EAE:
	dbf	d6,loc_202E94
	rts

; ------------------------------------------------------------------------------

loc_202EB4:
	move.w	#0,d1
	add.w	d5,d1
	move.w	d1,(a1)+
	move.b	(a4,d3.w),d1
	ext.w	d1
	add.w	d0,d1
	move.w	d1,(a1)+
	addq.b	#1,d3
	addq.b	#1,d4
	addq.b	#1,d2
	cmpi.b	#8,d2
	bne.s	loc_202ED6
	moveq	#0,d2
	move.w	(a2)+,d0

loc_202ED6:
	dbf	d6,loc_202EB4
	rts

; ------------------------------------------------------------------------------

unk_202EDC:
	dc.b	1
	dc.b	1
	dc.b	2
	dc.b	2
	dc.b	3
	dc.b	3
	dc.b	3
	dc.b	3
	dc.b	2
	dc.b	2
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
	dc.b	$FF
	dc.b	$FF
	dc.b	$FE
	dc.b	$FE
	dc.b	$FD
	dc.b	$FD
	dc.b	$FD
	dc.b	$FD
	dc.b	$FE
	dc.b	$FE
	dc.b	$FF
	dc.b	$FF
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
	dc.b	1
	dc.b	1
	dc.b	2
	dc.b	2
	dc.b	3
	dc.b	3
	dc.b	3
	dc.b	3
	dc.b	2
	dc.b	2
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

; ------------------------------------------------------------------------------

ScrollFgX:
	move.w	scroll_fg_x,d4
	bsr.s	CheckScrollFgX
	move.w	scroll_fg_x,d0
	andi.w	#$10,d0
	move.b	scroll_cross_x,d1
	eor.b	d1,d0
	bne.s	locret_20300E
	eori.b	#$10,scroll_cross_x
	move.w	scroll_fg_x,d0
	sub.w	d4,d0
	bpl.s	loc_203008
	bset	#2,scroll_flags_fg
	rts

; ------------------------------------------------------------------------------

loc_203008:
	bset	#3,scroll_flags_fg

locret_20300E:
	rts

; ------------------------------------------------------------------------------

CheckScrollFgX:
	move.w	8(a6),d0
	sub.w	scroll_fg_x,d0
	sub.w	scroll_focus_x,d0
	beq.s	loc_203022
	bcs.s	loc_203052
	bra.s	loc_203028

; ------------------------------------------------------------------------------

loc_203022:
	clr.w	scroll_x_move
	rts

; ------------------------------------------------------------------------------

loc_203028:
	cmpi.w	#$10,d0
	blt.s	loc_203032
	move.w	#$10,d0

loc_203032:
	add.w	scroll_fg_x,d0
	cmp.w	right_bound,d0
	blt.s	loc_203040
	move.w	right_bound,d0

loc_203040:
	move.w	d0,d1
	sub.w	scroll_fg_x,d1
	asl.w	#8,d1
	move.w	d0,scroll_fg_x
	move.w	d1,scroll_x_move
	rts

; ------------------------------------------------------------------------------

loc_203052:
	cmpi.w	#$FFF0,d0
	bge.s	loc_20305C
	move.w	#$FFF0,d0

loc_20305C:
	add.w	scroll_fg_x,d0
	cmp.w	left_bound,d0
	bgt.s	loc_203040
	move.w	left_bound,d0
	bra.s	loc_203040

; ------------------------------------------------------------------------------

ScrollFgXSlow:
	tst.w	d0
	bpl.s	loc_203076
	move.w	#$FFFE,d0
	bra.s	loc_203052

; ------------------------------------------------------------------------------

loc_203076:
	move.w	#2,d0
	bra.s	loc_203028

; ------------------------------------------------------------------------------

ScrollFgY:
	moveq	#0,d1
	move.w	$C(a6),d0
	sub.w	scroll_fg_y,d0
	btst	#2,$22(a6)
	beq.s	loc_203090
	subq.w	#5,d0

loc_203090:
	btst	#1,$22(a6)
	beq.s	loc_2030B0
	addi.w	#$20,d0
	sub.w	scroll_focus_y,d0
	bcs.s	loc_2030FC
	subi.w	#$40,d0
	bcc.s	loc_2030FC
	tst.b	bottom_bound_shift
	bne.s	loc_20310E
	bra.s	loc_2030BC

; ------------------------------------------------------------------------------

loc_2030B0:
	sub.w	scroll_focus_y,d0
	bne.s	loc_2030C2
	tst.b	bottom_bound_shift
	bne.s	loc_20310E

loc_2030BC:
	clr.w	scroll_y_move
	rts

; ------------------------------------------------------------------------------

loc_2030C2:
	cmpi.w	#$60,scroll_focus_y
	bne.s	loc_2030EA
	move.w	$14(a6),d1
	bpl.s	loc_2030D2
	neg.w	d1

loc_2030D2:
	cmpi.w	#$800,d1
	bcc.s	loc_2030FC
	move.w	#$600,d1
	cmpi.w	#6,d0
	bgt.s	loc_20315C
	cmpi.w	#$FFFA,d0
	blt.s	loc_203126
	bra.s	loc_203114

; ------------------------------------------------------------------------------

loc_2030EA:
	move.w	#$200,d1
	cmpi.w	#2,d0
	bgt.s	loc_20315C
	cmpi.w	#$FFFE,d0
	blt.s	loc_203126
	bra.s	loc_203114

; ------------------------------------------------------------------------------

loc_2030FC:
	move.w	#$1000,d1
	cmpi.w	#$10,d0
	bgt.s	loc_20315C
	cmpi.w	#$FFF0,d0
	blt.s	loc_203126
	bra.s	loc_203114

; ------------------------------------------------------------------------------

loc_20310E:
	moveq	#0,d0
	move.b	d0,bottom_bound_shift

loc_203114:
	moveq	#0,d1
	move.w	d0,d1
	add.w	scroll_fg_y,d1
	tst.w	d0
	bpl.w	loc_203166
	bra.w	loc_203132

; ------------------------------------------------------------------------------

loc_203126:
	neg.w	d1
	ext.l	d1
	asl.l	#8,d1
	add.l	scroll_fg_y,d1
	swap	d1

loc_203132:
	cmp.w	top_bound,d1
	bgt.s	loc_20318A
	cmpi.w	#$FF00,d1
	bgt.s	loc_203156
	andi.w	#$7FF,d1
	andi.w	#$7FF,$C(a6)
	andi.w	#$7FF,scroll_fg_y
	andi.w	#$3FF,scroll_bg_y
	bra.s	loc_20318A

; ------------------------------------------------------------------------------

loc_203156:
	move.w	top_bound,d1
	bra.s	loc_20318A

; ------------------------------------------------------------------------------

loc_20315C:
	ext.l	d1
	asl.l	#8,d1
	add.l	scroll_fg_y,d1
	swap	d1

loc_203166:
	cmp.w	bottom_bound,d1
	blt.s	loc_20318A
	subi.w	#$800,d1
	bcs.s	loc_203186
	andi.w	#$7FF,$C(a6)
	subi.w	#$800,scroll_fg_y
	andi.w	#$3FF,scroll_bg_y
	bra.s	loc_20318A

; ------------------------------------------------------------------------------

loc_203186:
	move.w	bottom_bound,d1

loc_20318A:
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
	bne.s	locret_2031CC
	eori.b	#$10,scroll_cross_y
	move.w	scroll_fg_y,d0
	sub.w	d4,d0
	bpl.s	loc_2031C6
	bset	#0,scroll_flags_fg
	rts

; ------------------------------------------------------------------------------

loc_2031C6:
	bset	#1,scroll_flags_fg

locret_2031CC:
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
	bne.s	loc_203202
	eori.b	#$10,scroll_cross_bg_x
	sub.l	d2,d0
	bpl.s	loc_2031FC
	bset	#2,scroll_flags_bg
	bra.s	loc_203202

; ------------------------------------------------------------------------------

loc_2031FC:
	bset	#3,scroll_flags_bg

loc_203202:
	move.l	scroll_bg_y,d3
	move.l	d3,d0
	add.l	d5,d0
	move.l	d0,scroll_bg_y
	move.l	d0,d1
	swap	d1
	andi.w	#$10,d1
	move.b	scroll_cross_bg_y,d2
	eor.b	d2,d1
	bne.s	locret_203236
	eori.b	#$10,scroll_cross_bg_y
	sub.l	d3,d0
	bpl.s	loc_203230
	bset	#0,scroll_flags_bg
	rts

; ------------------------------------------------------------------------------

loc_203230:
	bset	#1,scroll_flags_bg

locret_203236:
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
	bne.s	locret_20326C
	eori.b	#$10,scroll_cross_bg_y
	sub.l	d3,d0
	bpl.s	loc_203266
	bset	#4,scroll_flags_bg
	rts

; ------------------------------------------------------------------------------

loc_203266:
	bset	#5,scroll_flags_bg

locret_20326C:
	rts

; ------------------------------------------------------------------------------

ScrollBgY:
	move.w	scroll_bg_y,d3
	move.w	d0,scroll_bg_y
	move.w	d0,d1
	andi.w	#$10,d1
	move.b	scroll_cross_bg_y,d2
	eor.b	d2,d1
	bne.s	locret_20329C
	eori.b	#$10,scroll_cross_bg_y
	sub.w	d3,d0
	bpl.s	loc_203296
	bset	#0,scroll_flags_bg
	rts

; ------------------------------------------------------------------------------

loc_203296:
	bset	#1,scroll_flags_bg

locret_20329C:
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
	bne.s	locret_2032D0
	eori.b	#$10,scroll_cross_bg_x
	sub.l	d2,d0
	bpl.s	loc_2032CA
	bset	d6,scroll_flags_bg
	bra.s	locret_2032D0

; ------------------------------------------------------------------------------

loc_2032CA:
	addq.b	#1,d6
	bset	d6,scroll_flags_bg

locret_2032D0:
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
	bne.s	locret_203304
	eori.b	#$10,scroll_cross_bg2_x
	sub.l	d2,d0
	bpl.s	loc_2032FE
	bset	d6,scroll_flags_bg2
	bra.s	locret_203304

; ------------------------------------------------------------------------------

loc_2032FE:
	addq.b	#1,d6
	bset	d6,scroll_flags_bg2

locret_203304:
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
	bne.s	locret_203338
	eori.b	#$10,scroll_cross_bg3_x
	sub.l	d2,d0
	bpl.s	loc_203332
	bset	d6,scroll_flags_bg3
	bra.s	locret_203338

; ------------------------------------------------------------------------------

loc_203332:
	addq.b	#1,d6
	bset	d6,scroll_flags_bg3

locret_203338:
	rts

; ------------------------------------------------------------------------------
