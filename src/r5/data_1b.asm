; ------------------------------------------------------------------------------
; Sonic CD Disassembly
; ------------------------------------------------------------------------------
; Data (R51B)
; ------------------------------------------------------------------------------

Padding1:
	incbin	"padding/r51b_e_1.bin"

StageChunks:
	incbin	"src/maps/r5/chunks_1b.bin"

Padding2:
	incbin	"padding/r51b_e_2.bin"

PlayerGfx:
	incbin	"src/gfx/player.unc"
	even

PlayerSprites:
	include	"src/sprites/player.asm"
	even

PlayerGfxScript:
	include	"src/sprites/player_gfx.asm"
	even

PointsGfx:
	incbin	"src/gfx/points.nem"
	even

CapsuleGfx:
	incbin	"src/gfx/capsule.nem"
	even

BigRingGfx:
	incbin	"src/gfx/big_ring.nem"
	even

GoalGfx:
	incbin	"src/gfx/goal.nem"
	even

SignpostGfx:
	incbin	"src/gfx/signpost.nem"
	even

ResultsGfx:
	incbin	"src/gfx/results.nem"
	even

TimeOverGfx:
	incbin	"src/gfx/time_over.unc"
	even

GameOverGfx:
	incbin	"src/gfx/game_over.unc"
	even

TitleCardGfx:
	incbin	"src/gfx/title_card.nem"
	even

ShieldGfx:
	incbin	"src/gfx/shield.unc"
	even

InvincibleGfx:
	incbin	"src/gfx/invincible.unc"
	even

WarpGfx:
	incbin	"src/gfx/warp.unc"
	even

Spring45Gfx:
	incbin	"src/gfx/spring_45.nem"
	even

SpringGfx:
	incbin	"src/gfx/spring.nem"
	even

MonitorTimeGfx:
	incbin	"src/gfx/monitor_time.nem"
	even

ExplosionGfx:
	incbin	"src/gfx/explosion.nem"
	even

RingGfx:
	incbin	"src/gfx/ring.nem"
	even

LivesIconsGfx:
	incbin	"src/gfx/lives_icons.unc"
	even

HudNumbersGfx:
	incbin	"src/gfx/hud_numbers.unc"
	even

HudGfx:
	incbin	"src/gfx/hud.nem"
	even

CheckpointGfx:
	incbin	"src/gfx/checkpoint.nem"
	even

FlowerAnims:
	include	"src/anims/flower.asm"
	even

FlowerSprites:
	include	"src/sprites/r5/flower.asm"
	even

FlowerGfx:
	incbin	"src/gfx/r5/flower.nem"
	even

TitleCardTextGfx:
	incbin	"src/gfx/r5/title_card_text.nem"
	even

BossGfx1:
	incbin	"src/gfx/r5/boss_1_proto.nem"
	even

BossGfx2:
	incbin	"src/gfx/r5/boss_2_proto.nem"
	even

StageCollisionAngles:
	incbin	"src/maps/collision_angles.bin"
	even

StageCollisionColumns:
	incbin	"src/maps/collision_columns.bin"
	even

StageCollisionRows:
	incbin	"src/maps/collision_rows.bin"
	even

StageCollision:
	incbin	"src/maps/r5/collision_1b.bin"
	even

StageMaps:
	dc.w	StageMapFg-*
	dc.w	StageMapBg-StageMaps
	dc.w	StageMapBg2-StageMaps
	dc.w	StageMapUnk1-StageMaps
	dc.w	StageMapUnk2-StageMaps
	dc.w	StageMapUnk3-StageMaps
	dc.w	StageMapUnk4-StageMaps
	dc.w	StageMapUnk2-StageMaps
	dc.w	StageMapUnk2-StageMaps
	dc.w	StageMapUnk5-StageMaps
	dc.w	StageMapUnk5-StageMaps
	dc.w	StageMapUnk5-StageMaps
	dc.w	StageMapFg-StageMaps
	dc.w	StageMapBg-StageMaps
	dc.w	StageMapBg2-StageMaps
	dc.w	StageMapUnk1-StageMaps
	dc.w	StageMapUnk2-StageMaps
	dc.w	StageMapUnk3-StageMaps
	dc.w	StageMapUnk4-StageMaps
	dc.w	StageMapUnk2-StageMaps
	dc.w	StageMapUnk2-StageMaps
	dc.w	StageMapUnk5-StageMaps
	dc.w	StageMapUnk5-StageMaps
	dc.w	StageMapUnk5-StageMaps
	dc.w	StageMapFg-StageMaps
	dc.w	StageMapBg-StageMaps
	dc.w	StageMapBg2-StageMaps
	dc.w	StageMapUnk1-StageMaps
	dc.w	StageMapUnk2-StageMaps
	dc.w	StageMapUnk3-StageMaps
	dc.w	StageMapUnk4-StageMaps
	dc.w	StageMapUnk2-StageMaps
	dc.w	StageMapUnk2-StageMaps
	dc.w	StageMapUnk5-StageMaps
	dc.w	StageMapUnk5-StageMaps
	dc.w	StageMapUnk5-StageMaps

