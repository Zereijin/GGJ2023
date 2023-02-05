extends Avoider

## How far away from the player the beet’s projectile should be targeted
@export_range(0, 1000)
var target_distance := 100.0


func _physics_process(delta: float) -> void:
	super(delta)
	var towards_player := player.position - position
	gun.rotation = towards_player.angle()

func _on_gun_firing(projectile: Projectile) -> void:
	# Beet projectiles need a target position, not an aim direction, to work right
	var offset_angle := randf_range(0, TAU)
	var offset_vector := Vector2.from_angle(offset_angle) * target_distance
	projectile.target_point = player.position + offset_vector
