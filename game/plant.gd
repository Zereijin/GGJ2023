class_name Plant
extends RigidBody2D

## The sprite.
@onready
var sprite := $Sprite


func _process(_delta: float) -> void:
	if constant_force.is_zero_approx():
		sprite.stop()
	elif constant_force.max_axis_index() == Vector2.AXIS_X:
		if constant_force.x > 0:
			sprite.play(&"right")
		else:
			sprite.play(&"left")
	else:
		if constant_force.y > 0:
			sprite.play(&"down")
		else:
			sprite.play(&"up")