StageMapFg:
	incbin	"src/maps/r5/foreground_1b.bin"
	even

StageMapBg:
	incbin	"src/maps/r5/bg_inside_1b.bin"
	even

StageMapBg2:
	incbin	"src/maps/r5/bg_outside_1b.bin"
	even

StageMapUnk1:
	incbin	"src/maps/ghz2_foreground.bin"
	even

StageMapUnk3:
	incbin	"src/maps/empty.bin"
	even

StageMapUnk4:
	incbin	"src/maps/ghz3_foreground.bin"
	even

StageMapUnk2:
	incbin	"src/maps/empty.bin"
	even

StageMapUnk5:
	incbin	"src/maps/empty.bin"
	even

StageBlocks:
	incbin	"src/maps/r5/blocks_1b.nem"
	even

StageGfx:
	incbin	"src/maps/r5/gfx_1b.nem"
	even

PowerupAnims:
	include	"src/anims/powerup.asm"
	even

PowerupSprites:
	include	"src/sprites/powerup.asm"
	even

SplashAnims:
	include	"src/anims/splash.asm"
	even

SplashSprites:
	include	"src/sprites/splash.asm"
	even

HDoorAnims:
	include	"src/anims/r1/h_door.asm"
	even

HDoorSprites:
	include	"src/sprites/r1/h_door.asm"
	even

TunnelSplashAnims:
	include	"src/anims/r1/tunnel_splash.asm"
	even

TunnelSplashSprites:
	include	"src/sprites/r1/tunnel_splash.asm"
	even

ExplosionAnims:
	include	"src/anims/explosion.asm"
	even

ExplosionSprites:
	include	"src/sprites/explosion.asm"
	even

WobbleTable:
	incbin	"src/data/wobble.bin"
	even

CheckpointAnims:
	include	"src/anims/checkpoint.asm"
	even

CheckpointSprites:
	include	"src/sprites/checkpoint.asm"
	even

BigRingAnims:
	include	"src/anims/big_ring.asm"
	even

BigRingSprites:
	include	"src/sprites/big_ring.asm"
	even

SignpostAnims:
	include	"src/anims/signpost.asm"
	even

SignpostSprites:
	include	"src/sprites/signpost.asm"
	even

CapsuleAnims:
	include	"src/anims/capsule.asm"
	even

CapsuleSprites:
	include	"src/sprites/capsule.asm"
	even

BgInsideGfxB:
	incbin	"src/gfx/r5/bg_inside_b.nem"
	even

BgOutsideGfxB:
	incbin	"src/gfx/r5/bg_outside_b.nem"
	even

BridgeGfxB:
	incbin	"src/gfx/r5/bridge_b.nem"
	even

ConveyorCtrlGfxB:
	incbin	"src/gfx/r5/conveyor_control_b.nem"
	even

PlatformGfxB:
	incbin	"src/gfx/r5/platform_b.nem"
	even

AnimalsGfx:
	incbin	"src/gfx/r5/animals.nem"
	even

HologramAnimalsGfx:
	incbin	"src/gfx/r5/hologram_animals.nem"
	even

HologramGfx:
	incbin	"src/gfx/hologram.nem"
	even

BreakWallGfxB:
	incbin	"src/gfx/r5/break_wall_b.nem"
	even

ChainGfx:
	incbin	"src/gfx/chain.nem"
	even

CollapseFloorGfxB:
	incbin	"src/gfx/r5/collapse_floor_b.nem"
	even

SpikesHV4Gfx:
	incbin	"src/gfx/spikes_hv4.nem"
	even

StalactiteGfxB:
	incbin	"src/gfx/r5/stalactite_b.nem"
	even

RockGfxB:
	incbin	"src/gfx/r5/rock_b.nem"
	even

KumoKumoGfx:
	incbin	"src/gfx/r5/kumo_kumo.nem"
	even

KemusiGfx:
	incbin	"src/gfx/r5/kemusi.nem"
	even

SasoriGfx:
	incbin	"src/gfx/r5/sasori.nem"
	even

NoroNoroGfx:
	incbin	"src/gfx/r5/noro_noro.nem"
	even

RobotTransportGfxB:
	incbin	"src/gfx/robot_transport_b.nem"
	even

SinePlatformGfxB:
	incbin	"src/gfx/r5/sine_platform_b.nem"
	even

CrackFloorGfxB:
	incbin	"src/gfx/r5/crack_floor_b.nem"

Padding3:
	incbin	"padding/r51b_e_3.bin"

; ------------------------------------------------------------------------------
