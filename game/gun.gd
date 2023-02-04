extends Node2D

## The type of projectile to fire
@export
var projectile : PackedScene

## The number of projectiles to create at a time
@export_range(0, 1000)
var projectile_count := 1

## The projectile accuracy parameter
@export_range(0, 9)
var accuracy := 0

## The plant that owns the gun
@export
var plant : Node


func _fire() -> void:
	var angle_range := (45 - 5 * accuracy) / 360.0 * TAU
	for i in range(projectile_count):
		var proj := projectile.instantiate() as RigidBody2D
		proj.position = plant.position
		proj.linear_velocity = proj.linear_velocity.rotated(rotation).rotated(randf_range(-angle_range, angle_range))
		plant.get_parent().add_child(proj)
