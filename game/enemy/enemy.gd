class_name Enemy
extends Plant

## The force, in Newtons, applied when the plant wishes to walk
@export_range(0, 100000)
var force_multiplier: float

## The resource prefab
@export
var resource : PackedScene

## Which type of resource this enemy drops
@export
var resource_type : CollectibleResource.Type

## Whether the enemy is paralyzed
var paralyzed : bool:
	get:
		return not is_zero_approx(_paralyzed_for)

## How long the enemy is paralyzed for
var _paralyzed_for := 0.0

## The evolution timer
var evolution_timer: EvolutionTimer


## Configures the enemy by attaching any needed references
func configure(_player: Player, evolution_timer: EvolutionTimer):
	self.evolution_timer = evolution_timer
	$Damageable.health = $Damageable.health + (floorf(evolution_timer.run_time / 60.0) as int)


## Paralyzes the enemy for a period of time
func paralyze(duration: float) -> void:
	_paralyzed_for = maxf(_paralyzed_for, duration)


func _on_dead() -> void:
	var r := resource.instantiate() as CollectibleResource
	r.position = position
	r.type = resource_type
	get_parent().add_child(r)
	queue_free()


func _physics_process(delta: float) -> void:
	_paralyzed_for = maxf(0.0, _paralyzed_for - delta)
