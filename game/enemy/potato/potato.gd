extends Enemy

## The force, in Newtons, applied when the potato wishes to walk
@export_range(0, 100000)
var force_multiplier: float

## The object the potato tries to walk towards and shoot
@export
var target: Node2D

## The gun
@onready
var gun := $Gun


func _physics_process(_delta: float) -> void:
	constant_force = global_position.direction_to(target.global_position) * force_multiplier
	gun.rotation = constant_force.angle()
