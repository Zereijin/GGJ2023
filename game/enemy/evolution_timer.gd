class_name EvolutionTimer
extends Node

## How long the game has been running for, in seconds
var run_time := 0.0


func _physics_process(delta: float) -> void:
	run_time += delta
