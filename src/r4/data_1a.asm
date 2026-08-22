; ------------------------------------------------------------------------------
; Sonic CD Disassembly
; ------------------------------------------------------------------------------
; Data (R41A)
; ------------------------------------------------------------------------------

Padding1:
	incbin	"padding/r41a_e_1.bin"

StageChunks:
	incbin	"src/maps/r4/chunks_1a.bin"
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

WaterSurfaceGfx:
	incbin	"src/gfx/r4/water_surface.nem"
	even

FlowerAnims:
	include	"src/anims/flower.asm"
	even

FlowerSprites:
	include	"src/sprites/r4/flower.asm"
	even

FlowerGfx:
	incbin	"src/gfx/r4/flower.nem"
	even

TitleCardTextGfx:
	incbin	"src/gfx/r4/title_card_text.nem"
	even

BubbleNumbersGfx:
	incbin	"src/gfx/r4/bubble_numbers.nem"
	even

BubbleSprites:
	include	"src/sprites/r4/bubbles.asm"
	even

SpikeBallGfx:
	incbin	"src/gfx/r4/spike_ball.nem"
	even

ChainGfx:
	incbin	"src/gfx/chain.nem"
	even

TurbineGfxA:
	incbin	"src/gfx/r4/turbine_a.nem"
	even

CollapseFloorGfxA:
	incbin	"src/gfx/r4/collapse_floor_a.nem"
	even

ElectricBeamGfxA:
	incbin	"src/gfx/r4/electric_beam_a.nem"
	even

ShootGfx:
	incbin	"src/gfx/r4/shoot.nem"
	even

TonboGfx:
	incbin	"src/gfx/r4/tonbo.nem"
	even

TagaTagaGfx:
	incbin	"src/gfx/r4/taga_taga.nem"
	even

YagoGfx:
	incbin	"src/gfx/r4/yago.nem"
	even

AmenboGfx:
	incbin	"src/gfx/r4/amenbo.nem"
	even

WoodBlockGfx:
	incbin	"src/gfx/r4/wood_block.nem"
	even

AnimalsGfx:
	incbin	"src/gfx/r4/animals.nem"
	even

RobotTransportGfxA:
	incbin	"src/gfx/robot_transport_a.nem"

Padding2:
	incbin	"padding/r41a_e_2.bin"

PlayerGfx:
	incbin	"src/gfx/r4/player.unc"
	even

PlayerSprites:
	include	"src/sprites/r4/player.asm"
	even

PlayerGfxScript:
	include	"src/sprites/r4/player_gfx.asm"
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

byte_238A42:
	incbin	"src/data/r4/byte_238A42_1a.bin"
	even

byte_238C42:
	incbin	"src/data/r4/byte_238C42_1a.bin"
	even

byte_238E42:
	incbin	"src/data/r4/byte_238E42_1a.bin"
	even

byte_239042:
	incbin	"src/data/r4/byte_239042_1a.bin"
	even

byte_239242:
	incbin	"src/data/r4/byte_239242_1a.bin"
	even

byte_239442:
	incbin	"src/data/r4/byte_239442_1a.bin"
	even

byte_239642:
	incbin	"src/data/r4/byte_239642_1a.bin"
	even

byte_239842:
	incbin	"src/data/r4/byte_239842_1a.bin"
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
	incbin	"src/maps/r4/collision_1a.bin"
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
	incbin	"src/maps/r4/foreground_1a.bin"
	even

StageMapBg:
	incbin	"src/maps/r4/background_1a.bin"
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
	incbin	"src/maps/r4/blocks_1a.nem"
	even

StageGfx:
	incbin	"src/maps/r4/gfx_1a.nem"
	even

BreakPoleGfxAB:
	incbin	"src/gfx/r4/break_pole_ab.nem"
	even

SpikesV4Gfx:
	incbin	"src/gfx/spikes_v4.nem"
	even

BlockGfxA:
	incbin	"src/gfx/r4/block_a.nem"
	even

SwitchGfx:
	incbin	"src/gfx/switch.nem"
	even

SlopeElevatorGfxA:
	incbin	"src/gfx/r4/slope_elevator_a.nem"
	even

SwingGfxAB:
	incbin	"src/gfx/r4/swing_ab.nem"
	even

PrizePointsGfx:
	incbin	"src/gfx/r4/prize_points.nem"
	even

DoorGfxA:
	incbin	"src/gfx/r4/door_a.nem"
	even

GeyserGfx:
	incbin	"src/gfx/r4/geyser.nem"

Padding3:
	incbin	"padding/r41a_e_3.bin"

; ------------------------------------------------------------------------------
