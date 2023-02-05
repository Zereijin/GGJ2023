extends Projectile

## The path to the carrot enemy prefab
@export_file("*.tscn")
var carrot_path : String

## The carrot enemy prefab
@onready
var _carrot_prefab : PackedScene = load(carrot_path)

## The player
var player : Player

## The evolution timer
var evolution_timer : EvolutionTimer


func _ready() -> void:
	var land_timer : Timer = $LandTimer
	land_timer.start(land_timer.wait_time * maxf(1, evolution_timer.run_time / 100))


func _on_damage_area_body_entered(raw_body: Node2D) -> void:
	var body := raw_body as PhysicsBody2D
	var damageable := body.get_node("Damageable")
	if damageable is Damageable:
		damageable.damage(damage)


func _land() -> void:
	var carrot : Carrot = _carrot_prefab.instantiate()
	carrot.position = position
	carrot.configure(player, evolution_timer)
	get_parent().add_child(carrot)
	queue_free()
