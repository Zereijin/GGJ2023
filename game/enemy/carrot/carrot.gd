class_name Carrot
extends Avoider


func _physics_process(delta: float) -> void:
	super(delta)
	var towards_player := player.position - position
	gun.rotation = towards_player.angle()


func _on_gun_firing(projectile: Projectile) -> void:
	projectile.player = player
	projectile.evolution_timer = evolution_timer
	queue_free()
