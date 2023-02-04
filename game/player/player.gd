class_name Player
extends RigidBody2D

## The force, in Newtons, applied by a keypress or full joystick deflection
@export_range(0, 100000)
var force_multiplier: float

@export_range(0, 10) var maximum_health_level: int = 0
@export_range(0, 10) var defense_level: int = 0
@export_range(0, 10) var movement_speed_level: int = 0
@export_range(0, 10) var dodge_level: int = 0
@export_range(0, 10) var luck_level: int = 0
@export_range(0, 10) var projectile_damage_level: int = 0
@export_range(0, 10) var projectile_attack_speed_level: int = 0
@export_range(0, 10) var projectile_crit_chance_level: int = 0
@export_range(0, 10) var projectile_count_level: int = 0
@export_range(0, 10) var projectile_accuracy_level: int = 0
@export_range(0, 10) var scream_damage_level: int = 0
@export_range(0, 10) var scream_paralysis_duration_level: int = 0
@export_range(0, 10) var scream_charge_speed_level: int = 0
@export_range(0, 10) var scream_charge_maximum_level: int = 0
@export_range(0, 10) var health_regen_level: int = 0

func _unhandled_input(event: InputEvent) -> void:
	constant_force = Input.get_vector("left", "right", "up", "down") * force_multiplier
