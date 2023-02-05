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

## An object that has a “defense” integer property, or null to have a defense of zero
@export var defense_source : Node

@export var dodge_probability : float = 0

## Sounds
@onready var death_player : AudioStreamPlayer2D = $AudioPlayers/DeathPlayer
@onready var dodge_player : AudioStreamPlayer2D = $AudioPlayers/DodgePlayer
@onready var hurt_player : AudioStreamPlayer2D = $AudioPlayers/HurtPlayer

@export var death_sound : AudioStream
@export var dodge_sound : AudioStream
@export var hurt_sound : AudioStream

## Whether the entity is alive
var alive : bool:
	get:
		return health > 0 and not _died

## Whether the dead signal has been emitted yet
var _died := false

func _ready():
	death_player.stream = death_sound
	dodge_player.stream = dodge_sound
	hurt_player.stream = hurt_sound

## Deals damage to the entity
func damage(amount: int) -> void:
	if randf() < dodge_probability:
		dodge_player.play()
		return
	var defense : int = defense_source.defense if defense_source != null else 0
	health -= max(1, amount - defense)
	if health >= 0:
		hurt_player.play()

# Heals the entity
func heal(amount: int) -> void:
	health += amount

## Emits the dead signal if needed.
func _maybe_die() -> void:
	if health <= 0 and not _died:
		_died = true
		dead.emit()
		death_player.play()
