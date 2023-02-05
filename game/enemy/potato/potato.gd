extends Enemy

## The force, in Newtons, applied when the potato wishes to walk
@export_range(0, 100000)
var force_multiplier: float

## The object the potato tries to walk towards and shoot
var _player: Node2D

## The gun
@onready
var gun := $Gun


func configure(player: Player, evolution_timer: EvolutionTimer) -> void:
	super(player, evolution_timer)
	_player = player


func _physics_process(delta: float) -> void:
	super(delta)
	constant_force = Vector2.ZERO if paralyzed else \
		global_position.direction_to(_player.global_position) * force_multiplier
	gun.rotation = constant_force.angle()
