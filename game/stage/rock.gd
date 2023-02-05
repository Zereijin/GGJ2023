extends StaticBody2D

## How long the rock remains on the field before being removed, in seconds
@export_range(0, 10000)
var lifetime := 15.0

## How long before the end of the lifetime the rock begins to visually fade out
@export_range(0, 10000)
var fade_time := 1.0


func _ready() -> void:
	await get_tree().create_timer(lifetime - fade_time).timeout
	var tween := create_tween()
	tween.tween_property(self, "modulate", Color(1, 1, 1, 0), fade_time)
	await tween.finished
	queue_free()
