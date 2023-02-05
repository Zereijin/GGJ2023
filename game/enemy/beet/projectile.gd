extends Projectile

## The static rock prefab
@export
var rock_prefab : PackedScene

## The target marker prefab
@export
var target_marker_prefab : PackedScene

## The point the projectile will land on
var target_point : Vector2

## The target marker, created when the projectile begins flying
var _target_marker : Sprite2D


func _ready() -> void:
	linear_velocity = linear_velocity.project(target_point - position)
	_target_marker = target_marker_prefab.instantiate()
	_target_marker.position = target_point
	get_parent().add_child(_target_marker)


func _physics_process(_delta: float) -> void:
	if linear_velocity.dot(target_point - position) <= 0:
		# We’ve passed the closest point we’ll ever reach to the target, so land.
		var rock := rock_prefab.instantiate()
		rock.position = target_point
		get_parent().add_child(rock)
		_target_marker.queue_free()
		queue_free()
