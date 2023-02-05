extends Node2D

## The type of projectile to fire
@export
var projectile : PackedScene

## The number of projectiles to create at a time
@export_range(0, 1000)
var projectile_count := 1

## The plant that owns the gun
@export
var plant : Node

## How far left or right of the nominal direction the gun may fire, in radians
var angle_range := 0.0


func _fire() -> void:
	for i in range(projectile_count):
		var proj := projectile.instantiate() as RigidBody2D
		proj.position = plant.position
		proj.linear_velocity = proj.linear_velocity.rotated(rotation).rotated(randf_range(-angle_range, angle_range))
		plant.get_parent().add_child(proj)
