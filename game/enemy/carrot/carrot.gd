extends Avoider

## The gun
@onready
var gun := $Gun


func _physics_process(delta: float) -> void:
	super(delta)
	var towards_player := player.position - position
	gun.rotation = towards_player.angle()


func _on_gun_firing(projectile: Projectile) -> void:
	projectile.player = player
	queue_free()
