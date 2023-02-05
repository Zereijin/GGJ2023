extends Camera2D

## How much to multiply the player’s directional input by when added to the camera’s target position to achieve lookahead
@export_range(0, 1000)
var lookahead: float

## The player
@onready
var player: RigidBody2D = get_parent()

func _unhandled_input(_event: InputEvent) -> void:
	if player.freeze:
		position = Vector2.ZERO
	else:
		position = Input.get_vector("left", "right", "up", "down") * lookahead
