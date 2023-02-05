extends Node

## The situation
enum Situation {
	NOT_IN_GAME,
	ABOVE_GROUND,
	BELOW_GROUND,
	IN_SHOP,
}

## The fade time between situations
@export_range(0, 10)
var fade_time := 1.0

## The current situation
var situation : Situation = Situation.NOT_IN_GAME

## Whether each adjustable stream should be audible in each situation
##
## Each element is +1 if the stream should be audible in the situation, or -1 if not.
var _streams_audible : Array[PackedByteArray] = [
	# Not in game
	[
		# Nothing beyond base plays.
		-1,
		-1,
		-1,
	],

	# Above ground
	[
		# Above ground loop plays.
		1,
		# Below ground loop does not play.
		-1,
		# Shop loop does not play.
		-1,
	],

	# Below ground
	[
		# Above ground loop plays.
		1,
		# Below ground loop plays.
		1,
		# Shop loop does not play.
		-1,
	],

	# In shop
	[
		# Above ground loop does not play.
		-1,
		# Below ground loop does not play.
		-1,
		# Shop loop plays.
		1,
	],
]

## The streams that get adjusted at runtime
@onready
var _adjustable_streams : Array[AudioStreamPlayer] = [
	$AboveGroundLoop as AudioStreamPlayer,
	$BelowGroundLoop as AudioStreamPlayer,
	$ShopLoop as AudioStreamPlayer,
]


func _process(delta: float) -> void:
	var _audible := _streams_audible[situation]
	var step = delta / fade_time * 80.0
	for i in range(_adjustable_streams.size()):
		var sign := _audible.decode_s8(i)
		var stream := _adjustable_streams[i]
		stream.volume_db = clampf(stream.volume_db + sign * step, -80.0, 0.0)
