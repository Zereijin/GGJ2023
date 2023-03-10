class_name CollectibleResource
extends Area2D

enum Type {
	RED,
	GREEN,
	BLUE,
}

## Which type of resource this is
@export
var type : Type = Type.RED

## The images
var _images : Array[String] = [
	"res://game/resources/sprites/red_triangle.png",
	"res://game/resources/sprites/green_square.png",
	"res://game/resources/sprites/blue_star.png",
]
## Sounds
@onready var collectPlayer = $CollectPlayer

func _ready() -> void:
	$Sprite.texture = load(_images[type])


func _on_body_entered(body: Node2D) -> void:
	var player := body as Player
	collectPlayer.play()
	player.score += 1
	match type:
		Type.RED:
			player.r_resources += 50
		Type.GREEN:
			player.g_resources += 50
		Type.BLUE:
			player.b_resources += 50
	visible = false


func _on_collect_player_finished():
	queue_free()
