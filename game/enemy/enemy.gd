class_name Enemy
extends Plant

## The force, in Newtons, applied when the plant wishes to walk, for an un-evolved enemy
@export_range(0, 100000)
var base_force_multiplier: float

## The resource prefab
@export
var resource : PackedScene

## Which type of resource this enemy drops
@export
var resource_type : CollectibleResource.Type

## The enemy’s current defense stat
var defense : int:
	get:
		return floorf(evolution_timer.run_time / 180.0) as int

## Whether the enemy is paralyzed
var paralyzed : bool:
	get:
		return not is_zero_approx(_paralyzed_for)

## The evolution timer
var evolution_timer: EvolutionTimer

## The force, in Newtons, applied when the plant wishes to walk
var force_multiplier : float:
	get:
		return base_force_multiplier + evolution_timer.run_time

## How long the enemy is paralyzed for
var _paralyzed_for := 0.0

## The gun.
@onready
var gun : Gun = $Gun

## The base damage of the gun for an un-evolved enemy
@onready
var _base_normal_damage := gun.normal_damage

## The base shooting period of the gun for an un-evolved enemy
@onready
var _base_attack_period := gun.period

## The base projectile count for an un-evolved enemy
@onready
var _base_projectile_count := gun.projectile_count


## Configures the enemy by attaching any needed references
func configure(_player: Player, evolution_timer: EvolutionTimer):
	self.evolution_timer = evolution_timer
	$Damageable.health = $Damageable.health + (floorf(evolution_timer.run_time / 60.0) as int)


## Paralyzes the enemy for a period of time
func paralyze(duration: float) -> void:
	_paralyzed_for = maxf(_paralyzed_for, duration)


# Calculates how many projectiles to launch
func _projectile_count() -> int:
	return _base_projectile_count + (floorf(evolution_timer.run_time / 100.0) as int)


func _on_dead() -> void:
	var r := resource.instantiate() as CollectibleResource
	r.position = position
	r.type = resource_type
	get_parent().add_child(r)
	queue_free()


func _physics_process(delta: float) -> void:
	_paralyzed_for = maxf(0.0, _paralyzed_for - delta)


func _on_gun_pre_fire() -> void:
	gun.normal_damage = _base_normal_damage + (floorf(evolution_timer.run_time / 60.0) as int)
	gun.period = minf(_base_attack_period, _base_attack_period / (evolution_timer.run_time / 30.0))
	gun.projectile_count = _projectile_count()
