class_name Enemy
extends RigidBody2D

func _on_dead() -> void:
	queue_free()
