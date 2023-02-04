class_name Damageable
extends Node

## Emitted when the object’s health drops to zero or below
signal dead

@export_range(0, 1000)
var health : int:
	get:
		return health
	set(value):
		health = value
		_maybe_die()

## Whether the dead signal has been emitted yet
var _died := false

## Deals damage to the entity
func damage(amount: int) -> void:
	health -= amount

## Emits the dead signal if needed.
func _maybe_die() -> void:
	if health <= 0 and not _died:
		_died = true
		dead.emit()
