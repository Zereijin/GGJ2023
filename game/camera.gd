extends Camera2D

## How much to multiply the player’s velocity by when added to the camera’s target position to achieve lookahead
@export_range(0, 1000)
var lookahead: float

## The closest ancestor of type RigidBody2D
@onready
var rigidbody := _find_rigidbody2d_ancestor()

func _find_rigidbody2d_ancestor() -> RigidBody2D:
	var x: Node = self
	while x != null:
		var body := x as RigidBody2D
		if body != null:
			return body
		x = x.get_parent()
	return null

func _process(_delta: float) -> void:
	position = rigidbody.linear_velocity * lookahead
