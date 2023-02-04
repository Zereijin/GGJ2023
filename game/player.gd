extends RigidBody2D

## The force, in Newtons, applied by a keypress or full joystick deflection
@export_range(0, 100000)
var force_multiplier: float

func _unhandled_input(event: InputEvent) -> void:
	constant_force = Input.get_vector("left", "right", "up", "down") * force_multiplier
