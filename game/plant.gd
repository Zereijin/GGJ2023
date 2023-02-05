class_name Plant
extends RigidBody2D

## The sprite.
@onready
var sprite := $Sprite

## The damageable sub-node of this plant
@onready
var damageable : Damageable = $Damageable


func _process(_delta: float) -> void:
	if damageable.alive:
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


## Called when the plant’s health reaches zero
func _on_dead() -> void:
	# Become non-collidable and stop moving.
	collision_mask = 0
	collision_layer = 0
	freeze = true
	linear_velocity = Vector2.ZERO
	$CollisionShape.queue_free()

	# Play the animation
	sprite.play(&"die")
