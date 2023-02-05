class_name Enemy
extends Plant

func _on_dead() -> void:
	queue_free()
