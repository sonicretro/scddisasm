; ------------------------------------------------------------------------------

GetPlayerObject:
	lea	player_object,a6
	tst.b	use_player_2
	beq.s	locret_202B34
	lea	player_object_2,a6

locret_202B34:
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
	lea	unk_202B92,a0
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
	bra.w	loc_202BBE

; ------------------------------------------------------------------------------

unk_202B92:
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

unk_202B9E:
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

loc_202BBE:
	tst.b	spawn_mode
	beq.s	loc_202BDA
	jsr	LoadCheckpoint
	moveq	#0,d0
	moveq	#0,d1
	move.w	8(a6),d1
	move.w	$C(a6),d0
	bra.s	loc_202C16

; ------------------------------------------------------------------------------

loc_202BDA:
	lea	StagePlayerSpawn,a1
	tst.w	stage_demo
	bpl.s	loc_202BFC
	move.w	s1_credits_index,d0
	subq.w	#1,d0
	lsl.w	#2,d0
	lea	unk_202B9E,a1
	adda.w	d0,a1
	bra.s	loc_202C06

; ------------------------------------------------------------------------------

loc_202BFC:
	move.w	stage_demo,d0
	lsl.w	#2,d0
	adda.w	d0,a1

loc_202C06:
	moveq	#0,d1
	move.w	(a1)+,d1
	move.w	d1,8(a6)
	moveq	#0,d0
	move.w	(a1),d0
	move.w	d0,$C(a6)

loc_202C16:
	subi.w	#$A0,d1
	bcc.s	loc_202C1E
	moveq	#0,d1

loc_202C1E:
	move.w	right_bound,d2
	cmp.w	d2,d1
	bcs.s	loc_202C28
	move.w	d2,d1

loc_202C28:
	move.w	d1,scroll_fg_x
	subi.w	#$60,d0
	bcc.s	loc_202C34
	moveq	#0,d0

loc_202C34:
	cmp.w	bottom_bound,d0
	blt.s	loc_202C3E
	move.w	bottom_bound,d0

loc_202C3E:
	move.w	d0,scroll_fg_y
	bsr.w	sub_202C5A
	lea	unk_202C56,a1
	move.l	(a1),loop_chunk_1
	rts

; ------------------------------------------------------------------------------

StagePlayerSpawn:
	incbin	"src/maps/r4/spawn_1d.bin"
	even

unk_202C56:
	dc.b	$7F
	dc.b	$7F
	dc.b	$7F
	dc.b	$7F

; ------------------------------------------------------------------------------

sub_202C5A:
	move.w	scroll_fg_y,d0
	lsr.w	#1,d0
	move.w	d0,scroll_bg_y
	move.w	#0,scroll_bg_y+2
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

loc_202C96:
	clr.l	(a2)+
	dbf	d2,loc_202C96
	rts

; ------------------------------------------------------------------------------

UpdateScroll:
	lea	player_object,a6
	tst.b	scroll_lock
	beq.s	loc_202CAA
	rts

; ------------------------------------------------------------------------------

loc_202CAA:
	clr.w	scroll_flags_fg
	clr.w	scroll_flags_bg
	clr.w	scroll_flags_bg2
	clr.w	scroll_flags_bg3
	bsr.w	ScrollFgX
	bsr.w	ScrollFgY
	bsr.w	StageEvents
	move.w	scroll_fg_y,scroll_y
	move.w	scroll_bg_y,scroll_y+2
	lea	bg_scroll_lines,a1
	move.w	scroll_x_move,d4
	ext.l	d4
	asl.l	#2,d4
	move.l	d4,d3
	add.l	d3,d3
	add.l	d3,d4
	moveq	#2,d6
	move.w	scroll_y_move,d5
	ext.l	d5
	asl.l	#7,d5
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
	move.w	scroll_bg_x,d0
	neg.w	d0
	move.w	#$BF,d6

loc_202D26:
	move.w	d0,(a1)+
	dbf	d6,loc_202D26
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
	bra.w	*+4

; ------------------------------------------------------------------------------

loc_202D52:
	lea	unk_202DD0,a3
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

loc_202D88:
	cmp.w	water_y,d1
	bge.s	loc_202DA8
	move.l	d0,(a1)+
	addq.w	#1,d1
	addq.b	#1,d3
	addq.b	#1,d4
	addq.b	#1,d2
	cmpi.b	#8,d2
	bne.s	loc_202DA2
	moveq	#0,d2
	move.w	(a2)+,d0

loc_202DA2:
	dbf	d6,loc_202D88
	rts

; ------------------------------------------------------------------------------

loc_202DA8:
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
	bne.s	loc_202DCA
	moveq	#0,d2
	move.w	(a2)+,d0

