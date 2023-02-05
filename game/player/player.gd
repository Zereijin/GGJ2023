class_name Player
extends Plant

## Emitted when the player gains or loses resources
signal update_resources

## The force, in Newtons, applied by a keypress or full joystick deflection
@export_range(0, 100000)
var force_multiplier: float

@export_range(0, 10) var maximum_health_level: int = 0
@export_range(0, 10) var defense_level: int = 0
@export_range(0, 10) var movement_speed_level: int = 0
@export_range(0, 10) var dodge_level: int = 0
@export_range(0, 10) var luck_level: int = 0
@export_range(0, 10) var projectile_damage_level: int = 0:
	get:
		return projectile_damage_level
	set(value):
		projectile_damage_level = value
		if gun != null:
			gun.normal_damage = value + 1
			gun.critical_damage = (value + 1) * 2

@export_range(0, 10) var projectile_attack_speed_level: int = 0
@export_range(0, 10) var projectile_crit_chance_level: int = 0:
	get:
		return projectile_crit_chance_level
	set(value):
		projectile_crit_chance_level = value
		if gun != null:
			gun.critical_probability = value / 25.0

@export_range(0, 10) var projectile_count_level: int = 0:
	get:
		return projectile_count_level
	set(value):
		projectile_count_level = value
		if gun != null:
			gun.projectile_count = value + 1

@export_range(0, 10)
var projectile_accuracy_level: int = 0:
	get:
		return projectile_accuracy_level
	set(value):
		projectile_accuracy_level = value
		if gun != null:
			gun.angle_range = PI / 40 * (10 - value)

@export_range(0, 10) var scream_damage_level: int = 0
@export_range(0, 10) var scream_paralysis_duration_level: int = 0
@export_range(0, 10) var scream_charge_speed_level: int = 0
@export_range(0, 10) var scream_charge_maximum_level: int = 0
@export_range(0, 10) var health_regen_level: int = 0

## Resources
@export var r_resources: int = 50
@export var g_resources: int = 50
@export var b_resources: int = 50

## Whether the player is currently burrowed
var burrowed := false

## Whether the mouse pointer was moved recently, where “recently” means more recently than the last
## time the aiming joystick was deflected above its dead zone
var _mouse_recent := true

## The player’s gun
@onready
var gun := $Gun

# The burrowing animator.
@onready
var burrower := $Burrower


func _ready() -> void:
	# Set every level property to itself, to invoke the setters and push the side effects.
	maximum_health_level = maximum_health_level
	defense_level = defense_level
	movement_speed_level = movement_speed_level
	dodge_level = dodge_level
	luck_level = luck_level
	projectile_damage_level = projectile_damage_level
	projectile_attack_speed_level = projectile_attack_speed_level
	projectile_crit_chance_level = projectile_crit_chance_level
	projectile_count_level = projectile_count_level
	projectile_accuracy_level = projectile_accuracy_level
	scream_damage_level = scream_damage_level
	scream_paralysis_duration_level = scream_paralysis_duration_level
	scream_charge_speed_level = scream_charge_speed_level
	scream_charge_maximum_level = scream_charge_maximum_level
	health_regen_level = health_regen_level


func _unhandled_input(event: InputEvent) -> void:
	# Handle burrowing
	if event.is_action_pressed("burrow"):
		if burrower.get_queue().size() == 0:
			burrowed = not burrowed
			burrower.queue(&"burrow" if burrowed else &"unburrow")

	# Handle movement, only if not burrowed or burrowing
	constant_force = Input.get_vector("left", "right", "up", "down") * force_multiplier
	freeze = burrowed or burrower.is_playing()

	# Handle aiming
	var mouse := event as InputEventMouseMotion
	if mouse != null:
		_mouse_recent = true
	var pad_aim := Input.get_vector("aim_left", "aim_right", "aim_up", "aim_down")
	if not pad_aim.is_zero_approx():
		_mouse_recent = false
		gun.rotation = pad_aim.angle()


func _physics_process(_delta: float) -> void:
	if _mouse_recent:
		gun.rotation = get_local_mouse_position().angle()


func can_afford(costs: Array[int]) -> bool:
	return costs[0] <= r_resources and costs[1] <= g_resources and costs[2] <= b_resources


func try_to_buy(costs: Array[int]) -> bool:
	if (not can_afford(costs)):
		return false

	r_resources -= costs[0]
	g_resources -= costs[1]
	b_resources -= costs[2]
	update_resources.emit()
	return true
