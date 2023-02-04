class_name Damageable
extends Node

## Emitted when the object’s health drops to zero or below
signal dead

## The maximum health
@export_range(0, 1000)
var max_health : int:
	get:
		return max_health
	set(value):
		max_health = value
		_maybe_die()

@export
var health : int:
	get:
		return max_health - _damage
	set(value):
		_damage = max_health - health
		_maybe_die()

## The amount of damage the entity has taken
var _damage := 0

## Whether the dead signal has been emitted yet
var _died := false

## Deals damage to the entity
func damage(amount: int) -> void:
	print("Damageable receives damage %d" % amount)
	_damage += amount
	_maybe_die()

## Emits the dead signal if needed.
func _maybe_die() -> void:
	if health <= 0 and not _died:
		_died = true
		dead.emit()
