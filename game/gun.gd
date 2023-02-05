extends Node2D

## Emitted for each projectile fired just before adding it to the node tree
signal firing(projectile: Projectile)

## The type of projectile to fire
@export
var projectile : PackedScene

## The number of projectiles to create at a time
@export_range(0, 1000)
var projectile_count := 1

@export var projectile_speed : float = 1

## The plant that owns the gun
@export
var plant : Node

## How far left or right of the nominal direction the gun may fire, in radians
var angle_range := 0.0

## The probability of the gun launching a critical-hit projectile, between 0 and 1
var critical_probability := 0.0

## The damage dealt normally
var normal_damage := 1

## The damage dealt during a critical hit
var critical_damage := 1

## Sounds
@onready var shoot_player : AudioStreamPlayer2D = $ShootPlayer
@export var shoot_sound : AudioStream

func _ready():
	shoot_player.stream = shoot_sound

func update_attack_rate(newWaitTime : float):
	$Timer.wait_time = newWaitTime
	print(newWaitTime)

func _fire() -> void:
	for i in range(projectile_count):
		var critical := randf() < critical_probability
		var proj := projectile.instantiate() as Projectile
		proj.position = plant.position
		var flight_angle = rotation + randf_range(-angle_range, angle_range)
		proj.linear_velocity = proj.linear_velocity.rotated(flight_angle) * projectile_speed
		proj.rotation = flight_angle
		proj.damage = critical_damage if critical else normal_damage
		firing.emit(proj)
		plant.get_parent().add_child(proj)
		shoot_player.play()