loc_202DCA:
	dbf	d6,loc_202DA8
	rts

; ------------------------------------------------------------------------------

unk_202DD0:
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
	bne.s	locret_202F02
	eori.b	#$10,scroll_cross_x
	move.w	scroll_fg_x,d0
	sub.w	d4,d0
	bpl.s	loc_202EFC
	bset	#2,scroll_flags_fg
	rts

; ------------------------------------------------------------------------------

loc_202EFC:
	bset	#3,scroll_flags_fg

locret_202F02:
	rts

; ------------------------------------------------------------------------------

CheckScrollFgX:
	move.w	8(a6),d0
	sub.w	scroll_fg_x,d0
	sub.w	scroll_focus_x,d0
	beq.s	loc_202F16
	bcs.s	loc_202F46
	bra.s	loc_202F1C

; ------------------------------------------------------------------------------

loc_202F16:
	clr.w	scroll_x_move
	rts

; ------------------------------------------------------------------------------

loc_202F1C:
	cmpi.w	#$10,d0
	blt.s	loc_202F26
	move.w	#$10,d0

loc_202F26:
	add.w	scroll_fg_x,d0
	cmp.w	right_bound,d0
	blt.s	loc_202F34
	move.w	right_bound,d0

loc_202F34:
	move.w	d0,d1
	sub.w	scroll_fg_x,d1
	asl.w	#8,d1
	move.w	d0,scroll_fg_x
	move.w	d1,scroll_x_move
	rts

; ------------------------------------------------------------------------------

loc_202F46:
	cmpi.w	#$FFF0,d0
	bge.s	loc_202F50
	move.w	#$FFF0,d0

loc_202F50:
	add.w	scroll_fg_x,d0
	cmp.w	left_bound,d0
	bgt.s	loc_202F34
	move.w	left_bound,d0
	bra.s	loc_202F34

; ------------------------------------------------------------------------------

ScrollFgXSlow:
	tst.w	d0
	bpl.s	loc_202F6A
	move.w	#$FFFE,d0
	bra.s	loc_202F46

; ------------------------------------------------------------------------------

loc_202F6A:
	move.w	#2,d0
	bra.s	loc_202F1C

; ------------------------------------------------------------------------------

ScrollFgY:
	moveq	#0,d1
	move.w	$C(a6),d0
	sub.w	scroll_fg_y,d0
	btst	#2,$22(a6)
	beq.s	loc_202F84
	subq.w	#5,d0

loc_202F84:
	btst	#1,$22(a6)
	beq.s	loc_202FA4
	addi.w	#$20,d0
	sub.w	scroll_focus_y,d0
	bcs.s	loc_202FF0
	subi.w	#$40,d0
	bcc.s	loc_202FF0
	tst.b	bottom_bound_shift
	bne.s	loc_203002
	bra.s	loc_202FB0

; ------------------------------------------------------------------------------

loc_202FA4:
	sub.w	scroll_focus_y,d0
	bne.s	loc_202FB6
	tst.b	bottom_bound_shift
	bne.s	loc_203002

loc_202FB0:
	clr.w	scroll_y_move
	rts

; ------------------------------------------------------------------------------

loc_202FB6:
	cmpi.w	#$60,scroll_focus_y
	bne.s	loc_202FDE
	move.w	$14(a6),d1
	bpl.s	loc_202FC6
	neg.w	d1

loc_202FC6:
	cmpi.w	#$800,d1
	bcc.s	loc_202FF0
	move.w	#$600,d1
	cmpi.w	#6,d0
	bgt.s	loc_203050
	cmpi.w	#$FFFA,d0
	blt.s	loc_20301A
	bra.s	loc_203008

; ------------------------------------------------------------------------------

loc_202FDE:
	move.w	#$200,d1
	cmpi.w	#2,d0
	bgt.s	loc_203050
	cmpi.w	#$FFFE,d0
	blt.s	loc_20301A
	bra.s	loc_203008

; ------------------------------------------------------------------------------

loc_202FF0:
	move.w	#$1000,d1
	cmpi.w	#$10,d0
	bgt.s	loc_203050
	cmpi.w	#$FFF0,d0
	blt.s	loc_20301A
	bra.s	loc_203008

; ------------------------------------------------------------------------------

loc_203002:
	moveq	#0,d0
	move.b	d0,bottom_bound_shift

loc_203008:
	moveq	#0,d1
	move.w	d0,d1
	add.w	scroll_fg_y,d1
	tst.w	d0
	bpl.w	loc_20305A
	bra.w	loc_203026

; ------------------------------------------------------------------------------

loc_20301A:
	neg.w	d1
	ext.l	d1
	asl.l	#8,d1
	add.l	scroll_fg_y,d1
	swap	d1

