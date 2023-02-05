class_name Plant
extends RigidBody2D

## The sprite.
@onready
var sprite := $Sprite


func _process(_delta: float) -> void:
	if constant_force.is_zero_approx():
		sprite.stop()
	else:
		var mx := absf(constant_force.x)
		var my := absf(constant_force.y)
		if mx > my || is_equal_approx(mx, my):
			if constant_force.x > 0:
				sprite.play(&"right")
			else:
				sprite.play(&"left")
		else:
			if constant_force.y > 0:
				sprite.play(&"down")
			else:
				sprite.play(&"up")
