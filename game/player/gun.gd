extends Node2D

## Whether the mouse pointer was moved recently, where “recently” means more recently than the last
## time the aiming joystick was deflected above its dead zone.
var mouse_recent := true

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
		rotation = get_parent().get_local_mouse_position().angle()
