class_name Projectile
extends RigidBody2D

## Which physics layers the projectile should delete itself on contact with
@export_flags_2d_physics
var delete_on_touch := 0

## How much damage the projectile should deal on impact
var damage := 1

func _on_body_entered(raw_body: Node) -> void:
	var body := raw_body as PhysicsBody2D
	var damageable := body.get_node("Damageable")
	if damageable is Damageable:
		damageable.damage(damage)
	if body.collision_layer & delete_on_touch:
		get_tree().queue_delete(self)
