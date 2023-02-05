class_name Avoider
extends Enemy

## The force, in Newtons, applied when the plant wishes to walk
@export_range(0, 100000)
var force_multiplier: float

## How far away from the player the plant tries to stay
@export
var avoid_distance := 250.0

## How far outside the desired avoid distance before the plant starts walking
@export
var dead_zone := 10.0

## The object the plant tries to keep some distance from
var player: Node2D


func configure(player: Player) -> void:
	super(player)
	self.player = player


func _physics_process(delta: float) -> void:
	super(delta)
	var towards_player := player.position - position
	var distance_error = towards_player.length() - avoid_distance
	if absf(distance_error) > dead_zone and not paralyzed:
		constant_force = towards_player.normalized() * force_multiplier * signf(distance_error)
	else:
		constant_force = Vector2.ZERO
