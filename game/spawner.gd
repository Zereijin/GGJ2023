extends Polygon2D

## How long to warn before spawning the enemies
@export
var warning_duration := 2.0

## The spawn warning marker
@export
var warning_marker : Node2D

## The plants that can be spawned
@export
var plants : Array[PackedScene]

## How many plants to spawn at a time
@export
var count := 5

## How much to multiply the plant count minus one by to get the radius of the spawning circle
@export
var radius_factor := 10.0

## The node under which spawned plants should be hung
@export
var parent_node : Node2D

## The player, used for configuring monsters
@export
var player : Player

## The evolution timer
@export
var evolution_timer : EvolutionTimer

## The rectangle within which plants can be spawned
@onready
var target_area := _calculate_target_area()


func _calculate_target_area() -> Rect2:
	var ret := Rect2(0, 0, 0, 0)
	for i in polygon:
		ret = ret.expand(i)
	return ret


func _ready() -> void:
	_spawn()


func _spawn() -> void:
	var count_snapshot := count
	var radius := (count_snapshot - 1) * radius_factor
	var shrunk_area := target_area.grow(-radius)
	var target_point := shrunk_area.position + \
		Vector2(randf_range(0, shrunk_area.size.x), randf_range(0, shrunk_area.size.y))
	warning_marker.position = target_point
	warning_marker.visible = true
	await get_tree().create_timer(warning_duration).timeout
	warning_marker.visible = false
	for i in range(count_snapshot):
		var angle := TAU * i / count_snapshot
		var spawn_pos := target_point + Vector2.from_angle(angle) * radius
		var plant : Enemy = plants[randi_range(0, plants.size() - 1)].instantiate()
		plant.position = spawn_pos
		plant.configure(player, evolution_timer)
		parent_node.add_child(plant)
