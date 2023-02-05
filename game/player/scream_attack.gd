class_name ScreamAttack
extends Area2D

## How long, in seconds, the attack stays visible on the screen
@export_range(0, 100)
var fade_time := 2.0

## How fast, in radians per second, the attack spins
@export_range(0, 10 * TAU)
var spin_speed := TAU

## How much damage is applied to each enemy in the area
var damage := 0

## How long each enemy in the area is paralyzed
var paralysis_duration := 0.0


func _ready() -> void:
	create_tween().set_loops().bind_node(self) \
		.tween_property($Sprite, "rotation", spin_speed, 1.0).as_relative()
	var tween := create_tween().bind_node(self)
	tween.tween_property($Sprite, "modulate", Color(1, 1, 1, 0), fade_time)
	# Wait for two physics frames, one for this object to start existing and another for the list of
	# overlaps to be generated.
	await get_tree().physics_frame
	await get_tree().physics_frame
	for target in get_overlapping_bodies():
		var damageable := target.get_node("Damageable") as Damageable
		if damageable != null:
			damageable.damage(damage)
		var enemy := target as Enemy
		if enemy != null:
			print("is enemy")
			enemy.paralyze(paralysis_duration)
	await tween.finished
	queue_free()
