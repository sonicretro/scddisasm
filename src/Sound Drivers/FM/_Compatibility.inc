; -------------------------------------------------------------------------
; Sonic CD Disassembly
; -------------------------------------------------------------------------
; ASM68K compatibility for AS
; -------------------------------------------------------------------------

; -------------------------------------------------------------------------
; Start RS structure
; -------------------------------------------------------------------------

rsset macro org
	dephase
	phase	org
	endm

; -------------------------------------------------------------------------
; Start RS structure at 0
; -------------------------------------------------------------------------

rsreset macro
	rsset	0
	endm

; -------------------------------------------------------------------------
; RS structure entry
; -------------------------------------------------------------------------

rs macro num
	rept	num
		dc.ATTRIBUTE	0
	endm
	endm

; -------------------------------------------------------------------------
