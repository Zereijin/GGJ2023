class_name Enemy
extends Node

func _on_dead() -> void:
	queue_free()
