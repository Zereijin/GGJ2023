class_name Player
extends Plant

## Emitted when the player gains or loses resources
signal update_resources

## Emitted when the player starts screaming
signal start_screaming

## Emitted when the player dies
signal dead

## The force, in Newtons, applied by a keypress or full joystick deflection
@export_range(0, 100000)
var force_multiplier: float

@export_range(0, 10) var maximum_health_level: int = 0:
	get:
		return maximum_health_level
	set(value):
		maximum_health_level = value
		maximum_health = 5 * (value + 1)
		if health_bar != null:
			health_bar.update()

@export_range(0, 10) var defense_level: int = 0:
	get:
		return defense_level
	set(value):
		defense_level = value
		if damageable != null:
			damageable.defense = value

@export_range(0, 10) var movement_speed_level: int = 0

@export_range(0, 10) var dodge_level: int = 0:
	get:
		return dodge_level
	set(value):
		dodge_level = value
		if damageable != null:
			damageable.dodge_probability = value * .05
@export_range(0, 10) var luck_level: int = 0
@export_range(0, 10) var projectile_damage_level: int = 0:
	get:
		return projectile_damage_level
	set(value):
		projectile_damage_level = value
		if gun != null:
			gun.normal_damage = value + 1
			gun.critical_damage = gun.normal_damage * 2

@export_range(0, 10) var projectile_attack_speed_level: int = 0:
	get:
		return projectile_attack_speed_level
	set(value):
		projectile_attack_speed_level = value
		if gun != null:
			gun.update_attack_rate(2 - float(projectile_attack_speed_level) / 7)

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
			gun.angle_range = PI / 35 * (10 - value)

@export_range(0, 10) var scream_damage_level: int = 0:
	get:
		return scream_damage_level
	set(value):
		scream_damage_level = value
		_scream_damage = value + 1

@export_range(0, 10) var scream_paralysis_duration_level: int = 0:
	get:
		return scream_paralysis_duration_level
	set(value):
		scream_paralysis_duration_level = value
		_scream_paralysis_duration = (value + 1) * 0.5

@export_range(0, 10) var scream_charge_speed_level: int = 0:
	get:
		return scream_charge_speed_level
	set(value):
		scream_charge_speed_level = value
		_scream_charge_speed = value * 2 + 1

@export_range(0, 10) var scream_charge_maximum_level: int = 0:
	get:
		return scream_charge_maximum_level
	set(value):
		scream_charge_maximum_level = value
		_scream_charge_maximum = 5 + value * 3

@export_range(0, 10) var health_regen_level: int = 0:
	get:
		return health_regen_level
	set(value):
		health_regen_level = value
		if heal_timer != null:
			heal_timer.wait_time = 5.0 / (value + 1)

## The scaling factor between scream charge level and scream circle size, in pixels per charge unit
@export_range(0, 1000)
var scream_size_scale_factor := 300.0

## Red triangle resources
@export var r_resources: int = 50:
	get:
		return r_resources
	set(value):
		r_resources = value
		update_resources.emit()

## Green square resources
@export var g_resources: int = 50:
	get:
		return g_resources
	set(value):
		g_resources = value
		update_resources.emit()

## Blue star resources
@export var b_resources: int = 50:
	get:
		return b_resources
	set(value):
		b_resources = value
		update_resources.emit()

## The prefab for the scream attack
@export
var scream_attack : PackedScene

## Whether the player is alive
var alive : bool:
	get:
		return damageable.alive

## Whether the player is currently burrowed
var burrowed := false

## Whether the mouse pointer was moved recently, where “recently” means more recently than the last
## time the aiming joystick was deflected above its dead zone
var _mouse_recent := true

## The player’s maximum health
var maximum_health := 5

## The speed at which the scream charge level increases, in charge units per second
var _scream_charge_speed := 1.0

## The current scream charge level
var _scream_charge := 0.0

## The maximum scream charge level
var _scream_charge_maximum := 1.0

## The damage applied by a scream attack
var _scream_damage := 1

## How long enemies in a scream attack are paralyzed, in seconds
var _scream_paralysis_duration := 1.0

## The player’s gun
@onready
var gun := $Gun

# The player's healthbar.
@onready
var health_bar := $HealthBar
@onready
var damageable := $Damageable

# The timer used to heal the player while burrowed
@onready
var heal_timer = $HealTimer

# The burrowing animator.
@onready
var burrower := $Burrower

# The scream indicator
@onready
var scream_indicator := $ScreamIndicator

# Sounds
@onready var burrowPlayer := $AudioPlayers/BurrowPlayer
@onready var screamPlayer := $AudioPlayers/ScreamPlayer
@onready var unburrowPlayer := $AudioPlayers/UnburrowPlayer


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

	# Initialize health
	damageable.health = maximum_health
	health_bar.update()


func _unhandled_input(event: InputEvent) -> void:
	# Handle burrowing
	if event.is_action_pressed("burrow"):
		if burrower.get_queue().size() == 0:
			burrowed = not burrowed
			burrower.queue(&"burrow" if burrowed else &"unburrow")
			if burrowed:
				burrowPlayer.play()
				heal_timer.start()
			else:
				unburrowPlayer.play()
				heal_timer.stop()

	# Handle movement, only if not burrowed or burrowing
	constant_force = Input.get_vector("left", "right", "up", "down") * (force_multiplier + (300 * movement_speed_level))
	freeze = burrowed or burrower.is_playing()

	# Handle aiming
	var mouse := event as InputEventMouseMotion
	if mouse != null:
		_mouse_recent = true
	var pad_aim := Input.get_vector("aim_left", "aim_right", "aim_up", "aim_down")
	if not pad_aim.is_zero_approx():
		_mouse_recent = false
		gun.rotation = pad_aim.angle()


func _physics_process(delta: float) -> void:
	if _mouse_recent:
		gun.rotation = get_local_mouse_position().angle()
	if burrowed:
		_scream_charge = minf(_scream_charge + delta * _scream_charge_speed, _scream_charge_maximum)


func _process(delta: float) -> void:
	super(delta)
	scream_indicator.scale = Vector2.ONE * scream_size_scale_factor * _scream_charge


func _heal_tick() -> void:
	if damageable.health < maximum_health:
		damageable.heal(1)

func _start_screaming() -> void:
	start_screaming.emit()

func _on_start_screaming() -> void:
	var attack := scream_attack.instantiate() as ScreamAttack
	attack.scale = scream_indicator.scale
	attack.position = position
	attack.damage = _scream_damage
	attack.paralysis_duration = _scream_paralysis_duration
	get_parent().add_child(attack)
	_scream_charge = 0.0
	screamPlayer.play()


func can_afford(costs: Array[int]) -> bool:
	return costs[0] <= r_resources and costs[1] <= g_resources and costs[2] <= b_resources


func try_to_buy(costs: Array[int]) -> bool:
	if (not can_afford(costs)):
		return false

	r_resources -= costs[0]
	g_resources -= costs[1]
	b_resources -= costs[2]
	return true


func _dead() -> void:
	dead.emit()
