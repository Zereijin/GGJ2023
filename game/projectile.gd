extends RigidBody2D

## Which physics layers the projectile should delete itself on contact with
@export_flags_2d_physics
var delete_on_touch := 0

## Whether the projectile is deleting itself
var _deleting := false

## Invoked when a projectile is about to delete itself due to touching something
##
## Subclasses may override this function to provide custom behaviour.
func _crashed(_body: PhysicsBody2D) -> void:
	pass

func _on_body_entered(raw_body: Node) -> void:
	if not _deleting:
		var body := raw_body as PhysicsBody2D
		if body.collision_layer & delete_on_touch:
			_deleting = true
			self._crashed(body)
			get_tree().queue_delete(self)
