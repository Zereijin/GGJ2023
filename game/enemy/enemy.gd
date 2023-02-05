class_name Enemy
extends Plant

## Whether the enemy is paralyzed
var paralyzed : bool:
	get:
		return not is_zero_approx(_paralyzed_for)

## How long the enemy is paralyzed for
var _paralyzed_for := 0.0


## Paralyzes the enemy for a period of time
func paralyze(duration: float) -> void:
	_paralyzed_for = maxf(_paralyzed_for, duration)


func _on_dead() -> void:
	queue_free()


func _physics_process(delta: float) -> void:
	_paralyzed_for = maxf(0.0, _paralyzed_for - delta)