loc_203026:
	cmp.w	top_bound,d1
	bgt.s	loc_20307E
	cmpi.w	#$FF00,d1
	bgt.s	loc_20304A
	andi.w	#$7FF,d1
	andi.w	#$7FF,$C(a6)
	andi.w	#$7FF,scroll_fg_y
	andi.w	#$3FF,scroll_bg_y
	bra.s	loc_20307E

; ------------------------------------------------------------------------------

loc_20304A:
	move.w	top_bound,d1
	bra.s	loc_20307E

; ------------------------------------------------------------------------------

loc_203050:
	ext.l	d1
	asl.l	#8,d1
	add.l	scroll_fg_y,d1
	swap	d1

loc_20305A:
	cmp.w	bottom_bound,d1
	blt.s	loc_20307E
	subi.w	#$800,d1
	bcs.s	loc_20307A
	andi.w	#$7FF,$C(a6)
	subi.w	#$800,scroll_fg_y
	andi.w	#$3FF,scroll_bg_y
	bra.s	loc_20307E

; ------------------------------------------------------------------------------

loc_20307A:
	move.w	bottom_bound,d1

loc_20307E:
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
	bne.s	locret_2030C0
	eori.b	#$10,scroll_cross_y
	move.w	scroll_fg_y,d0
	sub.w	d4,d0
	bpl.s	loc_2030BA
	bset	#0,scroll_flags_fg
	rts

; ------------------------------------------------------------------------------

loc_2030BA:
	bset	#1,scroll_flags_fg

locret_2030C0:
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
	bne.s	loc_2030F6
	eori.b	#$10,scroll_cross_bg_x
	sub.l	d2,d0
	bpl.s	loc_2030F0
	bset	#2,scroll_flags_bg
	bra.s	loc_2030F6

; ------------------------------------------------------------------------------

loc_2030F0:
	bset	#3,scroll_flags_bg

loc_2030F6:
	move.l	scroll_bg_y,d3
	move.l	d3,d0
	add.l	d5,d0
	move.l	d0,scroll_bg_y
	move.l	d0,d1
	swap	d1
	andi.w	#$10,d1
	move.b	scroll_cross_bg_y,d2
	eor.b	d2,d1
	bne.s	locret_20312A
	eori.b	#$10,scroll_cross_bg_y
	sub.l	d3,d0
	bpl.s	loc_203124
	bset	#0,scroll_flags_bg
	rts

; ------------------------------------------------------------------------------

loc_203124:
	bset	#1,scroll_flags_bg

locret_20312A:
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
	bne.s	locret_203160
	eori.b	#$10,scroll_cross_bg_y
	sub.l	d3,d0
	bpl.s	loc_20315A
	bset	#4,scroll_flags_bg
	rts

; ------------------------------------------------------------------------------

loc_20315A:
	bset	#5,scroll_flags_bg

locret_203160:
	rts

; ------------------------------------------------------------------------------

ScrollBgY:
	move.w	scroll_bg_y,d3
	move.w	d0,scroll_bg_y
	move.w	d0,d1
	andi.w	#$10,d1
	move.b	scroll_cross_bg_y,d2
	eor.b	d2,d1
	bne.s	locret_203190
	eori.b	#$10,scroll_cross_bg_y
	sub.w	d3,d0
	bpl.s	loc_20318A
	bset	#0,scroll_flags_bg
	rts

; ------------------------------------------------------------------------------

loc_20318A:
	bset	#1,scroll_flags_bg

locret_203190:
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
	bne.s	locret_2031C4
	eori.b	#$10,scroll_cross_bg_x
	sub.l	d2,d0
	bpl.s	loc_2031BE
	bset	d6,scroll_flags_bg
	bra.s	locret_2031C4

; ------------------------------------------------------------------------------

loc_2031BE:
	addq.b	#1,d6
	bset	d6,scroll_flags_bg

locret_2031C4:
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
	bne.s	locret_2031F8
	eori.b	#$10,scroll_cross_bg2_x
	sub.l	d2,d0
	bpl.s	loc_2031F2
	bset	d6,scroll_flags_bg2
	bra.s	locret_2031F8

; ------------------------------------------------------------------------------

loc_2031F2:
	addq.b	#1,d6
	bset	d6,scroll_flags_bg2

locret_2031F8:
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
	bne.s	locret_20322C
	eori.b	#$10,scroll_cross_bg3_x
	sub.l	d2,d0
	bpl.s	loc_203226
	bset	d6,scroll_flags_bg3
	bra.s	locret_20322C

; ------------------------------------------------------------------------------

loc_203226:
	addq.b	#1,d6
	bset	d6,scroll_flags_bg3

locret_20322C:
	rts

; ------------------------------------------------------------------------------
