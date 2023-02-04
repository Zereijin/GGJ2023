extends Node2D

## The type of projectile to fire
@export
var projectile : PackedScene

## The number of projectiles to create at a time
@export_range(0, 1000)
var projectile_count := 1

## The projectile accuracy parameter
@export_range(0, 9)
var accuracy := 0

## Whether the mouse pointer was moved recently, where “recently” means more recently than the last
## time the aiming joystick was deflected above its dead zone
var mouse_recent := true

## The root player node
@onready
var player := get_parent()

func _unhandled_input(event: InputEvent) -> void:
	var mouse := event as InputEventMouseMotion
	if mouse != null:
		mouse_recent = true
	var pad_aim := Input.get_vector("aim_left", "aim_right", "aim_up", "aim_down")
	if not pad_aim.is_zero_approx():
		mouse_recent = false
		rotation = pad_aim.angle()

func _physics_process(_delta: float) -> void:
	if mouse_recent:
		rotation = player.get_local_mouse_position().angle()

func _fire() -> void:
	var angle_range := (45 - 5 * accuracy) / 360.0 * TAU
	for i in range(projectile_count):
		var proj := projectile.instantiate() as RigidBody2D
		proj.position = player.position
		proj.linear_velocity = proj.linear_velocity.rotated(rotation).rotated(randf_range(-angle_range, angle_range))
		player.get_parent().add_child(proj)
