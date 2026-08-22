; ------------------------------------------------------------------------------
; Sonic CD Disassembly
; ------------------------------------------------------------------------------
; Data (R83C)
; ------------------------------------------------------------------------------

Padding1:
	incbin	"padding/r83c_e_1.bin"

StageChunks:
	incbin	"src/maps/r8/chunks_3c.bin"
	even

LaserAnims:
	include	"src/anims/r8/laser.asm"
	even

FlowerAnims:
	include	"src/anims/flower.asm"
	even

FlowerSprites:
	include	"src/sprites/r8/flower.asm"
	even

FlowerGfx:
	incbin	"src/gfx/r8/flower.nem"
	even

LaserGfx:
	incbin	"src/gfx/r8/laser.nem"
	even

TitleCardTextGfx:
	incbin	"src/gfx/r8/title_card_text.nem"
	even

byte_21E396:
	incbin	"src/data/r8/byte_2345CA_c.bin"
	even

byte_21E496:
	incbin	"src/data/r8/byte_2346CA_c.bin"
	even

byte_21E596:
	incbin	"src/data/r8/byte_2347CA_c.bin"
	even

byte_21E696:
	incbin	"src/data/r8/byte_2348CA_c.bin"
	even

byte_21E796:
	incbin	"src/data/r8/byte_2349CA_c.bin"
	even

byte_21E896:
	incbin	"src/data/r8/byte_234ACA_c.bin"
	even

byte_21E996:
	incbin	"src/data/r8/byte_234BCA_c.bin"
	even

byte_21EA96:
	incbin	"src/data/r8/byte_234CCA_c.bin"
	even

byte_21EC96:
	incbin	"src/data/r8/byte_234ECA_c.bin"
	even

byte_21EE96:
	incbin	"src/data/r8/byte_2350CA_c.bin"
	even

byte_21F096:
	incbin	"src/data/r8/byte_21EC96_c.bin"
	even

byte_21F296:
	incbin	"src/data/r8/byte_21FA16.bin"
	even

byte_21F316:
	incbin	"src/data/r8/byte_21FA96.bin"
	even

byte_21F396:
	incbin	"src/data/r8/byte_21FB16.bin"
	even

byte_21F416:
	incbin	"src/data/r8/byte_21FB96.bin"
	even

byte_21F496:
	incbin	"src/data/r8/byte_21FC16.bin"
	even

byte_21F516:
	incbin	"src/data/r8/byte_21FC96.bin"

Padding2:
	incbin	"padding/r83c_e_2.bin"

PlayerGfx:
	incbin	"src/gfx/r8/player.unc"
	even

PlayerSprites:
	include	"src/sprites/r8/player.asm"
	even

PlayerGfxScript:
	include	"src/sprites/r8/player_gfx.asm"
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

RevolveDoorGfx:
	incbin	"src/gfx/r8/revolve_door.nem"
	even

BossDoorGfx:
	incbin	"src/gfx/r8/boss_door.nem"
	even

BossPanelsGfx1:
	incbin	"src/gfx/r8/boss_panels_1.nem"
	even

BossPanelsGfx2:
	incbin	"src/gfx/r8/boss_panels_2.nem"
	even

BossPanelsGfx3:
	incbin	"src/gfx/r8/boss_panels_3.nem"
	even

BossMachineGfx:
	incbin	"src/gfx/r8/boss_machine.nem"
	even

BossPanelSprites:
	dc.w	BossPanelSprites1-BossPanelSprites
	dc.w	BossPanelSprites2-BossPanelSprites
	dc.w	BossPanelSprites3-BossPanelSprites
	dc.w	BossPanelSprites4-BossPanelSprites
	dc.w	BossPanelSprites5-BossPanelSprites
	dc.w	BossPanelSprites6-BossPanelSprites

EggMobileSprites:
	include	"src/sprites/r8/eggmobile.asm"
	even

SparksSprites:
	include	"src/sprites/r8/sparks.asm"
	even

EggmanSprites:
	include	"src/sprites/r8/eggman.asm"
	even

BossPanelSprites1:
	include	"src/sprites/r8/boss_panel_1.asm"
	even

BossPanelSprites2:
	include	"src/sprites/r8/boss_panel_2.asm"
	even

BossPanelSprites3:
	include	"src/sprites/r8/boss_panel_3.asm"
	even

BossPanelSprites4:
	include	"src/sprites/r8/boss_panel_4.asm"
	even

BossPanelSprites5:
	include	"src/sprites/r8/boss_panel_5.asm"
	even

BossPanelSprites6:
	include	"src/sprites/r8/boss_panel_6.asm"
	even

AmyRoseGfx:
	incbin	"src/gfx/r8/amy_rose.nem"
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
	incbin	"src/maps/r8/collision_3c.bin"
	even

StageMaps:
	dc.w	StageMapFg-*
	dc.w	StageMapBg-StageMaps
	dc.w	StageMapNull-StageMaps
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
	dc.w	StageMapNull-StageMaps
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
	dc.w	StageMapNull-StageMaps
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
	incbin	"src/maps/r8/foreground_3c.bin"
	even

StageMapBg:
	incbin	"src/maps/r8/background_3c.bin"
	even

StageMapNull:
	incbin	"src/maps/empty.bin"
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
	incbin	"src/maps/r8/blocks_3c.nem"
	even

StageGfx:
	incbin	"src/maps/r8/gfx_3c.nem"
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

DoorGfx:
	incbin	"src/gfx/r8/door.nem"
	even

SpikesV4Gfx:
	incbin	"src/gfx/spikes_v4.nem"
	even

CrusherGfx:
	incbin	"src/gfx/r8/crusher.nem"
	even

CollapseFloorGfx:
	incbin	"src/gfx/r8/collapse_floor.nem"
	even

SwitchGfx:
	incbin	"src/gfx/switch.nem"
	even

SpikePoleGfx:
	incbin	"src/gfx/r8/spike_pole.nem"
	even

BumperGfx:
	incbin	"src/gfx/r3/bumper.nem"
	even

BlockGfx:
	incbin	"src/gfx/r8/block.nem"
	even

RotatePlatformGfx:
	incbin	"src/gfx/r8/rotate_platform.nem"
	even

BuzzsawGfxABD:
	incbin	"src/gfx/r8/buzzsaw_abd.nem"
	even

BuzzsawGfxC:
	incbin	"src/gfx/r8/buzzsaw_c.nem"
	even

SpikeCrusherGfx:
	incbin	"src/gfx/r8/spike_crusher.nem"
	even

SpringWheelGfx:
	incbin	"src/gfx/spring_wheel.nem"
	even

MechaBuGfx:
	incbin	"src/gfx/r8/mecha_bu.nem"
	even

HotaruGfx:
	incbin	"src/gfx/r8/hotaru.nem"
	even

AnimalsGfx:
	incbin	"src/gfx/r8/animals.nem"
	even

HotaruSprites:
	include	"src/sprites/r8/hotaru.asm"
	even

SpikeCrusherSprites:
	include	"src/sprites/r8/spike_crusher.asm"
	even

BuzzsawSprites:
	include	"src/sprites/r8/buzzsaw_cd.asm"

Padding3:
	incbin	"padding/r83c_e_3.bin"

; ------------------------------------------------------------------------------
