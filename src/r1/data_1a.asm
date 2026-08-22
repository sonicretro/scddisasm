; ------------------------------------------------------------------------------
; Sonic CD Disassembly
; ------------------------------------------------------------------------------
; Data (R11A)
; ------------------------------------------------------------------------------

Padding1:
	incbin	"padding/r11a_e_1.bin"

StageChunks:
	incbin	"src/maps/r1/chunks_1a.bin"
	even

PlayerSprites:
	include	"src/sprites/r1/player.asm"
	even

Boost3dSprites:
	include	"src/sprites/r1/3d_boost.asm"

Padding2:
	incbin	"padding/r11a_e_2.bin"

PlayerGfx:
	incbin	"src/gfx/r1/player.unc"
	even

PlayerGfxScript:
	include	"src/sprites/r1/player_gfx.asm"
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

LogInsideGfxCD:
	incbin	"src/gfx/r1/log_inside_cd.nem"
	even

LogInsideGfxAB:
	incbin	"src/gfx/r1/log_inside_ab.nem"
	even

FlowerAnims:
	include	"src/anims/flower.asm"
	even

FlowerSprites:
	include	"src/sprites/r1/flower.asm"
	even

FlowerGfx:
	incbin	"src/gfx/r1/flower.nem"
	even

TitleCardTextGfx:
	incbin	"src/gfx/r1/title_card_text.nem"
	even

PlatformGfx:
	incbin	"src/gfx/r1/platform.nem"
	even

BoulderGfx:
	incbin	"src/gfx/r1/boulder.nem"
	even

BlockGfx:
	incbin	"src/gfx/r1/block.nem"
	even

SpringWheelGfx:
	incbin	"src/gfx/spring_wheel.nem"
	even

SpinDiscGfx:
	incbin	"src/gfx/r1/spin_disc.nem"
	even

TunnelSplashGfx:
	incbin	"src/gfx/r1/tunnel_splash.nem"
	even

WaterfallGfx:
	incbin	"src/gfx/r1/waterfall.nem"
	even

DoorGfx:
	incbin	"src/gfx/r1/door.nem"
	even

SplashGfx:
	incbin	"src/gfx/splash.nem"
	even

AntonGfx:
	incbin	"src/gfx/r1/anton.nem"
	even

MosquiGfx:
	incbin	"src/gfx/r1/mosqui.nem"
	even

PataBataGfx:
	incbin	"src/gfx/r1/pata_bata.nem"
	even

TagaTageGfx:
	incbin	"src/gfx/r1/taga_taga.nem"
	even

TamabbohGfx:
	incbin	"src/gfx/r1/tamabboh.nem"
	even

SpringboardGfx:
	incbin	"src/gfx/r1/springboard.nem"
	even

SwitchGfx:
	incbin	"src/gfx/r1/switch.nem"
	even

SpikesV2Gfx:
	incbin	"src/gfx/spikes_v2.nem"
	even

SwingGfx:
	incbin	"src/gfx/r1/swing.nem"
	even

AnimalsGfx:
	incbin	"src/gfx/r1/animals.nem"
	even

DiscDrillGfx:
	incbin	"src/gfx/r1/disc_drill.nem"
	even

RobotTransportGfxA:
	incbin	"src/gfx/robot_transport_a.nem"
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
	incbin	"src/maps/r1/collision_1a.bin"
	even

StageMaps:
	dc.w	StageMapFg-*
	dc.w	StageMapBg-StageMaps
	dc.w	StageMapNull-StageMaps
	dc.w	StageMapNull-StageMaps
	dc.w	StageMapNull-StageMaps
	dc.w	StageMapNull-StageMaps
	dc.w	StageMapNull-StageMaps
	dc.w	StageMapNull-StageMaps
	dc.w	StageMapNull-StageMaps
	dc.w	StageMapNull-StageMaps
	dc.w	StageMapNull-StageMaps
	dc.w	StageMapNull-StageMaps
	dc.w	StageMapFg-StageMaps
	dc.w	StageMapBg-StageMaps
	dc.w	StageMapNull-StageMaps
	dc.w	StageMapNull-StageMaps
	dc.w	StageMapNull-StageMaps
	dc.w	StageMapNull-StageMaps
	dc.w	StageMapNull-StageMaps
	dc.w	StageMapNull-StageMaps
	dc.w	StageMapNull-StageMaps
	dc.w	StageMapNull-StageMaps
	dc.w	StageMapNull-StageMaps
	dc.w	StageMapNull-StageMaps
	dc.w	StageMapFg-StageMaps
	dc.w	StageMapBg-StageMaps
	dc.w	StageMapNull-StageMaps
	dc.w	StageMapNull-StageMaps
	dc.w	StageMapNull-StageMaps
	dc.w	StageMapNull-StageMaps
	dc.w	StageMapNull-StageMaps
	dc.w	StageMapNull-StageMaps
	dc.w	StageMapNull-StageMaps
	dc.w	StageMapNull-StageMaps
	dc.w	StageMapNull-StageMaps
	dc.w	StageMapNull-StageMaps

StageMapFg:
	incbin	"src/maps/r1/foreground_1a.bin"
	even

StageMapBg:
	incbin	"src/maps/r1/background_1a.bin"
	even

StageMapNull:

PlayerHoleGfx:
	incbin	"src/gfx/r1/player_hole.nem"
	even

Plant3d:
	incbin	"src/gfx/r1/3d_plant.nem"
	even

Boost3dGfx:
	incbin	"src/gfx/r1/3d_boost.nem"
	even

StageBlocks:
	incbin	"src/maps/r1/blocks_1a.nem"
	even

StageGfx:
	incbin	"src/maps/r1/gfx_1a.nem"
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
CapsuleSprites:

AmyRoseGfx:
	incbin	"src/gfx/r1/amy_rose.nem"
	even

AmyRoseSprites:
	include	"src/sprites/r1/amy_rose.asm"
	even

AmyRoseAnims:
	include	"src/anims/r1/amy_rose.asm"
	even

Padding3:
	incbin	"padding/r11a_e_3.bin"

; ------------------------------------------------------------------------------
