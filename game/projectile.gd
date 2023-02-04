extends RigidBody2D

## Which physics layers the projectile should delete itself on contact with
@export_flags_2d_physics
var delete_on_touch := 0

func _on_body_entered(raw_body: Node) -> void:
	var body := raw_body as PhysicsBody2D
	var damageable := body.get_node("Damageable") as Damageable
	if damageable != null:
		damageable.damage(1)
	if body.collision_layer & delete_on_touch:
		get_tree().queue_delete(self)
