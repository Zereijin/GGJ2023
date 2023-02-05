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

@export var defense : int = 0
@export var dodge_probability : float = 0

## Whether the entity is alive
var alive : bool:
	get:
		return health > 0 and not _died

## Whether the dead signal has been emitted yet
var _died := false

## Deals damage to the entity
func damage(amount: int) -> void:
	if randf() < dodge_probability:
		#TODO: Dodge sound
		return
	health -= max(1, amount - defense)

# Heals the entity
func heal(amount: int) -> void:
	health += amount

## Emits the dead signal if needed.
func _maybe_die() -> void:
	if health <= 0 and not _died:
		_died = true
		dead.emit()
