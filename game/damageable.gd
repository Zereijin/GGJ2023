class_name Damageable
extends Node

## Emitted when the object’s health drops to zero or below
signal dead
## Emitted when the object's health changes
signal update_health

@export_range(0, 1000)
var health : int:
	get:
		return health
	set(value):
		health = value
		update_health.emit()
		_maybe_die()

## Whether the dead signal has been emitted yet
var _died := false

## Deals damage to the entity
func damage(amount: int) -> void:
	health -= amount

# Heals the entity
func heal(amount: int) -> void:
	health += amount

## Emits the dead signal if needed.
func _maybe_die() -> void:
	if health <= 0 and not _died:
		_died = true
		dead.emit()
