extends ProgressBar

func update_max_health(maxHealth:int):
	max_value = maxHealth

func update_health(currentHealth:int):
	value = currentHealth


func _on_damageable_update_health(currentHealth):
	update_health(currentHealth)
