class_name Enemy
extends Node

func _on_dead() -> void:
	get_parent().queue_free()
