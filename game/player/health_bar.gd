extends ProgressBar

## The player whose health to show
@export
var target : Player

## The Damageable node.
@onready
var damageable : Damageable = target.get_node("Damageable")


func update():
	value = damageable.health
	max_value = target.maximum_health
